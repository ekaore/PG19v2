#!/bin/bash
# PG19v2 Multi-Portal Deploy Script
# Usage: ./deploy.sh <portal> [dev|prod] [--no-build]
#
# Portals (flat subdomain scheme for Cloudflare SSL):
#   main     → pg19.doka.team / dev-pg19.doka.team
#   land     → pg19-land.doka.team / dev-pg19-land.doka.team
#   partner  → pg19-partner.doka.team / dev-pg19-partner.doka.team
#   client   → pg19-client.doka.team / dev-pg19-client.doka.team
#   admin    → pg19-admin.doka.team / dev-pg19-admin.doka.team
#   tgclient → pg19-tg.doka.team (prod only, Telegram Web App)

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Config
SERVER="doka-server-deploy"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PORTALS="main land partner client admin tgclient"
ENV_FILE="$SCRIPT_DIR/.env.deploy"

# Load secrets from .env.deploy (required)
if [ ! -f "$ENV_FILE" ]; then
    echo -e "${RED}Error: $ENV_FILE not found!${NC}"
    echo "Create it with SUPABASE_URL, SUPABASE_ANON_KEY, etc."
    exit 1
fi

# Export all variables from .env.deploy (simple parser, no quotes support)
export $(grep -v '^#' "$ENV_FILE" | xargs)

get_worktree_path() {
    case $1 in
        main)     echo "/Users/doka/PG19v2" ;;
        land)     echo "/Users/doka/PG19v2land" ;;
        partner)  echo "/Users/doka/PG19v2partner" ;;
        client)   echo "/Users/doka/PG19v2client" ;;
        admin)    echo "/Users/doka/PG19v2admin" ;;
        tgclient) echo "/Users/doka/PG19v2tgclient" ;;
    esac
}

get_remote_path() {
    local portal=$1
    local env=$2
    if [ "$env" == "dev" ]; then
        echo "/opt/pg19-dev-$portal"
    else
        echo "/opt/pg19-$portal"
    fi
}

get_url() {
    local portal=$1
    local env=$2
    if [ "$portal" == "tgclient" ]; then
        echo "pg19-tg.doka.team"
    elif [ "$env" == "dev" ]; then
        if [ "$portal" == "main" ]; then
            echo "dev-pg19.doka.team"
        else
            echo "dev-pg19-$portal.doka.team"
        fi
    else
        if [ "$portal" == "main" ]; then
            echo "pg19.doka.team"
        else
            echo "pg19-$portal.doka.team"
        fi
    fi
}

get_container_name() {
    local portal=$1
    local env=$2
    if [ "$portal" == "tgclient" ]; then
        echo "pg19-tg"
    elif [ "$env" == "dev" ]; then
        echo "pg19-dev-$portal"
    else
        echo "pg19-$portal"
    fi
}

usage() {
    echo -e "${BLUE}PG19v2 Multi-Portal Deploy${NC}"
    echo ""
    echo "Usage: $0 <portal> [env] [options]"
    echo ""
    echo "Portals:"
    echo "  main      Main site (pg19.doka.team)"
    echo "  land      Landing page (pg19-land.doka.team)"
    echo "  partner   Partner portal (pg19-partner.doka.team)"
    echo "  client    Client cabinet (pg19-client.doka.team)"
    echo "  admin     Admin panel (pg19-admin.doka.team)"
    echo "  tgclient  Telegram Web App (pg19-tg.doka.team, prod only)"
    echo "  all       Deploy all portals"
    echo ""
    echo "Environments:"
    echo "  prod      Production (default)"
    echo "  dev       Development preview (dev-pg19-*.doka.team)"
    echo ""
    echo "Options:"
    echo "  --no-build    Skip Docker build, only restart"
    echo "  --status      Show status of all deployments"
    echo ""
    echo "Examples:"
    echo "  $0 client              # Deploy client to prod"
    echo "  $0 client dev          # Deploy client to dev"
    echo "  $0 partner prod --no-build  # Restart partner prod"
    echo "  $0 all dev             # Deploy all to dev"
    echo "  $0 --status            # Show all statuses"
    exit 1
}

status() {
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  PG19v2 Deployment Status${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""

    for env in prod dev; do
        echo -e "${CYAN}[$env]${NC}"
        echo ""
        for portal in $PORTALS; do
            local url=$(get_url $portal $env)
            local container=$(get_container_name $portal $env)

            printf "  %-10s → https://%s\n" "$portal" "$url"

            local status=$(ssh $SERVER "docker ps -a --filter name=^${container}$ --format '{{.Status}}'" 2>/dev/null || echo "")

            if [[ "$status" == *"Up"* ]]; then
                echo -e "             ${GREEN}● Running${NC} ($status)"
            elif [[ -z "$status" ]]; then
                echo -e "             ${RED}○ Not deployed${NC}"
            else
                echo -e "             ${RED}○ $status${NC}"
            fi
        done
        echo ""
    done
}

sync_base_layer_to_portal() {
    local remote_path=$1
    local base_worktree="/Users/doka/PG19v2"

    echo -e "${YELLOW}►${NC} Syncing base layer to portal..."
    ssh $SERVER "mkdir -p $remote_path/_base_layer"

    rsync -avz --delete \
        --exclude=node_modules \
        --exclude=.nuxt \
        --exclude=.output \
        --exclude=.git \
        --exclude=deploy \
        --exclude=logs \
        "$base_worktree/" "$SERVER:$remote_path/_base_layer/"
}

generate_compose() {
    local portal=$1
    local env=$2
    local remote_path=$3

    local url=$(get_url $portal $env)
    local container=$(get_container_name $portal $env)

    # Select bot token
    local telegram_bot_username="PG19CONNECTBOT"
    local telegram_bot_token="$TELEGRAM_BOT_TOKEN_MAIN"
    if [ "$portal" == "tgclient" ]; then
        telegram_bot_username="PG19WEBAPP_bot"
        telegram_bot_token="$TELEGRAM_BOT_TOKEN_TG"
    fi

    # Validate required env vars
    if [ -z "$SUPABASE_URL" ] || [ -z "$SUPABASE_ANON_KEY" ]; then
        echo -e "${RED}Error: Missing SUPABASE_URL or SUPABASE_ANON_KEY in .env.deploy${NC}"
        exit 1
    fi

    ssh $SERVER "cat > $remote_path/docker-compose.yml" << EOF
services:
  $container:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: $container
    restart: unless-stopped
    environment:
      - NODE_ENV=production
      - SUPABASE_URL=$SUPABASE_URL
      - SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY
      - SUPABASE_SERVICE_KEY=$SUPABASE_SERVICE_KEY
      - NUXT_SUPABASE_SERVICE_KEY=$SUPABASE_SERVICE_KEY
      - NUXT_TELEGRAM_BOT_TOKEN=$telegram_bot_token
      - TELEGRAM_BOT_USERNAME=$telegram_bot_username
      - YANDEX_MAPS_API_KEY=$YANDEX_MAPS_API_KEY
    healthcheck:
      test: ["CMD", "wget", "-q", "--spider", "http://127.0.0.1:3000/"]
      interval: 30s
      timeout: 5s
      retries: 3
      start_period: 60s
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.$container.rule=Host(\`$url\`)"
      - "traefik.http.services.$container.loadbalancer.server.port=3000"
    networks:
      - pg19-network

networks:
  pg19-network:
    external: true
EOF
}

create_compose_file() {
    local portal=$1
    local compose_file="$SCRIPT_DIR/deploy/docker-compose.$portal.yml"
    mkdir -p "$(dirname "$compose_file")"
    cat > "$compose_file" << 'EOF'
# Auto-generated placeholder. Actual config is generated on server during deploy.
EOF
    echo -e "${GREEN}Created placeholder: $compose_file${NC}"
}

deploy_portal() {
    local portal=$1
    local env=$2
    local no_build=$3

    local worktree=$(get_worktree_path $portal)
    local remote_path=$(get_remote_path $portal $env)
    local url=$(get_url $portal $env)
    local container=$(get_container_name $portal $env)
    local compose_file="$SCRIPT_DIR/deploy/docker-compose.$portal.yml"

    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Deploying: $portal ($env) → https://$url${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""

    if [ ! -d "$worktree" ]; then
        echo -e "${RED}Error: Worktree not found: $worktree${NC}"
        return 1
    fi

    if [ ! -f "$compose_file" ]; then
        create_compose_file $portal
    fi

    local commit=$(cd "$worktree" && git rev-parse --short HEAD)
    local branch_name=$(cd "$worktree" && git branch --show-current)
    echo -e "${YELLOW}►${NC} Branch: $branch_name @ $commit"
    echo -e "${YELLOW}►${NC} Environment: $env"
    echo ""

    echo -e "${YELLOW}►${NC} Preparing server directory..."
    ssh $SERVER "sudo mkdir -p $remote_path && sudo chown vv:vv $remote_path"

    echo -e "${YELLOW}►${NC} Syncing code to server..."
    rsync -avz --delete \
        --exclude=node_modules \
        --exclude=.nuxt \
        --exclude=.output \
        --exclude=.git \
        --exclude=deploy \
        --exclude=logs \
        --exclude=_base_layer \
        "$worktree/" "$SERVER:$remote_path/"

    if [[ "$portal" == "client" || "$portal" == "admin" || "$portal" == "partner" ]]; then
        sync_base_layer_to_portal "$remote_path"
    fi

    echo -e "${YELLOW}►${NC} Generating Docker configs..."
    generate_compose $portal $env "$remote_path"
    scp "$worktree/Dockerfile" "$SERVER:$remote_path/Dockerfile"

    if [ "$no_build" == "true" ]; then
        echo -e "${YELLOW}►${NC} Restarting container (no build)..."
        ssh $SERVER "cd $remote_path && docker compose restart"
    else
        echo -e "${YELLOW}►${NC} Building and starting container..."
        ssh $SERVER "cd $remote_path && docker compose down 2>/dev/null || true && docker compose up -d --build"
    fi

    echo -e "${YELLOW}►${NC} Waiting for container to be healthy..."
    sleep 5

    local status=$(ssh $SERVER "docker ps --filter name=^${container}$ --format '{{.Status}}'" 2>/dev/null)
    if [[ "$status" == *"Up"* ]]; then
        echo ""
        echo -e "${GREEN}✓ Successfully deployed!${NC}"
        echo -e "  URL: https://$url"
        echo -e "  Commit: $commit"
        echo -e "  Container: $container"
        echo -e "  Status: $status"
    else
        echo -e "${RED}✗ Deployment may have failed. Check logs:${NC}"
        echo "  ssh $SERVER 'docker logs $container'"
    fi
    echo ""
}

# Parse arguments
PORTAL=""
ENV="prod"
NO_BUILD="false"

while [[ $# -gt 0 ]]; do
    case $1 in
        main|land|partner|client|admin|tgclient|all)
            PORTAL=$1
            shift
            ;;
        dev|prod)
            ENV=$1
            shift
            ;;
        --no-build)
            NO_BUILD="true"
            shift
            ;;
        --status)
            status
            exit 0
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            usage
            ;;
    esac
done

if [ -z "$PORTAL" ]; then
    usage
fi

if [ "$PORTAL" == "all" ]; then
    for p in $PORTALS; do
        if [ "$p" == "tgclient" ] && [ "$ENV" == "dev" ]; then
            echo -e "${YELLOW}Skipping tgclient (prod-only portal)${NC}"
            continue
        fi
        deploy_portal $p $ENV $NO_BUILD
    done
else
    if [ "$PORTAL" == "tgclient" ] && [ "$ENV" == "dev" ]; then
        echo -e "${YELLOW}Warning: tgclient is designed for prod only. Deploying anyway...${NC}"
    fi
    deploy_portal $PORTAL $ENV $NO_BUILD
fi

echo -e "${GREEN}Done!${NC}"
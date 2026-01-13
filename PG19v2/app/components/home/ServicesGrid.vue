<script setup lang="ts">
interface ServiceItem {
  id: string
  title: string
  description: string
  icon: string
  color: string
  link: string
  features: string[]
  comingSoon?: boolean
}

interface ServicesContent {
  title: string
  subtitle: string
  items: ServiceItem[]
}

// Загружаем контент из API
const { content, pending } = useSiteContent<{ services: ServicesContent }>('home')

// Получаем сервисы из контента или используем fallback
const services = computed(() => {
  const items = content.value?.services?.items || []
  return items.map(item => {
    const color: string = item.color || 'primary'
    return {
      ...item,
      href: item.link,
      color,
      gradient: getGradient(color)
    }
  })
})

const sectionTitle = computed(() => content.value?.services?.title || 'Всё для комфортной цифровой жизни')
const sectionSubtitle = computed(() => content.value?.services?.subtitle || '')

function getGradient(color: string | undefined): string {
  const gradients = {
    primary: 'from-primary/20 to-primary/5',
    secondary: 'from-secondary/20 to-secondary/5',
    accent: 'from-accent/20 to-accent/5',
    info: 'from-info/20 to-info/5'
  } as const
  
  const colorKey = (color || 'primary') as keyof typeof gradients
  return gradients[colorKey] || gradients.primary
}

const chatStore = useChatStore()

const colorClasses: Record<string, { icon: string; glow: string; tag: string }> = {
  primary: {
    icon: 'text-primary',
    glow: 'group-hover:shadow-glow-primary',
    tag: 'bg-primary/10 text-primary border-primary/20'
  },
  secondary: {
    icon: 'text-secondary',
    glow: 'group-hover:shadow-glow-secondary',
    tag: 'bg-secondary/10 text-secondary border-secondary/20'
  },
  accent: {
    icon: 'text-accent',
    glow: 'group-hover:shadow-glow-accent',
    tag: 'bg-accent/10 text-accent border-accent/20'
  },
  info: {
    icon: 'text-info',
    glow: 'group-hover:shadow-[0_0_30px_rgba(0,84,166,0.4)]',
    tag: 'bg-info/10 text-info border-info/20'
  }
}
</script>

<template>
  <section class="py-12 md:py-16 relative overflow-hidden" :style="{ background: 'var(--bg-base)' }">
    <!-- Background decoration -->
    <div class="absolute inset-0 mesh-gradient-subtle opacity-50"></div>

    <div class="container mx-auto px-4 relative z-10">
      <!-- Header -->
      <div class="text-center mb-8">
        <div class="inline-flex items-center gap-2 glass-card rounded-full px-4 py-2 mb-4 opacity-0 animate-fade-in-up">
          <Icon name="heroicons:sparkles" class="w-4 h-4 text-primary" />
          <span class="text-primary font-medium text-sm uppercase tracking-wider">
            Услуги сообщества
          </span>
        </div>
        <h2 class="text-3xl md:text-4xl lg:text-5xl font-bold text-[var(--text-primary)] mb-6 opacity-0 animate-fade-in-up stagger-1">
          {{ sectionTitle.split(' ').slice(0, 3).join(' ') }}
          <span class="text-gradient-primary"> {{ sectionTitle.split(' ').slice(3).join(' ') }}</span>
        </h2>
        <p class="text-lg text-[var(--text-muted)] max-w-2xl mx-auto mb-4 opacity-0 animate-fade-in-up stagger-2">
          {{ sectionSubtitle || 'Выберите услугу, чтобы узнать подробности' }}
        </p>
        <!-- Визуальная подсказка -->
        <div class="inline-flex items-center gap-2 px-4 py-2 glass-card rounded-full opacity-0 animate-fade-in-up stagger-2">
          <Icon name="heroicons:cursor-arrow-rays" class="w-4 h-4 text-primary" />
          <span class="text-sm text-[var(--text-muted)]">Наведите на карточку, чтобы увидеть подробности</span>
        </div>
      </div>

      <!-- Services grid -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 lg:gap-8">
        <NuxtLink
          v-for="(service, index) in services"
          :key="service.href"
          :to="service.href"
          class="group glass-card rounded-3xl p-8 transition-all duration-500 opacity-0 animate-fade-in-up relative hover:scale-[1.02] hover:-translate-y-1"
          :class="[`stagger-${index + 1}`, (colorClasses[service.color] || colorClasses.primary)?.glow || '']"
        >
          <!-- Icon container -->
          <div
            class="icon-container mb-6 group-hover:scale-110 transition-transform duration-300"
            :class="`bg-gradient-to-br ${service.gradient}`"
          >
            <Icon
              :name="service.icon"
              :class="['w-7 h-7', (colorClasses[service.color] || colorClasses.primary)?.icon || '', 'group-hover:scale-110 transition-transform']"
            />
          </div>

          <!-- Title -->
          <h3 class="text-xl font-bold text-[var(--text-primary)] mb-3 group-hover:text-primary transition-colors">
            {{ service.title }}
          </h3>

          <!-- Description -->
          <p class="text-[var(--text-muted)] mb-6 leading-relaxed group-hover:text-[var(--text-secondary)] transition-colors">
            {{ service.description }}
          </p>

          <!-- Features -->
          <div class="flex flex-wrap gap-2 mb-4">
            <span
              v-for="(feature, featureIndex) in service.features"
              :key="feature"
              :class="[
                'text-xs px-3 py-1.5 rounded-full border font-medium transition-all group-hover:scale-105',
                (colorClasses[service.color] || colorClasses.primary)?.tag || ''
              ]"
              :style="{ transitionDelay: `${featureIndex * 50}ms` }"
            >
              {{ feature }}
            </span>
          </div>

          <!-- Визуальные индикаторы статуса -->
          <div class="mb-4 flex flex-wrap items-center gap-3">
            <!-- Индикатор доступности -->
            <div
              v-if="!service.comingSoon"
              class="flex items-center gap-1.5 text-xs text-accent"
            >
              <Icon name="heroicons:check-circle" class="w-3.5 h-3.5" />
              <span>Доступно</span>
            </div>
            <!-- Индикатор популярности -->
            <div
              v-if="(service.id === 'internet' || service.id === 'tv') && !service.comingSoon"
              class="flex items-center gap-1.5 text-xs text-primary"
            >
              <Icon name="heroicons:star" class="w-3.5 h-3.5" />
              <span>Популярно</span>
            </div>
          </div>

          <!-- Arrow link -->
          <div class="flex items-center justify-between pt-4 border-t border-[var(--glass-border)]">
            <div class="flex items-center gap-2 text-[var(--text-muted)] group-hover:text-primary transition-colors">
              <span class="text-sm font-medium">Подробнее</span>
              <Icon
                name="heroicons:arrow-right"
                class="w-4 h-4 transform group-hover:translate-x-1 transition-transform"
              />
            </div>
            <div
              v-if="service.comingSoon"
              class="px-2 py-1 rounded-full bg-orange-500/10 border border-orange-500/20 flex items-center gap-1"
            >
              <Icon name="heroicons:clock" class="w-3 h-3 text-orange-400" />
              <span class="text-xs text-orange-400 font-medium">Скоро</span>
            </div>
          </div>

          <!-- Визуальная подсказка о кликабельности -->
          <div class="absolute top-4 right-4 opacity-0 group-hover:opacity-100 transition-opacity">
            <div class="w-8 h-8 rounded-full bg-primary/20 flex items-center justify-center">
              <Icon name="heroicons:cursor-arrow-rays" class="w-4 h-4 text-primary" />
            </div>
          </div>
        </NuxtLink>
      </div>

      <!-- Bottom CTA -->
      <div class="text-center mt-16 opacity-0 animate-fade-in-up stagger-6">
        <div class="glass-card rounded-2xl p-6 max-w-2xl mx-auto mb-6">
          <div class="flex items-center justify-center gap-2 mb-3">
            <Icon name="heroicons:light-bulb" class="w-5 h-5 text-primary" />
            <h3 class="text-lg font-semibold text-[var(--text-primary)]">Не нашли нужную услугу?</h3>
          </div>
          <p class="text-[var(--text-muted)] mb-4">
            Мы постоянно расширяем возможности сообщества. Свяжитесь с нами, и мы обсудим ваши потребности.
          </p>
          <div class="flex flex-col sm:flex-row items-center justify-center gap-3">
            <NuxtLink
              to="/connect"
              class="btn-secondary inline-flex items-center gap-2"
            >
              <Icon name="heroicons:chat-bubble-left-right" class="w-5 h-5" />
              <span>Связаться с нами</span>
            </NuxtLink>
            <button
              @click="chatStore.open()"
              class="btn-primary inline-flex items-center gap-2"
            >
              <Icon name="heroicons:phone" class="w-5 h-5" />
              <span>Задать вопрос</span>
            </button>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

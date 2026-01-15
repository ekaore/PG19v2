<script setup lang="ts">
interface Stat {
  value: string
  unit: string
  label: string
  color: string
}

interface HeroStatsContent {
  stats: Stat[]
  badge: string
}

// Загружаем контент из API
const { content } = useSiteContent<{ hero_stats: HeroStatsContent }>('home')

// Получаем статистику из контента или используем fallback
const stats = computed(() => content.value?.hero_stats?.stats || [
  { value: '191', unit: 'канал', label: 'ТВ', color: 'secondary' },
  { value: '699', unit: '₽/мес', label: 'от', color: 'accent' }
])

const badgeText = computed(() => content.value?.hero_stats?.badge || 'Более 100 000 участников сообщества')

// Функция для плавной прокрутки к следующей секции
function scrollToNext() {
  if (import.meta.client) {
    const nextSection = document.querySelector('section:not(:first-of-type)')
    if (nextSection) {
      nextSection.scrollIntoView({ behavior: 'smooth', block: 'start' })
    }
  }
}
</script>

<template>
  <section class="relative min-h-screen flex items-center mesh-gradient-hero overflow-hidden pt-20">
    <!-- Animated network pattern -->
    <div class="absolute inset-0 network-pattern opacity-30"></div>

    <!-- Floating decorative shapes -->
    <div class="floating-shape w-[500px] h-[500px] bg-primary/20 top-1/4 -left-48 animate-float"></div>
    <div class="floating-shape w-[400px] h-[400px] bg-secondary/15 bottom-1/4 -right-32 animate-float" style="animation-delay: -2s;"></div>
    <div class="floating-shape w-[300px] h-[300px] bg-info/10 top-1/2 left-1/3 animate-float" style="animation-delay: -4s;"></div>

    <!-- Content -->
    <div class="container mx-auto px-4 py-12 md:py-16 relative z-10">
      <div class="max-w-5xl mx-auto">
        <!-- Main content grid -->
        <div class="grid lg:grid-cols-5 gap-8 lg:gap-12 items-center">
          <!-- Text content -->
          <div class="lg:col-span-3 text-center lg:text-left">
            <!-- Badge -->
            <div
              class="inline-flex items-center gap-2 glass-card rounded-full px-5 py-2.5 mb-8 opacity-0 animate-fade-in-up hover:scale-105 transition-transform group cursor-default"
            >
              <span class="relative flex h-2.5 w-2.5">
                <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-accent opacity-75"></span>
                <span class="relative inline-flex rounded-full h-2.5 w-2.5 bg-accent"></span>
              </span>
              <span class="text-sm font-medium text-[var(--text-secondary)] group-hover:text-[var(--text-primary)] transition-colors">{{ badgeText }}</span>
              <Icon name="heroicons:arrow-trending-up" class="w-4 h-4 text-accent opacity-0 group-hover:opacity-100 transition-opacity" />
            </div>

            <!-- Heading -->
            <h1
              class="text-4xl md:text-5xl lg:text-6xl xl:text-7xl font-bold mb-6 leading-[1.1] opacity-0 animate-fade-in-up stagger-1"
            >
              <img src="/logo.png" alt="ПЖ19" class="inline-block h-12 md:h-16 lg:h-20 align-baseline mr-2" />
              <span class="text-[var(--text-primary)]">—</span>
              <br class="hidden sm:block" />
              <span class="text-gradient-primary">сообщество</span>
              <span class="text-[var(--text-primary)]">,</span>
              <br />
              <span class="text-[var(--text-muted)] font-normal">а не провайдер</span>
            </h1>

            <!-- Subheading -->
            <p
              class="text-lg md:text-xl text-[var(--text-muted)] mb-6 max-w-xl mx-auto lg:mx-0 leading-relaxed opacity-0 animate-fade-in-up stagger-2"
            >
              Закрытое сообщество для совместного доступа к услугам связи.
              <span class="text-[var(--text-secondary)] font-medium">Мы не продаём интернет</span> — мы вместе строим инфраструктуру для себя.
            </p>

            <!-- Визуальная подсказка о преимуществах -->
            <div class="mb-6 opacity-0 animate-fade-in-up stagger-2 flex flex-wrap gap-2 justify-center lg:justify-start">
              <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-medium bg-accent/10 text-accent border border-accent/20">
                <Icon name="heroicons:check" class="w-3.5 h-3.5" />
                <span>БЕЗ ОГРАНИЧЕНИЙ</span>
              </span>
              <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-medium bg-primary/10 text-primary border border-primary/20">
                <Icon name="heroicons:check" class="w-3.5 h-3.5" />
                <span>Прозрачные взносы</span>
              </span>
              <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-medium bg-secondary/10 text-secondary border border-secondary/20">
                <Icon name="heroicons:check" class="w-3.5 h-3.5" />
                <span>Управление сообществом</span>
              </span>
            </div>

            <!-- CTA Buttons -->
            <div
              class="flex flex-col sm:flex-row items-center lg:items-start justify-center lg:justify-start gap-4 mb-10 opacity-0 animate-fade-in-up stagger-3"
            >
              <NuxtLink
                to="/connect"
                class="group w-full sm:w-auto btn-accent inline-flex items-center justify-center gap-3 px-8 py-4 text-lg relative overflow-hidden"
              >
                <span class="relative z-10 flex items-center gap-3">
                  <Icon name="heroicons:user-plus" class="w-5 h-5" />
                  <span>Вступить в сообщество</span>
                  <Icon
                    name="heroicons:arrow-right"
                    class="w-5 h-5 transition-transform group-hover:translate-x-1"
                  />
                </span>
                <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/10 to-transparent translate-x-[-100%] group-hover:translate-x-[100%] transition-transform duration-1000" />
              </NuxtLink>
              <NuxtLink
                to="/about"
                class="w-full sm:w-auto btn-secondary inline-flex items-center justify-center gap-2 text-lg group"
              >
                <Icon name="heroicons:information-circle" class="w-5 h-5 transition-transform group-hover:scale-110" />
                <span>Узнать больше</span>
              </NuxtLink>
            </div>

            <!-- Визуальная подсказка для прокрутки -->
            <div class="opacity-0 animate-fade-in-up stagger-4 flex flex-col items-center gap-2 text-[var(--text-muted)] cursor-pointer group" @click="scrollToNext">
              <p class="text-sm group-hover:text-[var(--text-primary)] transition-colors">Узнайте больше о наших услугах</p>
              <Icon name="heroicons:chevron-down" class="w-6 h-6 animate-bounce group-hover:scale-110 transition-transform" />
            </div>
          </div>

          <!-- Stats cards -->
          <div class="lg:col-span-2">
            <div class="grid gap-4 max-w-sm mx-auto lg:ml-auto">
              <!-- Speed card - special emphasis -->
              <div class="glass-card rounded-2xl p-6 opacity-0 animate-fade-in-up stagger-2 border-primary/30 hover:border-primary/50 transition-all group cursor-pointer hover:scale-105">
                <div class="flex items-center justify-between mb-3">
                  <div class="flex items-center gap-2 text-[var(--text-muted)] text-sm">
                    <Icon name="heroicons:bolt" class="w-4 h-4 text-primary group-hover:animate-pulse" />
                    <span>Скорость интернета</span>
                  </div>
                  <Icon name="heroicons:sparkles" class="w-4 h-4 text-primary opacity-0 group-hover:opacity-100 transition-opacity" />
                </div>
                <p class="text-xl md:text-2xl font-bold text-primary mb-1 group-hover:scale-105 transition-transform">
                  Без ограничений
                </p>
                <p class="text-[var(--text-muted)] text-sm">
                  Канал до <span class="text-[var(--text-secondary)] font-semibold">1000 Мбит/с</span> — вся скорость ваша
                </p>
                <!-- Визуальная подсказка -->
                <div class="mt-3 pt-3 border-t border-[var(--glass-border)] opacity-0 group-hover:opacity-100 transition-opacity">
                  <p class="text-xs text-[var(--text-muted)] flex items-center gap-1.5">
                    <Icon name="heroicons:light-bulb" class="w-3.5 h-3.5" />
                    <span>Скорость зависит только от вашего оборудования</span>
                  </p>
                </div>
              </div>

              <div
                v-for="(stat, index) in stats"
                :key="stat.label"
                class="glass-card rounded-2xl p-6 opacity-0 animate-fade-in-up hover:scale-105 transition-all group cursor-pointer"
                :class="`stagger-${index + 3}`"
              >
                <div class="flex items-center justify-between mb-2">
                  <p class="text-[var(--text-muted)] text-xs uppercase tracking-wider">{{ stat.label }}</p>
                  <Icon
                    :name="stat.label === 'ТВ' ? 'heroicons:tv' : 'heroicons:banknotes'"
                    class="w-4 h-4 text-[var(--text-muted)] opacity-0 group-hover:opacity-100 transition-opacity"
                  />
                </div>
                <div class="flex items-baseline gap-2">
                  <span
                    class="text-4xl md:text-5xl font-bold transition-all group-hover:scale-110"
                    :class="{
                      'text-primary': stat.color === 'primary',
                      'text-secondary': stat.color === 'secondary',
                      'text-accent': stat.color === 'accent'
                    }"
                  >
                    {{ stat.value }}
                  </span>
                  <span class="text-lg text-[var(--text-muted)]">{{ stat.unit }}</span>
                </div>
                <!-- Дополнительная информация при наведении -->
                <div class="mt-3 pt-3 border-t border-[var(--glass-border)] opacity-0 group-hover:opacity-100 transition-opacity">
                  <p class="text-xs text-[var(--text-muted)]">
                    <span v-if="stat.label === 'ТВ'">Цифровое телевидение высокого качества</span>
                    <span v-else>Минимальный членский взнос</span>
                  </p>
                </div>
              </div>

            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Bottom gradient fade (instead of wave) -->
    <div class="absolute bottom-0 left-0 right-0 h-32 bg-gradient-to-t from-[var(--bg-base)] to-transparent"></div>
  </section>
</template>

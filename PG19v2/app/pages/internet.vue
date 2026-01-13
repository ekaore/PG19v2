<script setup lang="ts">
useHead({
  title: 'Интернет — ПЖ19'
})

interface Feature {
  icon: string
  title: string
  description: string
}

interface InternetContent {
  items: Feature[]
  equipment?: {
    title: string
    router: {
      name: string
      description: string
      price_monthly: number
    }
  }
}

// Загружаем контент из API
const { content } = useSiteContent<{ features: InternetContent }>('internet')

// Получаем features из контента или используем fallback
const features = computed(() => content.value?.features?.items || [
  { icon: 'heroicons:no-symbol', title: 'Мы не режем скорость', description: 'Вы получаете всю полосу канала. Никаких искусственных ограничений' },
  { icon: 'heroicons:bolt', title: 'До 1000 Мбит/с', description: 'Максимальная скорость зависит только от вашего оборудования' },
  { icon: 'heroicons:device-tablet', title: '10+ устройств', description: 'Стабильная работа всех гаджетов одновременно' },
  { icon: 'heroicons:arrow-down-tray', title: '1 ГБ за 20 сек', description: 'Скачивание файлов на максимальной скорости' }
])

const equipment = computed(() => content.value?.features?.equipment?.router)
</script>

<template>
  <div class="pt-28">
    <!-- Hero -->
    <section class="mesh-gradient-hero py-12 md:py-16 relative overflow-hidden">
      <div class="absolute inset-0 network-pattern opacity-20"></div>
      <div class="floating-shape w-[400px] h-[400px] bg-primary/20 -top-32 -right-32"></div>

      <div class="container mx-auto px-4 relative z-10">
        <div class="max-w-4xl mx-auto text-center">
          <div class="inline-flex items-center justify-center w-20 h-20 glass-card rounded-3xl mb-8 opacity-0 animate-fade-in-up group hover:scale-110 transition-transform">
            <Icon name="heroicons:wifi" class="w-10 h-10 text-primary group-hover:animate-pulse" />
          </div>
          <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold text-[var(--text-primary)] mb-6 opacity-0 animate-fade-in-up stagger-1">
            Интернет <span class="text-gradient-primary">без ограничений</span>
          </h1>
          <p class="text-xl text-[var(--text-muted)] mb-8 max-w-2xl mx-auto opacity-0 animate-fade-in-up stagger-2">
            Мы не режем скорость — вы получаете всю полосу канала до 1000 Мбит/с.
            Никаких тарифных ограничений, скорость зависит только от вашего оборудования.
          </p>

          <!-- Визуальные индикаторы преимуществ -->
          <div class="flex flex-wrap items-center justify-center gap-4 mb-10 opacity-0 animate-fade-in-up stagger-2">
            <div class="flex items-center gap-2 px-4 py-2 glass-card rounded-full">
              <Icon name="heroicons:bolt" class="w-4 h-4 text-primary" />
              <span class="text-sm font-medium text-[var(--text-primary)]">До 1000 Мбит/с</span>
            </div>
            <div class="flex items-center gap-2 px-4 py-2 glass-card rounded-full">
              <Icon name="heroicons:check-circle" class="w-4 h-4 text-accent" />
              <span class="text-sm font-medium text-[var(--text-primary)]">Без ограничений</span>
            </div>
            <div class="flex items-center gap-2 px-4 py-2 glass-card rounded-full">
              <Icon name="heroicons:device-tablet" class="w-4 h-4 text-secondary" />
              <span class="text-sm font-medium text-[var(--text-primary)]">10+ устройств</span>
            </div>
          </div>

          <NuxtLink
            to="/connect"
            class="group btn-primary inline-flex items-center gap-3 px-8 py-4 text-lg opacity-0 animate-fade-in-up stagger-3 relative overflow-hidden"
          >
            <span class="relative z-10">Подключиться</span>
            <Icon name="heroicons:arrow-right" class="w-5 h-5 relative z-10 transition-transform group-hover:translate-x-1" />
            <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/10 to-transparent translate-x-[-100%] group-hover:translate-x-[100%] transition-transform duration-1000"></div>
          </NuxtLink>
        </div>
      </div>
    </section>

    <!-- Features -->
    <section class="py-12 md:py-16" :style="{ background: 'var(--bg-base)' }">
      <div class="container mx-auto px-4">
        <!-- Заголовок секции -->
        <div class="text-center mb-8">
          <div class="inline-flex items-center gap-2 glass-card rounded-full px-4 py-2 mb-4 opacity-0 animate-fade-in-up">
            <Icon name="heroicons:sparkles" class="w-4 h-4 text-primary" />
            <span class="text-primary font-medium text-sm uppercase tracking-wider">Преимущества</span>
          </div>
          <h2 class="text-3xl md:text-4xl font-bold text-[var(--text-primary)] opacity-0 animate-fade-in-up stagger-1">
            Почему выбирают нас?
          </h2>
        </div>

        <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
          <div
            v-for="(feature, index) in features"
            :key="feature.title"
            class="group glass-card p-6 rounded-2xl opacity-0 animate-fade-in-up hover:scale-105 transition-all duration-300 cursor-pointer"
            :class="`stagger-${index + 1}`"
          >
            <div class="icon-container mb-4 group-hover:scale-110 transition-transform">
              <div class="w-14 h-14 rounded-xl bg-gradient-to-br from-primary/20 to-primary/5 flex items-center justify-center group-hover:from-primary/30 group-hover:to-primary/10 transition-all">
                <Icon :name="feature.icon" class="w-7 h-7 text-primary" />
              </div>
            </div>
            <h3 class="text-lg font-semibold text-[var(--text-primary)] mb-2 group-hover:text-primary transition-colors">
              {{ feature.title }}
            </h3>
            <p class="text-[var(--text-muted)] group-hover:text-[var(--text-secondary)] transition-colors">
              {{ feature.description }}
            </p>
            <!-- Визуальная подсказка -->
            <div class="mt-4 pt-4 border-t border-[var(--glass-border)] opacity-0 group-hover:opacity-100 transition-opacity">
              <div class="flex items-center gap-2 text-xs text-accent">
                <Icon name="heroicons:check-badge" class="w-3.5 h-3.5" />
                <span>Включено в тариф</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Equipment -->
    <section class="py-20 md:py-32 mesh-gradient-dark relative overflow-hidden">
      <div class="floating-shape w-[400px] h-[400px] bg-primary/10 -bottom-32 -left-32"></div>
      
      <div class="container mx-auto px-4 relative z-10">
        <div class="text-center mb-8">
          <div class="inline-flex items-center gap-2 glass-card rounded-full px-4 py-2 mb-4">
            <Icon name="heroicons:cog-6-tooth" class="w-4 h-4 text-primary" />
            <span class="text-primary font-medium text-sm uppercase tracking-wider">Оборудование</span>
          </div>
          <h2 class="text-3xl md:text-4xl font-bold text-[var(--text-primary)] mb-4">
            Нужен роутер?
          </h2>
          <p class="text-lg text-[var(--text-muted)] max-w-2xl mx-auto">
            Мы можем предоставить современный Wi-Fi роутер в аренду или вы можете использовать свой
          </p>
        </div>

        <div class="max-w-2xl mx-auto">
          <div class="glass-card rounded-3xl p-8 group hover:scale-[1.02] transition-all duration-300 relative overflow-hidden">
            <!-- Glow effect -->
            <div class="absolute -inset-1 bg-gradient-to-br from-primary/20 via-secondary/10 to-accent/20 rounded-[32px] blur-xl opacity-0 group-hover:opacity-100 transition-opacity -z-10"></div>
            
            <div class="flex flex-col md:flex-row items-start gap-6">
              <div class="w-24 h-24 rounded-2xl bg-gradient-to-br from-primary/20 to-secondary/10 flex items-center justify-center flex-shrink-0 group-hover:scale-110 transition-transform">
                <Icon name="heroicons:wifi" class="w-12 h-12 text-primary" />
              </div>
              <div class="flex-grow">
                <div class="flex items-center gap-2 mb-2">
                  <h3 class="font-bold text-[var(--text-primary)] text-xl">
                    {{ equipment?.name || 'Wi-Fi роутер SNR-CPE-ME2' }}
                  </h3>
                  <span class="px-2 py-1 rounded-full bg-accent/10 text-accent text-xs font-medium border border-accent/20">
                    Рекомендуется
                  </span>
                </div>
                <p class="text-[var(--text-muted)] mb-4">
                  {{ equipment?.description || 'Двухдиапазонный роутер с поддержкой Wi-Fi 5' }}
                </p>
                
                <!-- Характеристики -->
                <div class="grid grid-cols-2 gap-3 mb-4">
                  <div class="flex items-center gap-2 text-sm text-[var(--text-muted)]">
                    <Icon name="heroicons:check-circle" class="w-4 h-4 text-accent" />
                    <span>Wi-Fi 5 (802.11ac)</span>
                  </div>
                  <div class="flex items-center gap-2 text-sm text-[var(--text-muted)]">
                    <Icon name="heroicons:check-circle" class="w-4 h-4 text-accent" />
                    <span>2.4 + 5 ГГц</span>
                  </div>
                  <div class="flex items-center gap-2 text-sm text-[var(--text-muted)]">
                    <Icon name="heroicons:check-circle" class="w-4 h-4 text-accent" />
                    <span>До 10 устройств</span>
                  </div>
                  <div class="flex items-center gap-2 text-sm text-[var(--text-muted)]">
                    <Icon name="heroicons:check-circle" class="w-4 h-4 text-accent" />
                    <span>Настройка включена</span>
                  </div>
                </div>

                <div class="flex items-baseline gap-2 pt-4 border-t border-[var(--glass-border)]">
                  <p class="text-3xl font-bold text-primary">
                    +{{ equipment?.price_monthly || 99 }}
                  </p>
                  <span class="text-lg text-[var(--text-muted)]">₽/мес</span>
                  <span class="text-sm text-[var(--text-muted)] ml-2">(аренда)</span>
                </div>

                <!-- Подсказка -->
                <div class="mt-4 flex items-center gap-2 text-xs text-[var(--text-muted)]">
                  <Icon name="heroicons:information-circle" class="w-4 h-4" />
                  <span>Можно использовать свой роутер, совместимый с нашим оборудованием</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

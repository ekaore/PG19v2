<script setup lang="ts">
useHead({
  title: 'Видеонаблюдение — ПЖ19'
})

const features = [
  { icon: 'heroicons:cloud', title: 'Облачный архив', description: 'Хранение записей в облаке до 30 дней' },
  { icon: 'heroicons:clock', title: '24/7 запись', description: 'Непрерывная запись круглосуточно' },
  { icon: 'heroicons:bell', title: 'Уведомления', description: 'Мгновенные оповещения о движении' },
  { icon: 'heroicons:device-phone-mobile', title: 'Мобильный доступ', description: 'Просмотр с любого устройства' }
]
</script>

<template>
  <div class="pt-28">
    <!-- Hero -->
    <section class="mesh-gradient-hero py-12 md:py-16 relative overflow-hidden">
      <div class="absolute inset-0 network-pattern opacity-20"></div>
      <div class="floating-shape w-[400px] h-[400px] bg-info/20 -top-32 -left-32"></div>

      <div class="container mx-auto px-4 relative z-10">
        <div class="max-w-4xl mx-auto text-center">
          <div class="inline-flex items-center justify-center w-20 h-20 glass-card rounded-3xl mb-8 opacity-0 animate-fade-in-up group hover:scale-110 transition-transform">
            <Icon name="heroicons:video-camera" class="w-10 h-10 text-info group-hover:animate-pulse" />
          </div>
          <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold text-[var(--text-primary)] mb-6 opacity-0 animate-fade-in-up stagger-1">
            <span class="text-info">Видео</span>наблюдение
          </h1>
          <p class="text-xl text-[var(--text-muted)] mb-8 max-w-2xl mx-auto opacity-0 animate-fade-in-up stagger-2">
            Облачное видеонаблюдение для дома и бизнеса с удалённым доступом
          </p>

          <!-- Визуальные индикаторы преимуществ -->
          <div class="flex flex-wrap items-center justify-center gap-4 mb-10 opacity-0 animate-fade-in-up stagger-2">
            <div class="flex items-center gap-2 px-4 py-2 glass-card rounded-full">
              <Icon name="heroicons:cloud" class="w-4 h-4 text-info" />
              <span class="text-sm font-medium text-[var(--text-primary)]">Облачное хранение</span>
            </div>
            <div class="flex items-center gap-2 px-4 py-2 glass-card rounded-full">
              <Icon name="heroicons:shield-check" class="w-4 h-4 text-accent" />
              <span class="text-sm font-medium text-[var(--text-primary)]">Безопасность</span>
            </div>
            <div class="flex items-center gap-2 px-4 py-2 glass-card rounded-full">
              <Icon name="heroicons:device-phone-mobile" class="w-4 h-4 text-primary" />
              <span class="text-sm font-medium text-[var(--text-primary)]">Доступ 24/7</span>
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
    <section class="py-20 md:py-32" :style="{ background: 'var(--bg-base)' }">
      <div class="container mx-auto px-4">
        <div class="text-center mb-8">
          <div class="inline-flex items-center gap-2 glass-card rounded-full px-4 py-2 mb-4 opacity-0 animate-fade-in-up">
            <Icon name="heroicons:sparkles" class="w-4 h-4 text-info" />
            <span class="text-info font-medium text-sm uppercase tracking-wider">Возможности</span>
          </div>
          <h2 class="text-3xl md:text-4xl font-bold text-[var(--text-primary)] mb-4 opacity-0 animate-fade-in-up stagger-1">
            Что входит в услугу?
          </h2>
          <p class="text-lg text-[var(--text-muted)] max-w-2xl mx-auto opacity-0 animate-fade-in-up stagger-2">
            Полный набор функций для эффективного видеонаблюдения
          </p>
        </div>

        <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
          <div
            v-for="(feature, index) in features"
            :key="feature.title"
            class="group glass-card p-6 rounded-2xl opacity-0 animate-fade-in-up hover:scale-105 transition-all duration-300 cursor-pointer"
            :class="`stagger-${index + 1}`"
          >
            <div class="w-14 h-14 rounded-xl bg-gradient-to-br from-info/20 to-info/5 flex items-center justify-center mb-4 group-hover:scale-110 transition-transform group-hover:from-info/30 group-hover:to-info/10">
              <Icon :name="feature.icon" class="w-7 h-7 text-info" />
            </div>
            <h3 class="text-lg font-semibold text-[var(--text-primary)] mb-2 group-hover:text-info transition-colors">
              {{ feature.title }}
            </h3>
            <p class="text-[var(--text-muted)] group-hover:text-[var(--text-secondary)] transition-colors">
              {{ feature.description }}
            </p>
            <!-- Визуальная подсказка -->
            <div class="mt-4 pt-4 border-t border-[var(--glass-border)] opacity-0 group-hover:opacity-100 transition-opacity">
              <div class="flex items-center gap-2 text-xs text-info">
                <Icon name="heroicons:check-badge" class="w-3.5 h-3.5" />
                <span>Включено в тариф</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Use Cases -->
    <section class="py-20 md:py-32 mesh-gradient-dark relative overflow-hidden">
      <div class="floating-shape w-[400px] h-[400px] bg-info/10 -bottom-32 -right-32"></div>
      
      <div class="container mx-auto px-4 relative z-10">
        <div class="text-center mb-8">
          <div class="inline-flex items-center gap-2 glass-card rounded-full px-4 py-2 mb-4">
            <Icon name="heroicons:home" class="w-4 h-4 text-info" />
            <span class="text-info font-medium text-sm uppercase tracking-wider">Применение</span>
          </div>
          <h2 class="text-3xl md:text-4xl font-bold text-[var(--text-primary)] mb-4">
            Для кого подходит?
          </h2>
          <p class="text-lg text-[var(--text-muted)] max-w-2xl mx-auto">
            Видеонаблюдение для дома, офиса и бизнеса
          </p>
        </div>

        <div class="grid md:grid-cols-3 gap-6 max-w-4xl mx-auto">
          <div class="glass-card rounded-2xl p-6 text-center group hover:scale-105 transition-all">
            <div class="w-16 h-16 rounded-xl bg-gradient-to-br from-info/20 to-info/5 flex items-center justify-center mx-auto mb-4 group-hover:scale-110 transition-transform">
              <Icon name="heroicons:home" class="w-8 h-8 text-info" />
            </div>
            <h3 class="font-bold text-[var(--text-primary)] mb-2 group-hover:text-info transition-colors">
              Для дома
            </h3>
            <p class="text-sm text-[var(--text-muted)] mb-3">
              Защита вашего дома и семьи
            </p>
            <ul class="text-xs text-[var(--text-muted)] space-y-1 text-left">
              <li class="flex items-center gap-2">
                <Icon name="heroicons:check" class="w-3.5 h-3.5 text-accent" />
                <span>Контроль периметра</span>
              </li>
              <li class="flex items-center gap-2">
                <Icon name="heroicons:check" class="w-3.5 h-3.5 text-accent" />
                <span>Уведомления о движении</span>
              </li>
              <li class="flex items-center gap-2">
                <Icon name="heroicons:check" class="w-3.5 h-3.5 text-accent" />
                <span>Просмотр с телефона</span>
              </li>
            </ul>
          </div>

          <div class="glass-card rounded-2xl p-6 text-center group hover:scale-105 transition-all">
            <div class="w-16 h-16 rounded-xl bg-gradient-to-br from-primary/20 to-primary/5 flex items-center justify-center mx-auto mb-4 group-hover:scale-110 transition-transform">
              <Icon name="heroicons:building-office" class="w-8 h-8 text-primary" />
            </div>
            <h3 class="font-bold text-[var(--text-primary)] mb-2 group-hover:text-primary transition-colors">
              Для офиса
            </h3>
            <p class="text-sm text-[var(--text-muted)] mb-3">
              Безопасность рабочего пространства
            </p>
            <ul class="text-xs text-[var(--text-muted)] space-y-1 text-left">
              <li class="flex items-center gap-2">
                <Icon name="heroicons:check" class="w-3.5 h-3.5 text-accent" />
                <span>Контроль доступа</span>
              </li>
              <li class="flex items-center gap-2">
                <Icon name="heroicons:check" class="w-3.5 h-3.5 text-accent" />
                <span>Архив событий</span>
              </li>
              <li class="flex items-center gap-2">
                <Icon name="heroicons:check" class="w-3.5 h-3.5 text-accent" />
                <span>Удаленный мониторинг</span>
              </li>
            </ul>
          </div>

          <div class="glass-card rounded-2xl p-6 text-center group hover:scale-105 transition-all">
            <div class="w-16 h-16 rounded-xl bg-gradient-to-br from-secondary/20 to-secondary/5 flex items-center justify-center mx-auto mb-4 group-hover:scale-110 transition-transform">
              <Icon name="heroicons:briefcase" class="w-8 h-8 text-secondary" />
            </div>
            <h3 class="font-bold text-[var(--text-primary)] mb-2 group-hover:text-secondary transition-colors">
              Для бизнеса
            </h3>
            <p class="text-sm text-[var(--text-muted)] mb-3">
              Комплексное решение для бизнеса
            </p>
            <ul class="text-xs text-[var(--text-muted)] space-y-1 text-left">
              <li class="flex items-center gap-2">
                <Icon name="heroicons:check" class="w-3.5 h-3.5 text-accent" />
                <span>Множество камер</span>
              </li>
              <li class="flex items-center gap-2">
                <Icon name="heroicons:check" class="w-3.5 h-3.5 text-accent" />
                <span>Расширенный архив</span>
              </li>
              <li class="flex items-center gap-2">
                <Icon name="heroicons:check" class="w-3.5 h-3.5 text-accent" />
                <span>Интеграция с системами</span>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </section>

    <!-- Equipment -->
    <section class="py-20 md:py-32" :style="{ background: 'var(--bg-base)' }">
      <div class="container mx-auto px-4">
        <div class="text-center mb-8">
          <div class="inline-flex items-center gap-2 glass-card rounded-full px-4 py-2 mb-4">
            <Icon name="heroicons:cog-6-tooth" class="w-4 h-4 text-info" />
            <span class="text-info font-medium text-sm uppercase tracking-wider">Оборудование</span>
          </div>
          <h2 class="text-3xl md:text-4xl font-bold text-[var(--text-primary)] mb-4">
            Какие камеры нужны?
          </h2>
          <p class="text-lg text-[var(--text-muted)] max-w-2xl mx-auto">
            Мы поможем подобрать и настроить оборудование под ваши задачи
          </p>
        </div>

        <div class="max-w-2xl mx-auto">
          <div class="glass-card rounded-3xl p-8 group hover:scale-[1.02] transition-all duration-300 relative overflow-hidden">
            <!-- Glow effect -->
            <div class="absolute -inset-1 bg-gradient-to-br from-info/20 via-primary/10 to-accent/20 rounded-[32px] blur-xl opacity-0 group-hover:opacity-100 transition-opacity -z-10"></div>
            
            <div class="flex flex-col md:flex-row items-start gap-6">
              <div class="w-24 h-24 rounded-2xl bg-gradient-to-br from-info/20 to-primary/10 flex items-center justify-center flex-shrink-0 group-hover:scale-110 transition-transform">
                <Icon name="heroicons:video-camera" class="w-12 h-12 text-info" />
              </div>
              <div class="flex-grow">
                <div class="flex items-center gap-2 mb-2">
                  <h3 class="font-bold text-[var(--text-primary)] text-xl">
                    IP-камеры
                  </h3>
                  <span class="px-2 py-1 rounded-full bg-accent/10 text-accent text-xs font-medium border border-accent/20">
                    Рекомендуется
                  </span>
                </div>
                <p class="text-[var(--text-muted)] mb-4">
                  Современные IP-камеры с поддержкой HD и Full HD разрешения
                </p>
                
                <!-- Характеристики -->
                <div class="grid grid-cols-2 gap-3 mb-4">
                  <div class="flex items-center gap-2 text-sm text-[var(--text-muted)]">
                    <Icon name="heroicons:check-circle" class="w-4 h-4 text-accent" />
                    <span>HD / Full HD</span>
                  </div>
                  <div class="flex items-center gap-2 text-sm text-[var(--text-muted)]">
                    <Icon name="heroicons:check-circle" class="w-4 h-4 text-accent" />
                    <span>Ночное видение</span>
                  </div>
                  <div class="flex items-center gap-2 text-sm text-[var(--text-muted)]">
                    <Icon name="heroicons:check-circle" class="w-4 h-4 text-accent" />
                    <span>Детекция движения</span>
                  </div>
                  <div class="flex items-center gap-2 text-sm text-[var(--text-muted)]">
                    <Icon name="heroicons:check-circle" class="w-4 h-4 text-accent" />
                    <span>Настройка включена</span>
                  </div>
                </div>

                <!-- Подсказка -->
                <div class="mt-4 flex items-center gap-2 text-xs text-[var(--text-muted)]">
                  <Icon name="heroicons:information-circle" class="w-4 h-4" />
                  <span>Можно использовать свои совместимые IP-камеры или приобрести у нас</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

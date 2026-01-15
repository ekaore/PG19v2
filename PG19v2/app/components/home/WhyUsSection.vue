<script setup lang="ts">
const features = [
  {
    icon: 'heroicons:bolt',
    title: 'Скорость не ограничена',
    description: 'Мы не режем скорость. Вы получаете всю полосу канала — до 1000 Мбит/с без искусственных лимитов'
  },
  {
    icon: 'heroicons:banknotes',
    title: 'Взносы, а не оплата услуг',
    description: 'Членские взносы идут только на содержание и развитие инфраструктуры сообщества'
  },
  {
    icon: 'heroicons:user-group',
    title: 'Общее управление',
    description: 'Один пайщик = один голос. Каждый участник может влиять на развитие сообщества'
  },
  {
    icon: 'heroicons:arrow-trending-up',
    title: 'Чем нас больше — тем лучше',
    description: 'Новые участники усиливают возможности всего сообщества и качество связи'
  }
]

const included = [
  { text: 'Интернет без ограничения скорости', icon: 'heroicons:wifi' },
  { text: 'Цифровое ТВ 191 канал', icon: 'heroicons:tv' },
  { text: 'Техподдержка 24/7', icon: 'heroicons:phone' },
  { text: 'Право голоса', icon: 'heroicons:hand-raised' }
]
</script>

<template>
  <section class="py-12 md:py-16 mesh-gradient-dark relative overflow-hidden">
    <!-- Decorative elements -->
    <div class="floating-shape w-[600px] h-[600px] bg-primary/10 -bottom-48 -left-48"></div>
    <div class="floating-shape w-[400px] h-[400px] bg-secondary/10 -top-32 -right-32"></div>

    <div class="container mx-auto px-4 relative z-10">
      <div class="grid lg:grid-cols-2 gap-8 lg:gap-12 items-center">
        <!-- Content -->
        <div>
          <span class="inline-block text-primary font-medium text-sm uppercase tracking-wider mb-4 opacity-0 animate-fade-in-up">
            Наши преимущества
          </span>

          <h2 class="text-3xl md:text-4xl lg:text-5xl font-bold text-[var(--text-primary)] mb-6 opacity-0 animate-fade-in-up stagger-1">
            Почему мы —
            <span class="text-gradient-primary">сообщество</span>,
            <br class="hidden md:block" />
            а не провайдер?
          </h2>

          <p class="text-lg text-[var(--text-muted)] mb-8 leading-relaxed opacity-0 animate-fade-in-up stagger-2">
            Коммерческие провайдеры ориентированы на прибыль.
            Мы — на <span class="text-[var(--text-primary)] font-semibold">доверие, прозрачность и равноправие</span>.
            Каждый член сообщества — не клиент, а полноправный участник.
          </p>

          <!-- Визуальные акценты на ключевых словах -->
          <div class="mb-8 opacity-0 animate-fade-in-up stagger-2 flex flex-wrap gap-2">
            <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-medium bg-primary/10 text-primary border border-primary/20">
              <Icon name="heroicons:heart" class="w-3.5 h-3.5" />
              <span>Доверие</span>
            </span>
            <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-medium bg-accent/10 text-accent border border-accent/20">
              <Icon name="heroicons:eye" class="w-3.5 h-3.5" />
              <span>Прозрачность</span>
            </span>
            <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-medium bg-secondary/10 text-secondary border border-secondary/20">
              <Icon name="heroicons:scale" class="w-3.5 h-3.5" />
              <span>Равноправие</span>
            </span>
          </div>

          <!-- Визуальное сравнение -->
          <div class="mb-8 opacity-0 animate-fade-in-up stagger-2">
            <div class="glass-card rounded-2xl p-4 flex items-center justify-between gap-4">
              <div class="flex-1 text-center">
                <div class="text-xs text-[var(--text-muted)] mb-2">Обычные провайдеры</div>
                <div class="flex items-center justify-center gap-2 text-red-400">
                  <Icon name="heroicons:x-circle" class="w-5 h-5" />
                  <span class="text-sm font-medium">Ограничения</span>
                </div>
              </div>
              <div class="w-px h-12 bg-[var(--glass-border)]"></div>
              <div class="flex-1 text-center">
                <div class="text-xs text-[var(--text-muted)] mb-2">Наше сообщество</div>
                <div class="flex items-center justify-center gap-2 text-accent">
                  <Icon name="heroicons:check-circle" class="w-5 h-5" />
                  <span class="text-sm font-medium">Без ограничений</span>
                </div>
              </div>
            </div>
          </div>

          <div class="grid sm:grid-cols-2 gap-6">
            <div
              v-for="(feature, index) in features"
              :key="index"
              class="group opacity-0 animate-fade-in-up glass-card rounded-2xl p-5 hover:scale-105 transition-all duration-300"
              :class="`stagger-${index + 3}`"
            >
              <div class="flex gap-4">
                <div class="flex-shrink-0 w-14 h-14 rounded-xl glass-card flex items-center justify-center group-hover:bg-primary/10 group-hover:scale-110 transition-all duration-300">
                  <Icon :name="feature.icon" class="w-7 h-7 text-primary group-hover:scale-110 transition-transform" />
                </div>
                <div class="flex-1">
                  <h3 class="font-semibold text-[var(--text-primary)] mb-2 group-hover:text-primary transition-colors text-lg">
                    {{ feature.title }}
                  </h3>
                  <p class="text-[var(--text-muted)] text-sm leading-relaxed">
                    {{ feature.description }}
                  </p>
                  <!-- Визуальная подсказка -->
                  <div class="mt-3 pt-3 border-t border-[var(--glass-border)] opacity-0 group-hover:opacity-100 transition-opacity">
                    <div class="flex items-center gap-2 text-xs text-accent">
                      <Icon name="heroicons:sparkles" class="w-3.5 h-3.5" />
                      <span>Ключевое преимущество</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Pricing card -->
        <div class="relative opacity-0 animate-fade-in-up stagger-5 group">
          <!-- Glow effect -->
          <div class="absolute -inset-4 bg-gradient-to-br from-primary/30 via-secondary/20 to-accent/20 rounded-[40px] blur-2xl opacity-60 group-hover:opacity-80 transition-opacity"></div>

          <div class="pricing-card relative p-8 md:p-10 hover:scale-[1.02] transition-transform duration-300">
            <!-- Header -->
            <div class="text-center mb-10">
              <div class="inline-flex items-center gap-2 glass-card rounded-full px-4 py-2 mb-6">
                <Icon name="heroicons:sparkles" class="w-4 h-4 text-primary" />
                <span class="text-sm text-[var(--text-secondary)]">Единый взнос</span>
              </div>

              <p class="text-[var(--text-muted)] mb-3">Членский взнос от</p>
              <div class="flex items-baseline justify-center gap-2 relative">
                <span class="text-6xl md:text-7xl font-bold text-[var(--text-primary)] relative">
                  699
                  <!-- Визуальный акцент -->
                  <span class="absolute -top-2 -right-2 w-3 h-3 bg-accent rounded-full animate-pulse"></span>
                </span>
                <div class="text-left">
                  <span class="text-2xl text-[var(--text-muted)]">₽</span>
                  <p class="text-sm text-[var(--text-muted)]">в месяц</p>
                </div>
              </div>
              <div class="mt-3 flex items-center justify-center gap-2">
                <Icon name="heroicons:information-circle" class="w-4 h-4 text-[var(--text-muted)]" />
                <p class="text-sm text-[var(--text-muted)]">
                Зависит от локации подключения
              </p>
              </div>
              <!-- Визуальная подсказка о выгоде -->
              <div class="mt-4 inline-flex items-center gap-2 px-4 py-2 rounded-full bg-accent/10 border border-accent/20">
                <Icon name="heroicons:banknotes" class="w-4 h-4 text-accent" />
                <span class="text-xs text-accent font-medium">Все услуги включены</span>
              </div>
            </div>

            <!-- Included -->
            <div class="space-y-3 mb-10">
              <div class="mb-4">
                <h4 class="text-sm font-semibold text-[var(--text-primary)] mb-2 flex items-center gap-2">
                  <Icon name="heroicons:check-badge" class="w-4 h-4 text-accent" />
                  <span>Всё включено в один взнос:</span>
                </h4>
              </div>
              <div
                v-for="(item, index) in included"
                :key="item.text"
                class="group flex items-center gap-4 p-4 rounded-xl bg-[var(--glass-bg)] hover:bg-[var(--glass-hover-bg)] transition-all hover:scale-105 cursor-pointer"
                :style="{ transitionDelay: `${index * 50}ms` }"
              >
                <div class="w-10 h-10 rounded-lg bg-gradient-to-br from-accent/20 to-accent/5 flex items-center justify-center group-hover:scale-110 transition-transform">
                  <Icon :name="item.icon" class="w-5 h-5 text-accent" />
                </div>
                <span class="text-[var(--text-primary)] font-medium flex-1">{{ item.text }}</span>
                <Icon name="heroicons:check-circle" class="w-5 h-5 text-accent opacity-0 group-hover:opacity-100 transition-opacity" />
              </div>
            </div>

            <!-- CTA -->
            <NuxtLink
              to="/connect"
              class="group btn-accent flex items-center justify-center gap-3 w-full py-5 text-lg relative overflow-hidden"
            >
              <span class="relative z-10">Вступить в сообщество</span>
              <Icon
                name="heroicons:arrow-right"
                class="w-5 h-5 transition-transform group-hover:translate-x-1 relative z-10"
              />
              <!-- Анимация при наведении -->
              <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/10 to-transparent translate-x-[-100%] group-hover:translate-x-[100%] transition-transform duration-1000"></div>
            </NuxtLink>
            
            <!-- Дополнительная подсказка -->
            <div class="mt-4 text-center">
              <p class="text-xs text-[var(--text-muted)] flex items-center justify-center gap-2">
                <Icon name="heroicons:clock" class="w-3.5 h-3.5" />
                <span>Подключение за 1-2 дня</span>
              </p>
            </div>

            <!-- Legal note -->
            <p class="text-xs text-[var(--text-muted)] text-center mt-6 flex items-center justify-center gap-2">
              <Icon name="heroicons:shield-check" class="w-4 h-4" />
              Деятельность в рамках закона РФ о потребительской кооперации
            </p>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

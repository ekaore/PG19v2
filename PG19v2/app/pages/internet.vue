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

// FAQ данные
const faqItems = [
  {
    question: 'Какая реальная скорость интернета?',
    answer: 'Скорость зависит от вашего оборудования и расстояния до точки доступа. Максимальная скорость канала — до 1000 Мбит/с. Мы не ограничиваем скорость искусственно.'
  },
  {
    question: 'Нужно ли покупать роутер?',
    answer: 'Нет, роутер можно взять в аренду за 99 ₽/мес или использовать свой совместимый роутер. Настройка включена в стоимость.'
  },
  {
    question: 'Сколько устройств можно подключить?',
    answer: 'Ограничений по количеству устройств нет. Рекомендуется до 10 устройств для стабильной работы, но можно и больше.'
  },
  {
    question: 'Есть ли ограничения по трафику?',
    answer: 'Нет, трафик безлимитный. Вы можете использовать интернет без ограничений по объему данных.'
  },
  {
    question: 'Как быстро происходит подключение?',
    answer: 'Обычно подключение занимает 1-3 рабочих дня после подачи заявки, в зависимости от технических возможностей.'
  },
  {
    question: 'Что делать при проблемах со связью?',
    answer: 'Свяжитесь с нами через чат на сайте или Telegram. Мы оперативно решаем технические вопросы.'
  }
]

// Пошаговая инструкция
const steps = [
  {
    icon: 'heroicons:document-text',
    title: 'Подайте заявку',
    description: 'Заполните форму подключения на сайте или свяжитесь с нами'
  },
  {
    icon: 'heroicons:check-badge',
    title: 'Проверка возможности',
    description: 'Мы проверим техническую возможность подключения по вашему адресу'
  },
  {
    icon: 'heroicons:calendar',
    title: 'Согласование даты',
    description: 'Согласуем удобное время для установки оборудования'
  },
  {
    icon: 'heroicons:wrench-screwdriver',
    title: 'Установка',
    description: 'Наш специалист установит и настроит оборудование'
  },
  {
    icon: 'heroicons:check-circle',
    title: 'Готово!',
    description: 'Интернет готов к использованию. При необходимости поможем с настройкой'
  }
]

const activeFaq = ref<number | null>(null)

function toggleFaq(index: number) {
  activeFaq.value = activeFaq.value === index ? null : index
}
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
    <section class="py-12 md:py-16 mesh-gradient-dark relative overflow-hidden">
      <div class="floating-shape w-[400px] h-[400px] bg-primary/10 -bottom-32 -left-32"></div>
      
      <div class="container mx-auto px-4 relative z-10">
        <div class="text-center mb-6">
          <div class="inline-flex items-center gap-2 glass-card rounded-full px-4 py-2 mb-3">
            <Icon name="heroicons:cog-6-tooth" class="w-4 h-4 text-primary" />
            <span class="text-primary font-medium text-sm uppercase tracking-wider">Оборудование</span>
          </div>
          <h2 class="text-3xl md:text-4xl font-bold text-[var(--text-primary)] mb-3">
            Нужен роутер?
          </h2>
          <p class="text-lg text-[var(--text-muted)] max-w-2xl mx-auto">
            Мы можем предоставить современный Wi-Fi роутер в аренду или вы можете использовать свой
          </p>
        </div>

        <div class="max-w-2xl mx-auto">
          <div class="glass-card rounded-3xl p-6 group hover:scale-[1.02] transition-all duration-300 relative overflow-hidden">
            <!-- Glow effect -->
            <div class="absolute -inset-1 bg-gradient-to-br from-primary/20 via-secondary/10 to-accent/20 rounded-[32px] blur-xl opacity-0 group-hover:opacity-100 transition-opacity -z-10"></div>
            
            <div class="flex flex-col md:flex-row items-start gap-4">
              <div class="w-20 h-20 rounded-2xl bg-gradient-to-br from-primary/20 to-secondary/10 flex items-center justify-center flex-shrink-0 group-hover:scale-110 transition-transform">
                <Icon name="heroicons:wifi" class="w-10 h-10 text-primary" />
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
                <p class="text-[var(--text-muted)] mb-3">
                  {{ equipment?.description || 'Двухдиапазонный роутер с поддержкой Wi-Fi 5' }}
                </p>
                
                <!-- Характеристики -->
                <div class="grid grid-cols-2 gap-2 mb-3">
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

                <div class="flex items-baseline gap-2 pt-3 border-t border-[var(--glass-border)]">
                  <p class="text-3xl font-bold text-primary">
                    +{{ equipment?.price_monthly || 99 }}
                  </p>
                  <span class="text-lg text-[var(--text-muted)]">₽/мес</span>
                  <span class="text-sm text-[var(--text-muted)] ml-2">(аренда)</span>
                </div>

                <!-- Подсказка -->
                <div class="mt-3 flex items-center gap-2 text-xs text-[var(--text-muted)]">
                  <Icon name="heroicons:information-circle" class="w-4 h-4" />
                  <span>Можно использовать свой роутер, совместимый с нашим оборудованием</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- How to Connect -->
    <section class="py-12 md:py-16" :style="{ background: 'var(--bg-base)' }">
      <div class="container mx-auto px-4">
        <div class="text-center mb-12">
          <div class="inline-flex items-center gap-2 glass-card rounded-full px-4 py-2 mb-4">
            <Icon name="heroicons:arrow-path" class="w-4 h-4 text-primary" />
            <span class="text-primary font-medium text-sm uppercase tracking-wider">Как подключиться</span>
          </div>
          <h2 class="text-3xl md:text-4xl font-bold text-[var(--text-primary)] mb-4">
            Простой процесс подключения
          </h2>
          <p class="text-lg text-[var(--text-muted)] max-w-2xl mx-auto">
            Всего 5 простых шагов до высокоскоростного интернета
          </p>
        </div>

        <div class="max-w-4xl mx-auto">
          <div class="relative">
            <!-- Vertical timeline line -->
            <div class="hidden md:block absolute left-8 top-0 bottom-0 w-0.5 bg-gradient-to-b from-primary/30 via-primary/50 to-primary/30"></div>
            
            <div class="space-y-8">
              <div
                v-for="(step, index) in steps"
                :key="step.title"
                class="relative opacity-0 animate-fade-in-up"
                :class="`stagger-${index + 1}`"
              >
                <!-- Timeline dot -->
                <div class="hidden md:block absolute left-8 top-8 w-4 h-4 rounded-full bg-primary border-4 border-[var(--bg-base)] transform -translate-x-1/2 z-10 shadow-lg shadow-primary/30"></div>
                
                <!-- Content card -->
                <div class="md:ml-20 glass-card rounded-2xl p-6 md:p-8 group hover:scale-[1.02] transition-all duration-300 relative overflow-hidden">
                  <!-- Gradient glow on hover -->
                  <div class="absolute inset-0 bg-gradient-to-r from-primary/5 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity -z-10"></div>
                  
                  <div class="flex flex-col md:flex-row items-start gap-6">
                    <!-- Icon -->
                    <div class="flex-shrink-0">
                      <div class="w-16 h-16 rounded-xl bg-gradient-to-br from-primary/20 to-primary/5 flex items-center justify-center group-hover:scale-110 group-hover:from-primary/30 group-hover:to-primary/10 transition-all duration-300">
                        <Icon :name="step.icon" class="w-8 h-8 text-primary" />
                      </div>
                    </div>
                    
                    <!-- Content -->
                    <div class="flex-1">
                      <div class="flex items-center gap-3 mb-3">
                        <span class="px-3 py-1 rounded-full bg-primary/10 text-primary text-xs font-bold border border-primary/20">
                          Шаг {{ index + 1 }}
                        </span>
                        <h3 class="text-xl font-bold text-[var(--text-primary)] group-hover:text-primary transition-colors">
                          {{ step.title }}
                        </h3>
                      </div>
                      <p class="text-[var(--text-muted)] leading-relaxed mb-4">
                        {{ step.description }}
                      </p>
                      
                      <!-- Additional info for specific steps -->
                      <div
                        v-if="index === 0"
                        class="flex items-center gap-2 text-sm text-accent bg-accent/10 px-3 py-2 rounded-lg border border-accent/20"
                      >
                        <Icon name="heroicons:clock" class="w-4 h-4" />
                        <span>Заполнение займет 2-3 минуты</span>
                      </div>
                      <div
                        v-if="index === 1"
                        class="flex items-center gap-2 text-sm text-accent bg-accent/10 px-3 py-2 rounded-lg border border-accent/20"
                      >
                        <Icon name="heroicons:check-badge" class="w-4 h-4" />
                        <span>Проверка занимает 1 рабочий день</span>
                      </div>
                      <div
                        v-if="index === 2"
                        class="flex items-center gap-2 text-sm text-accent bg-accent/10 px-3 py-2 rounded-lg border border-accent/20"
                      >
                        <Icon name="heroicons:calendar" class="w-4 h-4" />
                        <span>Удобное время для вас</span>
                      </div>
                      <div
                        v-if="index === 3"
                        class="flex items-center gap-2 text-sm text-accent bg-accent/10 px-3 py-2 rounded-lg border border-accent/20"
                      >
                        <Icon name="heroicons:wrench-screwdriver" class="w-4 h-4" />
                        <span>Установка занимает 30-60 минут</span>
                      </div>
                      <div
                        v-if="index === 4"
                        class="flex items-center gap-2 text-sm text-accent bg-accent/10 px-3 py-2 rounded-lg border border-accent/20"
                      >
                        <Icon name="heroicons:sparkles" class="w-4 h-4" />
                        <span>Интернет готов к использованию!</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          <!-- CTA Button -->
          <div class="text-center mt-12">
            <NuxtLink
              to="/connect"
              class="group btn-primary inline-flex items-center gap-3 px-8 py-4 text-lg relative overflow-hidden"
            >
              <span class="relative z-10">Начать подключение</span>
              <Icon name="heroicons:arrow-right" class="w-5 h-5 relative z-10 transition-transform group-hover:translate-x-1" />
              <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/10 to-transparent translate-x-[-100%] group-hover:translate-x-[100%] transition-transform duration-1000"></div>
            </NuxtLink>
          </div>
        </div>
      </div>
    </section>

    <!-- FAQ -->
    <section class="py-12 md:py-16 mesh-gradient-dark relative overflow-hidden">
      <div class="floating-shape w-[400px] h-[400px] bg-secondary/10 -bottom-32 -left-32"></div>
      
      <div class="container mx-auto px-4 relative z-10">
        <div class="text-center mb-12">
          <div class="inline-flex items-center gap-2 glass-card rounded-full px-4 py-2 mb-4">
            <Icon name="heroicons:question-mark-circle" class="w-4 h-4 text-primary" />
            <span class="text-primary font-medium text-sm uppercase tracking-wider">Частые вопросы</span>
          </div>
          <h2 class="text-3xl md:text-4xl font-bold text-[var(--text-primary)] mb-4">
            Ответы на популярные вопросы
          </h2>
        </div>

        <div class="max-w-3xl mx-auto space-y-4">
          <div
            v-for="(item, index) in faqItems"
            :key="index"
            class="glass-card rounded-2xl overflow-hidden transition-all duration-300"
            :class="activeFaq === index ? 'ring-2 ring-primary/50' : ''"
          >
            <button
              @click="toggleFaq(index)"
              class="w-full p-6 text-left flex items-center justify-between gap-4 group"
            >
              <span class="font-semibold text-[var(--text-primary)] group-hover:text-primary transition-colors">
                {{ item.question }}
              </span>
              <Icon
                :name="activeFaq === index ? 'heroicons:chevron-up' : 'heroicons:chevron-down'"
                class="w-5 h-5 text-[var(--text-muted)] flex-shrink-0 transition-transform"
                :class="activeFaq === index ? 'rotate-180' : ''"
              />
            </button>
            <div
              v-show="activeFaq === index"
              class="px-6 pb-6 text-[var(--text-muted)] leading-relaxed animate-fade-in"
            >
              {{ item.answer }}
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

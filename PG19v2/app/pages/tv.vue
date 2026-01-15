<script setup lang="ts">
useHead({
  title: 'Телевидение — ПЖ19'
})

// Загружаем категории каналов из API
const { data: channelsData } = useTvChannels()

// Преобразуем в формат для отображения
const channels = computed(() => {
  return (channelsData.value || []).map(c => ({
    category: c.name,
    count: c.count,
    icon: c.icon
  }))
})

// Общее количество каналов
const totalChannels = computed(() => {
  return channels.value.reduce((sum, c) => sum + c.count, 0)
})

// FAQ
const faqItems = [
  {
    question: 'На каких устройствах можно смотреть ТВ?',
    answer: 'Телевидение доступно на Smart TV, ТВ-приставках, смартфонах, планшетах и компьютерах через приложение или веб-интерфейс.'
  },
  {
    question: 'Как работает архив передач?',
    answer: 'Вы можете просматривать передачи за последние 14 дней. Архив доступен для большинства каналов и обновляется автоматически.'
  },
  {
    question: 'Нужна ли ТВ-приставка?',
    answer: 'Приставка не обязательна, если у вас есть Smart TV или вы хотите смотреть на других устройствах. Приставка рекомендуется для лучшего качества и удобства.'
  },
  {
    question: 'Можно ли смотреть несколько каналов одновременно?',
    answer: 'Да, вы можете открыть несколько окон с разными каналами на разных устройствах одновременно.'
  },
  {
    question: 'Как часто обновляется список каналов?',
    answer: 'Список каналов регулярно обновляется. Новые каналы добавляются автоматически, о важных изменениях мы уведомляем участников сообщества.'
  },
  {
    question: 'Есть ли родительский контроль?',
    answer: 'Да, в настройках приставки и приложения можно настроить родительский контроль для ограничения доступа к определенным каналам.'
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
      <div class="floating-shape w-[400px] h-[400px] bg-secondary/20 -top-32 -left-32"></div>

      <div class="container mx-auto px-4 relative z-10">
        <div class="max-w-4xl mx-auto text-center">
          <div class="inline-flex items-center justify-center w-20 h-20 glass-card rounded-3xl mb-8 opacity-0 animate-fade-in-up group hover:scale-110 transition-transform">
            <Icon name="heroicons:tv" class="w-10 h-10 text-secondary group-hover:animate-pulse" />
          </div>
          <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold text-[var(--text-primary)] mb-6 opacity-0 animate-fade-in-up stagger-1">
            Цифровое <span class="text-gradient-secondary">телевидение</span>
          </h1>
          <p class="text-xl text-[var(--text-muted)] mb-6 opacity-0 animate-fade-in-up stagger-2">
            <span class="text-5xl font-bold text-secondary">{{ totalChannels || 191 }}</span> <span class="text-[var(--text-secondary)]">канал в HD и 4K качестве</span>
          </p>
          <p class="text-[var(--text-muted)] mb-8 opacity-0 animate-fade-in-up stagger-2">
            Включено в членский взнос без дополнительной платы
          </p>

          <!-- Визуальные индикаторы преимуществ -->
          <div class="flex flex-wrap items-center justify-center gap-4 mb-10 opacity-0 animate-fade-in-up stagger-2">
            <div class="flex items-center gap-2 px-4 py-2 glass-card rounded-full">
              <Icon name="heroicons:tv" class="w-4 h-4 text-secondary" />
              <span class="text-sm font-medium text-[var(--text-primary)]">HD и 4K</span>
            </div>
            <div class="flex items-center gap-2 px-4 py-2 glass-card rounded-full">
              <Icon name="heroicons:check-circle" class="w-4 h-4 text-accent" />
              <span class="text-sm font-medium text-[var(--text-primary)]">Без доплаты</span>
            </div>
            <div class="flex items-center gap-2 px-4 py-2 glass-card rounded-full">
              <Icon name="heroicons:clock" class="w-4 h-4 text-primary" />
              <span class="text-sm font-medium text-[var(--text-primary)]">Архив 14 дней</span>
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

    <!-- Channels -->
    <section class="py-12 md:py-16" :style="{ background: 'var(--bg-base)' }">
      <div class="container mx-auto px-4">
        <div class="text-center mb-8">
          <div class="inline-flex items-center gap-2 glass-card rounded-full px-4 py-2 mb-4 opacity-0 animate-fade-in-up">
            <Icon name="heroicons:sparkles" class="w-4 h-4 text-secondary" />
            <span class="text-secondary font-medium text-sm uppercase tracking-wider">Категории каналов</span>
          </div>
          <h2 class="text-3xl md:text-4xl font-bold text-[var(--text-primary)] mb-4 opacity-0 animate-fade-in-up stagger-1">
            Выберите интересующую категорию
          </h2>
          <p class="text-lg text-[var(--text-muted)] max-w-2xl mx-auto opacity-0 animate-fade-in-up stagger-2">
            Более {{ totalChannels || 191 }} каналов в различных категориях для всей семьи
          </p>
        </div>

        <div class="grid grid-cols-3 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6 gap-3">
          <div
            v-for="(item, index) in channels"
            :key="item.category"
            class="group glass-card p-5 rounded-xl opacity-0 animate-fade-in-up hover:scale-105 transition-all duration-300 cursor-pointer"
            :class="`stagger-${(index % 6) + 1}`"
          >
            <div class="flex items-center gap-3 mb-3">
              <div class="w-10 h-10 rounded-lg bg-gradient-to-br from-secondary/20 to-secondary/5 flex items-center justify-center group-hover:scale-110 transition-transform">
              <Icon :name="item.icon" class="w-5 h-5 text-secondary" />
              </div>
              <span class="text-3xl font-bold text-[var(--text-primary)] group-hover:text-secondary transition-colors">{{ item.count }}</span>
            </div>
            <p class="text-[var(--text-muted)] text-sm group-hover:text-[var(--text-primary)] transition-colors font-medium">
              {{ item.category }}
            </p>
            <!-- Визуальная подсказка -->
            <div class="mt-3 pt-3 border-t border-[var(--glass-border)] opacity-0 group-hover:opacity-100 transition-opacity">
              <div class="flex items-center gap-2 text-xs text-secondary">
                <Icon name="heroicons:arrow-right" class="w-3.5 h-3.5" />
                <span>Нажмите для просмотра</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Дополнительная информация -->
        <div class="mt-12 text-center opacity-0 animate-fade-in-up stagger-7">
          <div class="glass-card rounded-2xl p-6 max-w-2xl mx-auto">
            <div class="flex items-center justify-center gap-2 mb-3">
              <Icon name="heroicons:information-circle" class="w-5 h-5 text-secondary" />
              <h3 class="text-lg font-semibold text-[var(--text-primary)]">Все каналы включены</h3>
            </div>
            <p class="text-[var(--text-muted)] text-sm">
              Все {{ totalChannels || 191 }} каналов доступны без дополнительной платы. Список каналов регулярно обновляется и расширяется.
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Equipment -->
    <section class="py-16 mesh-gradient-dark relative overflow-hidden">
      <div class="floating-shape w-[400px] h-[400px] bg-secondary/10 -bottom-32 -right-32"></div>
      
      <div class="container mx-auto px-4 relative z-10">
        <div class="text-center mb-8">
          <div class="inline-flex items-center gap-2 glass-card rounded-full px-4 py-2 mb-4">
            <Icon name="heroicons:cog-6-tooth" class="w-4 h-4 text-secondary" />
            <span class="text-secondary font-medium text-sm uppercase tracking-wider">Оборудование</span>
          </div>
          <h2 class="text-3xl md:text-4xl font-bold text-[var(--text-primary)] mb-4">
            Нужна ТВ-приставка?
          </h2>
          <p class="text-lg text-[var(--text-muted)] max-w-2xl mx-auto">
            Мы можем предоставить современную Smart TV приставку в аренду или вы можете использовать свою
          </p>
        </div>

        <div class="max-w-2xl mx-auto">
          <div class="glass-card rounded-3xl p-8 group hover:scale-[1.02] transition-all duration-300 relative overflow-hidden">
            <!-- Glow effect -->
            <div class="absolute -inset-1 bg-gradient-to-br from-secondary/20 via-primary/10 to-accent/20 rounded-[32px] blur-xl opacity-0 group-hover:opacity-100 transition-opacity -z-10"></div>
            
            <div class="flex flex-col md:flex-row items-start gap-6">
              <div class="w-24 h-24 rounded-2xl bg-gradient-to-br from-secondary/20 to-primary/10 flex items-center justify-center flex-shrink-0 group-hover:scale-110 transition-transform">
                <Icon name="heroicons:tv" class="w-12 h-12 text-secondary" />
              </div>
              <div class="flex-grow">
                <div class="flex items-center gap-2 mb-2">
                  <h3 class="font-bold text-[var(--text-primary)] text-xl">
                    ТВ-приставка Imaqliq G-Box
                  </h3>
                  <span class="px-2 py-1 rounded-full bg-accent/10 text-accent text-xs font-medium border border-accent/20">
                    Рекомендуется
                  </span>
                </div>
                <p class="text-[var(--text-muted)] mb-4">
                  Smart TV приставка с поддержкой 4K и HDR
                </p>
                
                <!-- Характеристики -->
                <div class="grid grid-cols-2 gap-3 mb-4">
                  <div class="flex items-center gap-2 text-sm text-[var(--text-muted)]">
                    <Icon name="heroicons:check-circle" class="w-4 h-4 text-accent" />
                    <span>4K и HDR</span>
                  </div>
                  <div class="flex items-center gap-2 text-sm text-[var(--text-muted)]">
                    <Icon name="heroicons:check-circle" class="w-4 h-4 text-accent" />
                    <span>Android TV</span>
                  </div>
                  <div class="flex items-center gap-2 text-sm text-[var(--text-muted)]">
                    <Icon name="heroicons:check-circle" class="w-4 h-4 text-accent" />
                    <span>Архив передач</span>
                  </div>
                  <div class="flex items-center gap-2 text-sm text-[var(--text-muted)]">
                    <Icon name="heroicons:check-circle" class="w-4 h-4 text-accent" />
                    <span>Настройка включена</span>
                  </div>
                </div>

                <div class="flex items-baseline gap-2 pt-4 border-t border-[var(--glass-border)]">
                  <p class="text-3xl font-bold text-secondary">
                    +99
                  </p>
                  <span class="text-lg text-[var(--text-muted)]">₽/мес</span>
                  <span class="text-sm text-[var(--text-muted)] ml-2">(аренда)</span>
                </div>

                <!-- Подсказка -->
                <div class="mt-4 flex items-center gap-2 text-xs text-[var(--text-muted)]">
                  <Icon name="heroicons:information-circle" class="w-4 h-4" />
                  <span>Можно использовать Smart TV или другую совместимую приставку</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- FAQ -->
    <section class="py-12 md:py-16" :style="{ background: 'var(--bg-base)' }">
      <div class="container mx-auto px-4">
        <div class="text-center mb-12">
          <div class="inline-flex items-center gap-2 glass-card rounded-full px-4 py-2 mb-4">
            <Icon name="heroicons:question-mark-circle" class="w-4 h-4 text-secondary" />
            <span class="text-secondary font-medium text-sm uppercase tracking-wider">Частые вопросы</span>
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
            :class="activeFaq === index ? 'ring-2 ring-secondary/50' : ''"
          >
            <button
              @click="toggleFaq(index)"
              class="w-full p-6 text-left flex items-center justify-between gap-4 group"
            >
              <span class="font-semibold text-[var(--text-primary)] group-hover:text-secondary transition-colors">
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

<script setup lang="ts">
useHead({
  title: 'О сообществе — ПЖ19'
})

const values = [
  { icon: 'heroicons:shield-check', title: 'Доверие', description: 'Прозрачные отношения между участниками' },
  { icon: 'heroicons:eye', title: 'Прозрачность', description: 'Открытая информация о расходах и решениях' },
  { icon: 'heroicons:scale', title: 'Равноправие', description: 'Каждый участник имеет равные права' },
  { icon: 'heroicons:users', title: 'Сообщество', description: 'Вместе мы сильнее и эффективнее' }
]

// Статистика
const stats = [
  { value: '100 000+', label: 'Участников', icon: 'heroicons:users', color: 'primary' },
  { value: '8+', label: 'Лет работы', icon: 'heroicons:calendar', color: 'secondary' },
  { value: '1000', label: 'Мбит/с скорость', icon: 'heroicons:bolt', color: 'accent' },
  { value: '24/7', label: 'Поддержка', icon: 'heroicons:chat-bubble-left-right', color: 'info' }
]

// Пошаговая инструкция вступления
const joinSteps = [
  {
    icon: 'heroicons:document-text',
    title: 'Подайте заявку',
    description: 'Заполните форму на сайте или свяжитесь с нами'
  },
  {
    icon: 'heroicons:check-badge',
    title: 'Проверка возможности',
    description: 'Мы проверим техническую возможность подключения'
  },
  {
    icon: 'heroicons:document-duplicate',
    title: 'Оформление документов',
    description: 'Подписание договора и вступление в кооператив'
  },
  {
    icon: 'heroicons:calendar',
    title: 'Согласование даты',
    description: 'Согласуем удобное время для установки'
  },
  {
    icon: 'heroicons:wrench-screwdriver',
    title: 'Подключение',
    description: 'Установка оборудования и настройка услуг'
  },
  {
    icon: 'heroicons:check-circle',
    title: 'Вы участник!',
    description: 'Добро пожаловать в сообщество ПЖ19'
  }
]

// FAQ
const faqItems = [
  {
    question: 'Как стать участником сообщества?',
    answer: 'Подайте заявку на подключение через форму на сайте. После проверки технической возможности мы свяжемся с вами для оформления документов.'
  },
  {
    question: 'Сколько стоит членский взнос?',
    answer: 'Минимальный членский взнос составляет 699 ₽/мес. Точная сумма зависит от вашей локации и выбранных услуг.'
  },
  {
    question: 'Можно ли выйти из сообщества?',
    answer: 'Да, вы можете выйти из кооператива в любое время, подав соответствующее заявление. Оборудование остается вашей собственностью.'
  },
  {
    question: 'Как принимаются решения в сообществе?',
    answer: 'Все важные решения принимаются на общих собраниях участников. Один пайщик = один голос. Протоколы собраний доступны всем участникам.'
  },
  {
    question: 'Куда идут членские взносы?',
    answer: 'Все средства расходуются строго на содержание и развитие инфраструктуры: оплата каналов связи, обслуживание оборудования, развитие сети.'
  },
  {
    question: 'Есть ли ограничения по скорости?',
    answer: 'Нет, мы не ограничиваем скорость искусственно. Вы получаете максимальную скорость, доступную в вашей точке подключения (до 1000 Мбит/с).'
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
      <div class="floating-shape w-[500px] h-[500px] bg-primary/15 -bottom-32 -left-32"></div>
      <div class="floating-shape w-[400px] h-[400px] bg-secondary/15 -top-32 -right-32"></div>

      <div class="container mx-auto px-4 relative z-10">
        <div class="max-w-4xl mx-auto text-center">
          <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold text-[var(--text-primary)] mb-6 opacity-0 animate-fade-in-up">
            О сообществе
            <img src="/logo.png" alt="ПЖ19" class="inline-block h-10 md:h-14 lg:h-16 align-baseline ml-2" />
          </h1>
          <p class="text-xl text-[var(--text-muted)] opacity-0 animate-fade-in-up stagger-1">
            Закрытое сообщество из более чем 100 000 участников,
            объединившихся для совместного доступа к услугам связи на некоммерческой основе
          </p>
        </div>
      </div>
    </section>

    <!-- Main content -->
    <section class="py-12 md:py-16" :style="{ background: 'var(--bg-base)' }">
      <div class="container mx-auto px-4">
        <div class="max-w-3xl mx-auto">
          <div class="space-y-8">
            <div class="opacity-0 animate-fade-in-up">
              <h2 class="text-2xl md:text-3xl font-bold text-[var(--text-primary)] mb-4">
                <img src="/logo.png" alt="ПЖ19" class="inline-block h-7 md:h-8 align-baseline mr-1" /> — сообщество, а не провайдер
              </h2>
              <p class="text-[var(--text-muted)] leading-relaxed">
                Мы не продаём интернет — мы вместе строим и развиваем инфраструктуру для себя.
                В условиях, когда коммерческие провайдеры ориентированы исключительно на прибыль,
                мы предлагаем иной подход — основанный на доверии, прозрачности и равноправии.
              </p>
            </div>

            <div class="opacity-0 animate-fade-in-up stagger-1">
              <h2 class="text-2xl md:text-3xl font-bold text-[var(--text-primary)] mb-4">Почему это работает иначе</h2>
              <p class="text-[var(--text-muted)] leading-relaxed">
                Каждый член сообщества — не клиент, а полноправный участник с правом голоса
                в принятии решений. Наши участники не оплачивают услуги — они вносят регулярные
                членские взносы, необходимые для развития и поддержания инфраструктуры.
              </p>
            </div>

            <div class="opacity-0 animate-fade-in-up stagger-2">
              <h2 class="text-2xl md:text-3xl font-bold text-[var(--text-primary)] mb-6">Чем мы отличаемся</h2>
              <div class="grid gap-4">
                <div class="glass-card rounded-xl p-5">
                  <div class="flex items-start gap-4">
                    <div class="w-10 h-10 rounded-lg bg-primary/20 flex items-center justify-center flex-shrink-0">
                      <Icon name="heroicons:bolt" class="w-5 h-5 text-primary" />
                    </div>
                    <div>
                      <h3 class="font-semibold text-[var(--text-primary)] mb-1">Никаких искусственных ограничений</h3>
                      <p class="text-[var(--text-muted)] text-sm">Каждый участник получает максимальную скорость, доступную в точке подключения (до 1000 Мбит/с)</p>
                    </div>
                  </div>
                </div>
                <div class="glass-card rounded-xl p-5">
                  <div class="flex items-start gap-4">
                    <div class="w-10 h-10 rounded-lg bg-secondary/20 flex items-center justify-center flex-shrink-0">
                      <Icon name="heroicons:banknotes" class="w-5 h-5 text-secondary" />
                    </div>
                    <div>
                      <h3 class="font-semibold text-[var(--text-primary)] mb-1">Взносы, а не оплата услуг</h3>
                      <p class="text-[var(--text-muted)] text-sm">Средства идут только на содержание и развитие инфраструктуры</p>
                    </div>
                  </div>
                </div>
                <div class="glass-card rounded-xl p-5">
                  <div class="flex items-start gap-4">
                    <div class="w-10 h-10 rounded-lg bg-accent/20 flex items-center justify-center flex-shrink-0">
                      <Icon name="heroicons:user-group" class="w-5 h-5 text-accent" />
                    </div>
                    <div>
                      <h3 class="font-semibold text-[var(--text-primary)] mb-1">Общее управление</h3>
                      <p class="text-[var(--text-muted)] text-sm">Один пайщик = один голос</p>
                    </div>
                  </div>
                </div>
                <div class="glass-card rounded-xl p-5">
                  <div class="flex items-start gap-4">
                    <div class="w-10 h-10 rounded-lg bg-info/20 flex items-center justify-center flex-shrink-0">
                      <Icon name="heroicons:arrow-trending-up" class="w-5 h-5 text-info" />
                    </div>
                    <div>
                      <h3 class="font-semibold text-[var(--text-primary)] mb-1">Чем нас больше — тем лучше каждому</h3>
                      <p class="text-[var(--text-muted)] text-sm">Новые участники усиливают возможности всего сообщества</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="opacity-0 animate-fade-in-up stagger-3">
              <h2 class="text-2xl md:text-3xl font-bold text-[var(--text-primary)] mb-4">Как устроены взносы</h2>
              <p class="text-[var(--text-muted)] leading-relaxed">
                Членский взнос зависит от локации подключения. Минимальный — 699 ₽/мес.
                Все средства расходуются строго по уставным задачам кооператива.
              </p>
            </div>

            <div class="opacity-0 animate-fade-in-up stagger-4">
              <p class="text-sm text-[var(--text-muted)] italic flex items-center gap-2">
                <Icon name="heroicons:shield-check" class="w-4 h-4" />
                Деятельность ПЖ19 ведётся в соответствии с законодательством РФ
                о потребительской кооперации и уставом кооператива.
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Stats -->
    <section class="py-12 md:py-16 mesh-gradient-dark relative overflow-hidden">
      <div class="floating-shape w-[400px] h-[400px] bg-primary/10 -top-32 -right-32"></div>
      
      <div class="container mx-auto px-4 relative z-10">
        <div class="text-center mb-12">
          <div class="inline-flex items-center gap-2 glass-card rounded-full px-4 py-2 mb-4">
            <Icon name="heroicons:chart-bar" class="w-4 h-4 text-primary" />
            <span class="text-primary font-medium text-sm uppercase tracking-wider">Статистика</span>
          </div>
          <h2 class="text-3xl md:text-4xl font-bold text-[var(--text-primary)] mb-4">
            ПЖ19 в цифрах
          </h2>
        </div>

        <div class="grid grid-cols-2 md:grid-cols-4 gap-6 max-w-5xl mx-auto">
          <div
            v-for="(stat, index) in stats"
            :key="stat.label"
            class="glass-card rounded-2xl p-6 text-center group hover:scale-105 transition-all duration-300 opacity-0 animate-fade-in-up"
            :class="`stagger-${index + 1}`"
          >
            <div
              class="w-14 h-14 rounded-xl flex items-center justify-center mx-auto mb-4 group-hover:scale-110 transition-transform"
              :class="{
                'bg-gradient-to-br from-primary/20 to-primary/5': stat.color === 'primary',
                'bg-gradient-to-br from-secondary/20 to-secondary/5': stat.color === 'secondary',
                'bg-gradient-to-br from-accent/20 to-accent/5': stat.color === 'accent',
                'bg-gradient-to-br from-info/20 to-info/5': stat.color === 'info'
              }"
            >
              <Icon
                :name="stat.icon"
                :class="[
                  'w-7 h-7',
                  stat.color === 'primary' ? 'text-primary' : '',
                  stat.color === 'secondary' ? 'text-secondary' : '',
                  stat.color === 'accent' ? 'text-accent' : '',
                  stat.color === 'info' ? 'text-info' : ''
                ]"
              />
            </div>
            <div
              class="text-3xl md:text-4xl font-bold mb-2"
              :class="{
                'text-primary': stat.color === 'primary',
                'text-secondary': stat.color === 'secondary',
                'text-accent': stat.color === 'accent',
                'text-info': stat.color === 'info'
              }"
            >
              {{ stat.value }}
            </div>
            <p class="text-sm text-[var(--text-muted)] font-medium">
              {{ stat.label }}
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Values -->
    <section class="py-12 md:py-16" :style="{ background: 'var(--bg-base)' }">
      <div class="container mx-auto px-4">
        <h2 class="text-3xl md:text-4xl font-bold text-[var(--text-primary)] text-center mb-12">Наши ценности</h2>
        <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
          <div
            v-for="(value, index) in values"
            :key="value.title"
            class="glass-card p-6 rounded-2xl text-center opacity-0 animate-fade-in-up hover:scale-105 transition-all duration-300"
            :class="`stagger-${index + 1}`"
          >
            <div class="w-14 h-14 bg-gradient-to-br from-primary/20 to-secondary/10 rounded-xl flex items-center justify-center mx-auto mb-4 group-hover:scale-110 transition-transform">
              <Icon :name="value.icon" class="w-7 h-7 text-primary" />
            </div>
            <h3 class="text-lg font-semibold text-[var(--text-primary)] mb-2">{{ value.title }}</h3>
            <p class="text-[var(--text-muted)] text-sm">{{ value.description }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- How to Join -->
    <section class="py-12 md:py-16" :style="{ background: 'var(--bg-base)' }">
      <div class="container mx-auto px-4">
        <div class="text-center mb-12">
          <div class="inline-flex items-center gap-2 glass-card rounded-full px-4 py-2 mb-4">
            <Icon name="heroicons:user-plus" class="w-4 h-4 text-primary" />
            <span class="text-primary font-medium text-sm uppercase tracking-wider">Как вступить</span>
          </div>
          <h2 class="text-3xl md:text-4xl font-bold text-[var(--text-primary)] mb-4">
            Стать участником просто
          </h2>
          <p class="text-lg text-[var(--text-muted)] max-w-2xl mx-auto">
            Всего 6 простых шагов до вступления в сообщество
          </p>
        </div>

        <div class="max-w-4xl mx-auto">
          <div class="relative">
            <!-- Vertical timeline line -->
            <div class="hidden md:block absolute left-8 top-0 bottom-0 w-0.5 bg-gradient-to-b from-primary/30 via-primary/50 to-primary/30"></div>
            
            <div class="space-y-8">
              <div
                v-for="(step, index) in joinSteps"
                :key="step.title"
                class="relative opacity-0 animate-fade-in-up"
                :class="`stagger-${index + 1}`"
              >
                <!-- Timeline dot -->
                <div class="hidden md:block absolute left-8 top-8 w-4 h-4 rounded-full bg-primary border-4 border-[var(--bg-base)] transform -translate-x-1/2 z-10 shadow-lg shadow-primary/30"></div>
                
                <!-- Content card -->
                <div class="md:ml-20 glass-card rounded-2xl p-6 md:p-8 group hover:scale-[1.02] transition-all duration-300 relative overflow-hidden">
                  <div class="absolute inset-0 bg-gradient-to-r from-primary/5 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity -z-10"></div>
                  
                  <div class="flex flex-col md:flex-row items-start gap-6">
                    <div class="flex-shrink-0">
                      <div class="w-16 h-16 rounded-xl bg-gradient-to-br from-primary/20 to-primary/5 flex items-center justify-center group-hover:scale-110 group-hover:from-primary/30 group-hover:to-primary/10 transition-all duration-300">
                        <Icon :name="step.icon" class="w-8 h-8 text-primary" />
                      </div>
                    </div>
                    <div class="flex-1">
                      <div class="flex items-center gap-3 mb-3">
                        <span class="px-3 py-1 rounded-full bg-primary/10 text-primary text-xs font-bold border border-primary/20">
                          Шаг {{ index + 1 }}
                        </span>
                        <h3 class="text-xl font-bold text-[var(--text-primary)] group-hover:text-primary transition-colors">
                          {{ step.title }}
                        </h3>
                      </div>
                      <p class="text-[var(--text-muted)] leading-relaxed">
                        {{ step.description }}
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- FAQ -->
    <section class="py-12 md:py-16 mesh-gradient-dark relative overflow-hidden">
      <div class="floating-shape w-[400px] h-[400px] bg-primary/10 -bottom-32 -right-32"></div>
      
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

    <!-- CTA -->
    <section class="py-12 md:py-16" :style="{ background: 'var(--bg-base)' }">
      <div class="container mx-auto px-4 text-center">
        <h2 class="text-3xl md:text-4xl font-bold text-[var(--text-primary)] mb-6">
          Присоединяйтесь к сообществу
        </h2>
        <p class="text-lg text-[var(--text-muted)] mb-10 max-w-2xl mx-auto">
          Станьте частью ПЖ19 и получите доступ к качественной связи
          на некоммерческих условиях
        </p>
        <NuxtLink
          to="/connect"
          class="group btn-accent inline-flex items-center gap-3 px-8 py-4 text-lg relative overflow-hidden"
        >
          <span class="relative z-10">Вступить в сообщество</span>
          <Icon name="heroicons:arrow-right" class="w-5 h-5 relative z-10 transition-transform group-hover:translate-x-1" />
          <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/10 to-transparent translate-x-[-100%] group-hover:translate-x-[100%] transition-transform duration-1000"></div>
        </NuxtLink>
      </div>
    </section>
  </div>
</template>

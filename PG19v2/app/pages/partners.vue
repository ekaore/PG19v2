<script setup lang="ts">
useHead({
  title: 'Партнёрам — ПЖ19'
})

const benefits = [
  { icon: 'heroicons:user-group', title: 'Расширение аудитории', description: 'Доступ к 100 000+ участников сообщества' },
  { icon: 'heroicons:chart-bar', title: 'Стабильный доход', description: 'Прозрачные условия партнёрства' },
  { icon: 'heroicons:wrench-screwdriver', title: 'Техническая поддержка', description: 'Помощь в интеграции и обслуживании' },
  { icon: 'heroicons:shield-check', title: 'Надёжность', description: 'Работа в рамках законодательства РФ' }
]

// Типы партнёрства
const partnershipTypes = [
  {
    icon: 'heroicons:server',
    title: 'Операторы связи',
    description: 'Владельцы телекоммуникационных сетей и инфраструктуры',
    features: ['Доступ к большой аудитории', 'Техническая интеграция', 'Прозрачные условия']
  },
  {
    icon: 'heroicons:building-office',
    title: 'Провайдеры услуг',
    description: 'Компании, предоставляющие интернет и телекоммуникационные услуги',
    features: ['Расширение покрытия', 'Совместные проекты', 'Маркетинговая поддержка']
  },
  {
    icon: 'heroicons:cog-6-tooth',
    title: 'Технические партнёры',
    description: 'Поставщики оборудования и технических решений',
    features: ['Интеграция решений', 'Техническая поддержка', 'Долгосрочное сотрудничество']
  },
  {
    icon: 'heroicons:handshake',
    title: 'Стратегические партнёры',
    description: 'Компании, заинтересованные в совместном развитии',
    features: ['Совместные проекты', 'Взаимная выгода', 'Долгосрочные отношения']
  }
]

// Требования к партнёрам
const requirements = [
  {
    icon: 'heroicons:check-badge',
    title: 'Лицензии и сертификаты',
    description: 'Наличие необходимых разрешений для ведения деятельности'
  },
  {
    icon: 'heroicons:shield-check',
    title: 'Соответствие законодательству',
    description: 'Соблюдение требований российского законодательства'
  },
  {
    icon: 'heroicons:chart-bar',
    title: 'Стабильность бизнеса',
    description: 'Опыт работы и стабильное финансовое положение'
  },
  {
    icon: 'heroicons:heart',
    title: 'Разделение ценностей',
    description: 'Совпадение принципов и подходов к работе'
  }
]

</script>

<template>
  <div class="pt-28">
    <!-- Hero -->
    <section class="mesh-gradient-hero py-12 md:py-16 relative overflow-hidden">
      <div class="absolute inset-0 network-pattern opacity-20"></div>
      <div class="floating-shape w-[400px] h-[400px] bg-accent/20 -top-32 -left-32"></div>

      <div class="container mx-auto px-4 relative z-10">
        <div class="max-w-4xl mx-auto text-center">
          <div class="inline-flex items-center justify-center w-20 h-20 glass-card rounded-3xl mb-8 opacity-0 animate-fade-in-up">
            <Icon name="heroicons:building-office-2" class="w-10 h-10 text-accent" />
          </div>
          <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold text-[var(--text-primary)] mb-6 opacity-0 animate-fade-in-up stagger-1">
            <span class="text-accent">Партнёрам</span>
          </h1>
          <p class="text-xl text-[var(--text-muted)] opacity-0 animate-fade-in-up stagger-2">
            Приглашаем к сотрудничеству владельцев сетей и операторов связи
          </p>
        </div>
      </div>
    </section>

    <!-- Benefits -->
    <section class="py-12 md:py-16" :style="{ background: 'var(--bg-base)' }">
      <div class="container mx-auto px-4">
        <h2 class="text-3xl md:text-4xl font-bold text-[var(--text-primary)] text-center mb-8">Преимущества партнёрства</h2>
        <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
          <div
            v-for="(benefit, index) in benefits"
            :key="benefit.title"
            class="glass-card p-6 rounded-2xl opacity-0 animate-fade-in-up"
            :class="`stagger-${index + 1}`"
          >
            <div class="w-14 h-14 rounded-xl bg-gradient-to-br from-accent/20 to-accent/5 flex items-center justify-center mb-4">
              <Icon :name="benefit.icon" class="w-7 h-7 text-accent" />
            </div>
            <h3 class="text-lg font-semibold text-[var(--text-primary)] mb-2">{{ benefit.title }}</h3>
            <p class="text-[var(--text-muted)]">{{ benefit.description }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Partnership Types -->
    <section class="py-12 md:py-16 mesh-gradient-dark relative overflow-hidden">
      <div class="floating-shape w-[400px] h-[400px] bg-primary/10 -bottom-32 -right-32"></div>
      
      <div class="container mx-auto px-4 relative z-10">
        <div class="text-center mb-12">
          <div class="inline-flex items-center gap-2 glass-card rounded-full px-4 py-2 mb-4">
            <Icon name="heroicons:handshake" class="w-4 h-4 text-accent" />
            <span class="text-accent font-medium text-sm uppercase tracking-wider">Типы партнёрства</span>
          </div>
          <h2 class="text-3xl md:text-4xl font-bold text-[var(--text-primary)] mb-4">
            С кем мы сотрудничаем
          </h2>
          <p class="text-lg text-[var(--text-muted)] max-w-2xl mx-auto">
            Мы открыты к различным формам партнёрства и готовы обсудить сотрудничество
          </p>
        </div>

        <div class="grid md:grid-cols-2 gap-6">
          <div
            v-for="(type, index) in partnershipTypes"
            :key="type.title"
            class="glass-card rounded-2xl p-6 opacity-0 animate-fade-in-up group hover:scale-[1.02] transition-all duration-300 relative overflow-hidden"
            :class="`stagger-${index + 1}`"
          >
            <div class="absolute inset-0 bg-gradient-to-br from-accent/5 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity -z-10"></div>
            
            <div class="flex items-start gap-4 mb-4">
              <div class="w-14 h-14 rounded-xl bg-gradient-to-br from-accent/20 to-accent/5 flex items-center justify-center flex-shrink-0 group-hover:scale-110 transition-transform">
                <Icon :name="type.icon" class="w-7 h-7 text-accent" />
              </div>
              <div class="flex-1">
                <h3 class="text-xl font-bold text-[var(--text-primary)] mb-2 group-hover:text-accent transition-colors">
                  {{ type.title }}
                </h3>
                <p class="text-[var(--text-muted)] text-sm mb-4">
                  {{ type.description }}
                </p>
              </div>
            </div>
            
            <div class="space-y-2">
              <div
                v-for="feature in type.features"
                :key="feature"
                class="flex items-center gap-2 text-sm text-[var(--text-muted)]"
              >
                <Icon name="heroicons:check-circle" class="w-4 h-4 text-accent flex-shrink-0" />
                <span>{{ feature }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Requirements -->
    <section class="py-12 md:py-16 mesh-gradient-dark">
      <div class="container mx-auto px-4">
        <div class="text-center mb-12">
          <div class="inline-flex items-center gap-2 glass-card rounded-full px-4 py-2 mb-4">
            <Icon name="heroicons:clipboard-document-check" class="w-4 h-4 text-secondary" />
            <span class="text-secondary font-medium text-sm uppercase tracking-wider">Требования</span>
          </div>
          <h2 class="text-3xl md:text-4xl font-bold text-[var(--text-primary)] mb-4">
            Что нужно для партнёрства
          </h2>
          <p class="text-lg text-[var(--text-muted)] max-w-2xl mx-auto">
            Основные требования к потенциальным партнёрам
          </p>
        </div>

        <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-6 max-w-6xl mx-auto">
          <div
            v-for="(req, index) in requirements"
            :key="req.title"
            class="glass-card rounded-2xl p-6 text-center opacity-0 animate-fade-in-up group hover:scale-[1.02] transition-all duration-300"
            :class="`stagger-${index + 1}`"
          >
            <div class="w-14 h-14 rounded-xl bg-gradient-to-br from-secondary/20 to-secondary/5 flex items-center justify-center mx-auto mb-4 group-hover:scale-110 transition-transform">
              <Icon :name="req.icon" class="w-7 h-7 text-secondary" />
            </div>
            <h3 class="text-lg font-semibold text-[var(--text-primary)] mb-2 group-hover:text-secondary transition-colors">
              {{ req.title }}
            </h3>
            <p class="text-sm text-[var(--text-muted)]">
              {{ req.description }}
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Contact -->
    <section class="py-16 mesh-gradient-dark">
      <div class="container mx-auto px-4">
        <div class="max-w-2xl mx-auto text-center">
          <h2 class="text-3xl md:text-4xl font-bold text-[var(--text-primary)] mb-6">
            Стать партнёром
          </h2>
          <p class="text-lg text-[var(--text-muted)] mb-10">
            Свяжитесь с нами для обсуждения условий сотрудничества
          </p>

          <div class="glass-card rounded-3xl p-8">
            <div class="space-y-6 mb-8">
              <a href="mailto:partners@pg19.ru" class="flex items-center justify-center gap-4 group">
                <div class="w-12 h-12 rounded-xl bg-accent/10 flex items-center justify-center group-hover:bg-accent/20 transition-colors">
                  <Icon name="heroicons:envelope" class="w-6 h-6 text-accent" />
                </div>
                <span class="text-[var(--text-primary)] text-lg group-hover:text-accent transition-colors">partners@pg19.ru</span>
              </a>
              <a href="tel:+78001234567" class="flex items-center justify-center gap-4 group">
                <div class="w-12 h-12 rounded-xl bg-primary/10 flex items-center justify-center group-hover:bg-primary/20 transition-colors">
                  <Icon name="heroicons:phone" class="w-6 h-6 text-primary" />
                </div>
                <span class="text-[var(--text-primary)] text-lg group-hover:text-primary transition-colors">8 (800) 123-45-67</span>
              </a>
            </div>

            <NuxtLink
              to="/connect"
              class="btn-primary inline-flex items-center gap-3 px-8 py-4 text-lg"
            >
              <span>Оставить заявку</span>
              <Icon name="heroicons:arrow-right" class="w-5 h-5" />
            </NuxtLink>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

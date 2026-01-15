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

// Fallback данные для услуг
const fallbackServices: ServiceItem[] = [
  {
    id: 'internet',
    title: 'Интернет',
    description: 'Мы не режем скорость. Канал до 1000 Мбит/с — вся полоса ваша',
    icon: 'heroicons:wifi',
    color: 'primary',
    link: '/internet',
    features: ['Скорость не ограничена', 'До 1000 Мбит/с', '10+ устройств']
  },
  {
    id: 'tv',
    title: 'Телевидение',
    description: '191 канал в HD и 4К качестве. Архив передач до 14 дней',
    icon: 'heroicons:tv',
    color: 'secondary',
    link: '/tv',
    features: ['191 канал', 'HD и 4К', 'Архив 14 дней']
  },
  {
    id: 'mobile',
    title: 'Мобильная связь',
    description: 'Выгодные тарифы для участников сообщества. Скоро!',
    icon: 'heroicons:device-phone-mobile',
    color: 'accent',
    link: '/mobile',
    features: ['Выгодные тарифы', 'Безлимит', 'Скоро'],
    comingSoon: true
  },
  {
    id: 'cctv',
    title: 'Видеонаблюдение',
    description: 'Облачное хранение записей. Доступ с любого устройства',
    icon: 'heroicons:video-camera',
    color: 'info',
    link: '/cctv',
    features: ['Облачное хранение', 'Доступ 24/7', 'HD камеры']
  },
  {
    id: 'intercom',
    title: 'Домофон',
    description: 'Умный домофон с видеосвязью и управлением со смартфона',
    icon: 'heroicons:phone',
    color: 'secondary',
    link: '/intercom',
    features: ['Видеосвязь', 'Управление с телефона', 'Запись посетителей']
  }
]

// Получаем сервисы из контента или используем fallback
const services = computed(() => {
  const items = content.value?.services?.items && content.value.services.items.length > 0
    ? content.value.services.items
    : fallbackServices
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
    icon: 'text-orange-400',
    glow: 'group-hover:shadow-glow-primary',
    tag: 'bg-yellow-500/80 text-gray-900 border-yellow-500/30'
  },
  secondary: {
    icon: 'text-pink-400',
    glow: 'group-hover:shadow-glow-secondary',
    tag: 'bg-pink-500/80 text-gray-900 border-pink-500/30'
  },
  accent: {
    icon: 'text-green-400',
    glow: 'group-hover:shadow-glow-accent',
    tag: 'bg-green-500/80 text-gray-900 border-green-500/30'
  },
  info: {
    icon: 'text-orange-400',
    glow: 'group-hover:shadow-[0_0_30px_rgba(0,84,166,0.4)]',
    tag: 'bg-yellow-500/80 text-gray-900 border-yellow-500/30'
  }
}
</script>

<template>
  <section class="py-12 md:py-16 relative overflow-hidden" :style="{ background: 'var(--bg-base)' }">
    <!-- Background decoration -->
    <div class="absolute inset-0 mesh-gradient-subtle opacity-50"></div>

    <div class="container mx-auto px-4 relative z-10">
      <!-- Header -->
      <div class="text-center mb-12">
        <div class="inline-flex items-center gap-2 mb-4">
          <span class="text-primary/80 font-medium text-xs uppercase tracking-wider">
            УСЛУГИ СООБЩЕСТВА
          </span>
        </div>
        <h2 class="text-3xl md:text-4xl lg:text-5xl font-bold text-[var(--text-primary)] mb-6">
          Всё для комфортной 
          <span class="text-gradient-primary">цифровой жизни</span>
        </h2>
        <p class="text-base md:text-lg text-[var(--text-muted)] max-w-2xl mx-auto">
          {{ sectionSubtitle || 'Интернет, телевидение, мобильная связь и другие сервисы — всё в одном сообществе на выгодных условиях' }}
        </p>
      </div>

      <!-- Services grid -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 lg:gap-8">
        <NuxtLink
          v-for="(service, index) in services"
          :key="service.href"
          :to="service.href"
          class="group glass-card rounded-2xl p-6 transition-all duration-300 hover:scale-[1.02] hover:-translate-y-1 relative"
        >
          <!-- Coming Soon Badge -->
          <div
            v-if="service.comingSoon"
            class="absolute top-4 right-4 z-10"
          >
            <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-semibold bg-accent/20 text-accent border border-accent/40 backdrop-blur-sm">
              <Icon name="heroicons:clock" class="w-3.5 h-3.5" />
              <span>Скоро</span>
            </span>
          </div>

          <!-- Icon -->
          <div class="mb-4">
            <Icon
              :name="service.icon"
              :class="['w-8 h-8', (colorClasses[service.color] || colorClasses.primary)?.icon || '']"
            />
          </div>

          <!-- Title -->
          <h3 class="text-xl font-bold text-[var(--text-primary)] mb-3">
            {{ service.title }}
          </h3>

          <!-- Description -->
          <p class="text-sm text-[var(--text-muted)] mb-4 leading-relaxed">
            {{ service.description }}
          </p>

          <!-- Features -->
          <div class="flex flex-wrap gap-2 mb-4">
            <span
              v-for="feature in service.features"
              :key="feature"
              :class="[
                'text-xs px-3 py-1 rounded-full font-medium',
                (colorClasses[service.color] || colorClasses.primary)?.tag || ''
              ]"
            >
              {{ feature }}
            </span>
          </div>

          <!-- Link -->
          <div class="flex items-center gap-2 text-sm text-[var(--text-muted)] group-hover:text-primary transition-colors mt-4">
            <span>Подробнее</span>
            <Icon
              name="heroicons:arrow-right"
              class="w-4 h-4 transform group-hover:translate-x-1 transition-transform"
            />
          </div>
        </NuxtLink>
        
        <!-- Пустая ячейка для 6-й позиции -->
        <div class="hidden lg:block"></div>
      </div>

      <!-- Bottom CTA -->
      <div class="text-center mt-12">
        <p class="text-[var(--text-muted)] mb-4">
          Не нашли нужную услугу? Мы постоянно расширяем возможности
        </p>
        <NuxtLink
          to="/connect"
          class="inline-flex items-center gap-2 glass-card rounded-xl px-6 py-3 border border-[var(--glass-border)] hover:border-primary/50 transition-colors"
        >
          <Icon name="heroicons:chat-bubble-left-right" class="w-5 h-5" />
          <span>Связаться с нами</span>
        </NuxtLink>
      </div>
    </div>
  </section>
</template>

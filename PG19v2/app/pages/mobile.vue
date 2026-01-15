<script setup lang="ts">
useHead({
  title: 'Мобильная связь — ПЖ19'
})

const email = ref('')
const submitted = ref(false)
const loading = ref(false)

async function subscribeToNotifications() {
  if (!email.value || !email.value.includes('@')) {
    return
  }
  
  loading.value = true
  try {
    // Здесь можно добавить API вызов для подписки
    await new Promise(resolve => setTimeout(resolve, 1000))
    submitted.value = true
    email.value = ''
  } catch (error) {
    console.error(error)
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div class="pt-28">
    <!-- Hero -->
    <section class="mesh-gradient-hero py-12 md:py-16 relative overflow-hidden">
      <div class="absolute inset-0 network-pattern opacity-20"></div>
      <div class="floating-shape w-[400px] h-[400px] bg-accent/20 -top-32 -right-32"></div>

      <div class="container mx-auto px-4 relative z-10">
        <div class="max-w-4xl mx-auto text-center">
          <div class="inline-flex items-center justify-center w-20 h-20 glass-card rounded-3xl mb-8 opacity-0 animate-fade-in-up group hover:scale-110 transition-transform">
            <Icon name="heroicons:device-phone-mobile" class="w-10 h-10 text-accent group-hover:animate-pulse" />
          </div>
          <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold text-[var(--text-primary)] mb-6 opacity-0 animate-fade-in-up stagger-1">
            Мобильная <span class="text-accent">связь</span>
          </h1>
          <p class="text-xl text-[var(--text-muted)] mb-8 opacity-0 animate-fade-in-up stagger-2">
            Выгодные тарифы на мобильную связь для участников сообщества
          </p>

          <!-- Coming soon badge -->
          <div class="inline-flex items-center gap-3 glass-card rounded-full px-6 py-3 mb-8 opacity-0 animate-fade-in-up stagger-3 group hover:scale-105 transition-transform">
            <Icon name="heroicons:clock" class="w-5 h-5 text-accent animate-pulse" />
            <span class="font-medium text-[var(--text-primary)]">Скоро будет доступно</span>
          </div>

          <!-- Планируемые преимущества -->
          <div class="flex flex-wrap items-center justify-center gap-4 opacity-0 animate-fade-in-up stagger-3">
            <div class="flex items-center gap-2 px-4 py-2 glass-card rounded-full">
              <Icon name="heroicons:banknotes" class="w-4 h-4 text-accent" />
              <span class="text-sm font-medium text-[var(--text-primary)]">Выгодные тарифы</span>
            </div>
            <div class="flex items-center gap-2 px-4 py-2 glass-card rounded-full">
              <Icon name="heroicons:signal" class="w-4 h-4 text-primary" />
              <span class="text-sm font-medium text-[var(--text-primary)]">Безлимитные пакеты</span>
            </div>
            <div class="flex items-center gap-2 px-4 py-2 glass-card rounded-full">
              <Icon name="heroicons:check-circle" class="w-4 h-4 text-accent" />
              <span class="text-sm font-medium text-[var(--text-primary)]">Только для участников</span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Development Status -->
    <section class="py-12 md:py-16" :style="{ background: 'var(--bg-base)' }">
      <div class="container mx-auto px-4">
        <div class="max-w-3xl mx-auto">
          <!-- Статус разработки -->
          <div class="text-center mb-8">
            <div class="w-24 h-24 glass-card rounded-3xl flex items-center justify-center mx-auto mb-8 group hover:scale-110 transition-transform">
              <Icon name="heroicons:signal" class="w-12 h-12 text-accent group-hover:animate-pulse" />
          </div>
          <h2 class="text-2xl md:text-3xl font-bold text-[var(--text-primary)] mb-4">
            Мы работаем над этим
          </h2>
            <p class="text-[var(--text-muted)] mb-8 text-lg">
            Услуга мобильной связи находится в разработке.
            Оставьте заявку, и мы сообщим вам о запуске.
          </p>
          </div>

          <!-- Форма подписки на уведомления -->
          <div class="glass-card rounded-3xl p-8 md:p-10 mb-8">
            <div class="text-center mb-6">
              <div class="inline-flex items-center gap-2 glass-card rounded-full px-4 py-2 mb-4">
                <Icon name="heroicons:bell" class="w-4 h-4 text-accent" />
                <span class="text-accent font-medium text-sm uppercase tracking-wider">Уведомление о запуске</span>
              </div>
              <h3 class="text-xl font-bold text-[var(--text-primary)] mb-2">
                Узнайте первыми о запуске
              </h3>
              <p class="text-[var(--text-muted)] text-sm">
                Оставьте email, и мы сообщим вам, когда услуга станет доступна
              </p>
            </div>

            <form v-if="!submitted" @submit.prevent="subscribeToNotifications" class="space-y-4">
              <div class="flex flex-col sm:flex-row gap-3">
                <input
                  v-model="email"
                  type="email"
                  placeholder="Ваш email"
                  required
                  class="flex-1 px-4 py-3 rounded-xl bg-[var(--glass-bg)] border border-[var(--glass-border)] text-[var(--text-primary)] placeholder-[var(--text-muted)] focus:outline-none focus:border-accent focus:ring-2 focus:ring-accent/20 transition-all"
                />
                <button
                  type="submit"
                  :disabled="loading || !email"
                  class="btn-accent px-8 py-3 disabled:opacity-50 disabled:cursor-not-allowed inline-flex items-center justify-center gap-2"
                >
                  <Icon v-if="loading" name="heroicons:arrow-path" class="w-5 h-5 animate-spin" />
                  <Icon v-else name="heroicons:paper-airplane" class="w-5 h-5" />
                  <span>{{ loading ? 'Отправка...' : 'Подписаться' }}</span>
                </button>
              </div>
            </form>

            <!-- Сообщение об успешной подписке -->
            <div v-else class="text-center py-4">
              <div class="inline-flex items-center gap-2 px-6 py-3 rounded-full bg-accent/10 border border-accent/20 mb-4">
                <Icon name="heroicons:check-circle" class="w-5 h-5 text-accent" />
                <span class="text-accent font-medium">Спасибо! Мы сообщим вам о запуске</span>
              </div>
              <button
                @click="submitted = false"
                class="text-sm text-[var(--text-muted)] hover:text-[var(--text-primary)] transition-colors"
              >
                Подписаться еще раз
              </button>
            </div>
          </div>

          <!-- Альтернативный CTA -->
          <div class="text-center">
            <p class="text-[var(--text-muted)] mb-4">Или оставьте полную заявку на подключение</p>
          <NuxtLink
            to="/connect"
              class="group btn-primary inline-flex items-center gap-3 px-8 py-4 text-lg relative overflow-hidden"
          >
              <span class="relative z-10">Оставить заявку</span>
              <Icon name="heroicons:arrow-right" class="w-5 h-5 relative z-10 transition-transform group-hover:translate-x-1" />
              <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/10 to-transparent translate-x-[-100%] group-hover:translate-x-[100%] transition-transform duration-1000"></div>
          </NuxtLink>
          </div>
        </div>
      </div>
    </section>

    <!-- Планируемые возможности -->
    <section class="py-16 mesh-gradient-dark relative overflow-hidden">
      <div class="floating-shape w-[400px] h-[400px] bg-accent/10 -bottom-32 -left-32"></div>
      
      <div class="container mx-auto px-4 relative z-10">
        <div class="text-center mb-12">
          <div class="inline-flex items-center gap-2 glass-card rounded-full px-4 py-2 mb-4">
            <Icon name="heroicons:sparkles" class="w-4 h-4 text-accent" />
            <span class="text-accent font-medium text-sm uppercase tracking-wider">Планируемые возможности</span>
          </div>
          <h2 class="text-3xl md:text-4xl font-bold text-[var(--text-primary)] mb-4">
            Что будет доступно?
          </h2>
          <p class="text-lg text-[var(--text-muted)] max-w-2xl mx-auto">
            Мы планируем предложить выгодные тарифы специально для участников сообщества
          </p>
        </div>

        <div class="grid md:grid-cols-3 gap-6 max-w-4xl mx-auto">
          <div class="glass-card rounded-2xl p-6 text-center group hover:scale-105 transition-all">
            <div class="w-16 h-16 rounded-xl bg-gradient-to-br from-accent/20 to-accent/5 flex items-center justify-center mx-auto mb-4 group-hover:scale-110 transition-transform">
              <Icon name="heroicons:banknotes" class="w-8 h-8 text-accent" />
            </div>
            <h3 class="font-bold text-[var(--text-primary)] mb-2 group-hover:text-accent transition-colors">
              Выгодные тарифы
            </h3>
            <p class="text-sm text-[var(--text-muted)]">
              Специальные цены для участников сообщества
            </p>
          </div>

          <div class="glass-card rounded-2xl p-6 text-center group hover:scale-105 transition-all">
            <div class="w-16 h-16 rounded-xl bg-gradient-to-br from-primary/20 to-primary/5 flex items-center justify-center mx-auto mb-4 group-hover:scale-110 transition-transform">
              <Icon name="heroicons:signal" class="w-8 h-8 text-primary" />
            </div>
            <h3 class="font-bold text-[var(--text-primary)] mb-2 group-hover:text-primary transition-colors">
              Безлимитные пакеты
            </h3>
            <p class="text-sm text-[var(--text-muted)]">
              Интернет, звонки и SMS без ограничений
            </p>
          </div>

          <div class="glass-card rounded-2xl p-6 text-center group hover:scale-105 transition-all">
            <div class="w-16 h-16 rounded-xl bg-gradient-to-br from-secondary/20 to-secondary/5 flex items-center justify-center mx-auto mb-4 group-hover:scale-110 transition-transform">
              <Icon name="heroicons:device-phone-mobile" class="w-8 h-8 text-secondary" />
            </div>
            <h3 class="font-bold text-[var(--text-primary)] mb-2 group-hover:text-secondary transition-colors">
              Единый счет
            </h3>
            <p class="text-sm text-[var(--text-muted)]">
              Все услуги в одном личном кабинете
            </p>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

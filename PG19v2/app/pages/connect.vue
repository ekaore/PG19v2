<script setup lang="ts">
useHead({
  title: 'Подключиться — ПЖ19'
})

// Режим ввода адреса: 'input' или 'map'
const addressMode = ref<'input' | 'map'>('input')

// Форма
const form = reactive({
  fullName: '',
  phone: '',
  address: {
    text: '',
    coordinates: null as [number, number] | null,
    components: null as Record<string, any> | null
  }
})

// Состояния
const phoneValid = ref(false)
const coverageResult = ref<any>(null)
const isSubmitting = ref(false)
const isSubmitted = ref(false)
const submitError = ref('')

// Валидация формы
const isFormValid = computed(() => {
  return (
    form.fullName.trim().length >= 2 &&
    phoneValid.value &&
    form.address.coordinates !== null
  )
})

// Обработчик проверки зоны покрытия
const onCoverageCheck = (result: any) => {
  coverageResult.value = result
}

// Отправка формы
const submitForm = async () => {
  if (!isFormValid.value) return

  isSubmitting.value = true
  submitError.value = ''

  try {
    // Конвертируем coordinates [lat, lon] в latitude/longitude для API
    const [lat, lon] = form.address.coordinates || [0, 0]

    const response = await $fetch('/api/connection/create', {
      method: 'POST',
      body: {
        fullName: form.fullName.trim(),
        phone: form.phone,
        address: {
          text: form.address.text,
          latitude: lat,
          longitude: lon,
          components: form.address.components
        },
        source: 'website'
      }
    })

    // Успешная отправка
    isSubmitted.value = true
  } catch (e: any) {
    console.error('Submit error:', e)
    submitError.value = e.data?.message || e.message || 'Произошла ошибка при отправке заявки'
  } finally {
    isSubmitting.value = false
  }
}

// Сброс формы для новой заявки
const resetForm = () => {
  form.fullName = ''
  form.phone = ''
  form.address = {
    text: '',
    coordinates: null,
    components: null
  }
  phoneValid.value = false
  coverageResult.value = null
  isSubmitted.value = false
  submitError.value = ''
  addressMode.value = 'input'
}
</script>

<template>
  <div class="pt-28">
    <!-- Hero -->
    <section class="mesh-gradient-hero py-20 md:py-32 relative overflow-hidden">
      <div class="absolute inset-0 network-pattern opacity-20"></div>
      <div class="floating-shape w-[500px] h-[500px] bg-primary/15 -bottom-32 -right-32"></div>

      <div class="container mx-auto px-4 relative z-10">
        <div class="max-w-4xl mx-auto text-center">
          <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold text-[var(--text-primary)] mb-6 opacity-0 animate-fade-in-up">
            Подключиться к <span class="text-gradient-primary">сообществу</span>
          </h1>
          <p class="text-xl text-[var(--text-muted)] opacity-0 animate-fade-in-up stagger-1">
            Оставьте заявку, и мы свяжемся с вами для уточнения деталей
          </p>
        </div>
      </div>
    </section>

    <!-- Form -->
    <section class="py-20 md:py-32" :style="{ background: 'var(--bg-base)' }">
      <div class="container mx-auto px-4">
        <div class="max-w-3xl mx-auto">
          <!-- Success message -->
          <div v-if="isSubmitted" class="text-center opacity-0 animate-fade-in-up">
            <!-- Анимированная иконка успеха -->
            <div class="relative inline-block mb-8">
              <div class="w-24 h-24 glass-card rounded-3xl flex items-center justify-center mx-auto relative overflow-hidden group">
                <!-- Glow effect -->
                <div class="absolute inset-0 bg-gradient-to-br from-accent/30 to-accent/10 rounded-3xl opacity-0 group-hover:opacity-100 transition-opacity"></div>
                <Icon name="heroicons:check-circle" class="w-12 h-12 text-accent relative z-10 animate-bounce-in" />
              </div>
              <!-- Декоративные элементы -->
              <div class="absolute -top-2 -right-2 w-6 h-6 bg-accent rounded-full animate-ping opacity-75"></div>
              <div class="absolute -bottom-2 -left-2 w-4 h-4 bg-primary rounded-full animate-pulse"></div>
            </div>

            <h2 class="text-3xl md:text-4xl font-bold text-[var(--text-primary)] mb-4">
              Заявка <span class="text-gradient-primary">отправлена!</span>
            </h2>
            <p class="text-lg text-[var(--text-muted)] mb-8 max-w-xl mx-auto">
              Мы свяжемся с вами в ближайшее время для уточнения деталей подключения.
            </p>

            <!-- Информация о времени ответа -->
            <div class="glass-card rounded-2xl p-6 mb-8 max-w-md mx-auto">
              <div class="flex items-center justify-center gap-3 mb-4">
                <Icon name="heroicons:clock" class="w-5 h-5 text-primary" />
                <span class="text-sm font-medium text-[var(--text-primary)]">Время ответа</span>
              </div>
              <p class="text-sm text-[var(--text-muted)] mb-3">
                Обычно мы связываемся в течение <span class="text-[var(--text-primary)] font-semibold">1-2 рабочих дней</span>
              </p>
              <div class="flex items-center justify-center gap-4 text-xs text-[var(--text-muted)]">
                <div class="flex items-center gap-1.5">
                  <Icon name="heroicons:phone" class="w-4 h-4" />
                  <span>По телефону</span>
                </div>
                <div class="flex items-center gap-1.5">
                  <Icon name="heroicons:chat-bubble-left-right" class="w-4 h-4" />
                  <span>В Telegram</span>
                </div>
              </div>
            </div>

            <!-- Предупреждение о зоне покрытия -->
            <div v-if="coverageResult && !coverageResult.inCoverage" class="mb-8 p-5 bg-orange-500/10 border border-orange-500/20 rounded-xl max-w-md mx-auto">
              <div class="flex items-start gap-3">
                <Icon name="heroicons:exclamation-triangle" class="w-5 h-5 text-orange-400 flex-shrink-0 mt-0.5" />
                <div class="text-left">
                  <p class="text-sm text-orange-400 font-medium mb-1">Адрес вне зоны покрытия</p>
                  <p class="text-xs text-[var(--text-muted)]">
                    Мы обязательно рассмотрим возможность подключения и свяжемся с вами для обсуждения вариантов.
                  </p>
                </div>
              </div>
            </div>

            <!-- Действия -->
            <div class="flex flex-col sm:flex-row items-center justify-center gap-4 mb-8">
              <a
                href="https://pg19-client.doka.team"
                target="_blank"
                rel="noopener noreferrer"
                class="group btn-primary inline-flex items-center gap-3 px-8 py-4 text-lg relative overflow-hidden"
              >
                <Icon name="heroicons:clipboard-document-list" class="w-5 h-5 relative z-10" />
                <span class="relative z-10">Отследить статус заявки</span>
                <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/10 to-transparent translate-x-[-100%] group-hover:translate-x-[100%] transition-transform duration-1000"></div>
              </a>
              <button
                @click="resetForm"
                class="btn-secondary inline-flex items-center gap-2"
              >
                <Icon name="heroicons:arrow-path" class="w-5 h-5" />
                <span>Отправить еще одну</span>
              </button>
            </div>

            <!-- Дополнительная информация -->
            <div class="glass-card rounded-2xl p-6 max-w-2xl mx-auto">
              <h3 class="text-lg font-semibold text-[var(--text-primary)] mb-4 flex items-center justify-center gap-2">
                <Icon name="heroicons:information-circle" class="w-5 h-5 text-primary" />
                <span>Что дальше?</span>
              </h3>
              <div class="grid md:grid-cols-2 gap-4 text-left">
                <div class="flex items-start gap-3">
                  <div class="w-8 h-8 rounded-lg bg-primary/10 flex items-center justify-center flex-shrink-0">
                    <Icon name="heroicons:phone" class="w-4 h-4 text-primary" />
                  </div>
                  <div>
                    <p class="text-sm font-medium text-[var(--text-primary)] mb-1">Звонок от специалиста</p>
                    <p class="text-xs text-[var(--text-muted)]">
                      Мы уточним детали и ответим на ваши вопросы
                    </p>
                  </div>
                </div>
                <div class="flex items-start gap-3">
                  <div class="w-8 h-8 rounded-lg bg-secondary/10 flex items-center justify-center flex-shrink-0">
                    <Icon name="heroicons:calendar" class="w-4 h-4 text-secondary" />
                  </div>
                  <div>
                    <p class="text-sm font-medium text-[var(--text-primary)] mb-1">Согласование времени</p>
                    <p class="text-xs text-[var(--text-muted)]">
                      Выберем удобное время для визита специалиста
                    </p>
                  </div>
                </div>
                <div class="flex items-start gap-3">
                  <div class="w-8 h-8 rounded-lg bg-accent/10 flex items-center justify-center flex-shrink-0">
                    <Icon name="heroicons:truck" class="w-4 h-4 text-accent" />
                  </div>
                  <div>
                    <p class="text-sm font-medium text-[var(--text-primary)] mb-1">Выезд специалиста</p>
                    <p class="text-xs text-[var(--text-muted)]">
                      Наш специалист приедет и настроит оборудование
                    </p>
                  </div>
                </div>
                <div class="flex items-start gap-3">
                  <div class="w-8 h-8 rounded-lg bg-info/10 flex items-center justify-center flex-shrink-0">
                    <Icon name="heroicons:rocket-launch" class="w-4 h-4 text-info" />
                  </div>
                  <div>
                    <p class="text-sm font-medium text-[var(--text-primary)] mb-1">Подключение</p>
                    <p class="text-xs text-[var(--text-muted)]">
                      Наслаждайтесь услугами сообщества
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Form -->
          <form v-else @submit.prevent="submitForm" class="space-y-6">
            <!-- Прогресс-бар -->
            <div class="opacity-0 animate-fade-in-up mb-8">
              <div class="flex items-center justify-between mb-2">
                <span class="text-sm font-medium text-[var(--text-secondary)]">Прогресс заполнения</span>
                <span class="text-sm text-[var(--text-muted)]">
                  {{ Math.round((Number(form.fullName.trim().length >= 2) + Number(phoneValid) + Number(form.address.coordinates !== null)) / 3 * 100) }}%
                </span>
              </div>
              <div class="h-2 bg-[var(--glass-bg)] rounded-full overflow-hidden">
                <div
                  class="h-full bg-gradient-to-r from-primary to-secondary transition-all duration-500 rounded-full"
                  :style="{
                    width: `${(Number(form.fullName.trim().length >= 2) + Number(phoneValid) + Number(form.address.coordinates !== null)) / 3 * 100}%`
                  }"
                />
              </div>
            </div>

            <!-- Имя -->
            <div class="opacity-0 animate-fade-in-up">
              <UInput
                v-model="form.fullName"
                label="Как к вам обращаться?"
                type="text"
                required
                placeholder="Иван Иванов"
                hint="Укажите ваше полное имя для обращения"
                icon="heroicons:user"
              />
            </div>

            <!-- Телефон -->
            <div class="opacity-0 animate-fade-in-up stagger-1">
              <ConnectionPhoneInput
                v-model="form.phone"
                label="Телефон"
                required
                @validation="phoneValid = $event"
              />
            </div>

            <!-- Переключатель режима адреса -->
            <div class="opacity-0 animate-fade-in-up stagger-2">
              <label class="block text-sm font-medium text-[var(--text-secondary)] mb-3 flex items-center gap-2">
                <Icon name="heroicons:map-pin" class="w-4 h-4" />
                <span>Адрес подключения</span>
                <span class="text-primary">*</span>
                <Icon
                  name="heroicons:information-circle"
                  class="w-4 h-4 text-[var(--text-muted)] cursor-help"
                  title="Выберите способ указания адреса: ввод текста или выбор на карте"
                />
              </label>
              <div class="glass-card p-2 flex gap-2">
                <button
                  @click="addressMode = 'input'"
                  type="button"
                  :class="[
                    'flex-1 px-4 py-3 rounded-lg font-medium transition-all flex items-center justify-center gap-2',
                    addressMode === 'input'
                      ? 'bg-gradient-to-r from-primary to-secondary text-white shadow-lg'
                      : 'text-[var(--text-secondary)] hover:bg-white/5 border border-transparent hover:border-primary/20'
                  ]"
                >
                  <Icon name="heroicons:magnifying-glass" class="w-4 h-4" />
                  <span>Ввести адрес</span>
                </button>
                <button
                  @click="addressMode = 'map'"
                  type="button"
                  :class="[
                    'flex-1 px-4 py-3 rounded-lg font-medium transition-all flex items-center justify-center gap-2',
                    addressMode === 'map'
                      ? 'bg-gradient-to-r from-primary to-secondary text-white shadow-lg'
                      : 'text-[var(--text-secondary)] hover:bg-white/5 border border-transparent hover:border-primary/20'
                  ]"
                >
                  <Icon name="heroicons:map" class="w-4 h-4" />
                  <span>Выбрать на карте</span>
                </button>
              </div>
              <p class="mt-2 text-xs text-[var(--text-muted)] flex items-center gap-1.5">
                <Icon name="heroicons:light-bulb" class="w-3.5 h-3.5" />
                <span>Рекомендуем выбрать адрес из подсказок для точной проверки зоны покрытия</span>
              </p>
            </div>

            <!-- Адрес: Input или Map -->
            <div class="opacity-0 animate-fade-in-up stagger-3 relative z-50">
              <ConnectionAddressInput
                v-if="addressMode === 'input'"
                v-model="form.address"
                label="Адрес подключения"
                required
                @coverage-check="onCoverageCheck"
              />
              <ConnectionMapPicker
                v-else
                v-model="form.address"
                :show-coverage-zone="true"
                @coverage-check="onCoverageCheck"
              />
            </div>

            <!-- Сообщение о статусе зоны покрытия -->
            <div
              v-if="coverageResult && coverageResult.inCoverage"
              class="opacity-0 animate-fade-in-up stagger-4 p-4 bg-accent/10 border border-accent/20 rounded-lg"
            >
              <div class="flex items-start gap-3">
                <Icon name="heroicons:check-circle" class="w-5 h-5 text-accent flex-shrink-0 mt-0.5" />
                <div class="flex-1">
                  <p class="text-sm text-accent font-medium mb-1">Адрес в зоне покрытия!</p>
                  <p class="text-sm text-[var(--text-muted)]">
                    Отправьте заявку, и мы свяжемся с вами для уточнения деталей подключения.
                  </p>
                </div>
              </div>
            </div>

            <div
              v-else-if="coverageResult && !coverageResult.inCoverage"
              class="opacity-0 animate-fade-in-up stagger-4 p-4 bg-orange-500/10 border border-orange-500/20 rounded-lg"
            >
              <div class="flex items-start gap-3">
                <Icon name="heroicons:exclamation-triangle" class="w-5 h-5 text-orange-500 flex-shrink-0 mt-0.5" />
                <div class="flex-1">
                  <p class="text-sm text-orange-500 font-medium mb-1">Адрес вне зоны покрытия</p>
                  <p class="text-sm text-[var(--text-muted)]">
                    Вы можете оставить заявку, мы обязательно рассмотрим возможность подключения и свяжемся с вами.
                  </p>
                </div>
              </div>
            </div>

            <!-- Submit error -->
            <div
              v-if="submitError"
              class="opacity-0 animate-fade-in-up p-4 bg-red-500/10 border border-red-500/20 rounded-lg"
            >
              <div class="flex items-start gap-3">
                <Icon name="heroicons:x-circle" class="w-5 h-5 text-red-500 flex-shrink-0 mt-0.5" />
                <div class="flex-1">
                  <p class="text-sm text-red-500 font-medium mb-1">Ошибка при отправке</p>
                  <p class="text-sm text-[var(--text-muted)]">{{ submitError }}</p>
                </div>
              </div>
            </div>

            <!-- Submit -->
            <div class="opacity-0 animate-fade-in-up stagger-5 relative z-10">
              <!-- Визуальная подсказка о готовности формы -->
              <div
                v-if="!isFormValid && (form.fullName || form.phone || form.address.text)"
                class="mb-4 p-3 bg-blue-500/10 border border-blue-500/20 rounded-lg"
              >
                <div class="flex items-start gap-2">
                  <Icon name="heroicons:information-circle" class="w-5 h-5 text-blue-400 flex-shrink-0 mt-0.5" />
                  <div class="flex-1">
                    <p class="text-sm text-blue-400 font-medium mb-1">Заполните все обязательные поля</p>
                    <ul class="text-xs text-[var(--text-muted)] space-y-1">
                      <li v-if="form.fullName.trim().length < 2" class="flex items-center gap-1.5">
                        <Icon name="heroicons:minus-circle" class="w-3 h-3" />
                        <span>Имя должно содержать минимум 2 символа</span>
                      </li>
                      <li v-if="!phoneValid" class="flex items-center gap-1.5">
                        <Icon name="heroicons:minus-circle" class="w-3 h-3" />
                        <span>Укажите корректный номер телефона</span>
                      </li>
                      <li v-if="!form.address.coordinates" class="flex items-center gap-1.5">
                        <Icon name="heroicons:minus-circle" class="w-3 h-3" />
                        <span>Выберите адрес из подсказок</span>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>

              <button
                type="submit"
                :disabled="!isFormValid || isSubmitting"
                class="w-full btn-primary flex items-center justify-center gap-3 py-5 text-lg disabled:opacity-50 disabled:cursor-not-allowed relative overflow-hidden group"
              >
                <span class="relative z-10 flex items-center gap-3">
                  <Icon v-if="isSubmitting" name="heroicons:arrow-path" class="w-5 h-5 animate-spin" />
                  <Icon v-else-if="isFormValid" name="heroicons:paper-airplane" class="w-5 h-5" />
                  <span>{{ isSubmitting ? 'Отправка...' : isFormValid ? 'Отправить заявку' : 'Заполните все поля' }}</span>
                </span>
                <!-- Анимация при наведении на активную кнопку -->
                <div
                  v-if="isFormValid && !isSubmitting"
                  class="absolute inset-0 bg-gradient-to-r from-transparent via-white/10 to-transparent translate-x-[-100%] group-hover:translate-x-[100%] transition-transform duration-1000"
                />
              </button>
              <!-- Legal -->
              <p class="text-xs text-[var(--text-muted)] text-center mt-3 flex items-center justify-center gap-1.5">
                <Icon name="heroicons:shield-check" class="w-3.5 h-3.5" />
                <span>Нажимая кнопку, вы соглашаетесь с обработкой персональных данных</span>
              </p>
            </div>
          </form>
        </div>
      </div>
    </section>

    <!-- Info -->
    <section v-if="!isSubmitted" class="py-12 md:py-16 mesh-gradient-dark">
      <div class="container mx-auto px-4">
        <div class="max-w-3xl mx-auto">
          <div class="text-center mb-8">
            <div class="inline-flex items-center gap-2 glass-card rounded-full px-4 py-2 mb-4">
              <Icon name="heroicons:sparkles" class="w-4 h-4 text-primary" />
              <span class="text-primary font-medium text-sm uppercase tracking-wider">Процесс подключения</span>
            </div>
            <h2 class="text-2xl md:text-3xl font-bold text-[var(--text-primary)] mb-3">Как это работает</h2>
            <p class="text-[var(--text-muted)]">Простой процесс подключения в три шага</p>
          </div>
          <div class="grid md:grid-cols-3 gap-8">
            <div class="text-center group glass-card rounded-2xl p-6 hover:scale-105 transition-all">
              <div class="w-16 h-16 glass-card rounded-2xl flex items-center justify-center mx-auto mb-6 group-hover:scale-110 transition-transform bg-gradient-to-br from-primary/20 to-primary/5">
                <span class="text-2xl font-bold text-primary">1</span>
              </div>
              <h3 class="font-semibold text-[var(--text-primary)] mb-2 group-hover:text-primary transition-colors">Заявка</h3>
              <p class="text-[var(--text-muted)] text-sm">Укажите ваш адрес и контактные данные</p>
              <div class="mt-4 flex justify-center">
                <Icon name="heroicons:arrow-down" class="w-6 h-6 text-[var(--text-muted)] md:hidden" />
                <Icon name="heroicons:arrow-right" class="w-6 h-6 text-[var(--text-muted)] hidden md:block group-hover:translate-x-1 transition-transform" />
              </div>
            </div>
            <div class="text-center group glass-card rounded-2xl p-6 hover:scale-105 transition-all">
              <div class="w-16 h-16 glass-card rounded-2xl flex items-center justify-center mx-auto mb-6 group-hover:scale-110 transition-transform bg-gradient-to-br from-secondary/20 to-secondary/5">
                <span class="text-2xl font-bold text-secondary">2</span>
              </div>
              <h3 class="font-semibold text-[var(--text-primary)] mb-2 group-hover:text-secondary transition-colors">Проверка зоны</h3>
              <p class="text-[var(--text-muted)] text-sm">Мы автоматически проверим возможность подключения</p>
              <div class="mt-4 flex justify-center">
                <Icon name="heroicons:arrow-down" class="w-6 h-6 text-[var(--text-muted)] md:hidden" />
                <Icon name="heroicons:arrow-right" class="w-6 h-6 text-[var(--text-muted)] hidden md:block group-hover:translate-x-1 transition-transform" />
              </div>
            </div>
            <div class="text-center group glass-card rounded-2xl p-6 hover:scale-105 transition-all">
              <div class="w-16 h-16 glass-card rounded-2xl flex items-center justify-center mx-auto mb-6 group-hover:scale-110 transition-transform bg-gradient-to-br from-accent/20 to-accent/5">
                <span class="text-2xl font-bold text-accent">3</span>
              </div>
              <h3 class="font-semibold text-[var(--text-primary)] mb-2 group-hover:text-accent transition-colors">Подключение</h3>
              <p class="text-[var(--text-muted)] text-sm">Наш специалист приедет и настроит оборудование</p>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

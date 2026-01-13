<script setup lang="ts">
interface Props {
  modelValue?: string | number
  type?: string
  placeholder?: string
  label?: string
  error?: string
  disabled?: boolean
  required?: boolean
  hint?: string
  icon?: string
}

const props = withDefaults(defineProps<Props>(), {
  type: 'text',
  modelValue: ''
})

const emit = defineEmits<{
  'update:modelValue': [value: string | number]
}>()

const inputValue = computed({
  get: () => props.modelValue,
  set: (value) => emit('update:modelValue', value)
})

const hasValue = computed(() => {
  const val = String(props.modelValue || '')
  return val.trim().length > 0
})
</script>

<template>
  <div class="w-full">
    <label v-if="label" class="block text-sm font-medium text-[var(--text-secondary)] mb-2 flex items-center gap-2">
      <span>{{ label }}</span>
      <span v-if="required" class="text-red-500 text-xs" title="Обязательное поле">*</span>
      <Icon
        v-if="hint"
        name="heroicons:information-circle"
        class="w-4 h-4 text-[var(--text-muted)] cursor-help"
        :title="hint"
      />
    </label>
    <div class="relative">
      <div v-if="icon" class="absolute left-4 top-1/2 -translate-y-1/2 pointer-events-none">
        <Icon :name="icon" class="w-5 h-5 text-[var(--text-muted)]" />
      </div>
      <input
        v-model="inputValue"
        :type="type"
        :placeholder="placeholder"
        :disabled="disabled"
        class="w-full px-4 py-3 rounded-xl text-[var(--text-primary)] placeholder-[var(--text-muted)] focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all duration-200 disabled:opacity-50 disabled:cursor-not-allowed"
        :class="{
          'border-red-500 focus:border-red-500 focus:ring-red-500/20': error,
          'border-accent/50 focus:border-accent': hasValue && !error,
          'pl-11': icon
        }"
        :style="{
          background: 'var(--glass-bg)',
          border: error ? '1px solid rgb(239 68 68)' : hasValue && !error ? '1px solid rgba(0, 166, 81, 0.5)' : '1px solid var(--glass-border)'
        }"
      />
      <!-- Визуальный индикатор валидности -->
      <div
        v-if="hasValue && !error"
        class="absolute right-4 top-1/2 -translate-y-1/2 pointer-events-none"
      >
        <Icon name="heroicons:check-circle" class="w-5 h-5 text-accent" />
      </div>
      <div
        v-if="error"
        class="absolute right-4 top-1/2 -translate-y-1/2 pointer-events-none"
      >
        <Icon name="heroicons:exclamation-circle" class="w-5 h-5 text-red-500" />
      </div>
    </div>
    <!-- Подсказка -->
    <p v-if="hint && !error && !hasValue" class="mt-1.5 text-xs text-[var(--text-muted)] flex items-center gap-1.5">
      <Icon name="heroicons:light-bulb" class="w-3.5 h-3.5 flex-shrink-0" />
      <span>{{ hint }}</span>
    </p>
    <!-- Ошибка -->
    <p v-if="error" class="mt-1.5 text-sm text-red-400 flex items-center gap-1.5">
      <Icon name="heroicons:exclamation-circle" class="w-4 h-4 flex-shrink-0" />
      <span>{{ error }}</span>
    </p>
  </div>
</template>

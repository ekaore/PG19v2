<script setup lang="ts">
interface Props {
  type?: 'success' | 'error' | 'warning' | 'info'
  title?: string
  message: string
  duration?: number
  closable?: boolean
}

const props = withDefaults(defineProps<Props>(), {
  type: 'info',
  duration: 5000,
  closable: true
})

const emit = defineEmits<{
  close: []
}>()

const icons = {
  success: 'heroicons:check-circle',
  error: 'heroicons:x-circle',
  warning: 'heroicons:exclamation-triangle',
  info: 'heroicons:information-circle'
}

const colors = {
  success: {
    bg: 'bg-accent/10',
    border: 'border-accent/20',
    text: 'text-accent',
    icon: 'text-accent'
  },
  error: {
    bg: 'bg-red-500/10',
    border: 'border-red-500/20',
    text: 'text-red-500',
    icon: 'text-red-500'
  },
  warning: {
    bg: 'bg-orange-500/10',
    border: 'border-orange-500/20',
    text: 'text-orange-500',
    icon: 'text-orange-500'
  },
  info: {
    bg: 'bg-info/10',
    border: 'border-info/20',
    text: 'text-info',
    icon: 'text-info'
  }
}

const colorScheme = computed(() => colors[props.type])

onMounted(() => {
  if (props.duration > 0) {
    setTimeout(() => emit('close'), props.duration)
  }
})
</script>

<template>
  <div
    class="p-4 rounded-lg border flex items-start gap-3 animate-fade-in-up"
    :class="[colorScheme.bg, colorScheme.border]"
    role="alert"
    :aria-live="type === 'error' ? 'assertive' : 'polite'"
    :aria-atomic="true"
  >
    <Icon
      :name="icons[type]"
      class="w-5 h-5 flex-shrink-0 mt-0.5"
      :class="colorScheme.icon"
    />
    <div class="flex-1 min-w-0">
      <p v-if="title" class="font-medium mb-1" :class="colorScheme.text">
        {{ title }}
      </p>
      <p class="text-sm" :class="colorScheme.text">
        {{ message }}
      </p>
    </div>
    <button
      v-if="closable"
      @click="emit('close')"
      class="flex-shrink-0 p-1 rounded hover:bg-white/10 transition-colors"
      aria-label="Закрыть уведомление"
    >
      <Icon name="heroicons:x-mark" class="w-4 h-4" :class="colorScheme.text" />
    </button>
  </div>
</template>

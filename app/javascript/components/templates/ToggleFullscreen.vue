<script setup>
import {ref, onMounted, onBeforeUnmount} from "vue"
import FullScreen from "@/components/icons/full-screen.vue"
import Pinch from "@/components/icons/pinch.vue"

// Reactive state
const isFullscreenNow = ref(document.fullscreenElement !== null)

// Event emitter
const emit = defineEmits(['toggleFullscreen'])

// Toggle handler
function handleClick() {
  isFullscreenNow.value = !isFullscreenNow.value
  emit('toggleFullscreen')
}

// Fullscreen change handler
function handleFullscreenChange() {
  isFullscreenNow.value = document.fullscreenElement !== null
}

// Lifecycle hooks
onMounted(() => {
  document.addEventListener("fullscreenchange", handleFullscreenChange)
})

onBeforeUnmount(() => {
  document.removeEventListener("fullscreenchange", handleFullscreenChange)
})
</script>

<template>
  <button
    class="z-10 btn btn-sm btn-primary absolute top-8 right-3 opacity-40 hover:opacity-100"
    @click="handleClick"
    :aria-label="isFullscreenNow ? 'Exit fullscreen' : 'Enter fullscreen'"
  >
    <component
      :is="isFullscreenNow ? Pinch : FullScreen"
      class="h-4"
    />
    <span>{{ isFullscreenNow ? "Exit" : "Fullscreen" }}</span>
  </button>
</template>

<style scoped>
/* Add any custom styles here if needed */
</style>

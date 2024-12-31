<script setup>
import {ref, onMounted, onBeforeUnmount} from "vue"
import FullScreen from "@/components/icons/full-screen.vue";
import Pinch from "@/components/icons/pinch.vue";

const emit = defineEmits()
const isFullscreenNow = ref(false)

function handleClick() {
  isFullscreenNow.value = !isFullscreenNow.value
  emit('toggleFullscreen')
}

// Add and remove the event listener
onMounted(() => {
  document.addEventListener("fullscreenchange", () => {
    isFullscreenNow.value = document.fullscreenElement !== null;
  });
});

onBeforeUnmount(() => {
  document.removeEventListener("fullscreenchange", () => {
    isFullscreenNow.value = document.fullscreenElement !== null;
  });
});

</script>

<template>
  <button class="z-50 btn btn-sm btn-primary absolute top-8 right-3 opacity-40 hover:opacity-100"
          @click="handleClick"
  >
    <FullScreen v-if="!isFullscreenNow" class="h-4"/>
    <Pinch v-else class="h-4"/>
    <span>{{ isFullscreenNow ? "Exit" : "Fullscreen" }}</span>
  </button>
</template>

<style scoped>

</style>

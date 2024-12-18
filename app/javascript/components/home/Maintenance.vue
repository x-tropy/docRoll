<script setup>
import SettingsWheel from "~/components/icons/settings-wheel.vue";
</script>

<template>
  <div class="w-full h-full flex flex-col justify-center items-center gap-1">
    <div
        class="w-[78px] aspect-[1/1] mb-4 rounded-full flex items-center justify-center"
        :class="`bg-orange-500`"
    >
      <div class="p-2 rounded-xl bg-white bg-opacity-35 shadow-lg">
        <SettingsWheel strokewidth="2" width="28" height="28" class="drop-shadow-lg text-white spin "/>
      </div>
    </div>
      <h2 class="font-bold text-3xl tracking-tight text-gray-600">Under Maintenance</h2>
      <p class="px-10 sm:px-0 sm:w-1/2 lg:w-1/3 mt-1 leading-tight text-gray-600 text-center">This feature is currently under active development and not yet available. We’re excited to announce that it’s scheduled for launch on <b>February 17</b>. Stay tuned!</p>
  </div>
</template>

<style scoped>
@keyframes slow-spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

.spin {
  animation: slow-spin 8s linear infinite;

}
</style>

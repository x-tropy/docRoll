<script setup>
import SettingsWheel from "~/components/icons/settings-wheel.vue";
</script>

<template>
  <div class="w-full h-full flex flex-col justify-center items-center gap-1">
    <div
        class="w-[70px] aspect-[1/1] mb-4 rounded-full flex items-center justify-center"
        :class="`bg-orange-500`"
    >
      <div class="p-2 rounded-xl bg-white bg-opacity-35 shadow-lg">
        <SettingsWheel strokewidth="2" width="24" height="24" class="drop-shadow-lg text-white spin "/>
      </div>
    </div>
      <h2 class="font-bold text-3xl tracking-tight">Under Maintenance</h2>
      <p class="w-1/3 mt-1 text-center">I'm sorry, these features are not ready yet. But they are under heavy development currently, we are looking forward to launch them in March.</p>
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
  animation: slow-spin 10s linear infinite;

}
</style>

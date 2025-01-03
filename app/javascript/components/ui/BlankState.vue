<script setup>
import SettingsWheel from "~/components/icons/settings-wheel.vue";

defineProps({
  title: {
    type: String,
    required: true
  },
  body: {
    type: String,
    required: true
  },
  color: {
    type: String,
    default: 'orange'
  }
});

const colorClasses = {
  orange: 'bg-orange-500',
  blue: 'bg-blue-500',
  green: 'bg-green-500',
  red: 'bg-red-500',
  // add more colors as needed
}
</script>

<template>
  <div class="w-full h-full flex flex-col justify-center items-center gap-1">
    <div class="w-[78px] aspect-[1/1] mb-4 rounded-full flex items-center justify-center" :class="colorClasses[color]">
      <div class="p-2 rounded-xl bg-white bg-opacity-35 shadow-lg">
        <slot name="icon">
          <!-- Default icon if none provided -->
          <SettingsWheel strokewidth="2" width="28" height="28" class="drop-shadow-lg text-white" />
        </slot>
      </div>
    </div>
    <h2 class="font-bold text-3xl tracking-tight text-gray-600">{{ title }}</h2>
    <p class="px-10 sm:px-0 sm:w-1/2 lg:w-1/3 mt-1 leading-tight text-gray-600 text-center" v-html="body"></p>
    <slot name="action" />
  </div>
</template>

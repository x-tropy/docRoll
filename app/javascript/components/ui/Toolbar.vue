<script setup>
import {ref, defineAsyncComponent} from "vue";

const props = defineProps({
  items: {
    type: Array,
    required: true,
  },
  theme: {
    type: String,
    required: false,
    default: "dark",
  },
  currentItem: {
    type: Boolean,
    required: false
  },
  currentItemIndex: {
    type: Number,
    required: false,
  },
});

const currentItemIndex = ref(props.currentItemIndex || null);

const emit = defineEmits()
const select = (i, item) => {
  if (item.action) {
    emit("toolEvent", item.action)
  }

  if (!props.currentItem) return
  currentItemIndex.value = i
};

// Dynamically import components for icons
const iconComponents = props.items.reduce((acc, item) => {
  if (!item.icon) return acc;
  acc[item.icon] = defineAsyncComponent(() =>
      import(`../icons/${item.icon}.vue`)
  );
  return acc;
}, {});
</script>

<template>
  <ul class="rounded-[5px] bg-gray-600 flex overflow-hidden z-20 shadow-md">
    <li
        v-for="(item, index) in props.items"
        class="item"
        :class="{ active: currentItemIndex == index }"
        :key="index"
        @click="select(index, item)"
    >
      <span v-if="item.dividerLeft" class="divider"></span>
      <!-- Dynamically render the icon component -->
      <component :is="iconComponents[item.icon]" class="icon"/>
      <span v-if="item.label" class="ml-1.5 text-[13px] leading-none">
        {{ item.label }}
      </span>
      <span v-if="item.dividerRight" class="divider"></span>
    </li>
  </ul>
</template>

<style scoped>
.item {
  @apply text-white p-2 flex items-center cursor-pointer hover:text-cyan-300 font-medium;

  &.active {
    @apply text-cyan-300 bg-black;
  }

  &.disabled {
    @apply cursor-not-allowed;
  }
}

.divider {
  @apply w-[0.5px] bg-gray-500 h-full relative left-2;
}
</style>

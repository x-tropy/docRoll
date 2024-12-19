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
  size: {
    type: String,
    default: 'sm'
  }
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
</script>

<template>
  <ul class="rounded-[5px] bg-gray-600 flex overflow-hidden z-20 shadow-md">
    <li
        v-for="(item, index) in props.items"
        class="item"
        :class="{ active: currentItemIndex == index, ['item-'+props.size]: true }"
        :key="index"
        @click="select(index, item)"
    >
      <span v-if="item.dividerLeft" class="divider"></span>
      <!-- Dynamically render the icon component -->
      <component v-if="item.icon" :is="item.icon"/>
      <span v-if="item.label" class="text-[13px] leading-none select-none" :class="{'ml-1.5': item.icon}">
        {{ item.label }}
      </span>
      <span v-if="item.dividerRight" class="divider"></span>
    </li>
  </ul>
</template>

<style scoped>
.item {
  @apply text-white flex items-center cursor-pointer hover:text-cyan-300 font-medium relative;

  &.item-sm {
    @apply p-2;
  }

  &.item-md {
    @apply p-2.5;
  }

  &.active {
    @apply text-cyan-300 bg-black;
  }

  &.disabled {
    @apply cursor-not-allowed;
  }
}

.divider {
  @apply w-[0.5px] bg-gray-400 opacity-60 h-5 absolute right-0 z-20;
}

</style>

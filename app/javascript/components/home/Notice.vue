<script setup>
import Mouse1 from "~/components/icons/mouse-1.vue";
import ToolHand from "~/components/icons/tool-hand.vue";
</script>

<template>
<div class="flex items-center text-sm gap-1 bg-white text-gray-500 ml-2 px-2 py-0.5 shadow-md rounded">
  <Mouse1 /> <span>Scroll to zoom in/out</span>
  <ToolHand class="ml-2" stroke-width="1.5" width="20" /> <span>Drag to move around</span>
</div>
</template>

<style scoped>

</style>

<script setup>
import imageUrl from "../../assets/images/how-it-works.png"
import {ref, onMounted, onUnmounted} from "vue";

const zoomLevel = ref(1); // Track zoom level
const position = ref({x: 0, y: 0}); // Track image position
const dragging = ref(false); // Track dragging state
const lastMousePosition = ref({x: 0, y: 0}); // Store the last mouse position for calculations

// Handle mouse down to start dragging
const handleMouseDown = (e) => {
  dragging.value = true;
  console.log(dragging.value)
  lastMousePosition.value = {x: e.clientX, y: e.clientY};
};

// Handle mouse movement for dragging
const handleMouseMove = (e) => {
  if (!dragging.value) return;

  const dx = e.clientX - lastMousePosition.value.x;
  const dy = e.clientY - lastMousePosition.value.y;

  position.value.x += dx;
  position.value.y += dy;

  lastMousePosition.value = {x: e.clientX, y: e.clientY};
};

// Stop dragging on mouse up
const handleMouseUp = () => {
  dragging.value = false;
};

// Handle zooming with the scroll wheel
const handleWheel = (e) => {
  const zoomFactor = 0.1; // Adjust zoom factor as needed
  if (e.deltaY < 0) {
    zoomLevel.value = Math.min(zoomLevel.value + zoomFactor, 2); // Limit max zoom
  } else {
    zoomLevel.value = Math.max(zoomLevel.value - zoomFactor, 0.8); // Limit min zoom
  }
};

// Attach event listeners
onMounted(() => {
  window.addEventListener("mousemove", handleMouseMove);
  window.addEventListener("mouseup", handleMouseUp);
  window.addEventListener("wheel", handleWheel);
});

// Cleanup event listeners
onUnmounted(() => {
  window.removeEventListener("mousemove", handleMouseMove);
  window.removeEventListener("mouseup", handleMouseUp);
  window.removeEventListener("wheel", handleWheel);
});
</script>

<template>
  <div
      class="relative w-full h-screen overflow-hidden cursor-crosshair" :class="{'cursor-grabbing': dragging}"
      @mousedown="handleMouseDown"
  >
    <!-- Image -->
    <img
        :src="imageUrl"
        alt="Large Image"
        :style="{
        transform: `translate(${position.x}px, ${position.y}px) scale(${zoomLevel})`
      }"
        class="select-none"
    />
  </div>
</template>

<style scoped>
/* Basic styles for better interaction */
.relative {
  user-select: none; /* Prevent selection while dragging */
}

.select-none {
  pointer-events: none; /* Prevent interactions with the image itself */
}
</style>

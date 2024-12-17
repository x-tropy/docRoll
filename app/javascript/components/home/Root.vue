<script setup>
import Toolbar from "~/components/ui/Toolbar.vue";
import HowItWorks from "~/components/HowItWorks.vue"

const items = [
  {
    icon: "c-question",
    label: "How it works",
    dividerRight: true,
  },
  {
    icon: "n-edit",
    label: "Editor",
    dividerRight: true,
  },
  {
    icon: "circle-caret-right",
    label: "Player",
  }
]
</script>

<template>
  <div class="h-screen canvas-pattern">
    <Toolbar :items="items" currentItemIndex="0" />
    <HowItWorks />
  </div>
</template>

<style scoped>
.canvas-pattern {
  background-image: url("../../../assets/images/pattern.svg");
  background-repeat: repeat;
}
</style>

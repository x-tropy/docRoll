<script setup>
import SettingsWheel from "~/components/icons/settings-wheel.vue";
import Map from "@/components/icons/map.vue";
import BlankState from "@/components/ui/BlankState.vue";
</script>

<template>
  <BlankState title="Under Maintenance" body="This feature is currently under active development and not yet available. We’re excited to announce that it’s scheduled for launch on <b>February 17</b>. Stay tuned!" >
    <template #icon>
      <SettingsWheel strokewidth="2" width="28" height="28" class="drop-shadow-lg text-white spin "/>
    </template>
    <template #action>
      <a href="https://noteos.org/buwei/roadmap-of-docroll" target="_blank" class="btn-primary btn btn-md mt-2"><Map  /> Project Roadmap</a>
    </template>
  </BlankState>
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

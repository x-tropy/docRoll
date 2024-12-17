<script setup>
import Toolbar from "~/components/ui/Toolbar.vue";
import HowItWorks from "~/components/home/HowItWorks.vue"
import LogoGithub from "~/components/icons/logo-github.vue";
import {ref} from "vue";
import Player from "~/components/home/Player.vue";
import Editor from "~/components/home/Editor.vue";

const items = [
  {
    icon: "c-question",
    label: "How it works",
    dividerRight: true,
    action: "how-it-works"
  },
  {
    icon: "n-edit",
    label: "Editor",
    dividerRight: true,
    action: "editor"
  },
  {
    icon: "circle-caret-right",
    label: "Player",
    action: "player"
  }
]

const activeTabName = ref("how-it-works")

const executeTool = (action) => {
  activeTabName.value = action
}
</script>

<template>
  <div class="h-screen canvas-pattern" @zoom-in="console.log('in')">
    <Toolbar class="fixed top-5 left-5" :items="items" :currentItem="true" currentItemIndex="0" @tool-event="executeTool" />
    <a href="https://github.com/x-tropy/docRoll" target="_blank">
      <LogoGithub class="fixed top-5 right-5 z-20" width="28" height="28" />
    </a>
    <HowItWorks v-if="activeTabName == 'how-it-works'" />
    <Player v-if="activeTabName == 'player'" />
    <Editor v-if="activeTabName == 'editor'" />
  </div>
</template>

<style scoped>
.canvas-pattern {
  background-image: url("../../../assets/images/pattern.png");
  background-repeat: repeat;
}
</style>

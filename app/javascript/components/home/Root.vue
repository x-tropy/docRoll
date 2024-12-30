<script setup>
import Toolbar from "../ui/Toolbar.vue";
import HowItWorks from "../home/HowItWorks.vue"
import LogoGithub from "../icons/logo-github.vue";
import {ref} from "vue";
import Player from "../player/Root.vue";
import Editor from "../editor/Root.vue";
import CQuestion from "../icons/c-question.vue";
import NEdit from "../icons/n-edit.vue";
import CircleCaretRight from "../icons/circle-caret-right.vue";

const items = [
  {
    icon: CQuestion,
    label: "How it works",
    dividerRight: true,
    action: "how-it-works"
  },
  {
    icon: NEdit,
    label: "Editor",
    dividerRight: true,
    action: "editor"
  },
  {
    icon: CircleCaretRight,
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
    <a href="https://github.com/x-tropy/docRoll" class="fixed top-5 right-5 z-20 bg-white p-0.5 rounded-full" target="_blank">
      <LogoGithub  width="28" height="28" />
    </a>
    <HowItWorks v-if="activeTabName == 'how-it-works'" />
    <Player v-if="activeTabName == 'player'" />
    <Editor v-if="activeTabName == 'editor'" />
  </div>
</template>

<style scoped>
.canvas-pattern {
  background-image: url("../../../assets/images/pattern.svg");
  background-repeat: repeat;
}
</style>

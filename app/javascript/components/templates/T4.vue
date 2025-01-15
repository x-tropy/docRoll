<script setup>
import Logo from "../../../assets/images/docroll-logo.png"
import ToggleFullscreen from "./ToggleFullscreen.vue";
import {onMounted, onUnmounted, ref} from "vue"
import toggleFullscreen from "../../utils/toggle-fullscreen.js";
import {createMarkedInstance} from "@/utils/md-parser.js";
import 'highlight.js/styles/github.css'
import prependCodeLanguageLabel from "../../utils/prepend-code-language-label.js"

defineProps({
  indicator: {
    type: String,
    required: true,
    default: "1. Introduction"
  },
  body: {
    type: String,
    default: "# Title\n ## Secon\n [asd](https://asdf.com) \nYes or `no` \n```ruby\nclass CreateCourses < ActiveRecord::Migration[8.0]\n" +
      "  def change\n" +
      "    create_table :courses do |t|\n" +
      "      t.string :title\n" +
      "      t.date :production_date\n" +
      "      t.string :author\n" +
      "      t.string :link\n" +
      "      t.text :raw\n" +
      "      t.string :video\n" +
      "      t.text :toc\n" +
      "\n" +
      "      t.timestamps\n" +
      "    end\n" +
      "  end\n" +
      "end\n```"
  },
  pageNumber: {
    type: Number || String,
    required: true,
    default: 13
  },
  subtitle: {
    type: String
  }
})

const frame = ref(null)
const marked = createMarkedInstance()


onMounted(() => {
  prependCodeLanguageLabel()
})


</script>

<template>
  <div class="frame" ref="frame">
    <ToggleFullscreen @toggle-fullscreen="toggleFullscreen(frame)"/>
    <div class="header">
      <span class="indicator">{{ indicator }}</span>
      <img class="logo" :src="Logo"/>
    </div>
    <div class="content">
      <div class="article" v-html="marked.parse(body)"></div>
    </div>
    <span class="absolute text-sm font-semibold bottom-3 right-3 rounded-br-xl rounded-tl-xl bg-white px-2 py-0.5">
      {{ pageNumber }}
    </span>
    <div v-if="subtitle !== ''" class="subtitle-container">
      <p class="subtitle">{{ subtitle }}</p>
    </div>
  </div>
</template>

<style scoped></style>

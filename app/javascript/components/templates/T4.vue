<script setup>
import Logo from "../../../assets/images/docroll-logo.png"
import ToggleFullscreen from "./ToggleFullscreen.vue";
import {onMounted, onUnmounted, ref} from "vue"
import toggleFullscreen from "../../utils/toggle-fullscreen.js";
import {Marked} from "marked";
import {markedHighlight} from "marked-highlight";
import hljs from 'highlight.js';
import 'highlight.js/styles/github.css'

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
  }
})

const frame = ref(null)

const marked = new Marked(
  markedHighlight({
    emptyLangClass: 'hljs',
    langPrefix: 'hljs language-',
    highlight(code, lang, info) {
      const language = hljs.getLanguage(lang) ? lang : 'plaintext';
      return hljs.highlight(code, {language}).value;
    }
  })
);


onMounted(() => {
  const codeElements = Array.from(document.querySelectorAll("pre code"))
  codeElements.forEach(el => {
    // avoid duplicate rendering
    if (el.previousElementSibling?.classList.contains('code-language-label')) return

    const language = el.className.match(/language-(\w+)/)[1];
    if (language) {
      const label = document.createElement('span');
      label.textContent = language;
      label.classList.add('code-language-label');
      el.parentNode.insertBefore(label, el);
    }
  })
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
      <span class="absolute text-sm font-semibold bottom-0 right-0 rounded-br-xl rounded-tl-xl bg-white px-2 py-0.5">{{
          pageNumber
        }}</span>
    </div>
  </div>
</template>

<style scoped></style>

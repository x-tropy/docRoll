import {defineConfig} from 'vite'
import ViteRails from 'vite-plugin-rails'
import Vue from "@vitejs/plugin-vue"

export default defineConfig({
    plugins: [
        Vue(),
        ViteRails(),
    ],
})

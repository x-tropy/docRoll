<script setup>
import {ref} from "vue"
import submitForm from "../../utils/submit-form.js";

const slots = ref("")
const description = ref("")

async function submit() {
  const resp = await submitForm("/templates/create", {
    "template[slots]": slots.value,
    "template[description]": description.value
  })

  console.log(resp)
}
</script>

<template>
  <div class="w-1/3 mx-auto">
    <h1 class="simple-title">Create New Templates</h1>
    <form class=" gap-3 flex flex-col" @submit.prevent="submit">
      <textarea class="input" rows="5" v-model="slots" placeholder="slots"/>
      <textarea class="input" rows="5" v-model="description" placeholder="description"/>
      <button class="btn-primary btn btn-md">Submit</button>
    </form>
  </div>
</template>

<style scoped>

</style>

<script setup>
import {ref} from "vue"
import submitForm from "../../utils/submit-form.js";

const props = defineProps({
  template: {
    type: Object,
    required: false
  },
  method: {
    type: String,
    required: true
  },
  index: {
    type: Number
  }
})
let template
let title = "Create New Templates"
let url = "/templates"

if (props.method === 'PATCH') {
  title = `Update Template #${props.template.id}`
  url = `/templates/${props.template.id}`
}

const message = ref("")
const success = ref(false)
const slots = ref(props.template?.slots || "")
const description = ref(props.template?.description || "")
const name = ref(props.template?.name || "")
const emit = defineEmits()

async function submit() {
  const response = await submitForm(url, props.method, {
    "template[slots]": slots.value,
    "template[description]": description.value,
    "template[name]": name.value
  })
  const data = await response.json()
  if (response.ok) {
    if (Object.keys(data).includes("message")) {
      success.value = true
      message.value = data.message
    }
    emit('closeForm', {
      index: props.index,
      id: props.template.id,
      name: name.value,
      slots: slots.value,
      description: description.value
    })
  } else {
    console.log(data)
    message.value = data.error || "An error occurred!"
  }
}


</script>

<template>
  <h1 class="simple-title">
    {{ title }}
  </h1>
  <form class=" gap-3 flex flex-col" @submit.prevent="submit">
    <p v-if="message" :class="{'text-green-500': success}">{{ message }}</p>
    <input type="text" class="input" v-model="name" placeholder="name"/>
    <textarea class="input" rows="5" v-model="slots" placeholder="slots"/>
    <textarea class="input" rows="5" v-model="description" placeholder="description"/>
    <div class="grid grid-cols-2 gap-2">
      <button class="btn-primary btn btn-md" type="submit">Submit</button>
      <button class="btn-outline btn btn-md" @click.prevent="emit('closeForm')">Cancel</button>
    </div>
  </form>
</template>

<style scoped>

</style>

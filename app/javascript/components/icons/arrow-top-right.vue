<template>
  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><title>{{title}}</title>
    <g :fill="color">
      <path
        d="M14,1H7A1,1,0,0,0,7,3h4.586L1.293,13.293a1,1,0,1,0,1.414,1.414L13,4.414V9a1,1,0,0,0,2,0V2A1,1,0,0,0,14,1Z"
        :fill="color"></path>
    </g>
  </svg>
</template>

<script>
export default {
  props: {
    title: {
      type: String,
      default: "arrow top right"
    },
    color: {
      type: String,
      default: "#000"
    }
  }
}
</script>

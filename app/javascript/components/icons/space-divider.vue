<template>
  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" :width="width" :height="height">
    <g :fill="fill">
      <path
        d="M14,5H2c-1.105,0-2-.895-2-2V1C0,.447,.448,0,1,0s1,.447,1,1V3H14V1c0-.553,.448-1,1-1s1,.447,1,1V3c0,1.105-.895,2-2,2Z"
        :fill="fill"></path>
      <path
        d="M15,16c-.552,0-1-.447-1-1v-2H2v2c0,.553-.448,1-1,1s-1-.447-1-1v-2c0-1.105,.895-2,2-2H14c1.105,0,2,.895,2,2v2c0,.553-.448,1-1,1Z"
        :fill="fill"></path>
      <path d="M1,9c-.551,0-1-.449-1-1s.449-1,1-1,1,.449,1,1-.449,1-1,1Z" :fill="_secondaryfill"></path>
      <path d="M15,9c-.551,0-1-.449-1-1s.449-1,1-1,1,.449,1,1-.449,1-1,1Z" :fill="_secondaryfill"></path>
      <path d="M8,9c-.551,0-1-.449-1-1s.449-1,1-1,1,.449,1,1-.449,1-1,1Z" :fill="_secondaryfill"></path>
    </g>
  </svg>
</template>

<script>
export default {
  props: {
    width: {
      type: [Number, String],
      default: "1em"
    },
    height: {
      type: [Number, String],
      default: "1em"
    },
    strokewidth: {
      type: [Number, String],
      default: 1
    },
    fill: {
      type: String,
      default: "currentColor"
    },
    secondaryfill: {
      type: String
    }
  },
  computed: {
    _secondaryfill: function () {
      return this.secondaryfill || this.fill
    }
  }
}
</script>

<template><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" :width="width" :height="height"><g :fill="fill"><path d="M15,0H1C0.4,0,0,0.4,0,1v11c0,0.6,0.4,1,1,1h6v1H3v2h10v-2H9v-1h6c0.6,0,1-0.4,1-1V1C16,0.4,15.6,0,15,0z M14,11H2V2h12V11z" :fill="fill"></path></g></svg></template>

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
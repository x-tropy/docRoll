<template><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" :width="width" :height="height"><g :fill="fill"><path d="M15,9H13V3H3V9H1V3A2.006,2.006,0,0,1,3,1H13a2.006,2.006,0,0,1,2,2Z" :fill="fill"></path><path d="M14,14H2a2.006,2.006,0,0,1-2-2V11H16v1A2.006,2.006,0,0,1,14,14Z" :fill="fill"></path><polygon points="7 5 10 7 7 9 7 5" :fill="_secondaryfill"></polygon></g></svg></template>

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
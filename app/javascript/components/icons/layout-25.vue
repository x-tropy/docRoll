<template><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" :width="width" :height="height"><g :fill="fill"><path d="M16,5H0V2c0-0.552,0.448-1,1-1h14c0.552,0,1,0.448,1,1V5z" :fill="_secondaryfill"></path> <path d="M5,15H1c-0.552,0-1-0.448-1-1V7h5V15z" :fill="fill"></path> <path d="M15,15H7V7h9v7C16,14.552,15.552,15,15,15z" :fill="fill"></path></g></svg></template>

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
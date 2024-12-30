<template><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" :width="width" :height="height"><g :fill="fill"><path d="M1,1v3c0,0.552,0.448,1,1,1h12c0.552,0,1-0.448,1-1V1c0-0.552-0.448-1-1-1H2C1.448,0,1,0.448,1,1z" :fill="fill"></path> <path d="M1,12v3c0,0.552,0.448,1,1,1h12c0.552,0,1-0.448,1-1v-3c0-0.552-0.448-1-1-1H2C1.448,11,1,11.448,1,12z" :fill="fill"></path> <path d="M15,9H1C0.448,9,0,8.552,0,8v0c0-0.552,0.448-1,1-1h14c0.552,0,1,0.448,1,1v0 C16,8.552,15.552,9,15,9z" :fill="_secondaryfill"></path></g></svg></template>

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
<template><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" :width="width" :height="height"><title>{{title}}</title><g :fill="fill"><path d="M7.5,3.5V3A1.5,1.5,0,0,0,6,1.5H6A1.5,1.5,0,0,0,4.5,3V9.5L2.179,8.587a1.209,1.209,0,0,0-1.3.268h0A1.209,1.209,0,0,0,.82,10.505l2.619,2.9a6.136,6.136,0,0,0,4.618,2.1H9.364A6.136,6.136,0,0,0,15.5,9.364V3.5a1,1,0,0,0-1-1h0a1,1,0,0,0-1,1v1" fill="none" stroke-linecap="round" stroke-linejoin="round" :stroke="fill"></path> <path d="M10.5,3.5V3A1.5,1.5,0,0,1,12,1.5h0A1.5,1.5,0,0,1,13.5,3V6.5" fill="none" stroke-linecap="round" stroke-linejoin="round" :stroke="fill"></path> <path d="M7.5,6.5V2A1.5,1.5,0,0,1,9,.5H9A1.5,1.5,0,0,1,10.5,2V6.5" fill="none" stroke-linecap="round" stroke-linejoin="round" :stroke="fill"></path></g></svg></template>

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
		title: {
			type: String,
			default: "tool hand"
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
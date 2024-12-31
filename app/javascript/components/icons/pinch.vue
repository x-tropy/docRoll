<template><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" :width="width" :height="height"><title>{{title}}</title><g :fill="fill"><path d="M15.70703,1.70703c0.39062-0.39062,0.39062-1.02344,0-1.41406s-1.02344-0.39062-1.41406,0 l-2.5,2.5L9,0v7h7l-2.79297-2.79297L15.70703,1.70703z" :fill="_secondaryfill"></path> <path d="M2.79297,11.79297l-2.5,2.5c-0.39062,0.39062-0.39062,1.02344,0,1.41406C0.48828,15.90234,0.74414,16,1,16 s0.51172-0.09766,0.70703-0.29297l2.5-2.5L7,16V9H0L2.79297,11.79297z" :fill="fill"></path></g></svg></template>

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
			default: "pinch"
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
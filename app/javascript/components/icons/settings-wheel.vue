<template><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" :width="width" :height="height"><title>{{title}}</title><g stroke-linecap="square" stroke-linejoin="miter" stroke-miterlimit="10" :fill="fill"><line x1="7.5" y1="4.205" x2="12" y2="12" fill="none" :stroke-width="strokewidth" :stroke="_secondaryfill"></line><line x1="7.5" y1="19.795" x2="12" y2="12" fill="none" :stroke-width="strokewidth" :stroke="_secondaryfill"></line><line x1="21" y1="12" x2="12" y2="12" fill="none" :stroke-width="strokewidth" :stroke="_secondaryfill"></line><circle cx="12" cy="12" r="9" fill="none" :stroke-width="strokewidth" :stroke="fill"></circle><line x1="12" y1="1" x2="12" y2="3" fill="none" :stroke-width="strokewidth" :stroke="fill"></line><line x1="6.5" y1="2.474" x2="7.5" y2="4.205" fill="none" :stroke-width="strokewidth" :stroke="fill"></line><line x1="2.474" y1="6.5" x2="4.206" y2="7.5" fill="none" :stroke-width="strokewidth" :stroke="fill"></line><line x1="1" y1="12" x2="3" y2="12" fill="none" :stroke-width="strokewidth" :stroke="fill"></line><line x1="2.474" y1="17.5" x2="4.206" y2="16.5" fill="none" :stroke-width="strokewidth" :stroke="fill"></line><line x1="6.5" y1="21.526" x2="7.5" y2="19.795" fill="none" :stroke-width="strokewidth" :stroke="fill"></line><line x1="12" y1="23" x2="12" y2="21" fill="none" :stroke-width="strokewidth" :stroke="fill"></line><line x1="17.5" y1="21.526" x2="16.5" y2="19.794" fill="none" :stroke-width="strokewidth" :stroke="fill"></line><line x1="21.526" y1="17.5" x2="19.794" y2="16.5" fill="none" :stroke-width="strokewidth" :stroke="fill"></line><line x1="23" y1="12" x2="21" y2="12" fill="none" :stroke-width="strokewidth" :stroke="fill"></line><line x1="21.526" y1="6.5" x2="19.794" y2="7.5" fill="none" :stroke-width="strokewidth" :stroke="fill"></line><line x1="17.5" y1="2.474" x2="16.5" y2="4.206" fill="none" :stroke-width="strokewidth" :stroke="fill"></line></g></svg></template>

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
			default: "settings wheel"
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
<template><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" :width="width" :height="height"><title>{{title}}</title><g :fill="fill"><path d="M8,0C3.6,0,0,3.6,0,8s3.6,8,8,8,8-3.6,8-8S12.4,0,8,0Zm0,13c-.552,0-1-.448-1-1s.448-1,1-1,1,.448,1,1-.448,1-1,1Zm1.623-4.908c-.497,.427-.623,.571-.623,.908,0,.553-.448,1-1,1s-1-.447-1-1c0-1.294,.795-1.976,1.322-2.427,.497-.425,.623-.57,.623-.906,0-.183,0-.667-.944-.667-.436,.024-.901,.224-1.258,.561-.401,.378-1.035,.359-1.414-.041-.379-.402-.361-1.035,.041-1.414,.702-.661,1.617-1.054,2.579-1.104h.003c1.812,0,2.993,1.071,2.993,2.666,0,1.293-.795,1.975-1.321,2.425Z" :fill="fill"></path></g></svg></template>

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
			default: "c question"
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
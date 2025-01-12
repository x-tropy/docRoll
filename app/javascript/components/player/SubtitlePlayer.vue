<script setup>
import { ref,  onMounted, onUnmounted } from 'vue'

const props = defineProps({
  subtitles: {
    type: Array,
    required: true
  },
  audioUrl: {
    type: String,
    required: true
  }
})

const audioRef = ref(null)
const subtitles = JSON.parse(props.subtitles)
const currentSubtitle = ref('')
const isPlaying = ref(false)
const lastCheckedTime = ref(0)

// Update subtitle based on current time
const updateSubtitle = () => {
  if (!audioRef.value) return

  const currentTime = audioRef.value.currentTime
  if (Math.abs(currentTime - lastCheckedTime.value) < 0.5) {
    return
  }

  lastCheckedTime.value = currentTime

  const subtitle = subtitles.find(sub =>
    currentTime >= sub.start_time && currentTime <= sub.end_time
  )

  currentSubtitle.value = subtitle ? subtitle.text : ''
}

// Play/pause toggle
const togglePlay = () => {
  if (audioRef.value.paused) {
    audioRef.value.play()
    isPlaying.value = true
  } else {
    audioRef.value.pause()
    isPlaying.value = false
  }
}

// Setup event listeners
onMounted(() => {
  if (audioRef.value) {
    audioRef.value.addEventListener('timeupdate', updateSubtitle)
  }
})

onUnmounted(() => {
  if (audioRef.value) {
    audioRef.value.removeEventListener('timeupdate', updateSubtitle)
  }
})
</script>

<template>
  <div class="subtitle-player">
    <div class="h-10 ">
      {{ currentSubtitle }}
    </div>
    <audio ref="audioRef" controls>
      <source :src="audioUrl" type="audio/mpeg">
      Your browser does not support the audio element.
    </audio>

    <button @click="togglePlay" class="btn btn-primary btn-md">
      {{ isPlaying ? 'Pause' : 'Play' }}
    </button>

  </div>
</template>

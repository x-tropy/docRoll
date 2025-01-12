<script setup>
import { ref, watch } from 'vue'

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

// Update subtitle based on current time
const updateSubtitle = () => {
  if (!audioRef.value) return

  const currentTime = audioRef.value.currentTime
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

// Listen to time updates
watch(audioRef, (newRef) => {
  if (newRef) {
    newRef.addEventListener('timeupdate', updateSubtitle)
  }
})
</script>

<template>
  <div class="subtitle-player">
    <audio ref="audioRef" controls>
      <source :src="audioUrl" type="audio/mpeg">
      Your browser does not support the audio element.
    </audio>

    <button @click="togglePlay" class="btn btn-primary btn-md">
      {{ isPlaying ? 'Pause' : 'Play' }}
    </button>

    <div class="h-10 pt-4">
      {{ currentSubtitle }}
    </div>
  </div>
</template>

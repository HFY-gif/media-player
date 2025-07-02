<template>
  <div>
    <main class="home-container">
      <img src="@/assets/bofang.png" alt="播放Banner" class="banner-img" />
      <div class="buttons">
        <input type="file" ref="videoInput" accept="video/*" @change="handleVideoSelect" hidden />
        <input type="file" ref="audioInput" accept="audio/*" @change="handleAudioSelect" hidden />
        <button @click="$refs.videoInput.click()">选择视频</button>
        <button @click="$refs.audioInput.click()">选择音频</button>
      </div>
    </main>
  </div>
</template>

<script>
export default {
  data() {
    return {
      username: '',
      userId: localStorage.getItem('user_id')
    }
  },
  mounted() {
    const user = JSON.parse(localStorage.getItem('currentUser'))
    this.username = user?.username || '游客'
  },
  methods: {
    handleVideoSelect() {
      const file = this.$refs.videoInput.files[0]
      if (file) {
        const url = URL.createObjectURL(file)
        const title = file.name
        this.$router.push({
          path: '/video-player',
          query: { src: url, title }
        })
      }
    },
    handleAudioSelect() {
      const file = this.$refs.audioInput.files[0]
      if (file) {
        const url = URL.createObjectURL(file)
        const title = file.name
        this.$router.push({
          path: '/audio-player',
          query: { src: url, title }
        })
      }
    }
  }
}
</script>



<style scoped>
  .navbar {
  width: 100vw;
  position: fixed;
  top: 0;
  left: 0;
  padding: 0 5vw;
  height: 60px;
  display: flex;
  align-items: center;
  background-color: #fff;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  z-index: 1000;
}

.nav-title {
  font-size: 24px;
  font-weight: bold;
  color: #333;
  margin-right: auto;
}

.nav-links {
  display: flex;
  gap: 30px;
}

.nav-links a {
  text-decoration: none;
  color: #333;
  font-size: 16px;
  transition: color 0.3s;
}

.nav-links a:hover {
  color: #409eff;
}

.router-link-exact-active {
  font-weight: nromal;
  font-size: 18px;
  text-decoration: underline;
}

.home-container {
  margin-top: 80px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: calc(100vh - 80px);
  padding: 20px;
  box-sizing: border-box;
  text-align: center;
}

.banner-img {
  max-width: 90vw;
  width: 650px;
  border-radius: 8px;
  margin-bottom: 30px;
  object-fit: contain;
}

.buttons {
  display: flex;
  gap: 40px;
  flex-wrap: wrap;
  justify-content: center;
}

.buttons button {
  padding: 12px 28px;
  font-size: 16px;
  border-radius: 8px;
  border: none;
  background-color: #409eff;
  color: white;
  cursor: pointer;
  transition: background-color 0.3s;
  min-width: 140px;
}

.buttons button:hover {
  background-color: #66b1ff;
}
</style>

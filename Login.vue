<template>
  <div class="min-h-screen flex items-center justify-center bg-cover bg-center bg-gray-900 px-4 bg-register">
    <form 
      class="w-full max-w-[440px] bg-black/70 rounded-xl shadow-2xl p-6 space-y-8" 
      @submit.prevent="handleLogin"
    >
      <div class="w-full max-w-[375px] space-y-8 mx-auto">
        <div class="text-center space-y-4">
          <h1 class="font-['Pacifico'] text-4xl text-white">Body+</h1>
          <p class="text-gray-400 text-lg">欢迎使用</p>
        </div>

        <div class="flex space-x-4 border-b border-gray-600 pb-4">
          <router-link
            to="/login"
            class="flex-1 text-center py-3"
            :class="$route.path === '/login' ? 'text-white border-b-2 border-white' : 'text-gray-400'">
            登录
          </router-link>
          <router-link
            to="/register"
            class="flex-1 text-center py-3"
            :class="$route.path === '/register' ? 'text-white border-b-2 border-white' : 'text-gray-400'">
            注册
          </router-link>
        </div>

        <div class="space-y-4">
          <div class="relative">
            <div class="absolute inset-y-0 left-0 input-icon text-gray-300">
              <i class="fas fa-user text-lg"></i>
            </div>
            <input
              v-model="n_username"
              type="text"
              placeholder="请输入用户名"
              class="w-full pl-12 pr-4 py-3 border-none bg-gray-700 text-white rounded-lg focus:ring-2 focus:ring-gray-500 focus:outline-none text-sm placeholder-gray-400" />
          </div>

          <div class="relative">
            <div class="absolute inset-y-0 left-0 input-icon text-gray-300">
              <i class="fas fa-lock text-lg"></i>
            </div>
            <input
              :type="n_showPassword ? 'text' : 'password'"
              v-model="n_password"
              placeholder="请输入密码"
              class="w-full pl-12 pr-12 py-3 border-none bg-gray-700 text-white rounded-lg focus:ring-2 focus:ring-gray-500 focus:outline-none text-sm placeholder-gray-400" />
            <button @click="togglePassword" type="button" class="absolute inset-y-0 right-0 input-icon text-gray-300">
              <i :class="n_showPassword ? 'fas fa-eye-slash' : 'fas fa-eye'" class="text-lg"></i>
            </button>
          </div>

          <button
            type="submit"
            class="w-full py-3 bg-gray-600 text-white font-medium !rounded-button hover:bg-gray-500 transition-all"
          >
            登录
          </button>
        </div>

        <div class="flex justify-between text-sm">
          <router-link to="/register" class="text-gray-300 ml-auto">立即注册</router-link>
        </div>
      </div>
    </form>
  </div>
</template>


<script setup>
import { ref } from 'vue'
import { useCourseStore } from '@/stores/courseStore'
import { useRouter } from 'vue-router'
import axios from 'axios'

const n_router = useRouter()
const n_username = ref('')
const n_password = ref('')
const n_showPassword = ref(false)

const togglePassword = () => {
  n_showPassword.value = !n_showPassword.value
}

const handleLogin = async () => {
  try {
    const response = await axios.post(
      'http://localhost:5000/api/login',
      {
        username: n_username.value,
        password: n_password.value
      },
      {
        withCredentials: true,
        headers: {
          'Content-Type': 'application/json'
        }
      }
    )

    if (response.data && response.data.success) {
      alert('登录成功')

      const userData = response.data.data

      // 保存用户信息到 localStorage
      localStorage.setItem('userData', JSON.stringify({
        id: userData.user_id,
        username: userData.username,
        name: userData.name || ' ',
        gender: userData.gender || ' ',
        region: userData.region || ' ',
        weight: userData.weight|| ' ',
        height: userData.height|| ' ',
        targetWeight: userData.target_weight|| ' ',
        weightHistory: userData.weight_history || []
      }))

      // ✅ 加载课程收藏数据
      const courseStore = useCourseStore()
      await courseStore.fetchFavoritesFromBackend(userData.user_id)
      
      // 跳转
      n_router.push('/home')
    } else {
      alert('用户名或密码错误')
    }
  } catch (error) {
    console.error('登录失败:', error)
    alert('登录请求失败，请稍后再试')
  }
}
</script>


<style scoped>
.input-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
}

input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}
input

</style>

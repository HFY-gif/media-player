<template>
  <div class="min-h-screen flex items-center justify-center bg-blue-100 px-4 bg-register">
    <form 
      class="w-full max-w-[440px] bg-white rounded-xl shadow-xl p-6 space-y-8" 
      @submit.prevent="handleLogin"
    >
      <div class="w-full max-w-[375px] space-y-8 mx-auto">
        <div class="text-center space-y-4">
          <h1 class="font-['Pacifico'] text-4xl text-blue-700">媒体播放器</h1>
          <p class="text-gray-600 text-lg">欢迎使用</p>
        </div>

        <div class="flex space-x-4 border-b border-gray-300 pb-4">
          <router-link
            to="/"
            class="flex-1 text-center py-3"
            :class="$route.path === '/' ? 'text-blue-600 border-b-2 border-blue-600 font-medium' : 'text-gray-400'">
            登录
          </router-link>
          <router-link
            to="/register"
            class="flex-1 text-center py-3"
            :class="$route.path === '/register' ? 'text-blue-600 border-b-2 border-blue-600 font-medium' : 'text-gray-400'">
            注册
          </router-link>
        </div>

        <div class="space-y-4">
          <div class="relative">
            <div class="absolute inset-y-0 left-0 input-icon text-gray-400">
              <i class="fas fa-user text-lg"></i>
            </div>
            <input
              v-model="n_username"
              type="text"
              placeholder="请输入用户名"
              class="w-full pl-8 pr-4 py-3 border border-gray-300 bg-white text-gray-800 rounded-lg focus:ring-2 focus:ring-blue-400 focus:outline-none text-sm placeholder-gray-400" />
          </div>

          <div class="relative">
            <div class="absolute inset-y-0 left-0 input-icon text-gray-400">
              <i class="fas fa-lock text-lg"></i>
            </div>
            <input
              :type="n_showPassword ? 'text' : 'password'"
              v-model="n_password"
              placeholder="请输入密码"
              class="w-full pl-8 pr-12 py-3 border border-gray-300 bg-white text-gray-800 rounded-lg focus:ring-2 focus:ring-blue-400 focus:outline-none text-sm placeholder-gray-400" />
            <button @click="togglePassword" type="button" class="absolute inset-y-0 right-0 input-icon text-gray-400">
              <i :class="n_showPassword ? 'fas fa-eye-slash' : 'fas fa-eye'" class="text-lg"></i>
            </button>
          </div>

          <button
            type="submit"
            class="w-full py-3 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-500  transition-all"
          >
            登录
          </button>
        </div>
      </div>
    </form>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const n_router = useRouter()
const n_username = ref('')
const n_password = ref('')
const n_showPassword = ref(false)

const togglePassword = () => {
  n_showPassword.value = !n_showPassword.value
}

// 从localStorage读取用户
function getUsers() {
  return JSON.parse(localStorage.getItem('users') || '[]')
}

const handleLogin = () => {
  if (!n_username.value || !n_password.value) {
    alert('请输入用户名和密码')
    
    return
  }

  const users = getUsers()
  const user = users.find(u => u.username === n_username.value)

  if (!user) {
    alert('用户不存在')
    return
  }

  if (user.password !== n_password.value) {
    alert('密码错误')
    return
  }


  localStorage.setItem('currentUser', JSON.stringify({ username: n_username.value }))


  alert('登录成功！')
  n_router.push('/home')
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

/* 背景可选，不设 login.jpg 时使用纯色 */
.bg-register {
  background-image: none;
}
</style>

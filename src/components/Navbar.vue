<template>
  <nav class="navbar">
    <div class="container">
      <div class="nav-group">
        <ul class="nav-group-left" v-if="$route.path.startsWith('/project/')">
          <li class="nav-item">
            <router-link class="nav-link" to="/">
              <i class="fas fa-arrow-left fa-lg"></i>
              {{ lang === 'en' ? 'Back' : 'Назад' }}
            </router-link>
          </li>
        </ul>
        <ul class="nav-group-right" v-else>
          <li class="nav-item">
            <a class="nav-link" href="#home">
              {{ lang === 'en' ? 'Home' : 'Начало' }}
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#about">
              {{ lang === 'en' ? 'About' : 'Обо мне' }}
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#projects">
              {{ lang === 'en' ? 'Projects' : 'Проекты' }}
            </a>
          </li>
        </ul>
        <ul>
          <li class="nav-item">
            <a class="nav-link" @click="toggleLang" role="button">
              <img :src="flag" :alt="lang" />
            </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<script>
const flagEn = '/img/flag-us.png';
const flagRu = '/img/flag-ru.png';

export default {
  name: 'Navbar',
  computed: {
    lang() {
      return this.$store.state.lang;
    },
    flag() {
      return this.lang === 'en' ? flagEn : flagRu;
    }
  },
  methods: {
    toggleLang(e) {
      e.preventDefault();
      this.$store.commit('toggleLang');
    }
  }
};
</script>

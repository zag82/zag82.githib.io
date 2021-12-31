<template>
  <div class="container mt-6" id="project" v-if="pro">
    <h1>{{ pro.name }}</h1>
    <div class="pro-image">
      <a :href="pro.img" target="_blank" rel="noopener noreferrer">
        <img :src="pro.img" :alt="pro.name" />
      </a>
      <p>{{ pro.description }}</p>
    </div>
    <div v-if="pro.overview">
      <h3>{{ lang === 'en' ? 'Overview' : 'Описание' }}</h3>
      <p>{{ pro.overview }}</p>
    </div>
    <div v-if="pro.features">
      <h3>{{ lang === 'en' ? 'Features' : 'Характеристики' }}"</h3>
      <ul>
        <li v-for="(feature, index) in pro.features" :key="index">
          {{ feature }}
        </li>
      </ul>
    </div>
    <div v-if="pro.src">
      <h3>{{ lang === 'en' ? 'Sources' : 'Исходный код' }}</h3>
      <p>
        <a :href="pro.src" target="_blank" rel="noopener noreferrer">
          <i class="far fa-file-code fa-lg"></i>
          {{ lang === 'en' ? 'View sources' : 'Просмотреть исходный код' }}
        </a>
      </p>
    </div>
    <div v-if="pro.extra">
      <h3>{{ pro.extra.title }}</h3>
      <p>
        <a :href="pro.extra.link" target="_blank" rel="noopener noreferrer">
          <i class="fas fa-info-circle fa-lg"></i>
          {{ pro.extra.name }}
        </a>
      </p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Project',
  data() {
    return {};
  },
  activated() {
    if (this.pro) window.scrollTo(0, 0);
    else this.$router.replace({ name: 'Home' });
  },
  computed: {
    lang() {
      return this.$store.state.lang;
    },
    pro() {
      const pname = this.$route.params.id;
      const prFound = this.$store.getters.projects.filter(
        (p) => p.name.toLowerCase() === pname
      );
      if (prFound && prFound.length > 0 && prFound[0]) return prFound[0];
      return null;
    }
  }
};
</script>

<template>
  <div>
    <section id="home">
      <h1>{{ lang === 'en' ? 'Andrey' : 'Андрей' }} = new Developer();</h1>
    </section>
    <section id="about">
      <div class="container">
        <div class="about-card">
          <div class="about-img">
            <img src="/img/me.jpg" alt="profile" />
            <div>
              {{ lang === 'en' ? 'Andrey' : 'Андрей' }}
              <br />
              {{ lang === 'en' ? 'Zhdanov' : 'Жданов' }}
            </div>
          </div>
          <div class="about-context" v-if="lang === 'en'">
            <h3>About me</h3>
            <p>I am application developer for web and desktop.</p>
            <p>
              I prefer healthy life full of sport activities without smoking and
              alcohol.
            </p>
            <p>My preference in life is to be honest with people and myself.</p>
            <p class="about-badges">
              <span>#coding</span> <span>#running</span> <span>#cycling</span>
              <span>#work-with-wood</span> <span>#electronics</span>
              <span>#gardening</span>
            </p>
          </div>

          <div class="about-context" v-else>
            <h3>Обо мне</h3>
            <p>Я разработчик настольных и интернет приложений.</p>
            <p>
              Веду здоровый образ жизни, занимаюсь спортом, не приемлю курение и
              алкоголь.
            </p>
            <p>Ценю в людях честность по отношению к окружающим и себе.</p>
            <p class="about-badges">
              <span>#программирование</span> <span>#бег</span>
              <span>#велосипед</span> <span>#столярка</span>
              <span>#электроника</span> <span>#садоводство</span>
            </p>
          </div>
        </div>
      </div>
    </section>
    <section id="projects" class="container">
      <h3>{{ lang === 'en' ? 'My projects' : 'Мои проекты' }}</h3>
      <div class="row">
        <div
          v-for="(pro, index) in projects"
          :key="index"
          :class="['pro-item', index === 0 ? 'pro-item-first' : null]"
        >
          <router-link
            :to="{ name: 'Project', params: { id: pro.name.toLowerCase() } }"
          >
            <img :src="pro.img" :alt="pro.name" />
          </router-link>
          <router-link
            :to="{ name: 'Project', params: { id: pro.name.toLowerCase() } }"
          >
            {{ pro.name }} - {{ pro.description }}
          </router-link>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
export default {
  name: 'Home',
  activated() {
    window.scrollTo(0, 0);
  },
  computed: {
    lang() {
      return this.$store.state.lang;
    },
    projects() {
      return this.$store.getters.projects;
    }
  }
};
</script>

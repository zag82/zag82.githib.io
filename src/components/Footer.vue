<template>
  <footer>
    <div class="container">
      <div class="footer-row">
        <div class="footer-block">
          <h5>{{ lang === 'en' ? 'Contacts' : 'Контакты' }}</h5>
          <ul>
            <li>
              <a
                :href="
                  lang === 'en'
                    ? 'https://t.me/zag82'
                    : 'tg://resolve?domain=zag82'
                "
                target="_blank"
                rel="noopener noreferrer"
              >
                <i class="fab fa-telegram fa-lg" /> Telegram
              </a>
            </li>
            <li>
              <a
                href="https://vk.com/id303928"
                target="_blank"
                rel="noopener noreferrer"
              >
                <i class="fab fa-vk fa-lg" /> VK
              </a>
            </li>
          </ul>
        </div>
        <div class="footer-block">
          <h5>{{ lang === 'en' ? 'Work' : 'Работа' }}</h5>
          <ul>
            <li>
              <a
                href="https://github.com/zag82"
                target="_blank"
                rel="noopener noreferrer"
              >
                <i class="fab fa-github fa-lg" /> GitHub
              </a>
            </li>
            <li>
              <a
                :href="lang === 'en' ? '/RESUME_en.pdf' : '/RESUME_ru.pdf'"
                target="_blank"
                rel="noopener noreferrer"
              >
                <i class="far fa-file fa-lg"></i>
                {{ lang === 'en' ? 'Resume' : 'Резюме' }}
              </a>
            </li>
          </ul>
        </div>
      </div>
      <p>
        &copy; {{ new Date().getFullYear() }}
        {{ lang === 'en' ? 'Andrey Zhdanov' : 'Андрей Жданов' }}
      </p>
    </div>
  </footer>
</template>

<script>
export default {
  name: 'Footer',
  computed: {
    lang() {
      return this.$store.state.lang;
    }
  }
};
</script>

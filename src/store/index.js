import { createStore } from 'vuex';
import { projectsEn, projectsRu } from '../data/projectsData';

const initialLang = () => {
  let language = localStorage.getItem('lang');
  if (language === null || (language !== 'en' && language !== 'ru')) {
    language = 'en';
    localStorage.setItem('lang', language);
  }
  return language;
};

export default createStore({
  state: {
    lang: initialLang()
  },
  mutations: {
    toggleLang(state) {
      const language = state.lang === 'en' ? 'ru' : 'en';
      state.lang = language;
      localStorage.setItem('lang', language);
    }
  },
  getters: {
    projects: (state) => {
      return state.lang === 'en' ? projectsEn : projectsRu;
    }
  },
  actions: {},
  modules: {}
});

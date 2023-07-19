/**
 * @typedef {Object} ProjectType
 * @property {string} name
 * @property {string} description
 * @property {string} [overview]
 * @property {string[]} [features]
 * @property {string} [src]
 * @property {string} img
 * @property {Object} [extra]
 * @property {string} extra.title - The title
 * @property {string[]} extra.name - Name
 * @property {string[]} extra.link - link to site or repository online
 */

/**
 * @type {ProjectType[]}
 */
export const projectsEn = [
  {
    name: 'WebSmeta',
    description: 'Huge enterprise web app for local estimate',
    overview: `
      Distributed web-application for local estimates creation having lots of 
      features and possibilities for user
    `,
    features: [
      'Work with estimates databases',
      'Coefficients, indices and total additions',
      'Formula calculations for any field',
      'Multiple users can edit document simutaneously',
      'Acts creation, compensation, M-29 form',
      'Copy & paste and many more...'
    ],
    extra: {
      title: 'Links',
      name: ['Site', 'Company'],
      link: ['https://gss-online.ru', 'https://gosstroysmeta.ru']
    },
    img: '/img/projects/websmeta.png'
  },
  {
    name: 'GSmeta',
    description: 'Sample web application to show estimate calculations',
    overview: `
      This application was made as a sample to show React possibilities to 
      make fully functional estimates application on web.
    `,
    features: [
      'Change cost quantity',
      'Copy and paste any selected item',
      'View extended properties on eny selected item',
      'Collapse and expand cost additional information'
    ],
    src: 'https://github.com/zag82/zag82.github.io/tree/main/projects/gsmeta',
    img: '/img/projects/gsmeta.png'
  },
  {
    name: 'QNotes',
    description: 'Web application for notes and tips storing',
    overview: `
      This application was made during React studying. But later I started to use
      it in my life, so it is constantly developed and improved for better user 
      experience and quality. It is built using React. Additional libraries are 
      Bootstrap, React-Router and FontAwesome. Firebase is used as a backend.
    `,
    features: [
      'Note storing with category value',
      'Filter notes by categories',
      'categories list paramenter can be changed manually using Firebase admin panel',
      'Application is mobile friendly and can be saved at mobile phone starting page',
      'Notes are constantly sync with Firebase server database'
    ],
    img: '/img/projects/qnotes.png'
  },
  {
    name: 'Gosstroysmeta',
    description: 'Desktop office application for construction estimates',
    overview: `
      This application was written at my full time job in team of developers. 
      Program calculates estimates, apply indexes and coefficients. It is written on Delphi.
    `,
    features: [
      'Calculation engine with formulas and links between parts of document. Aggregate functions, that can be used in formulas',
      'Script engine to expand program functionality',
      'Work with cost databases',
      'Apply indexes and coefficients',
      'And more, that cost engineers need...'
    ],
    extra: {
      title: 'Links',
      name: ['Company site'],
      link: ['https://gosstroysmeta.ru']
    },
    img: '/img/projects/gss.png'
  },
  {
    name: 'Promo',
    description: 'Web projects for promo-software.com',
    overview: `
      Several sites for BTL advertisement to present data from merchandizers. 
      All sites are made on php using self-made original framework, frontend is build using ExtJS 4.2. 
    `,
    features: [
      'Address book',
      'Each addres details to show visits',
      'Visits to all points',
      'Visit details with all collected data, photo and  audio',
      'Report in table view and charts for various cases',
      'All reports and pages can be filtered. Some filters allow multiselect and inplace search features',
      'Summarized tables',
      'All reports and pages Excel export according to filters applied',
      'Ability to add custom reports for particular project'
    ],
    img: '/img/projects/promo.png'
  },

  {
    name: 'Ariel',
    description:
      'Program for acquiring and processing eddy current signals from PL500 device',
    overview: `
      Program allows you to connect to Rohman PL500 eddy current testing device 
      and store eddy current testing data to files. Scecond application allows
      to view and analyse signals acquired. Program is written on Delphi and 
      has high data processing and signal manipulations speed.
    `,
    features: [
      'Works with Rohman PL500 eddy current device',
      'Set paramenters for 16 eddy current channels: drive, frequency, filtering, compensation etc.',
      'Automatic record start when probes enters inspected object. Automatic file saving when probes leaves inspected object. All of this is for no operatpr inspections',
      'Signal analysis and defects recognition',
      'Automatic defect parameters estimation',
      'Manual signal analysis',
      'Scripting module for data processing automation'
    ],
    src: 'https://github.com/zag82/zag82.github.io/tree/main/projects/ariel',
    img: '/img/projects/ariel.png'
  },
  {
    name: 'MagNum3D',
    description: 'Finite elements method modelling program',
    overview: `
      This finite elements method modelling program allows calculate electromagnetic
      fields distributions. It was created by me during studying in institute when I
      was a student. It allows to solve plane, axisymmetrical and 3d electromagnetic 
      tasks. Finnite elements mesh is semi-regular, because it can be expanded and 
      squeezed at several areas. Program was written in Delphi and it is very fast in solving tasks.
    `,
    features: [
      'Tasks: electrostatic, steady state and eddy currents',
      'Mesh models for planes and in volume',
      'One model for 2D and 3D tasks calculations',
      'Post processing: vector field, force lines, surface of values, equipotential lines',
      'Plots for field values distribution along specified direction',
      'Calculations of potentials, flux dencity, intencity',
      'Calculations on magnetic curve for ferromagnetic materials'
    ],
    src: 'https://github.com/zag82/zag82.github.io/tree/main/projects/magnum3d',
    img: '/img/projects/magnum3d.png'
  }
];

/**
 * @type {ProjectType[]}
 */
export const projectsRu = [
  {
    name: 'WebSmeta',
    description: 'Полноценная локальная смета в вебе',
    overview: `
      Распределенное сетевое веб-приложение для составления локальных смет 
      со множеством возможностей 
    `,
    features: [
      'Работа с СНБ',
      'Коэффициенты, индексы, начисления',
      'Все поля задаются формулами',
      'Возможено многопользовательская работа с документом',
      'Создание актов, компенсаций, М-29',
      'Копирование и вставка',
      'И многое другое'
    ],
    extra: {
      title: 'Ссылки',
      name: ['Сайт', 'Компания'],
      link: ['https://gss-online.ru', 'https://gosstroysmeta.ru']
    },
    img: '/img/projects/websmeta.png'
  },
  {
    name: 'GSmeta',
    description: 'Пример расчета сметы в web',
    overview: `
      Это приложение было создано как пример, чтобы оценить возможности React
      для построения полнофункционального сметного приложения в web.
    `,
    features: [
      'Изменение количества по раценке',
      'Копирование и вставка выбранного элемента',
      'Просмотр дополнительной информации по выбранному элементу',
      'Сворачивание и разворачивание расценок для просмотра дополнительной детализациии'
    ],
    src: 'https://github.com/zag82/zag82.github.io/tree/main/projects/gsmeta',
    img: '/img/projects/gsmeta.png'
  },
  {
    name: 'QNotes',
    description: 'Веб приложение для хранения заметок',
    overview: `
      Это приложение я писал для изучения React, но в последствии стал пользоваться 
      им постоянно. Поскольку пользуюсь часто для сохранения своих заметок, то 
      приложение постоянно развивается и адаптируется для большего удобства и качества. 
      Сделано на React с использованием Bootstrap, React-Router и FontAwesome. 
      В качестве бекэнда используется Firebase.
    `,
    features: [
      'Сохранение заметок с указанием категории',
      'Фильтрация заметок по категориям',
      'Набор категорий и цветов можно поменять в ручном режиме через админку Firebase',
      'Приложение адаптировано для мобильных телефонов',
      'Данные приложения постоянно синхронизированы с базой на сервере'
    ],
    img: '/img/projects/qnotes.png'
  },
  {
    name: 'Gosstroysmeta',
    description: 'Приложение для составления сметной документации',
    overview: `
      Это приложение я писал на своей основной работе в команде разработчиков.
      Программа позволяет рассчитывать сметы, применять индексы, поправочные коэффициенты.
      Написана на Delphi.
    `,
    features: [
      'Собственный расчетный движок с формулами и ссылками на различные элементы. Возможность использовать агрегатные функции при расчете',
      'Скрипты для дополнения функционала программы',
      'Работа с базами сметных нормативов',
      'Применение индексов и коэффициентов',
      'И многое другое, что важно для сметчика'
    ],
    extra: {
      title: 'Ссылки',
      name: ['Сайт компании'],
      link: ['https://gosstroysmeta.ru']
    },
    img: '/img/projects/gss.png'
  },
  {
    name: 'Promo',
    description: 'Веб проекты для promo-software.com',
    overview: `
      Это набор сайтов для BTL-рекламы по сбору данных мерчендайзерами. 
      Проекты выполнены на собственном движке на php, фронтэнд - ExtJS 4.2. 
    `,
    features: [
      'Отображение списка адресов',
      'Отображение детализации по визитам в конкретный адрес',
      'Список визитов',
      'Детализация визита с отобаржением всех собранных данных, фото и аудио материалов',
      'Отчеты в виде таблиц и графиков по различным срезам',
      'Все отчеты и списки можно фильтровать. некоторые фильтры имеют множественный выбор и собственную строку поиска',
      'Сводные таблицы данных',
      'Экспорт в Эксель всех списков с учетом фильтров',
      'Возможность добавления уникальных отчетов для конкретного проекта'
    ],
    img: '/img/projects/promo.png'
  },
  {
    name: 'Ariel',
    description:
      'Программа получения и обработки вихретоковых сигналов с прибора PL500',
    overview: `
      Программа позволяет подключаться к вихретоковому прибору Rohman PL500 и 
      сохранять данные вихретоковых сигналов в файл. Второе приложение позволяет 
      просмоатривать и анализировать полученные сигналы. Программа написана 
      на Delphi и обладает высокой скоростью обработки данных и отображения сигналов.
    `,
    features: [
      'Работа с прибором PL500',
      'Задание параметров для 16 вихретоковых каналов: возбуждение, частота, фильтры, усиление, компенсация и т.д.',
      'Автоматическое включение записи при поднесении датчиков к объекту контроля и автоматическое сохранение файла при окончании контроля (позволяет наладить потоковый контроль без участия оператора)',
      'Анализ сигналов и обнаружение дефектов',
      'Автоматическое определение размеров дефекта',
      'Ручной анализ сигналов',
      'Скриптовой модуль для автоматизации анализа и обработки данных'
    ],
    src: 'https://github.com/zag82/zag82.github.io/tree/main/projects/ariel',
    img: '/img/projects/ariel.png'
  },
  {
    name: 'MagNum3D',
    description: 'Программа конечно-элементного моделирования',
    overview: `
      Программа конечно-элементного моделирования распределения электромагнитных
      полей. Создавалась мной еще в институте, будучи студентом. Позволяет рассчитывать
      плоские, осесимметричные и трехмерные распределения полей. Конечно-элементная сетка
      квази-регулярная, то есть может сжиматься и расширяться. Программа написана на
      Delphi и очень быстро решает задачи.
    `,
    features: [
      'Решаемые задачи: электростатика, электростатика с векторным потенциалом, статическое магнитное поле, гармоническое электромагнитное поле',
      'Построение сеточных моделей на плоскости и в пространстве',
      'Расчет двумерной и 3х-мерной задачи на одной модели',
      'Просмотр результатов: силовые линии, изолинии, поверхность распределения',
      'Отображение графиков распределения величины вдоль заданного направления',
      'Расчет потенциалов, плотности потока',
      'Учет кривой намагничивания для магнитных материалов'
    ],
    src: 'https://github.com/zag82/zag82.github.io/tree/main/projects/magnum3d',
    img: '/img/projects/magnum3d.png'
  }
];

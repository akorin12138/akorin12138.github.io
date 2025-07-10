import type { UserThemeConfig } from 'valaxy-theme-yun'
import { defineValaxyConfig } from 'valaxy'
import { addonWaline } from 'valaxy-addon-waline'

// add icons what you will need
const safelist = [
  'i-ri-home-line',
]

/**
 * User Config
 */
export default defineValaxyConfig<UserThemeConfig>({
  // site config see site.config.ts

  theme: 'yun',

  modules: {
      rss: {
        enable: true,
        fullText: false,
      },
    },

  themeConfig: {
    banner: {
      enable: true,
      title: '眼前的樱',
      // cloud: {
      //   enable:true
      // }
    },
    bg_image: {
      enable: true,
      url: 'https://pic.akorin.icu/bg-dark1.jpg',
      dark: 'https://pic.akorin.icu/bg-white1.png',
      opacity: 0.55,
    },
    pages: [
      // {
      //   name: '我的小伙伴们',
      //   url: '/links/',
      //   icon: 'i-ri-genderless-line',
      //   color: 'dodgerblue',
      // },
      // {
      //   name: '喜欢的女孩子',
      //   url: '/girls/',
      //   icon: 'i-ri-women-line',
      //   color: 'hotpink',
      // },
    ],

    footer: {
      since: 2016,
      beian: {
        enable: false,
        icp: '苏ICP备17038157号',
      },
    },

  },
  addons: [
      addonWaline({
        // Waline 配置项，参考 https://waline.js.org/reference/client/props.html
        serverURL: 'https://waline.akorin.icu',
        meta: ['nick', 'mail'],
        emoji: ['https://unpkg.com/@waline/emojis@1.1.0/tw-emoji'],
        login: 'force',
        texRenderer: true,
        dark: 'auto',
      }),
    ],
  unocss: { safelist },
})

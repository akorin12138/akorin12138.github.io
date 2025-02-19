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
      url: 'https://pub-3f9780acd0d54f9dabe63c0a1ab77225.r2.dev/20230520_025611.jpg',
      dark: 'https://pub-3f9780acd0d54f9dabe63c0a1ab77225.r2.dev/20230520.jpg',
      opacity: 0.25,
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

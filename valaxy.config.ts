import type { UserThemeConfig } from 'valaxy-theme-yun'
import { defineValaxyConfig } from 'valaxy'

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
      title: '往事如烟',
    },
    bg_image: {
      enable: true,
      url: 'https://www.helloimg.com/i/2025/01/28/67980e5d6d0f4.jpg',
      dark: 'https://www.helloimg.com/i/2025/01/28/67980c4378c89.jpg',
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

  unocss: { safelist },
})

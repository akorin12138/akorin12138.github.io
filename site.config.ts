import { defineSiteConfig } from 'valaxy'

export default defineSiteConfig({
  url: 'http://akorin.icu',
  lang: 'zh-CN',
  title: 'AkoRin的小站',
  subtitle: '只满足于眼前的『樱』',

  favicon: 'https://www.helloimg.com/i/2025/01/28/6797d27a549c8.png',
  author: {
    name: 'akorin',
    avatar: 'https://www.helloimg.com/i/2025/01/28/6797d27a549c8.png',
  },
  description: '随心记录',
  social: [
    // {
    //   name: 'RSS',
    //   link: '/atom.xml',
    //   icon: 'i-ri-rss-line',
    //   color: 'orange',
    // },
    // {
    //   name: 'QQ 群 1050458482',
    //   link: 'https://qm.qq.com/cgi-bin/qm/qr?k=kZJzggTTCf4SpvEQ8lXWoi5ZjhAx0ILZ&jump_from=webapi',
    //   icon: 'i-ri-qq-line',
    //   color: '#12B7F5',
    // },
    {
      name: 'GitHub',
      link: 'https://github.com/akorin12138',
      icon: 'i-ri-github-line',
      color: '#A5A5E3',
    },
    // {
    //   name: '微博',
    //   link: 'https://weibo.com/jizhideyunyoujun',
    //   icon: 'i-ri-weibo-line',
    //   color: '#E6162D',
    // },
    // {
    //   name: '豆瓣',
    //   link: 'https://www.douban.com/people/yunyoujun/',
    //   icon: 'i-ri-douban-line',
    //   color: '#007722',
    // },
    // {
    //   name: '网易云音乐',
    //   link: 'https://music.163.com/#/user/home?id=247102977',
    //   icon: 'i-ri-netease-cloud-music-line',
    //   color: '#C20C0C',
    // },
    // {
    //   name: '知乎',
    //   link: 'https://www.zhihu.com/people/yunyoujun/',
    //   icon: 'i-ri-zhihu-line',
    //   color: '#0084FF',
    // },
    // {
    //   name: '哔哩哔哩',
    //   link: 'https://space.bilibili.com/1579790',
    //   icon: 'i-ri-bilibili-line',
    //   color: '#FF8EB3',
    // },
    // {
    //   name: '微信公众号',
    //   link: 'https://cdn.yunyoujun.cn/img/about/white-qrcode-and-search.jpg',
    //   icon: 'i-ri-wechat-2-line',
    //   color: '#1AAD19',
    // },
    // {
    //   name: 'Twitter',
    //   link: 'https://twitter.com/YunYouJun',
    //   icon: 'i-ri-twitter-x-fill',
    //   color: 'black',
    // },
    // {
    //   name: 'Telegram Channel',
    //   link: 'https://t.me/elpsycn',
    //   icon: 'i-ri-telegram-line',
    //   color: '#0088CC',
    // },
    {
      name: 'E-Mail',
      link: 'mailto:niozi@outlook.com',
      icon: 'i-ri-mail-line',
      color: '#1DDBAF',
    },
    // {
    //   name: 'Travelling',
    //   link: 'https://www.travellings.cn/go.html',
    //   icon: 'i-ri-train-line',
    //   color: 'var(--va-c-text)',
    // },
  ],

  search: {
    enable: false,
  },

  sponsor: {
    enable: true,
    description: '谢谢你的喜欢',
  },
})

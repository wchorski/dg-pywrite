---
{"dg-publish":true,"permalink":"/developer/NextJS/NextJS Analytics and Add Blockers/","created":"2024-02-29T22:19:56.124-06:00","updated":"2024-06-04T15:45:04.000-05:00"}
---

I want to make sure I get session data from my users even if they have an add blocker. To do this I just need to create a proxy in the `next.config.js` that routes my analytics data as if it's from the same domain

## next.config.js
```js
/** @type {import('next').NextConfig} */

const ANALYTICS_URL = process.env.NEXT_PUBLIC_UMAMI_URL + '/:match*'
console.log('ANALYTICS_URL', ANALYTICS_URL);

const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  async rewrites() {
    return [
      {
        source: '/stats/:match*',
        destination: ANALYTICS_URL,
      },
    ]
  },
}

module.exports = nextConfig
```

I first tried this out on my [[developer/Projects/Make-a-Gram\|Make-a-Gram]] project

---
## Credits
- [next.config.js: Rewrites | Next.js (nextjs.org)](https://nextjs.org/docs/api-reference/next.config.js/rewrites)
- [How to use a proxy in Next.js - LogRocket Blog](https://blog.logrocket.com/how-to-use-proxy-next-js/)
- [Running on Vercel | umami](https://umami.is/docs/running-on-vercel)

## Backlinks
- [[developer/NextJS/NextJS\|NextJS]]
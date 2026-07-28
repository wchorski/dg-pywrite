---
{"dg-publish":true,"tags":["nodejs","middleware","analytics","proxy"],"permalink":"/developer/node-js/analytics-middleware-route-with-astro-js/","dgPassFrontmatter":true}
---

You just got your fancy self host analytics app running on your home server. You're ready to throw it onto your other self hosted apps and see the traffic *pour* in. Only to realize that many ad blockers will block this traffic.

Ok no problem, I'll just make sure my tracker script has a non descriptor name that is not blocked by trackers. Here is Umami's [Tracker Script Name](https://docs.umami.is/docs/environment-variables#tracker_script_name) solution. While this is a good start, this still shows as a 3rd party domain (something ad blockers also do not like).

Ok, so the solution is to route that traffic through the domain. The client only interacts with one site that then talks to the analytics domain in the backend
## Proxy
> A _proxy_ is an intermediary server that sits between a client (such as your application) and a destination server (such as a back-end API) - [Microsoft](https://learn.microsoft.com/en-us/microsoft-cloud/dev/dev-proxy/concepts/what-is-proxy)

With this in mind we can create a bridge that, from the client's view, shares the analytic's endpoints with another web app, effetely side stepping ad blockers.
### Analytics App
I am using [[developer/Home Lab/umami\|umami]] as my analytic tool, but I hope this guide can help others with the other many options. The basic way is to generate a site and drop the script tag into the `<head>` tag

```html
<script defer src="https://trail.tawtaw.site/path" data-website-id="7h653818-***"></script>
```

notice how I avoid using names like "analytics", "tracker", "metrics" as to avoid common ad block keywords. I am even able to rename the default `/script.js` to `/path` with [Tracker Script Name](https://docs.umami.is/docs/environment-variables#tracker_script_name)configuration.

We will still use this source url and website-id in our proxy.
### Middleware
I'm using the [[developer/HTMX/HTMX and Astro\|Astro]] node framework. Here i can drop in a `src/middleware.js` that will run this proxy

```env
UMAMI_HOST="https://trail.tawtaw.site"
UMAMI_SCRIPT="path"
UMAMI_PROXY_PREFIX="/assets/path"
UMAMI_WEB_ID="7h653818-***"
```

```ts
import { defineMiddleware } from "astro:middleware";

const UMAMI_HOST = process.env.UMAMI_HOST;
export const UMAMI_PROXY_PREFIX =
  process.env.UMAMI_PROXY_PREFIX ?? "/assets/path";

const ROUTE_MAP: Record<string, string> = {
  [UMAMI_PROXY_PREFIX]: "/path", // script
  [`${UMAMI_PROXY_PREFIX}/api/send`]: "/api/send", // data collection
};

export const onRequest = defineMiddleware(async (context, next) => {
  if (import.meta.env.DEV) {
    return next();
  }

  const url = new URL(context.request.url);
  const remotePath = ROUTE_MAP[url.pathname];

  if (remotePath && UMAMI_HOST) {
    const targetUrl = `${UMAMI_HOST}${remotePath}${url.search}`;
    const isBodyMethod = !["GET", "HEAD"].includes(context.request.method);

    const res = await fetch(targetUrl, {
      method: context.request.method,
      headers: {
        "content-type":
          context.request.headers.get("content-type") ?? "application/json",
        "user-agent": context.request.headers.get("user-agent") ?? "",
        "x-forwarded-for":
          context.request.headers.get("x-forwarded-for") ??
          context.clientAddress ??
          "",
      },
      body: isBodyMethod ? context.request.body : undefined,
      // @ts-ignore — required by undici for streaming request bodies
      duplex: isBodyMethod ? "half" : undefined,
    });

    const body = await res.arrayBuffer();
    return new Response(body, {
      status: res.status,
      headers: {
        "content-type":
          res.headers.get("content-type") ?? "application/javascript",
        "cache-control": res.headers.get("content-type")?.includes("javascript")
          ? "public, max-age=3600"
          : "no-store",
      },
    });
  }

  return next();
});
```

### Layout
Add the script tag in the base layout's `<head>`, but this time point it to the home domain instead of external analytics url

```js
const { SITE_TITLE, SITE_EXCERPT, DOMAIN_URL, UMAMI_WEB_ID } = import.meta.env;
// DOMAIN_URL="https://myappdomain.com"
// prefix gotten from middleware.ts
// UMAMI_PROXY_PREFIX="/assets/path"
```

```jsx
{
	UMAMI_WEB_ID && !import.meta.env.DEV ? (
		<script
			defer
			is:inline
			data-astro-rerun
			src={UMAMI_PROXY_PREFIX}
			data-website-id={UMAMI_WEB_ID}
			data-host-url={`${DOMAIN_URL}/assets/path`}
		/>
	) : (
		<meta name="analytics" content="analytics were not loaded" />
	)
}
```

Don't forget to add [data-astro-rerun](https://docs.astro.build/en/guides/view-transitions/#data-astro-rerun) if you are using View Transitions. This ensures the script is re-triggered even if you have SPA like page navigation. 

---
## Credit
- https://buddystat.com/docs/proxy-guide/astro
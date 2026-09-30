---
{"dg-publish":true,"tags":["nextcloud","analytics"],"permalink":"/developer/nextcloud-analytics-with-umami-and-js-loader-plugin-app/","dgPassFrontmatter":true,"dg-note-properties":{"tags":["nextcloud","analytics"]}}
---

Once I started sharing files and opening my [[developer/Home Lab/Nextcloud\|Nextcloud]] server to other users, I wanted to track it's usage and see what routes or files were the most popular.

I'm using a self hosted analytics tool called [[developer/Home Lab/umami\|umami]] to aggregate client data.  Get yourself the generated script with `website-id` that you would normally put in the `<head>` of the site. 

With Nextcloud you *could* modify the files and plop that script tag in the head, but it's recommended to use this plugin to inject custom #javascript 
## Install the Plugin
https://apps.nextcloud.com/apps/jsloader

After the install, find the config at https://cloutdrive.tawtaw.site/settings/admin/jsloader
## Insert the analytics endpoint
Here we build the `<script>` tag with JS. insert your custom `src` and `data-website-id` generated from [[developer/Home Lab/umami\|umami]]
```js
(function() {
    console.log('🍜 soup engaged');
    var script = document.createElement('script');
    script.defer = true;
    script.src = 'https://soup.tawtaw.site/ramen';
    script.setAttribute('data-website-id', 'f94ec847-****');
    document.head.appendChild(script);
})();
```

Domain where external Javascript is loaded from.
```txt
https://soup.tawtaw.site
```

hit save and now you're analytics should be hooked in for any route on your [[developer/Home Lab/Nextcloud\|Nextcloud]] server

> [!tip] Upgrades or Migrations
> I've noticed on major upgrades or when I migrated from the regular [[developer/Home Lab/Docker\|Docker]] version to [[developer/Docker/Docker Nextcloud AIO Re Install or Remove images\|Nextcloud AIO]] That these plugins can disable themselves. Makes sure to note down what plugins you use as you may need to re-enable them in the future.


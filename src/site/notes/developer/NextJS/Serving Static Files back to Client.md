---
{"dg-publish":true,"permalink":"/developer/NextJS/Serving Static Files back to Client/"}
---

After I [[developer/NextJS/Upload Files with next-connect and Multer\|Upload Files with next-connect and Multer]] I wanted to serve those same files back to the client. Ahh but not so fast says [[developer/NextJS/NextJS\|NextJS]]. 

> [!note](https://nextjs.org/docs/basic-features/static-file-serving)
> Only assets that are in the `public` directory at [link](https://nextjs.org/docs/api-reference/cli#build) will be served by Next.js. Files added at runtime won't be available. We recommend using a third party service like [AWS S3](https://aws.amazon.com/s3/) for persistent file storage.

### create an api endpoint
`./pages/api/images-endpoint/[...slug].js`
```javascript
import fs from "fs";
import path from "path";

export default function handler(req, res) {
  const imagePath = req.query.slug.join("/");
  const filePath = path.resolve(".", `./public/uploads/${imagePath}`);
  const imageBuffer = fs.readFileSync(filePath);
  res.setHeader("Content-Type", "image/jpg");
  return res.send(imageBuffer);
}
```

## Seperate Nginx server

Try and use nginx or another webserver to serve the public directory. That way it will serve newly added files without having to write extra code to serve files in nextjs. [link](https://stackoverflow.com/users/989394/bas080)

```javascript
server {
  /images/ {
    root /var/www/site/public
  }
}
```

## Express server inside NextJS
https://stackoverflow.com/a/70490960/15579591

## other stuff
Looks like we could fiddle with a custom server but that looks like a bigger headache [Advanced Features: Custom Server | Next.js (nextjs.org)](https://nextjs.org/docs/advanced-features/custom-server)

---
## Credits
- https://stackoverflow.com/a/72031304/15579591 - thanks to [User Rizwan Amjad ](https://stackoverflow.com/users/11503874/rizwan-amjad)
- [link](https://stackoverflow.com/questions/68225815/how-to-access-files-uploaded-to-the-public-folder-in-next-js#:~:text=From Next.js documentation%3A Only assets that are in,to them in the app at run time.)
---
{"dg-publish":true,"permalink":"/developer/next-js/next-router/","dgPassFrontmatter":true}
---

## use isReady if query is empty 
```javascript
const MediaPage = () => {
  const router = useRouter();

    useEffect(() => {
        if(router.isReady){
            const { media } = router.query;
            if (!mediaId) return null;
            getPostImage();
            ...
         }
    }, [router.isReady]);
   
    ...

}
```

---
## Credits
- https://stackoverflow.com/a/71879444/15579591

## Backlinks
- [[developer/NextJS/NextJS\|NextJS]]
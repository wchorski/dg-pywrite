---
{"dg-publish":true,"permalink":"/developer/NextJS/Next Router/","noteIcon":""}
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
- [[developer/Home Lab 🏠/NextJS\|developer/Home Lab 🏠/NextJS]]
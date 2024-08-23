---
{"dg-publish":true,"permalink":"/developer/NextJS/Next Router/","created":"2024-02-29T22:19:56.121-06:00","updated":"2024-03-01T00:21:11.000-06:00"}
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
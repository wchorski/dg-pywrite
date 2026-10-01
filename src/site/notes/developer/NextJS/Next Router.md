---
{"dg-publish":true,"permalink":"/developer/next-js/next-router/","noteIcon":"","created":"2025-04-09T11:39:59.000-05:00","updated":"2025-04-09T11:39:59.000-05:00","dg-note-properties":{}}
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
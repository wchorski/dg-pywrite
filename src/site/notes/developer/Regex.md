---
{"dg-publish":true,"permalink":"/developer/Regex/","noteIcon":""}
---



Here lies all the regular expressions that I found useful

[regex101: build, test, and debug regex](https://regex101.com/)

get anything to the right of `--`
```js
/(?<=\-\-).*/
```

get anything to the left of  `--`
```js
/^.*(?=\-\-)/
``` 

get anything between `[ ]`
```js
/(?<=\[).*(?=\])/
```

finds string between `](` & `)` →  used to find string between `](` & `)` i.e. `[link](http://this.com)` 
```js
/(?<=\]\().*(?=\))/g
```

replace any special characters that OS's don't like
```js
STRING.replace(/[&#\@\!, +()$~%'":*?<>{}]/g, '_')
```

Only alphabet characters are allowed for this field. ==NO spaces==
```js
/^[aA-zZ]+$/, 
```

phone number validation
```js
/^([+]?\d{1,2}[-\s]?|)\d{3}[-\s]?\d{3}[-\s]?\d{4}$/
```

Standard Password
```js
/^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8,40}$/
```

```
^                         Start anchor
(?=.*[A-Z].*[A-Z])        Ensure string has two uppercase letters.
(?=.*[!@#$&*])            Ensure string has one special case letter.
(?=.*[0-9].*[0-9])        Ensure string has two digits.
(?=.*[a-z].*[a-z].*[a-z]) Ensure string has three lowercase letters.
.{8}                      Ensure string is of length 8.
$                         End anchor.
```

Find a every line that starts with (with wildcard). Useful with [[developer/Media Software/iTunes XML Playlist to m3u Converter\|developer/Media Software/iTunes XML Playlist to m3u Converter]]
```js
# don't forget to excape any slashes \/
^\/Volumes\/edata\/iMusicLibrary\/.*$

# select any line that starts with "#EXTINF:" could have any number after colon, and ends with comma.
# examples that are removed: "#EXTINF:177,", "#EXTINF:246,", "#EXTINF:192,"
^#EXTINF:.*?,
```
## HTML Input Pattern Attribute
An `<input>` element with type="email" that must be in the following order: _characters_@_characters_._domain_ (characters followed by an @ sign, followed by more characters, and then a "."

After the "." sign, add at least 2 letters from a to z:

```html
<form action="/action_page.php">  
  <label for="email">Email:</label>  
  <input type="email" id="email" name="email"  
  pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$">  
  <input type="submit">  
</form>
```
---
## Credits
- [[freecodecamp.org)](https://www.freecodecamp.org/news/simple-regex-tricks-for-beginners-3acb3fa257cb/\|Simple RegEx tricks for beginners (freecodecamp.org)]]
- [regex101: Phone Number](https://regex101.com/r/rL2lD5/1)
- [Regex to validate password strength - Stack Overflow](https://stackoverflow.com/questions/5142103/regex-to-validate-password-strength)
- [[w3schools.com)](https://www.w3schools.com/TAGS/att_input_pattern.asp\|HTML input pattern Attribute (w3schools.com)]]

## Backlinks
- [[developer/Javascript/Javascript\|developer/Javascript/Javascript]]
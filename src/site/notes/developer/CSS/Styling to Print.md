---
{"dg-publish":true,"permalink":"/developer/css/styling-to-print/","noteIcon":""}
---

## Hide or Show When Printing
I Wanted to show certain items and hide others when a user goes to print a web page

```scss
@media print {
    @page {
      size: portrait;
    }
    body * {
      visibility: hidden;
    }
    .printable, .printable * {
      visibility: visible;
    }
    .printable {
      position: absolute;
      left: 0;
      top: 0;
    }

    .noprint{
      display: none !important;
      visibility: hidden !important;
    }

    .hideTillprint{
      position: inherit;
    }
  }
```

>[!tip] use the `!important` option when things like `display: none` are not working

## Fit contents into one page

---
## Credits
- [[Ctrl+P) - Stack Overflow](https://stackoverflow.com/questions/54441453/react-printer-friendly-printable-area-to-print-ctrlp\|css - React, printer friendly printable area to print (Ctrl+P) - Stack Overflow]]
- [html - @media print display:none isn't working - Stack Overflow](https://stackoverflow.com/questions/11698913/media-print-displaynone-isnt-working)

## Backlinks
- [[developer/CSS/Cascading Style Sheet Tips & Tricks\|developer/CSS/Cascading Style Sheet Tips & Tricks]]
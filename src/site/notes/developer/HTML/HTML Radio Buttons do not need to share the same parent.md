---
{"dg-publish":true,"tags":["html"],"permalink":"/developer/html/html-radio-buttons-do-not-need-to-share-the-same-parent/","dgPassFrontmatter":true}
---

As long as each input is of type `radio` and share the same name, i.e. `myGroup` they will act in tandem.

This saves a lot of headache where normally you would create a handful of checkboxes and have to loop through them to uncheck them when another is checked. You also get the added benefit of a string `value` property that can be outputted instead of working with a group of `boolean` values

```html
<div class="section-1">
  <label for="option1">
    <input type="radio" id="option1" name="myGroup" value="option1">
    Option 1
  </label>
</div>

<div class="section-2">
  <label for="option2">
    <input type="radio" id="option2" name="myGroup" value="option2">
    Option 2
  </label>
</div>

<div class="section-3">
  <label for="option3">
    <input type="radio" id="option3" name="myGroup" value="option3">
    Option 3
  </label>
</div>
```
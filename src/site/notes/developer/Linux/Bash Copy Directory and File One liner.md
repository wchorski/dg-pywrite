---
{"dg-publish":true,"permalink":"/developer/Linux/Bash Copy Directory and File One liner/","created":"2024-02-29T22:19:56.042-06:00","updated":"2024-03-01T00:19:20.000-06:00"}
---

I needed a #bash shell script that automatically copied over private files such as `.env` and `home.tsx` within my web development stack

Here is the stack overflow post by [Mark Amery](https://stackoverflow.com/a/32596855) that helped


```shell
mkdir -p /foo/bar && cp myfile.txt $_
```

> `$_` - expands to the last argument to the previous command

if the path as spaces, the strings need to be wrapped in quotes
```shell
mkdir -p "/my directory/name with/spaces" && cp "my filename with spaces.txt" "$_"
```

if you want to name the file with a new name
```shell
mkdir -p /foo/bar && cp ../from/another/dir/myfile.txt $_/my-file-with-new-name
```
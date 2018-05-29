# leajs-folders

Plugin of [leajs](https://github.com/lea-js/leajs-server).

Serves folders.

## leajs.config

```js
module.exports = {

  // Lookup to translate a url into a folder
  // $item ([Object, String]) Folder options, can be used as a shortcut for folders.$item.folders
  // $item.folder ([String, Array]) Folderpath, absolute or relative to CWD
  // $item.folders ([String, Array]) Synonym for folders.$item.folder
  // $item.mount (String) Url to mount the folder to, overwrites folder options name
  folders: {}, // Object

  // …

}
```

## License
Copyright (c) 2018 Paul Pflugradt
Licensed under the MIT license.
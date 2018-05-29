module.exports =
  folders: 
    type: Object
    default: {}
    desc: "Lookup to translate a url into a folder"
  folders$_item: 
    types: [Object,String]
    desc: "Folder options, can be used as a shortcut for folders.$item.folders"
  folders$_item$folder: 
    types: [String,Array]
    desc: "Folderpath, absolute or relative to CWD"
  folders$_item$folders: 
    types: [String,Array]
    desc: "Synonym for folders.$item.folder"
  folders$_item$mount:
    type: String
    desc: "Url to mount the folder to, overwrites folder options name"
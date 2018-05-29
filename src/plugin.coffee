
module.exports = ({init}) => init.hookIn ({
  config:{folders}, 
  path: {resolve, sep}, 
  util: {isString, isArray},
  respond, 
  Promise,
  position}) =>

  resolveFolder = (path) =>
    path = resolve(path)
    path += sep unless path.endsWith(sep)
    return path
  
  for k,v of folders
    if isString(v)
      v = folders[k] = folders: [resolveFolder(v)]
    else if v.folder
      v.folders = v.folder
    else
      v.folders = [v.folders] unless isArray(v.folders)
      v.folders = v.folders.map resolveFolder
    v.mount += "/" unless (v.mount ?= k).endsWith("/")
  

  if Object.keys(folders).length > 0
    respond.hookIn (req) =>
      if not req.body? and not req.file?
        url = req.url
        workers = []
        for k,v of folders
          if url.startsWith(mount = v.mount)
            for folder in v.folders
              resolved = resolve(folder, url.replace(mount,""))
              if resolved.startsWith(folder)
                workers.push(req.getFile resolved
                  .then => Object.assign req, v
                  .catch =>
                )
        return Promise.all workers
module.exports.configSchema = require("./configSchema")
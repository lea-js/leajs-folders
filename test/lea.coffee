{test, prepare, Promise, getTestID} = require "snapy"
try
  Lea = require "leajs-server/src/lea"
catch
  Lea = require "leajs-server"
http = require "http"
{writeFile, unlink} = require "fs-extra"

require "../src/plugin"

port = => 8081 + getTestID()

request = (path = "/") =>
  filter: "headers,statusCode,-headers.date,-headers.last-modified,body"
  stream: "":"body"
  promise: new Promise (resolve, reject) =>
    http.get Object.assign({hostname: "localhost", port: port(), agent: false}, {path: path}), resolve
    .on "error", reject
  plain: true

prepare (state, cleanUp) =>
  lea = await Lea
    config: Object.assign (state or {}), {
      listen:
        port:port()
      disablePlugins: ["leajs-folders"]
      plugins: ["./src/plugin"]
      }
  cleanUp => lea.close()
  return state.folders

test {folders:{"/":"./test/"}}, (snap, folders, cleanUp) =>
  # file1
  filename1 = folders["/"]+"file1"
  filename2 = folders["/"]+"file2"
  await Promise.all [
    writeFile filename1, "file1"
    writeFile filename2, "file2"
  ] 
  cleanUp => Promise.all [
    unlink filename1
    unlink filename2
  ]
  snap request("/file1")
  snap request("/file2")
  # error when trying to get outside file
  snap request("/../.gitignore")

test {folders:{first:{folders:"./test",mount:"/r"}}}, (snap, folders, cleanUp) =>
  # file1
  filename3 = folders.first.folders+"/file3"
  await Promise.all [
    writeFile filename3, "file3"
  ] 
  cleanUp => Promise.all [
    unlink filename3
  ]
  snap request("/r/file3")
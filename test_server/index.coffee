
restify = require 'restify'

server = restify.createServer
  name: 'record-set-test-server'
  version: '0.0.0'

server.use restify.queryParser()
server.use restify.bodyParser()

# CORS is enabled by the next 2 statments
server.use restify.CORS()
server.use restify.fullResponse()

records = {}
curId = 1

add = (label) ->
  r = { id: curId, label: label}
  records[curId++] = r
  r

add "record1"
add "record2"

server.get '/my-record', (req,res,next) ->
  res.send records
  return next()

server.post '/my-record', (req,res,next) ->
  unless req.params.label? and req.params.label.trim() != ""
    res.send 400, {error: "invalid label"}
    return next()

  res.send (add req.params.label.trim())
  return next()

server.get '/my-record/:id', (req,res,next) ->
  unless req.params.id? and /^\d+$/.test req.params.id.trim()
    res.send 400, {error: "invalid id"}
    return next()

  id = parseInt req.params.id.trim(), 10

  unless records[id]?
    res.send 404, {error: "no such record"}
    return next()

  res.send records[id]
  return next()

server.put '/my-record/:id', (req,res,next) ->
  unless req.params.id? and (/^\d+$/.test req.params.id.trim())
    res.send 400, {error: "invalid id"}
    return next()

  id = parseInt req.params.id.trim(), 10

  unless records[id]?
    res.send 404, {error: "no such record"}
    return next()

  unless req.params.label? and req.params.label.trim() != ""
    res.send 400, {error: "invalid label"}
    return next()

  records[id].label = req.params.label.trim()
  res.send records[id]
  return next()

server.del '/my-record/:id', (req,res,next) ->
  unless req.params.id? and (/^\d+$/.test req.params.id.trim())
    res.send 400, {error: "invalid id"}
    return next()

  id = parseInt req.params.id.trim(), 10

  unless records[id]?
    res.send 404, {error: "no such record"}
    return next()

  delete records[id]
  res.send {}
  return next()

server.listen 9998

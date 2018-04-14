net  = require 'net'
util = require 'util'

module.exports =
class Server
  @defaultPort: 6666

  @start: (opts) -> new @constructor opts

  constructor: (opts = {}) ->
    { @Session = require './session' } = opts

    (@server = net.createServer())
      .on 'connection', (s) =>
        log "New connection:\n#{util.inspect s}"
        @startSession s
      .listen port = opts.port ? Server.defaultPort++

    log "Server started at localhost:#{port}"

  startSession: (socket) -> new @Session socket

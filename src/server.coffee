debug = (require './debug') __filename

net  = require 'net'
util = require 'util'

module.exports =
class Server
  @defaultPort: 6666

  constructor: (opts = {}) ->
    { port           = @constructor.defaultPort++
      @Session       = require './session'
      sessionHandler = (s) => new @Session s
    } = opts

    (@server = net.createServer())
      .on 'connection', sessionHandler
      .listen port

    debug "Server started at localhost:#{port}"

readline = require 'readline'
util     = require 'util'

module.exports =
class Session
  @comment: '''
    Turns a TCP connection into an exchange of requests and results.
  '''

  constructor: (@socket, @handlerChain = require './minimal-commands') ->
    @socket.setEncoding 'utf8'

    (@readline = readline.createInterface input: @socket, output: @socket)
      .on 'line', (line) =>
        try
          @handlerChain.handleLine line
        catch e
          @echoError e

  shutdown: -> @socket.server.shutdown()
  echo: (s) -> @socket.write s + '\n'

  eval: (code) ->
    log "eval: #{code}"

    try
      result = @eval rest

      @echo "=> #{util.inspect result}\n"

    catch e
      @echoError e

  echoError: (e) ->
    @echo ['error:', e.message, e.stack, ''].join '\n'

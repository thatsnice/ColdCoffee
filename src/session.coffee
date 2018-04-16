readline = require 'readline'
util     = require 'util'

cs       = require 'coffeescript'

debug    = (require './debug') __filename

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
          action = @handlerChain.handleLine line
          debug line, action
          action.call @
        catch e
          @echoError e

  shutdown: -> @socket.server.shutdown()
  echo: (s) -> @socket.write s + '\n'

  eval: (code) ->
    debug "eval: #{code}"

    try
      fn = cs.eval "-> #{code}"
      result = fn.call @

      @echo "=> #{util.inspect result}\n"

    catch e
      @echoError e

  echoError: (e) ->
    @echo ['error:', e.message, e.stack, ''].join '\n'

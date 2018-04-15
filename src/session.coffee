readline = require 'readline'
util     = require 'util'

module.exports =
class Session
  @comment: '''
    Turns a TCP connection into an exchange of directives and rendered results.
  '''

  constructor: (@socket, @handlerChain = require './minimal-commands') ->
    @socket.setEncoding 'utf8'

    (@readline = readline.createInterface input: @socket, output: @socket)
      .on 'line', (line) =>
        try
          @handlerChain.handleLine line
        catch e
          @echoError e

  lineHandler: (line) ->
    return unless line = @dealias line.trim()

    [, cmd, rest] = line.match /^(\S+)(?:\s+(.*))/

    @commandHandler {line, cmd, rest}

  echo: (s) -> @socket.write s + '\n'

  commandHandler: ({cmd, rest, line}) ->
    if 'function' isnt typeof @[methodName = "cmd_#{cmd}"]
      return @echo "input not recognized as a command"

    @[methodName] {cmd, rest, line}

  eval: (code) -> cs.eval code

  cmd_eval: ({rest}) ->
    log "cmd_eval: #{util.inspect arguments}"

    try
      result = @eval rest

      @echo "=> #{util.inspect result}\n"

    catch e
      @echoError e

  echoError: (e) ->
    @echo ['error:', e.message, e.stack, ''].join '\n'

  dealias: (line) ->
    history = []
    changed = false

    for [pattern, replacer] in @aliases
      [was, line] = [line, line.replace pattern, replacer]

      if (changed = was isnt line)
        if MAX_EXPANSIONS < history.push line
          throw new Error 'too many alias expansions'
        history.push was

    return {history, line}

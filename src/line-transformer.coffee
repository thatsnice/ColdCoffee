util  = require 'util'

debug = (require './debug') __filename

module.exports =
class LineTransformer
  constructor: (@transform, @next) ->

  defaultHandler: (l) ->
    @echoError new Error "No match found for input '#{util.inspect l}'"

  add: (transform) -> new @constructor transform, @

  handleLine: (line) ->
    try
      debug line
      debug util.inspect({line = line, done} = (@transform line) ? {})

      switch
        when      done then done
        when not @next then @defaultHandler  line
        when      line then @next.handleLine line

    catch e
      debug e


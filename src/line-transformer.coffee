util = require 'util'

debug = (require './debug') __filename

module.exports =
class LineTransformer
  constructor: (@transform, @next) ->

  add: (transform) -> new @constructor transform, @

  handleLine: (line) ->
    try
      debug line
      debug util.inspect({line = line, done} = @transform line)

      switch
        when      done then done
        when not @next then undefined
        when      line then @next.handleLine line

    catch e
      debug e


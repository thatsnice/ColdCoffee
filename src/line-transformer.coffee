module.exports =
class LineTransformer
  constructor: (@transform, @next) ->
    if (pattern = @matchLine) instanceof RegExp
      @matchLine = (s) -> s.match pattern

  add: (transform) -> new @constructor transform, @

  handleLine: (line) ->
    {line, done} = @transform line, matched

    switch
      when      done then done
      when not @next then undefined
      when      line then @next.handleLine

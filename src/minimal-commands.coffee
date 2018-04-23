util            = require 'util'

cs              = require 'coffeescript'

debug           = (require './debug') __filename

LineTransformer = require './line-transformer'

module.exports  = null

patterns = ->
  glob:       /// " (?: \\\" | \\\. | [^"] )* " | [^"]* ///
  whitespace: ///   \s+    ///
  splat:      /// ^ \*   $ ///
  notSplat:   /// ^ [^*]   ///

replacer = (pattern, replaceWith) -> (s) -> s.replace pattern, replaceWith

replaceOnMatch = (p, fn) ->
  (s) -> s.replace p, fn

globToRegexp = (glob) ->
  { glob, whitespace, splat, notSplat } = patterns

  new RegExp (glob.split whitespace
                  .map replacer notSplat, quoteForPattern
                  .map replacer    splat, glob
                  .join matchWhitespace
  )

addHandler      = (handler)  -> module.exports = new LineTransformer handler, module.exports
alias           = (from, to) -> addHandler (line) -> line: line.replace cmdPattern(from), to

cmds = (namesAndActions) ->
  for name, action of namesAndActions
    do (name, action) ->
      name = globToRegep name

      addHandler (line) ->
        if matched = line.match cmdPattern name
          debug "#{util.inspect pattern} =~ #{line}"
          done: -> action.call @, matched

cmds
  quit:                           -> @shutdown()
  eval:            ([, e])        -> @eval e
  say:             ([,      msg]) -> @say msg
  "to   * say  *": ([, tgt, msg]) -> @sayTo tgt, msg
  "page * with *": ([, tgt, msg]) -> @page tgt, msg

alias ';', 'eval'
alias "'", 'page'

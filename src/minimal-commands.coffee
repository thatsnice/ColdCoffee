debug = (require './debug') __filename

util = require 'util'

cs = require 'coffeescript'

LineTransformer = require './line-transformer'

module.exports = undefined

commandChain =
  new LineTransformer

cmd = (pattern, action) ->
  handler = (line) ->
    return {line} unless matched = line.match pattern
    debug "#{util.inspect pattern} =~ #{line}"

    done: -> action.call @, matched

  module.exports = new LineTransformer handler, module.exports

handlers =
  eval:     ([, e]) -> @eval e
  shutdown:         -> @shutdown()
  default:  ([l, ]) -> @echoError new Error "No match found for input '#{l}'"

cmd //,                  defaultHandler
cmd /quit/,              shutdownHandler
cmd /^ *(?:eval|;)(.*)/, evalHandler

debug = (require './debug') __filename

util = require 'util'

cs = require 'coffeescript'

LineTransformer = require './line-transformer'

module.exports = undefined

commandChain =
  new LineTransformer (line) ->
    debug msg = "No match found for input '#{line}'"

    done: -> @echoError new Error msg

cmd = (pattern, action) ->
  handler = (line) ->
    return {line} unless matched = line.match pattern
    debug "#{util.inspect pattern} =~ #{line}"

    done: -> action.call @, matched

  module.exports = new LineTransformer handler, module.exports

cmd /quit/,                      -> @shutdown()
cmd /^ *(?:eval|;)(.*)/, ([, e]) -> @eval e

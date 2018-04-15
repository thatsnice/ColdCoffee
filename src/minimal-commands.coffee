util = require 'util'

cs = require 'coffeescript'

LineTransformer = require './line-transformer'

commandChain =
  new LineTransformer (line) ->
    console.log msg = "No match found for input '#{line}'"

    done: -> @echoError new Error msg

cmd = (pattern, action) ->
  module.exports = module.exports.add (line) ->
    return line unless matched = line.match pattern

    done: action matched

cmd /quit/,                      -> @shutdown()
cmd /^ *(?:eval|;)(.*)/, ([, e]) -> @eval e

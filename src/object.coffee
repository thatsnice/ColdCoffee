ColdMethod = require './cmethod'

module.exports =
class ColdObject
  constructor: (info = {}) ->
    { @id
      @parents = []
      @vars    = new Set
      @data    = []
      @methods = {}
    } = info

    unless @id
      throw new Error "All ColdObject instances must have an id"

  toString: -> @id.toString()

  freeze: ->
    JSON.stringify {
        versionInfo: 'too soon!'
        @id
        @parents
        @data
        @methods
      }

  thaw: (frozen) ->
    new ColdObject frozen
  defineVar:    (name) ->
    unless @vars.has name
      @vars.add name
      @data[@][name] = undefined

  defineMethod: (name, code) ->

  getDefinitions: ->
    {@methods, @vars}


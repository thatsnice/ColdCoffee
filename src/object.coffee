ColdMethod = require './cmethod'

module.exports =
class ColdObject
  constructor: ->
    @methods = {}
    @parents = []
    @data = []
    @vars = new Set

  addParent: (parent) ->
    if parent.acceptChild @

  toString: -> @id.toString()

  defineVar: (name) ->
    unless @vars.has name
      @vars.add name
      @data[@][name] = undefined

  defineMethod: (name, code) ->

  getDefinitions: ->
    {@methods, @vars}


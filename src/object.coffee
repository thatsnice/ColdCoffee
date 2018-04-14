vm = require 'vm'

module.exports =
class ColdObject
  @comment: """
      I am a definition and also an instance of a definition. I extend a
      set of zero or more parent objects with zero or more methods. As an
      instance, I have state associated with my own methods and the methods of
      my ancestors.

      There is no (intended) difference in semantics between a ColdMUD object
      and a ColdCoffee object beyond shedding anything about ColdMUD which was
      required by the implementation itself (object numbers).

      My methods run in the context of the state they control on the instance
      receiving the message they are handling.
    """

  constructor: ->
    @id       = new Symbol

    # Where I come from
    @parents  = []

    # What I add
    @methods  = {}
    @varNames = new Set

    # Instance state
    @preparedMethods = {}
    @data = [@id]: @constructor.contextify undefined

    Object.defineProperties @getSandbox(@),
      self: get: => @

  getSandbox: (ancestor) ->
    (sb = @data[id = ancestor.id]) or
      throw new Error "No sandbox found for #{ancestor} (##{id})"

  receiveMessage: ({messageName, definer = @, caller, sender, args}) ->
    sandbox = @setMessageContext {caller, sender, args}

    definer.methods[messageName].send sandbox

  addParent: (parent) ->
    if parent.acceptChild @
      @preparedMethods[parent.id] = {}

  defineVar: (name) ->
    unless @vars.has name
      @vars.add name
      @data[@][name] = undefined

  defineMethod: (name, code) ->

  getDefinitions: ->
    {@methods, @vars}


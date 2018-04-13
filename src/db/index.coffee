# Usage
#

generated = {}

module.exports =
generator =
  (opts = {}) ->
    { parent     = generator '../../data/minimal'
      ColdObject = require './object'
    } = opts

    objects = []

    dbOps = (id) ->
      id:           -> id
      get:          -> objects[id] ?= parent[id]
      put: (frozen) -> objects[id]  = frozen


    db =
      create:      -> ColdObject dbOps objects.length
      lookup: (id) -> ColdObject dbOps id
      dump:        -> JSON.stringify objects

Object.assign generator, generator()

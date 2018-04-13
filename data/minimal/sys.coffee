module.exports = ->
  parents:  [1]
  children: []

  data: [
    $sys  = names: [ 'sys', 'root', 'wiz' ]
    $root = name: 'sys'
  ]

  methods:
    create: -> db.create()

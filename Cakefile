vm = require 'vm'

Object.assign global,
  log: console.log

task 'start', 'Start a server', (options = {}) ->
  new (require './src/server') options

task 'test',  'Run tests', (options = {}) ->
  unless reporterRequested argv = (require 'process').argv
    argv.push '--joe-reporter=console'

  Object.assign (sandbox = Object.create global), require 'joe'
  vm.runInNewContext 'require("./test")', sandbox

reporterRequested = (argv = (require 'process').argv) ->
  matchSwitch = (s) ->
    s.startsWith '--joe-reporter='

  -1 < argv.findIndex matchSwitch


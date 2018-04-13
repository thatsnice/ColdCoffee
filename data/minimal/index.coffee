names = 'sys root wiz'.split ' '

load = (name) -> require "./#{name}"

module.exports = names.map load

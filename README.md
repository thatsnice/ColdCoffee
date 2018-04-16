ColdMUD-inspired server with CoffeeScript as the (default) VM language

# milestones

## v0.1

    telnet localhost 6666
    ;tmp = $sys.create()
    ;$sys.checkpoint()
    ;$sys.restart()
    telnet localhost 6666
    ;tmp # displays created object

# Life cycle of a 'task'

- An event (passage of time, network activity, async callback) occurs
- That event is mapped to a target object, method and arguments (handler)
- A transaction starts to track changes resulting from this event
- ...

# Life cycle of a method call

- A message (name, args...) is sent to an instance
- A definer is found
- A vm.Script is found on that definer
- ...


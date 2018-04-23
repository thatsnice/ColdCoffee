ColdMUD-inspired server with CoffeeScript as the (default) VM language

# milestones

## v0.1

Inputs preceded by '> ', outputs by '=> '

    > telnet localhost 6666       # Done
    > ;3 + 4                      # Done
    => 7                          # Done

    > ;tmp = $sys.create()
    => #4

    > ;$sys.checkpoint()
    => true

    > ;$sys.restart()
    > telnet localhost 6666
    > ;tmp
    => #4

    > @program me.hello
    => Enter code for new method #2.hello
      @echo "hello"
    .
    => Syntax ok.
    => #2.hello saved as 'instance/2/hello.coffee'

    > @program me.hello(name)
    => Enter new code for existing method #2.hello or '.abort' to cancel
      @echo "Hello #{name}!"
    .
    => Syntax ok.
    => checked in new version of 'instance/2/hello.coffee'

    > @list me.hello
    => @program #2.hello(name)
    =>   @echo "Hello #{name}!"
    => .

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


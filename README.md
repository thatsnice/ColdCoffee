ColdMUD-inspired server with CoffeeScript as the (default) VM language

# milestones

## v0.1

    telnet localhost 6666
    ;tmp = $sys.create()
    ;$sys.checkpoint()
    ;$sys.restart()
    telnet localhost 6666
    ;tmp # displays created object

# All about Node VM module stuff

- There needs to be a VM sandbox for every instance + definer combination.
 - When `$vr_spawn1` receives '$vr::toString', that will run in a sandbox
   which is specific to spawn1 and $vr

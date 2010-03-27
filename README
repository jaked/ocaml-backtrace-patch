Patch to OCaml for backtraces in the toplevel and from dynamically
loaded code. For OCaml 3.10.x, adds Printexc functions for recording
backtraces which are similar to the 3.11.x ones.

Debugging information is loaded when code is loaded (stock OCaml loads
it only when a backtrace is generated), so the memory footprint may be
bigger. However it is allocated outside the heap so won't be copied
after a fork.

This doesn't work with dynamically loaded native code or the native
code toplevel.


To install:

 1. unpack your OCaml tree and cd into it

 2. from there, run `$PATCH/patch.sh` where `$PATCH` is the path where
    you unpacked the patch code

 3. build OCaml as usual


To use (OCaml 3.11.x):

 1. Call `Printexc.record_backtrace true` (or pass -b OCAMLRUNPARAM=b
    to ocamlrun) to start recording backtraces.

 2. Call `Printexc.get_backtrace ()` to get a backtrace, before
    another exception is raised.

 3. From the toplevel, you can say `#record_backtrace true` (which
    calls Printexc.record_backtrace).

 4. From the toplevel, you can say `#debug true` to get backtraces for
    code typed at the prompt or run with `#use`. Code typed at the
    prompt doesn't have useful line numbers though.


To use (OCaml 3.10.x):

 1. Call `Printexc.capture_backtrace true` (or pass -b OCAMLRUNPARAM=b
    to ocamlrun) to start recording backtraces.

 2. Call `Printexc.sprint_backtrace buf` to print a backtrace into a
    buffer, before another exception is raised.

 3. From the toplevel, you can say `#capture_backtrace true` (which
    calls Printexc.capture_backtrace).

 4. From the toplevel, you can say `#debug true` to get backtraces for
    code typed at the prompt or run with `#use`. Code typed at the
    prompt doesn't have useful line numbers though.

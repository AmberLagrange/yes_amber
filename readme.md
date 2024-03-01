[![License: MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg)](https://opensource.org/licenses/MIT)

# yes_amber

I wrote ``yes_amber`` for two reasons.
-   To dip my toes in assembly
-   To write a program that writes to ``stdout`` as fast as possible in a single thread

# Requirements

I wrote it with for ``nasm`` assembler, so you'll probably need that.

``pv`` is just for running the tests, so you don't *need* it, but it is nice to have.

You can instead pipe it through ``dd`` like ``./yes_amber_... | dd of=/dev/null bs=8k COUNT=10M``, but it's finicky about what your blocksize should be. I've found good results with a blocksize equal to that of the about of data given to the write syscall (double that of ``Y_COUNT``).

# Usage

Run the makefile ``make`` and it'll generate ``yes_amber_1_1``. This will write a single ``y\n`` to ``stdout`` per syscall. Very slow, don't do this.

Supplying the makefile with ``Y_COUNT`` will change the amount of ``y``s given to the syscall at once. Much faster (also increases binary size, but w/e).

Supplying the makefile with ``ITER`` will change the number of times it calls the write syscall before looping. Added this because I could; didn't really change the throughput in any meaningful way. You can ignore it, or set to 64 to be cool.

The ``test`` makefile target runs ``./test.sh``, which just iterates through all the ``yes_amber_*`` that have been assembled and runs them through ``pv``.

The ``clean`` target just deletes all the programs. Very novel I know.

### Note

You'll have to manually quit the programs during the test script as ``pv`` will keep running them until ``/dev/null`` is full (if ``/dev/null`` is full, godspeed. I don't know what you did).

# Example Assembling

```bash
$ make
$ make COUNT=4096
$ make COUNT=16384 ITER=64
```

# Results

On my machine I was able to get up to around 11 GiB/s using ``pv`` with this implementation with a count of 16k ``y``s. Any lower/higher gives performance loss.

GNU's ``yes`` program only yields around 9 GiB/s.

Christian Gati's [yes](https://github.com/cgati/yes) (written in Rust btw 🚀🚀🚀) yields around the same throughput as my program.

# FAQ

- Am I going to make this for other platforms? No
- Is this safe? Don't know
- Will I add other ``yes`` features? Heck no
- Hotel? Trivago
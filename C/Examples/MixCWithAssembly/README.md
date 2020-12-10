# Blink LED using C mixing with Assembly

Assembly handles the delay routines.

You can use `make` to compile and upload the code.

**Note**: The `USBPORT` in Makefile is for macOS only, you need to change it if you're using Linux or Windows.

## Requirements
 - [make](https://en.wikipedia.org/wiki/Make_(software))
 - avr-gcc
 - [avrdude](https://www.nongnu.org/avrdude/)

If you're not sure how to install check the [README](/C/Examples/Blink/README.md) in C directory on root of this repo.

## Compile

```
make
```

## Program

```
make install
```

**Note**: You need press reset (on some board you need to press it twice) to put the board in programming mode.

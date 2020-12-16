# Editor Development Environment

This is a guide on how to setup intellisense for C/C++ development for AVR.

This guide assumed you've already followed the [README.md](/C/README.md) install instructions.

## Visual Studio Code

On Visual Studio Code you'll need to download the [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools) extension.

Once you've installed it you can do `command+shift+p` on macOS or `control+shift+p` on Windows/Linux to open the command window and type in

```
C/C++: Edit Configurations (JSON)
```

You don't need to type in everything, it'll just show up. Open it and you'll see something like this

```json
{
  "configurations": [
    {
      "name": "Mac",
      "includePath": [
        "${workspaceFolder}/**"
      ],
      "defines": [],
      "compilerPath": "/usr/local/bin/gcc-10",
      "cStandard": "gnu17",
      "cppStandard": "gnu++14",
      "intelliSenseMode": "gcc-x64"
    }
  ],
  "version": 4
}
```

This will differ depending on what platform you're on. The thing that we're interested in are `"includePath"`, `"compilerPath"` and `"defines"`.

We use `"defines"` to define what device we might be using since it is needed for the `io.h` to work properly.

We need to add another path `"includePath"` that points to where avr includes are located.

### macOS

If you've installed the avr using homebrew tap then you can run this command

```
brew info avr-gcc
```

This will tell you where avr-gcc is installed. It'll look something like this

```
/usr/local/Cellar/avr-gcc/x.x.x
```

`x` are the version installed on your system.

If it's shown like the example above then we can assume that the include path are like this

```
/usr/local/Cellar/avr-gcc/x.x.x/avr/include
```

Add this to the `"includePath"` and we'll get the intellisense.

It is also good to add in `"compilerPath"`. We can use this command to get where the binary is installed

```
which avr-gcc
```

You'll get something like this

```
/usr/local/bin/avr-gcc
```

### Sample config file

```json
{
  "configurations": [
    {
      "name": "Mac",
      "includePath": [
        "${workspaceFolder}/**",
        "/usr/local/Cellar/avr-gcc/x.x.x/avr/include"
      ],
      "defines": ["__AVR_ATmega32U4__"],
      "compilerPath": "/usr/local/bin/avr-gcc",
      "cStandard": "gnu17",
      "cppStandard": "gnu++14",
      "intelliSenseMode": "gcc-x64"
    }
  ],
  "version": 4
}
```
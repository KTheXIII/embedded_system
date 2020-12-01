# Macro in AVR

Macros are a tool that the preprocessor use before compile. The macros are used for writing code that needs to be repeated with different functionality.

## Create and Using Macro

You can create a macro by opening with `.MACRO` and `.ENDMACRO`. Inside it you can use `@` and a number to create a parameter, ex. `@0`, `@1`, `@2`. 

Example:

```asm
.MACRO <macro_name>
  LDI R24, @0
  RCALL delay_ms
.ENDMACRO
```

`<macro_name>` can be anything. `@0` is the parameter. You can pass in a parameter when using the macro like this

```
<macro_name> 32
```

This pass in value `32` to `@0`.
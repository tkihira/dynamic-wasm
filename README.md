# Dynamic wasm creation example

## Live Demo

https://dynamic-wasm.vercel.app/

## What this is

This repository is an example of creating WebAssembly dynamically in JavaScript.

These implementations will show the result of ["A mandelbrot set fractal viewer in brainfuck written by Erik Bosman"](https://github.com/erikdubbelboer/brainfuck-jit/blob/master/mandelbrot.bf).

- JavaScript simple implementation: parsing each character and dealing with it straighforwardly in JavaScript
- JavaScript just-in-time implementation (single function): building a JavaScript function dynamically in JavaScript from BF codes and running the generated code, which is a single huge function (129014 bytes as function body text size)
- JavaScript just-in-time implementation (single function): building a JavaScript function dynamically in JavaScript from BF codes and running the generated code, which has multiple separated functions (688 functions)
- JavaScript just-in-time implementation: building a JavaScript function dynamically in JavaScript from BF codes and running the function
- WebAssembly simple implementation: parsing each character and dealing with it straighforwardly in WebAssembly (written in .wat and compiled to .wasm)
- WebAssembly just-in-time implementation (single function): building a WebAssembly binary dynamically in JavaScript from BF codes and running the generated binary, which is a single huge function (88566 bytes as function body binary size)
- WebAssembly just-in-time implementation (multiple functions): building a WebAssembly binary dynamically in JavaScript from BF codes and running the generated binary, which has multiple separated functions (688 functions and total 98026 bytes)

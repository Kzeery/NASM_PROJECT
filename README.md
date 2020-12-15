# NASM_PROJECT

### What is fproj?

fproj is a command-line application created in NASM x86_64 assembly language that calculates and displays a border array of a given string.  A border of a string **_x_[0.._n_‑1]** of length **_n_** is a substring **_x_[0.._k_]**, **0 = _k_ < _n_‑1** so that **_x_[0..k] = _x_[_n_‑_k_.._n_‑1]**, or, in the proper terminology, that is simultaneously a prefix and a suffix of the string. For illustration, **ababbcd** does not have a border, **ababbca** has a border **a**, the string **abab** has a border **ab**, while **ababa** has a border **a**, and also **aba** .

This application only accepts one string as a command-line argument of maximum length 12. It then displays the border array of the string as shown in some examples below.

```
[user ~/NASM_PROJECT/fproj] ./fproj abcdef
input string: abcdef
border array:0, 0, 0, 0, 0, 0




...  ...  ...  ...  ...  ...  
[user ~/NASM_PROJECT/fproj] ./fproj aaabbbaaa
input string: aaabbbaaa
border array:3, 2, 1, 0, 0, 0, 2, 1, 0




+++
+++  +++                      +++
+++  +++  +++  ...  ...  ...  +++  +++  ...
[user ~/NASM_PROJECT/fproj] ./fproj abcdabcdab
input string: abcdabcdab
border array:6, 5, 4, 3, 2, 1, 0, 0, 0, 0



+++
+++  +++
+++  +++  +++
+++  +++  +++  +++
+++  +++  +++  +++  +++  
+++  +++  +++  +++  +++  +++  ...  ...  ...  ...
```

## What is implemented in fproj?
fproj makes use of the NASM x86_64 assembly language. In its implementation, it makes use of the 16 available registers provided by NASM. It correctly saves and restores all callee-saved registers in each function call. It correctly passes arguments to other functions by pushing data onto the stack. It deals with various arrays, loops, strings, characters, and boolean applications. All in all, it is a complex application that displays my understanding for programming in various assembly languages. 
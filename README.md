# Fortran Tutorial (Quick Start)

## Introduction
This tutorial is designed to provide a quick introduction to Fortran programming, based on the official documentation from [fortran-lang.org](https://fortran-lang.org/). It is suitable for beginners and those looking to refresh their Fortran knowledge.

## Prerequisites
Before you start, make sure you have:
- A basic understanding of programming concepts
- A Fortran compiler installed (e.g., GFortran, Intel Fortran, or NAG Fortran)
- A code editor or IDE (such as VS Code, Emacs, or an integrated terminal)

## Installation
You must have a Fortran compiler installed on your system to compile and run this program. If you don't have one, you can install the GNU Fortran compiler, which is part of the GNU Compiler Collection (GCC).

### On Linux (Ubuntu/Debian)
```sh
sudo apt update && sudo apt install gfortran
```

### On macOS
You can install gfortran using Homebrew or MacPorts.
```sh
brew install gcc
```

### On Windows
You can get native binaries [here](https://www.equation.com/servlet/equation.cmd?fa=fortran) or use Windows Subsystem for Linux (WSL) with a Linux distribution (Recommended).

## Writing Your First Fortran Program
Create a new file called `hello.f90` and add the following code:

```fortran
program hello
    print *, "Hello, Fortran!"
end program hello
```

Save the file and compile it using:
```sh
gfortran hello.f90 -o hello
```
Run the executable:
```sh
./hello
```

You should see the output:
```
 Hello, Fortran!
```

## Topics Covered
- Basic syntax and structure
- Variables and data types
- Control flow (loops and conditionals)
- Arrays and matrices
- Functions and subroutines
- File handling
- Modules and best practices

## References
- [Fortran-lang.org](https://fortran-lang.org/)
- [GNU Fortran Compiler](https://gcc.gnu.org/fortran/)
- [Modern Fortran Style Guide](https://github.com/fortran-lang/style-guide)

## Contributions
Contributions are welcome! Feel free to open an issue or submit a pull request to improve this tutorial.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

---
Happy coding! 🚀
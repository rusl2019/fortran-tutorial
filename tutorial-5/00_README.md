# Organising code structure

Most programming languages allow you to collect commonly-used code into
_procedures_ that can be reused by _calling_ them from other sections of code.

Fortran has two forms of procedure:

- **Subroutine**: invoked by a `call` statement
- **Function**: invoked within an expression or assignment to which it returns a value

Both subroutines and functions have access to variables in the parent scope by _argument association_;
unless the `value` attribute is specified, this is similar to call by reference.
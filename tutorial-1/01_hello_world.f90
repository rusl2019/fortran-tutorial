!
! Fortran is a compiled language, which means that, once written,
! the source code must be passed through a compiler to produce a
! machine executable that can be run.
!
! You must have a Fortran compiler installed on your system to compile
! and run this program. If you don't have one, you can install the
! GNU Fortran compiler, which is part of the GNU Compiler Collection
! (GCC). You can download GCC from the following URL:
!
! - Windows: https://www.equation.com/servlet/equation.cmd?fa=fortran
! - macOS: Homebrew or MacPorts
! - Linux: Use the package manager of your distribution
!          (e.g., sudo apt-get install gfortran)
!
! To compile this program, you can use the following command:
!
!   gfortran -o hello_world hello_world.f90
!

program main

   print*, "Hello, World!"

end program main

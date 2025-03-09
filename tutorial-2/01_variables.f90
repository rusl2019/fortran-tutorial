!
! Variables store information that can be manipulated by the program.
! Fortran is a strongly typed language, which means that each variable must
! have a type.
!
! There are 5 built-in data types in Fortran:
!   - integer – for data that represent whole numbers, positive or negative
!   - real – for floating-point data (not a whole number)
!   - complex – pair consisting of a real part and an imaginary part
!   - character – for text data
!   - logical – for data that represent boolean (true or false) values
!
! Fortran is a statically typed language, which means the type of each variable
! is fixed when the program is compiled—variable types cannot change while the
! program is running.
!
! The syntax for declaring variables is:
! <variable_type> :: <variable_name>, <variable_name>, ...
!

program main
   implicit none

   ! Declare some variables of different types
   integer :: amount
   real :: pi, e ! two `real` variables declared
   complex :: frequency
   character :: initial
   logical :: isOkay

   amount = 10
   pi = 3.1415927
   frequency = (1.0, -0.5)
   initial = 'A'
   isOkay = .false.

   ! Print the values of the variables
   print *, 'The value of amount (integer) is: ', amount
   print *, 'The value of pi (real) is: ', pi
   print *, 'The value of frequency (complex) is: ', frequency
   print *, 'The value of initial (character) is: ', initial
   print *, 'The value of isOkay (logical) is: ', isOkay

end program main

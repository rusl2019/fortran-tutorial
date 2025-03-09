!
! In our Hello World example, we printed text to the command window. This is
! commonly referred to as writing to standard output or stdout.
!
! In a similar way, we can read values from the command window using the read
! statement:
!

program main
   implicit none
   real :: x, y

   ! This input source is commonly referred to as standard input or stdin.
   print *, 'Please enter two numbers. '
   read(*,*) x, y

   print *, 'The sum and product of the numbers are ', x+y, x*y

end program main

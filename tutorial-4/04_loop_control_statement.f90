!
! Most often than not, loops need to be stopped if a condition is met. Fortran
! provides two executable statements to deal with such cases.
!
! exit is used to quit the loop prematurely. It is usually enclosed inside an if.
!

program main
   implicit none

   integer :: i

   ! loop with exit
   do i = 1, 100
      if (i > 10) then
         exit  ! Stop printing numbers
      end if
      print *, i
   end do

   ! On the other hand, cycle skips whatever is left of the loop and goes into the
   ! next cycle.

   ! loop with cycle
   do i = 1, 10
      if (mod(i, 2) == 0) then
         cycle  ! Don't print even numbers
      end if
      print *, i
   end do
end program main

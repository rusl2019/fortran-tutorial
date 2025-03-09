!
! In the following example, a do loop construct is used to print out the numbers in
! a sequence. The do loop has an integer counter variable which is used to track
! which iteration of the loop is currently executing. In this example we use a common
! name for this counter variable: i.
!
! When we define the start of the do loop, we use our counter variable name followed
! by an equals (=) sign to specify the start value and final value of our counting
! variable.
!

program main
   implicit none

   integer :: i

   ! do loop
   do i = 1, 10
      print *, i
   end do

   ! do loop with skip
   do i = 1, 10, 2
      print *, i  ! Print odd numbers
   end do
end program main

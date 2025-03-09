!
! In the following examples, a conditional if construct is used to print out
! a message to describe the nature of the angle variable:
!

program main
   implicit none

   real :: angle

   angle = 45.0

   ! single branch if
   if (angle < 90.0) then
      print *, 'Angle is acute'
   end if

   ! two-branch if-else
   if (angle < 90.0) then
      print *, 'Angle is acute'
   else
      print *, 'Angle is obtuse'
   end if

   ! multi-branch if-else if-else
   if (angle < 90.0) then
      print *, 'Angle is acute'
   else if (angle < 180.0) then
      print *, 'Angle is obtuse'
   else
      print *, 'Angle is reflex'
   end if
end program main

!
! A condition may be added to a do loop with the while keyword. The loop will be
! executed while the condition given in while() evaluates to `.true.`.
!

program main
   implicit none

   integer :: i

   i = 1

   ! do while() loop
   do while (i < 11)
      print *, i
      i = i + 1
   end do
end program main

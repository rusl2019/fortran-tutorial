!
! A recurring case in any programming language is the use of nested loops.
! Nested loops refer to loops that exist within another loop. Fortran allows
! the programmer to tag or name each loop. If loops are tagged, there are two
! potential benefits:
!
! 1. The readability of the code may be improved (when the naming is meaningful).
! 2. exit and cycle may be used with tags, which allows for very fine-grained control of the loops.
!

program main
   implicit none

   integer :: i, j

   outer_loop: do i = 1, 10
      inner_loop: do j = 1, 10
         if ((j + i) > 10) then  ! Print only pairs of i and j that add up to 10
            cycle outer_loop  ! Go to the next iteration of the outer loop
         end if
         print *, 'I=', i, ' J=', j, ' Sum=', j + i
      end do inner_loop
   end do outer_loop
end program main

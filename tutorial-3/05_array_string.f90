!
! An array of strings can be expressed in Fortran as an array of character variables.
! All elements in a character array have equal length. However, strings of varying
! lengths can be provided as input to the array constructor, as shown in the example
! below. They will be truncated or right-padded with spaces if they are longer or
! shorter, respectively, than the declared length of the character array. Finally,
! we use the intrinsic function trim to remove any excess spaces when printing the values
! to the standard output.
!

program main
   implicit none
   character(len=10), dimension(2) :: keys, vals

   keys = [character(len=10) :: "user", "dbname"]
   vals = [character(len=10) :: "ben", "motivation"]

   call show(keys, vals)

contains

   subroutine show(akeys, avals)
      character(len=*), intent(in) :: akeys(:), avals(:)
      integer                      :: i

      do i = 1, size(akeys)
         print *, trim(akeys(i)), ": ", trim(avals(i))
      end do

   end subroutine show

end program main

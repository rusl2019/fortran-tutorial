!
! The subroutine input arguments, known as dummy arguments, are specified in parentheses
! after the subroutine name; the dummy argument types and attributes are declared
! within the body of the subroutine just like local variables.
!

program main
   implicit none

   real :: mat(10, 20)

   mat(:,:) = 0.0

   call print_matrix(10, 20, mat)

contains

   ! Print matrix A to screen
   subroutine print_matrix(n,m,A)
      implicit none

      ! Note the additional intent attribute when declaring the dummy arguments;
      ! this optional attribute signifies to the compiler whether the argument is
      ! ‘’read-only’’ (intent(in)) ‘’write-only’’ (intent(out)) or ‘’read-write’’
      ! (intent(inout)) within the procedure. In this example, the subroutine does
      ! not modify its arguments, hence all arguments are intent(in).
      integer, intent(in) :: n
      integer, intent(in) :: m
      real, intent(in) :: A(n, m)

      integer :: i

      do i = 1, n
         print *, A(i, 1:m)
      end do

   end subroutine print_matrix
end program main

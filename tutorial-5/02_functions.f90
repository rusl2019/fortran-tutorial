program main
   implicit none

   real :: v(9)

   v(:) = 9

   print *, 'Vector norm = ', vector_norm(9,v)

contains

   ! L2 Norm of a vector
   function vector_norm(n,vec) result(norm)
      implicit none
      ! In production code, the intrinsic function norm2 should be used.
      integer, intent(in) :: n
      real, intent(in) :: vec(n)
      real :: norm

      norm = sqrt(sum(vec**2))

   end function vector_norm
end program main

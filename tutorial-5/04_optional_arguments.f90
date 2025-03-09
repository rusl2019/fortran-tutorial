!
! An advantage of placing subroutines and functions in modules is that they can have
! optional arguments. In a procedure with an argument declared optional, the present
! function is used to test if the argument was set in the caller. Optional arguments
! that are not present may not be accessed within the procedure. Here is a generalization
! of the vector_norm function that can use powers other than 2 to compute the Lp norm.
!

module norm_mod
   implicit none
contains
   function vector_norm(vec,p) result(norm)
      real, intent(in) :: vec(:)
      integer, intent(in), optional :: p ! power
      real :: norm
      if (present(p)) then ! compute Lp norm
         norm = sum(abs(vec)**p) ** (1.0/p)
      else ! compute L2 norm
         norm = sqrt(sum(vec**2))
      end if
   end function vector_norm
end module norm_mod

program run_fcn
   use norm_mod
   implicit none

   real :: v(9)

   v(:) = 9

   print *, 'Vector norm = ', vector_norm(v), vector_norm(v,2)
   print *, 'L1 norm = ', vector_norm(v,1)

end program run_fcn

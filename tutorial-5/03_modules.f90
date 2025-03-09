!
! Fortran modules contain definitions that are made accessible to programs, procedures,
! and other modules through the use statement. They can contain data objects, type
! definitions, procedures, and interfaces.
!
! - Modules allow controlled scoping extension whereby entity access is made explicit
! - Modules automatically generate explicit interfaces required for modern procedures
!

module my_mod
   implicit none

   private  ! All entities are now module-private by default
   public public_var, print_matrix  ! Explicitly export public entities

   real, parameter :: public_var = 2
   integer :: private_var

contains

   ! Print matrix A to screen
   subroutine print_matrix(A)
      real, intent(in) :: A(:,:)  ! An assumed-shape dummy argument

      integer :: i

      do i = 1, size(A,1)
         print *, A(i,:)
      end do

   end subroutine print_matrix

end module my_mod

!
! Compare this print_matrix subroutine with that written outside of a module. We no
! longer have to explicitly pass the matrix dimensions and can instead take advantage
! of assumed-shape arguments since the module will generate the required explicit
! interface for us. This results in a much simpler subroutine interface.
!
! To use the module within a program:
!

program use_mod
   use my_mod
   ! explicit import list
   ! use my_mod, only: public_var
   ! aliased import
   ! use my_mod, only: printMat=>print_matrix

   implicit none

   real :: mat(10, 10)

   mat(:,:) = public_var

   call print_matrix(mat)

end program use_mod

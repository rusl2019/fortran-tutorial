!
! So far we have specified the size of our array in our program code—this type
! of array is known as a static array since its size is fixed when we compile
! our program.
!
! Quite often, we do not know how big our array needs to be until we run our
! program, for example, if we are reading data from a file of unknown size.
!
! For this problem, we need allocatable arrays. These are allocated while the
! program is running once we know how big the array needs to be.
!

program main
   implicit none

   integer, allocatable :: array1(:)
   integer, allocatable :: array2(:,:)

   allocate(array1(10))
   allocate(array2(10,10))

   ! ...

   deallocate(array1)
   deallocate(array2)

end program main

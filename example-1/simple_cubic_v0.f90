PROGRAM main

   IMPLICIT NONE

   integer :: i, j, k, naxis, natom
   double precision :: x, y, z, dr
   character(len=2) :: atom_type

   dr = 2.81d0
   atom_type = "Na"

   naxis=10
   natom=naxis*naxis*naxis ! natom=naxis**3

   open(unit=99, file="output.xyz")
   write (99,*) natom
   write (99,*) ""

   do k = 1, naxis
      do j = 1, naxis
         do i = 1, naxis
            x = (i-1)*dr
            y = (j-1)*dr
            z = (k-1)*dr
            write (99,*) "Na", x, y, z
         end do
      end do
   end do

   close(99)

CONTAINS

END PROGRAM main

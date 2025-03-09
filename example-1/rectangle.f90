PROGRAM main

   IMPLICIT NONE

   integer :: i, j, naxis, natom
   double precision :: x, y, dr

   dr = 2.81d0

   naxis=100
   natom=naxis*naxis

   open(unit=99, file="output.txt")
   write (99,*) natom
   write (99,*) ""

   do j = 1, naxis
      do i = 1, naxis
         x = (i-1)*dr
         y = (j-1)*dr
         write (99,*) "Na", x, y
      end do
   end do

   close(99)

CONTAINS


END PROGRAM main

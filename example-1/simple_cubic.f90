program main

   use iso_fortran_env, only: real64

   implicit none

   ! ============================================================
   ! Constants
   ! ============================================================
   integer, parameter :: lattice_size = 8                      ! Default lattice size

   real(real64), parameter :: avogadro = 6.02214076e23_real64  ! atoms/mol
   real(real64), parameter :: cm3_to_a3 = 1.0e24_real64        ! cm^3 to A^3 conversion
   real(real64), parameter :: atomic_mass = 39.948_real64      ! g/mol

   character(len=2), parameter :: atom_type = 'Ar'             ! Argon

   ! ============================================================
   ! Variables
   ! ============================================================
   integer :: i, j, k
   integer :: n_atoms

   real(real64) :: density
   real(real64) :: lattice_constant
   real(real64) :: x, y, z
   real(real64) :: lx, ly, lz

   ! ============================================================
   ! Get user input
   ! ============================================================
   print *, 'Enter the density (in g/cm³):'
   read *, density

   if (density <= 0.0_real64) then
      print *, 'Error: density must be greater than zero.'
      stop
   end if


   ! ============================================================
   ! Calculate lattice constant (in A)
   ! ============================================================
   lattice_constant = (atomic_mass / (density * avogadro) * cm3_to_a3) ** (1.0_real64/3.0_real64)

   ! ============================================================
   ! Calculate simulation box dimensions
   ! ============================================================
   lx = real(lattice_size, real64) * lattice_constant
   ly = real(lattice_size, real64) * lattice_constant
   lz = real(lattice_size, real64) * lattice_constant

   ! ============================================================
   ! Calculate total number of atoms
   ! ============================================================
   n_atoms = lattice_size * lattice_size * lattice_size

   ! ============================================================
   ! Open output file
   ! ============================================================
   open(unit=10, file='cubic_argon.xyz', status='replace', action='write')

   ! ============================================================
   ! Write XYZ header
   ! ============================================================
   write(10, '(I5)') n_atoms

   write(10, '(3F12.5)') lx, ly, lz

   ! ============================================================
   ! Generate and write coordinates
   ! ============================================================
   do i = 0, lattice_size - 1
      do j = 0, lattice_size - 1
         do k = 0, lattice_size - 1
            x = real(i, real64) * lattice_constant
            y = real(j, real64) * lattice_constant
            z = real(k, real64) * lattice_constant

            write(10, '(A2, 3F10.4)') atom_type, x, y, z
         end do
      end do
   end do

   ! ============================================================
   ! Close file
   ! ============================================================
   close(10)

   print *, 'XYZ file "cubic_argon.xyz" has been generated with', n_atoms, 'atoms'
   print *, 'Calculated lattice constant:', lattice_constant, 'A'

end program main

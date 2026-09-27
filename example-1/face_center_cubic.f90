program main

   use iso_fortran_env, only: real64

   implicit none

   ! ============================================================
   ! Constants
   ! ============================================================
   integer, parameter :: lattice_size = 8

   real(real64), parameter :: avogadro = 6.02214076e23_real64
   real(real64), parameter :: cm3_to_a3 = 1.0e24_real64
   real(real64), parameter :: atomic_mass = 39.948_real64

   character(len=2), parameter :: atom_type = 'Ar'

   ! ============================================================
   ! Variables
   ! ============================================================
   integer :: i, j, k, b
   integer :: n_atoms

   real(real64) :: density
   real(real64) :: lattice_constant
   real(real64) :: x, y, z
   real(real64) :: lx, ly, lz

   ! Fractional coordinates of FCC basis atoms
   real(real64), dimension(4,3) :: basis

   ! ============================================================
   ! FCC basis
   !
   ! Atom 1 : (0,   0,   0)
   ! Atom 2 : (0,   1/2, 1/2)
   ! Atom 3 : (1/2, 0,   1/2)
   ! Atom 4 : (1/2, 1/2, 0)
   ! ============================================================
   basis(1,:) = [0.0_real64, 0.0_real64, 0.0_real64]
   basis(2,:) = [0.0_real64, 0.5_real64, 0.5_real64]
   basis(3,:) = [0.5_real64, 0.0_real64, 0.5_real64]
   basis(4,:) = [0.5_real64, 0.5_real64, 0.0_real64]

   ! ============================================================
   ! Get user input
   ! ============================================================
   print *, 'Enter the density (in g/cm^3):'
   read *, density

   if (density <= 0.0_real64) then
      print *, 'Error: density must be greater than zero.'
      stop
   end if

   ! ============================================================
   ! Calculate lattice constant
   !
   ! FCC has 4 atoms per unit cell:
   !
   ! rho = (4 * atomic_mass) / (avogadro * a^3)
   !
   ! Therefore:
   !
   ! a = [(4*M)/(rho*N_A)]^(1/3)
   !
   ! cm^3 -> A^3 uses factor 1.0e24
   ! ============================================================
   lattice_constant = (4.0_real64 * atomic_mass / (density * avogadro) * cm3_to_a3) ** (1.0_real64 / 3.0_real64)

   ! ============================================================
   ! Calculate simulation box dimensions
   ! ============================================================
   lx = real(lattice_size, real64) * lattice_constant
   ly = real(lattice_size, real64) * lattice_constant
   lz = real(lattice_size, real64) * lattice_constant

   ! ============================================================
   ! Calculate total number of atoms
   !
   ! 4 atoms per FCC unit cell
   ! ============================================================
   n_atoms = 4 * lattice_size * lattice_size * lattice_size

   ! ============================================================
   ! Open output file
   ! ============================================================
   open(unit=10, file='fcc_argon.xyz', status='replace', action='write')

   ! ============================================================
   ! Write XYZ header
   ! ============================================================
   write(10, '(I5)') n_atoms

   write(10, '(3F12.5)') lx, ly, lz

   ! ============================================================
   ! Generate FCC lattice
   ! ============================================================
   do i = 0, lattice_size - 1
      do j = 0, lattice_size - 1
         do k = 0, lattice_size - 1
            do b = 1, 4
               x = (real(i, real64) + basis(b,1)) * lattice_constant
               y = (real(j, real64) + basis(b,2)) * lattice_constant
               z = (real(k, real64) + basis(b,3)) * lattice_constant

               write(10, '(A2, 3F10.4)') atom_type, x, y, z
            end do
         end do
      end do
   end do

   ! ============================================================
   ! Close file
   ! ============================================================
   close(10)

   print *, 'XYZ file "fcc_argon.xyz" has been generated with', n_atoms, 'atoms'
   print *, 'Calculated lattice constant:', lattice_constant, 'A'


end program main

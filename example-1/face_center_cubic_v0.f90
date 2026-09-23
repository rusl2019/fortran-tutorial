program main
   implicit none

   ! Variable declarations
   integer :: i, j, k, n_atoms
   integer, parameter :: lattice_size = 8           ! Default lattice size
   real :: density, lattice_constant, x, y, z
   real :: lx, ly, lz                               ! Box dimensions
   real, parameter :: avogadro = 6.02214076e23      ! atoms/mol
   real, parameter :: cm3_to_a3 = 1.0e24            ! cm^3 to A^3 conversion
   real, parameter :: atomic_mass = 39.948e0        ! g/mol
   real, parameter :: epsilon = 1.003e0             ! LJ parameter for Ar (kJ/mol)
   real, parameter :: sigma = 3.4                   ! LJ parameter for Ar (Å)
   character(len=2), parameter :: atom_type = 'Ar'  ! Argon

   ! Get user input
   print *, 'Enter the density (in g/cm³):'
   read *, density

   ! Initial lattice constant for FCC (4 atoms per unit cell)
   lattice_constant = (4.0 * atomic_mass / (density * avogadro) * cm3_to_a3) ** (1.0/3.0)

   ! Optimize lattice constant for FCC
   call optimize_lattice(lattice_constant)

   ! Calculate total number of atoms (4 atoms per conventional cubic cell)
   n_atoms = 4 * lattice_size * lattice_size * lattice_size

   ! Calculate box dimensions
   lx = lattice_size * lattice_constant
   ly = lattice_size * lattice_constant
   lz = lattice_size * lattice_constant

   ! Open output file
   open(unit=10, file='fcc_argon.xyz', status='replace')

   ! Write XYZ header with box dimensions
   write(10, '(I5)') n_atoms
   write(10, '(A,F6.4,A,F6.4,A,3F10.4)') 'Optimized FCC argon lattice: density=', density, &
      ' g/cm³, a=', lattice_constant, ' A, Lx Ly Lz=', lx, ly, lz

   ! Generate and write FCC coordinates
   call generate_fcc(lattice_size, lattice_constant, atom_type)

   ! Close file
   close(10)

   ! Print results
   print *, 'XYZ file "fcc_argon.xyz" has been generated with', n_atoms, 'atoms'
   print *, 'Optimized lattice constant:', lattice_constant, 'A'
   print *, 'Box dimensions (Å): Lx =', lx, 'Ly =', ly, 'Lz =', lz

contains

   !----------------------------------------------------------------------
   ! Subroutine untuk menghasilkan konfigurasi Face-Centered Cubic (FCC)
   !----------------------------------------------------------------------
   subroutine generate_fcc(n, a, atom)
      integer, intent(in) :: n
      real, intent(in)    :: a
      character(len=2), intent(in) :: atom
      integer :: i, j, k
      real :: x, y, z

      ! Basis FCC (4 atom per sel satuan)
      ! 1. (0, 0, 0)
      ! 2. (0.5, 0.5, 0)
      ! 3. (0.5, 0, 0.5)
      ! 4. (0, 0.5, 0.5)

      do i = 0, n - 1
         do j = 0, n - 1
            do k = 0, n - 1
               ! Atom 1: corner
               x = i * a
               y = j * a
               z = k * a
               write(10, '(A2, 3F10.4)') atom, x, y, z

               ! Atom 2: face center xy
               x = (i + 0.5) * a
               y = (j + 0.5) * a
               z = k * a
               write(10, '(A2, 3F10.4)') atom, x, y, z

               ! Atom 3: face center xz
               x = (i + 0.5) * a
               y = j * a
               z = (k + 0.5) * a
               write(10, '(A2, 3F10.4)') atom, x, y, z

               ! Atom 4: face center yz
               x = i * a
               y = (j + 0.5) * a
               z = (k + 0.5) * a
               write(10, '(A2, 3F10.4)') atom, x, y, z
            end do
         end do
      end do
   end subroutine generate_fcc

   !----------------------------------------------------------------------
   ! Optimasi lattice constant untuk FCC (12 nearest neighbors)
   !----------------------------------------------------------------------
   subroutine optimize_lattice(a)
      real, intent(inout) :: a
      real :: energy, new_energy, grad
      real :: r, r6, r12
      integer :: iter, max_iter, n_neighbors
      real, parameter :: tol = 1.0e-5
      real, parameter :: alpha = 0.01
      real, parameter :: sqrt2 = sqrt(2.0)

      max_iter = 1000
      n_neighbors = 12          ! FCC has 12 nearest neighbors

      do iter = 1, max_iter
         ! Nearest neighbor distance in FCC = a / √2
         r = a / sqrt2
         r6 = (sigma/r)**6
         r12 = r6*r6

         energy = 4.0 * epsilon * (r12 - r6) * n_neighbors
         grad   = 4.0 * epsilon * (-12.0*r12/r + 6.0*r6/r) * n_neighbors * (1.0/sqrt2)

         ! Gradient descent step
         a = a - alpha * grad

         ! New energy
         r = a / sqrt2
         r6 = (sigma/r)**6
         r12 = r6*r6
         new_energy = 4.0 * epsilon * (r12 - r6) * n_neighbors

         if (abs(new_energy - energy) < tol) exit
         energy = new_energy
      end do

      if (iter >= max_iter) then
         print *, 'Warning: Optimization did not converge'
      else
         print *, 'Optimization converged after', iter, 'iterations'
         print *, 'Final energy per atom:', energy/n_neighbors, 'kJ/mol'
         print *, 'Nearest neighbor distance:', a/sqrt2, 'A'
      end if
   end subroutine optimize_lattice

end program main

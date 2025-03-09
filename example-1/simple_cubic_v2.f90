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

   ! Initial lattice constant calculation
   lattice_constant = (atomic_mass / (density * avogadro) * cm3_to_a3) ** (1.0/3.0)

   ! Optimize lattice constant
   call optimize_lattice(lattice_constant)

   ! Calculate total number of atoms
   n_atoms = lattice_size * lattice_size * lattice_size

   ! Calculate box dimensions
   lx = lattice_size * lattice_constant
   ly = lattice_size * lattice_constant
   lz = lattice_size * lattice_constant

   ! Open output file
   open(unit=10, file='cubic_argon.xyz', status='replace')

   ! Write XYZ header with box dimensions
   write(10, '(I5)') n_atoms
   write(10, '(A,F6.4,A,F6.4,A,3F10.4)') 'Optimized cubic argon lattice: density=', density, &
      ' g/cm³, a=', lattice_constant, ' A, Lx Ly Lz=', lx, ly, lz

   ! Generate and write coordinates
   do i = 0, lattice_size - 1
      do j = 0, lattice_size - 1
         do k = 0, lattice_size - 1
            x = i * lattice_constant
            y = j * lattice_constant
            z = k * lattice_constant
            write(10, '(A2, 3F10.4)') atom_type, x, y, z
         end do
      end do
   end do

   ! Close file
   close(10)

   ! Print results
   print *, 'XYZ file "cubic_argon.xyz" has been generated with', n_atoms, 'atoms'
   print *, 'Optimized lattice constant:', lattice_constant, 'A'
   print *, 'Box dimensions (Å): Lx =', lx, 'Ly =', ly, 'Lz =', lz

contains

   subroutine optimize_lattice(a)
      real, intent(inout) :: a
      real :: energy, new_energy, grad
      real :: r, r6, r12
      integer :: iter, max_iter, n_neighbors
      real, parameter :: tol = 1.0e-5
      real, parameter :: alpha = 0.01

      max_iter = 1000
      n_neighbors = 6

      do iter = 1, max_iter
         ! Calculate energy and gradient for current lattice constant
         energy = 0.0
         grad = 0.0

         ! Simple cubic nearest neighbor contribution (6 neighbors)
         r = a
         r6 = (sigma/r)**6
         r12 = r6*r6
         energy = 4.0 * epsilon * (r12 - r6) * n_neighbors  ! 6 nearest neighbors
         grad = 4.0 * epsilon * (-12.0*r12/r + 6.0*r6/r) * n_neighbors  ! Corrected gradient

         ! Take a step
         a = a - alpha * grad

         ! Calculate new energy
         r = a
         r6 = (sigma/r)**6
         r12 = r6*r6
         new_energy = 4.0 * epsilon * (r12 - r6) * n_neighbors

         ! Check convergence
         if (abs(new_energy - energy) < tol) exit

         energy = new_energy
      end do

      if (iter >= max_iter) then
         print *, 'Warning: Optimization did not converge'
      else
         print *, 'Optimization converged after', iter, 'iterations'
         print *, 'Final energy per atom:', energy/n_neighbors, 'kJ/mol'
      end if
   end subroutine optimize_lattice

end program main

program main
   implicit none

   ! Variable declarations
   integer :: i, j, k, n_atoms
   integer, parameter :: lattice_size = 8           ! Default lattice size
   real :: density, lattice_constant, x, y, z
   real, parameter :: avogadro = 6.02214076e23      ! atoms/mol
   real, parameter :: cm3_to_a3 = 1.0e24            ! cm^3 to A^3 conversion
   real, parameter :: atomic_mass = 39.948e0        ! g/mol
   character(len=2), parameter :: atom_type = 'Ar'  ! Argon

   ! Get user input
   print *, 'Enter the density (in g/cm³):'
   read *, density

   ! Calculate lattice constant (in A)
   lattice_constant = (atomic_mass / (density * avogadro) * cm3_to_a3) ** (1.0/3.0)

   ! Calculate total number of atoms
   n_atoms = lattice_size * lattice_size * lattice_size

   ! Open output file
   open(unit=10, file='cubic_argon.xyz', status='replace')

   ! Write XYZ header
   write(10, '(I5)') n_atoms
   write(10, '(A,F6.4,A,F6.4,A)') 'Simple cubic argon lattice: density=', density, &
      ' g/cm³, a=', lattice_constant, ' A'

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

   print *, 'XYZ file "cubic_argon.xyz" has been generated with', n_atoms, 'atoms'
   print *, 'Calculated lattice constant:', lattice_constant, 'A'

end program main

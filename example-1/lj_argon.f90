program lj_energy_argon

   use iso_fortran_env, only: real64

   implicit none

   ! ============================================================
   ! Constants
   ! ============================================================
   real(real64), parameter :: sigma   = 3.405_real64       ! in Angstrom
   real(real64), parameter :: epsilon = 0.996_real64       ! in kJ/mol
   real(real64), parameter :: rcut    = 2.5_real64 * sigma ! in Angstrom

   ! ============================================================
   ! Variables
   ! ============================================================
   integer :: n_atoms

   real(real64) :: lx, ly, lz
   real(real64), allocatable :: x(:), y(:), z(:)
   real(real64) :: total_energy

   character(len=100) :: filename

   ! ============================================================
   ! Main program
   ! ============================================================
   ! 1. Input file name
   print *, "Enter XYZ filename (example: argon.xyz):"
   read *, filename

   ! 2. Call subroutine to read data
   call read_xyz_file(filename)

   ! 3. Call function to calculate energy
   total_energy = compute_lj_energy()

   ! 4. Display results
   print *, "========================================="
   print *, "          CALCULATION RESULTS"
   print *, "========================================="
   print *, " Number of Argon Atoms : ", n_atoms
   print *, " Potential Energy      : ", total_energy, " kJ/mol"
   print *, " Potential Energy/Atom : ", total_energy/n_atoms, " kJ/mol"
   print *, "========================================="

   ! ============================================================
   ! Free memory before exit
   ! ============================================================
   deallocate(x, y, z)

contains

   ! =====================================================================
   ! SUBROUTINE: Read XYZ coordinate file
   ! =====================================================================
   subroutine read_xyz_file(filename)
      character(len=*), intent(in) :: filename

      integer :: i
      character(len=2) :: atom_symbol

      open(unit=10, file=trim(filename), status='old', action='read')

      read(10, *) n_atoms
      read(10, *) lx, ly, lz

      ! Dynamically allocate arrays
      allocate(x(n_atoms), y(n_atoms), z(n_atoms))

      do i = 1, n_atoms
         read(10, *) atom_symbol, x(i), y(i), z(i)
      end do

      close(10)
   end subroutine read_xyz_file


   ! =====================================================================
   ! FUNCTION: Compute total Lennard-Jones potential energy
   ! =====================================================================
   function compute_lj_energy() result(total_energy)
      real(real64) :: total_energy

      integer :: i, j
      real(real64) :: dx, dy, dz
      real(real64) :: r2, r2_inv, r6_inv, r12_inv
      real(real64) :: pair_energy
      real(real64) :: rcut2

      rcut2 = rcut * rcut
      total_energy = 0.0_real64

      do i = 1, n_atoms - 1
         do j = i + 1, n_atoms

            ! --- Minimum Image Convention ---
            dx = x(i) - x(j)
            dy = y(i) - y(j)
            dz = z(i) - z(j)

            dx = dx - lx * nint(dx / lx)
            dy = dy - ly * nint(dy / ly)
            dz = dz - lz * nint(dz / lz)

            r2 = dx*dx + dy*dy + dz*dz

            ! --- Cutoff ---
            if (r2 < rcut2 .and. r2 > 0.0_real64) then
               r2_inv  = (sigma * sigma) / r2
               r6_inv  = r2_inv * r2_inv * r2_inv
               r12_inv = r6_inv * r6_inv

               pair_energy = 4.0_real64 * epsilon * (r12_inv - r6_inv)
               total_energy = total_energy + pair_energy
            end if

         end do
      end do
   end function compute_lj_energy

end program lj_energy_argon

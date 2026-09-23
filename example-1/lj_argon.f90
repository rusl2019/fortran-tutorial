program lj_energy_argon
    implicit none

    ! Definisi jenis data dan parameter fisik (Global untuk program ini)
    integer, parameter :: dp = selected_real_kind(15, 307)
    real(dp), parameter :: sigma = 3.405_dp       ! dalam Angstrom
    real(dp), parameter :: epsilon = 0.996_dp     ! dalam kJ/mol
    real(dp), parameter :: rcut = 2.5_dp * sigma  ! dalam Angstrom

    ! Variabel utama
    character(len=100) :: filename
    integer :: n_atoms
    real(dp) :: lx, ly, lz
    real(dp), allocatable :: x(:), y(:), z(:)
    real(dp) :: total_energy
    logical :: success

    ! 1. Input nama file
    print *, "Masukkan nama file XYZ (contoh: argon.xyz):"
    read *, filename

    ! 2. Panggil subroutine untuk membaca data
    call read_xyz_file(filename, x, y, z, n_atoms, lx, ly, lz, success)
    if (.not. success) stop

    ! 3. Panggil function untuk kalkulasi energi
    total_energy = compute_lj_energy(n_atoms, x, y, z, lx, ly, lz, rcut)

    ! 4. Tampilkan Hasil
    print *, "========================================="
    print *, "          HASIL PERHITUNGAN              "
    print *, "========================================="
    print '(A, I6)', " Jumlah Atom Argon : ", n_atoms
    print '(A, F15.4, A)', " Energi Potensial  : ", total_energy, " kJ/mol"
    print '(A, F15.4, A)', " Energi Potensial / Atom  : ", total_energy/n_atoms, " kJ/mol"
    print *, "========================================="

    ! Bersihkan memori sebelum selesai
    deallocate(x, y, z)

contains

    ! =====================================================================
    ! SUBROUTINE: Membaca file koordinat XYZ
    ! =====================================================================
    subroutine read_xyz_file(filename, x, y, z, n_atoms, lx, ly, lz, success)
        character(len=*), intent(in) :: filename
        real(dp), allocatable, intent(out) :: x(:), y(:), z(:)
        real(dp), intent(out) :: lx, ly, lz
        integer, intent(out) :: n_atoms
        logical, intent(out) :: success

        integer :: io_stat, i
        character(len=100) :: comment_line
        character(len=2) :: atom_symbol
        logical :: file_exists

        success = .false.

        ! Validasi file
        inquire(file=trim(filename), exist=file_exists)
        if (.not. file_exists) then
            print *, "Error: File '", trim(filename), "' tidak ditemukan!"
            return
        end if

        open(unit=10, file=trim(filename), status='old', action='read', iostat=io_stat)
        if (io_stat /= 0) return

        ! Proses membaca
        read(10, *) n_atoms
        read(10, *) lx, ly, lz

        ! Alokasi array secara dinamis
        allocate(x(n_atoms), y(n_atoms), z(n_atoms))

        do i = 1, n_atoms
            read(10, *) atom_symbol, x(i), y(i), z(i)
        end do

        close(10)
        success = .true.
    end subroutine read_xyz_file


    ! =====================================================================
    ! FUNCTION: Menghitung energi potensial total Lennard-Jones
    ! =====================================================================
    function compute_lj_energy(n_atoms, x, y, z, Lx, Ly, Lz, rcut) result(total_energy)
        integer, intent(in) :: n_atoms
        real(dp), intent(in) :: x(:), y(:), z(:)
        real(dp), intent(in) :: Lx, Ly, Lz, rcut
        real(dp) :: total_energy
    
        integer :: i, j
        real(dp) :: dx, dy, dz, r2, r2_inv, r6_inv, r12_inv, pair_energy
        real(dp) :: rcut2
    
        rcut2 = rcut * rcut
        total_energy = 0.0_dp
    
        do i = 1, n_atoms - 1
            do j = i + 1, n_atoms
    
                ! --- Minimum Image Convention ---
                dx = x(i) - x(j)
                dy = y(i) - y(j)
                dz = z(i) - z(j)
    
                dx = dx - Lx * nint(dx / Lx)
                dy = dy - Ly * nint(dy / Ly)
                dz = dz - Lz * nint(dz / Lz)
    
                r2 = dx*dx + dy*dy + dz*dz
    
                ! --- Cutoff ---
                if (r2 < rcut2 .and. r2 > 0.0_dp) then
                    r2_inv  = (sigma * sigma) / r2
                    r6_inv  = r2_inv * r2_inv * r2_inv
                    r12_inv = r6_inv * r6_inv
    
                    pair_energy = 4.0_dp * epsilon * (r12_inv - r6_inv)
                    total_energy = total_energy + pair_energy
                end if
    
            end do
        end do
    end function compute_lj_energy

end program lj_energy_argon

# Compiler and flags
FC      := gfortran
FFLAGS  := -O2 -Wall -Wextra -fcheck=all -g
LDFLAGS :=

# Source files and executables
SRCS    := face_center_cubic.f90 lj_argon.f90 simple_cubic.f90
EXES    := $(SRCS:.f90=)

# Default target
.PHONY: all clean help
all: $(EXES)

# Pattern rule: compile each .f90 into executable
%: %.f90
	$(FC) $(FFLAGS) $< -o $@ $(LDFLAGS)

# Clean build artifacts
clean:
	rm -f $(EXES) *.o *.mod *.xyz

# Help message
help:
	@echo "Available targets:"
	@echo "  all     - Build all programs (default)"
	@echo "  clean   - Remove executables and temporary files"
	@echo "  help    - Show this help message"
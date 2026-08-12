add_subdirectory(803.sph_exa_s)    # C++
add_subdirectory(809.cactus_s)     # C++, C      (ORIGIN 709.cactus_r)
add_subdirectory(811.tealeaf_s)    # C
add_subdirectory(816.nab_s)        # C
add_subdirectory(857.namd_s)       # C++
add_subdirectory(867.nest_s)       # C++, C      (ORIGIN 767.nest_r)
add_subdirectory(872.marian_s)     # C++         (ORIGIN 772.marian_r)
add_subdirectory(881.neutron_s)    # C

# The suite is built serial: SpecCPU2026.cmake defines SPEC_SUPPRESS_OPENMP for
# every SPEED benchmark, so the OpenMP regions in 803.sph_exa_s, 809.cactus_s,
# 811.tealeaf_s, 816.nab_s, 857.namd_s, 867.nest_s and 881.neutron_s compile as
# ordinary loops. See the SPEED block there for why.
#
# Not here, on purpose:
#
#   800.pot3d_s, 820.cloverleaf_s, 822.palm_s, 849.fotonik3d_s, 865.roms_s
#       Fortran, not ported.
#
#   998.specrand_s  fpspeed and intspeed share one specrand in SPEC CPU 2026;
#       CINT2026speed builds it.

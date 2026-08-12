add_subdirectory(801.xz_s)         # C++, C
add_subdirectory(807.ntest_s)      # C++         (ORIGIN 707.ntest_r)
add_subdirectory(817.flac_s)       # C++, C
add_subdirectory(821.gcc_s)        # C++, C      (ORIGIN 721.gcc_r)
add_subdirectory(823.llvm_s)       # C++, C      (ORIGIN 723.llvm_r)
add_subdirectory(827.cppcheck_s)   # C++         (ORIGIN 727.cppcheck_r)
add_subdirectory(829.abc_s)        # C++, C      (ORIGIN 729.abc_r)
add_subdirectory(834.vpr_s)        # C++, C      (ORIGIN 734.vpr_r)
add_subdirectory(835.gem5_s)       # C++, C      (ORIGIN 735.gem5_r)
add_subdirectory(838.diamond_s)    # C++, C
add_subdirectory(846.minizinc_s)   # C++, C
add_subdirectory(853.ns3_s)        # C++         (ORIGIN 753.ns3_r)
add_subdirectory(854.graph500_s)   # C
add_subdirectory(998.specrand_s)   # C++, C      (ORIGIN 999.specrand_r)

# The suite is built serial: SpecCPU2026.cmake defines SPEC_SUPPRESS_OPENMP for
# every SPEED benchmark, so 854.graph500_s's OpenMP regions compile as ordinary
# loops. See the SPEED block there for why.
#
# intspeed_no_fortran.bset is byte-for-byte identical to intspeed.bset in SPEC
# CPU 2026 v1.0.1, so nothing is missing from this list.

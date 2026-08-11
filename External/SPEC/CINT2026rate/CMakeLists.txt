if (TEST_SUITE_CLANGIR_ENABLE)
  message(STATUS "Enabling ClangIR for SPEC tests")
  add_compile_options(
    $<$<COMPILE_LANGUAGE:C>:-fclangir>
    $<$<COMPILE_LANGUAGE:CXX>:-fclangir>
  )
endif()

add_subdirectory(706.stockfish_r)   # C++
add_subdirectory(707.ntest_r)       # C++
add_subdirectory(708.sqlite_r)      # C
add_subdirectory(710.omnetpp_r)     # C++, C
add_subdirectory(714.cpython_r)     # C
add_subdirectory(721.gcc_r)         # C++, C
add_subdirectory(723.llvm_r)        # C++, C
add_subdirectory(727.cppcheck_r)    # C++
add_subdirectory(729.abc_r)         # C++, C
add_subdirectory(734.vpr_r)         # C++, C
add_subdirectory(735.gem5_r)        # C++, C
add_subdirectory(750.sealcrypto_r)  # C++, C
add_subdirectory(753.ns3_r)         # C++
add_subdirectory(777.zstd_r)        # C
add_subdirectory(999.specrand_r)    # C++, C

# CINT2026rate has no Fortran benchmark, so there is nothing here behind
# TEST_SUITE_FORTRAN. intrate_no_fortran.bset is byte-for-byte identical to
# intrate.bset in SPEC CPU 2026 v1.0.1.

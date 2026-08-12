# 782.lbm_r
# Generated from SPEC's own runcpu build and setup logs by
# clangir-upstream-report/spec2026-overlay/gen-cmakelists.py, then
# reviewed by hand. Sources, -D/-I flags and RUN lines are exactly what
# runcpu used for tune=base.
include(../../SpecCPU2026.cmake)
if (NOT TEST_SUITE_SPEC2026_ROOT)
  return ()
endif ()

speccpu2026_benchmark(RATE)

add_definitions(
  -DSPEC_RATE
)

list(APPEND LDFLAGS -lm)

## test ######################################################################

speccpu2026_run_test(
  10 reference.dat 0 0 200_200_130_ldc.of
  STDOUT lbm.out
  STDERR lbm.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  120 reference.dat 0 0 200_200_130_ldc.of
  STDOUT lbm.out
  STDERR lbm.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  900 reference.dat 0 0 200_200_130_ldc.of
  STDOUT lbm.out
  STDERR lbm.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output(
  ABSOLUTE_TOLERANCE 1e-07
)

speccpu2026_add_executable(
  lbm.c
  main.c
)

speccpu2026_prepare_rundir()

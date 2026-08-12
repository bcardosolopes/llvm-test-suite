# 803.sph_exa_s
# Generated from SPEC's own runcpu build and setup logs by
# clangir-upstream-report/spec2026-overlay/gen-cmakelists.py, then
# reviewed by hand. Sources, -D/-I flags and RUN lines are exactly what
# runcpu used for tune=base.
include(../../SpecCPU2026.cmake)
if (NOT TEST_SUITE_SPEC2026_ROOT)
  return ()
endif ()

speccpu2026_benchmark(SPEED)

speccpu2026_add_include_dirs(
  .
  include
  include/tree
)

add_definitions(
  -DSPEC_USE_LT_IN_KERNELS
)

## test ######################################################################

speccpu2026_remove_stale_output(
  RUN_TYPE test
  FILES
    constants.csv
    dump0.csv
    sqpatch.dat
)

speccpu2026_run_test(
  -n 100 -s 0 -w 1
  STDOUT sph_exa.out
  STDERR sph_exa.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_remove_stale_output(
  RUN_TYPE train
  FILES
    constants.csv
    dump0.csv
    dump5.csv
    dump7.csv
    sqpatch.dat
)

speccpu2026_run_test(
  -n 50 -s 7 -w 5
  STDOUT sph_exa.out
  STDERR sph_exa.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_remove_stale_output(
  RUN_TYPE ref
  FILES
    constants.csv
    dump0.csv
    dump14.csv
    dump21.csv
    dump24.csv
    dump7.csv
    sqpatch.dat
)

speccpu2026_run_test(
  -n 210 -s 24 -w 7
  STDOUT sph_exa.out
  STDERR sph_exa.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output(
  ABSOLUTE_TOLERANCE 0.0002
  RELATIVE_TOLERANCE 0.00506
)

speccpu2026_add_executable(
  sqpatch.cpp
)

speccpu2026_prepare_rundir()

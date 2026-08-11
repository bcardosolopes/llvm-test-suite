# 999.specrand_r
# Generated from SPEC's own runcpu build and setup logs by
# clangir-upstream-report/spec2026-overlay/gen-cmakelists.py, then
# reviewed by hand. Sources, -D/-I flags and RUN lines are exactly what
# runcpu used for tune=base.
include(../../SpecCPU2026.cmake)
if (NOT TEST_SUITE_SPEC2026_ROOT)
  return ()
endif ()

speccpu2026_benchmark(RATE)

###############################################################################
# specrand_r
###############################################################################

speccpu2026_add_include_dirs(
  specrand-common
  specrand-distributions
)

## test ######################################################################

speccpu2026_run_test(
  324342 24239
  STDOUT rand.specrand.24239.out
  STDERR rand.specrand.24239.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  1 11
  STDOUT rand.specrand.11.out
  STDERR rand.specrand.11.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  1255432124 234923
  STDOUT rand.specrand.234923.out
  STDERR rand.specrand.234923.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output(
  FILES
    rand.specrand.11.out
    rand.specrand.234923.out
    rand.specrand.24239.out
)

speccpu2026_add_executable(
  main.c
  specrand-common/specrand.c
)

speccpu2026_prepare_rundir()

###############################################################################
# distributions_r
###############################################################################

set(PROG ${BENCHMARK}.distributions_r)
speccpu2026_use_rundir(distributions_r)

# Same flags as the primary binary above; add_definitions() and
# include_directories() are directory-scoped, so they carry.

## test ######################################################################

speccpu2026_run_test(
  324342 24239
  STDOUT rand.distributions.24239.out
  STDERR rand.distributions.24239.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  1 11
  STDOUT rand.distributions.11.out
  STDERR rand.distributions.11.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  1255432124 234923
  STDOUT rand.distributions.234923.out
  STDERR rand.distributions.234923.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output(
  FILES
    rand.distributions.11.out
    rand.distributions.234923.out
    rand.distributions.24239.out
)

speccpu2026_add_executable(
  distributions.cc
)

speccpu2026_prepare_rundir()

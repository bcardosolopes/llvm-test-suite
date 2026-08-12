# 881.neutron_s
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
  RSBench
  XSBench
)

list(APPEND LDFLAGS -lm)

## test ######################################################################

speccpu2026_run_test(
  xsbench -s small -g 1000 -p 50000
  STDOUT xsbench.small.out
  STDERR xsbench.small.err
  RUN_TYPE test
)

speccpu2026_run_test(
  rsbench -m event -l 100000 -p 2000 -P 2000 -d
  STDOUT rsbench.event.out
  STDERR rsbench.event.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  xsbench -G hash -h 100 -p 100000 -g 500000 -s small
  STDOUT xsbench.hash.out
  STDERR xsbench.hash.err
  RUN_TYPE train
)

speccpu2026_run_test(
  rsbench -m history -l 1000 -p 1000 -P 1000 -W 100 -d
  STDOUT rsbench.history.out
  STDERR rsbench.history.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  xsbench -G unionized -m event -s large -l 800000000 -g 82500 -k 1
  STDOUT xsbench.unionized.out
  STDERR xsbench.unionized.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  rsbench -m history -s large -p 1500000 -P 300000 -W 35000 -l 60 -d
  STDOUT rsbench.history.out
  STDERR rsbench.history.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  xsbench -m history -G nuclide -s XXL -p 1000000 -l 65
  STDOUT xsbench.history.out
  STDERR xsbench.history.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  rsbench -m event -s large -l 400000000 -p 180000 -P 600000 -W 600000 -k 1 -d
  STDOUT rsbench.event.out
  STDERR rsbench.event.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output(
  ABSOLUTE_TOLERANCE 0.001
  RELATIVE_TOLERANCE 0.0001
)

speccpu2026_add_executable(
  XSBench/GridInit.c
  XSBench/Materials.c
  XSBench/Simulation.c
  XSBench/XSutils.c
  XSBench/io.c
  XSBench/Main.c
  RSBench/init.c
  RSBench/io.c
  RSBench/material.c
  RSBench/simulation.c
  RSBench/utils.c
  RSBench/main.c
  main_neutron.c
)

speccpu2026_prepare_rundir()

# 854.graph500_s
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
  spec_restrict
  spec_getopt
  .
)

list(APPEND LDFLAGS -lm)

## test ######################################################################

speccpu2026_run_test(
  -s 18 -e 16 -o bfs_test.bin -f 1
  STDOUT bfs_test.bin.out
  STDERR bfs_test.bin.err
  RUN_TYPE test
)

speccpu2026_run_test(
  -m 62 -p 100 -q apsp_NYroad_62.bin -g 1
  STDOUT apsp_NYroad_62.bin.out
  STDERR apsp_NYroad_62.bin.err
  RUN_TYPE test
)

speccpu2026_run_test(
  -p 100 -m 62 -i dist.bin -j dijkstra_NYroad_62.bin -k 1
  STDOUT verify_apsp.out
  STDERR verify_apsp.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  -s 20 -e 16 -o bfs_train.bin -f 1
  STDOUT bfs_train.bin.out
  STDERR bfs_train.bin.err
  RUN_TYPE train
)

speccpu2026_run_test(
  -m 3508 -p 3000 -q apsp_NYroad_3508.bin -g 1
  STDOUT apsp_NYroad_3508.bin.out
  STDERR apsp_NYroad_3508.bin.err
  RUN_TYPE train
)

speccpu2026_run_test(
  -p 3000 -m 3508 -i dist.bin -j dijkstra_NYroad_3508.bin -k 1
  STDOUT verify_apsp.out
  STDERR verify_apsp.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  -s 26 -e 16 -o bfs_refspeed.bin -f 1
  STDOUT bfs_refspeed.bin.out
  STDERR bfs_refspeed.bin.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -m 19384 -p 16000 -q apsp_NYroad_19384.bin -g 1
  STDOUT apsp_NYroad_19384.bin.out
  STDERR apsp_NYroad_19384.bin.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -p 16000 -m 19384 -i dist.bin -j dijkstra_NYroad_19384.bin -k 1
  STDOUT verify_apsp.out
  STDERR verify_apsp.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output()

speccpu2026_add_executable(
  apsp.c
  graph500.c
  graph_generator.c
  make_graph.c
  omp-csr.c
  options.c
  prng.c
  splittable_mrg.c
  utils.c
  verify.c
  xalloc.c
  spec_getopt/getopt.c
)

speccpu2026_prepare_rundir()

speccpu2026_generate_inputs_run(
  RUN_TYPE test
  STDOUT bfs_data_prep.out
  STDERR bfs_data_prep.err
  -s 18 -e 16 -o bfs_test.bin -P 1
)

speccpu2026_generate_inputs_run(
  RUN_TYPE train
  STDOUT bfs_data_prep.out
  STDERR bfs_data_prep.err
  -s 20 -e 16 -o bfs_train.bin -P 1
)

speccpu2026_generate_inputs_run(
  RUN_TYPE ref
  STDOUT bfs_data_prep.out
  STDERR bfs_data_prep.err
  -s 26 -e 16 -o bfs_refspeed.bin -P 1
)

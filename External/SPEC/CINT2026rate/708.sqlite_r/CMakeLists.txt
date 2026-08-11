# 708.sqlite_r
# Generated from SPEC's own runcpu build and setup logs by
# clangir-upstream-report/spec2026-overlay/gen-cmakelists.py, then
# reviewed by hand. Sources, -D/-I flags and RUN lines are exactly what
# runcpu used for tune=base.
include(../../SpecCPU2026.cmake)
if (NOT TEST_SUITE_SPEC2026_ROOT)
  return ()
endif ()

speccpu2026_benchmark(RATE)

speccpu2026_add_include_dirs(
  spec_inline_control
)

add_definitions(
  -DSQLITE_DISABLE_INTRINSIC
  -DSQLITE_OMIT_LOAD_EXTENSION
  -DSQLITE_THREADSAFE=0
  -DSQLITE_ENABLE_RTREE
  -DSQLITE_OMIT_DEPRECATED
  -DSQLITE_OMIT_TRACE
  -DSQLITE_OMIT_RANDOMNESS
  -DSQLITE_OMIT_WAL
)

list(APPEND LDFLAGS -lm)

## test ######################################################################

speccpu2026_run_test(
  --memdb --size 10 --testset main --verify
  STDOUT sqlite_r.main.out
  STDERR sqlite_r.main.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  --memdb --size 500 --testset main --verify
  STDOUT sqlite_r.main.out
  STDERR sqlite_r.main.err
  RUN_TYPE train
)

speccpu2026_run_test(
  --memdb --size 500 --testset cte --verify
  STDOUT sqlite_r.cte.out
  STDERR sqlite_r.cte.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  --memdb --size 2000 --testset main --verify
  STDOUT sqlite_r.main.out
  STDERR sqlite_r.main.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  --memdb --size 2000 --testset cte --verify
  STDOUT sqlite_r.cte.out
  STDERR sqlite_r.cte.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  --memdb --size 1000 --testset fp --verify
  STDOUT sqlite_r.fp.out
  STDERR sqlite_r.fp.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output()

speccpu2026_add_executable(
  sqlite3.c
  speedtest1.c
)

speccpu2026_prepare_rundir()

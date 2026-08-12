# 816.nab_s
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
  specrand
  rxspencer
)

add_definitions(
  -DNOPERFLIB
  -DNOREDUCE
)

list(APPEND LDFLAGS -lm)

## test ######################################################################

speccpu2026_run_test(
  --directory hkrdenq --seed 1930344093 --iterations 1000
  STDOUT hkrdenq.1000.out
  STDERR hkrdenq.1000.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  --directory aminos --seed 391519156 --iterations 1000
  STDOUT aminos.1000.out
  STDERR aminos.1000.err
  RUN_TYPE train
)

speccpu2026_run_test(
  --directory gcn4dna --seed 1850041461 --iterations 300
  STDOUT gcn4dna.300.out
  STDERR gcn4dna.300.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  --directory 3j1n --seed 20140317 --iterations 220 --epoques 3
  STDOUT 3j1n.220.3.out
  STDERR 3j1n.220.3.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  --directory 1am0 --seed 20220406 --iterations 500 --epoques 3
  STDOUT 1am0.500.3.out
  STDERR 1am0.500.3.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output(
  RELATIVE_TOLERANCE 0.02
)

speccpu2026_add_executable(
  nabmd.c
  sff.c
  nblist.c
  prm.c
  memutil.c
  molio.c
  molutil.c
  errormsg.c
  binpos.c
  rand2.c
  select_atoms.c
  reslib.c
  database.c
  traceback.c
  chirvol.c
  specrand/specrand.c
  rxspencer/regcomp.c
  rxspencer/regerror.c
  rxspencer/regexec.c
  rxspencer/regfree.c
)

speccpu2026_prepare_rundir()

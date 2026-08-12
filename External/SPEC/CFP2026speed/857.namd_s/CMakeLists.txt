# 857.namd_s
# Generated from SPEC's own runcpu build and setup logs by
# clangir-upstream-report/spec2026-overlay/gen-cmakelists.py, then
# reviewed by hand. Sources, -D/-I flags and RUN lines are exactly what
# runcpu used for tune=base.
include(../../SpecCPU2026.cmake)
if (NOT TEST_SUITE_SPEC2026_ROOT)
  return ()
endif ()

speccpu2026_benchmark(SPEED)

## test ######################################################################

speccpu2026_remove_stale_output(
  RUN_TYPE test
  FILES
    stmv.test.output
)

speccpu2026_run_test(
  --input stmv.input --iterations 1 --output stmv.test.output
  STDOUT namd.out
  STDERR namd.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_remove_stale_output(
  RUN_TYPE train
  FILES
    stmv.train.output
)

speccpu2026_run_test(
  --input stmv.input --iterations 49 --output stmv.train.output
  STDOUT namd.out
  STDERR namd.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_remove_stale_output(
  RUN_TYPE ref
  FILES
    stmv.ref.output
)

speccpu2026_run_test(
  --input stmv.input --output stmv.ref.output --iterations 399
  STDOUT namd.out
  STDERR namd.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output(
  ABSOLUTE_TOLERANCE 5e-05
)

speccpu2026_add_executable(
  Compute.C
  ComputeList.C
  ComputeNonbondedStd.C
  ComputeNonbondedUtil.C
  LJTable.C
  Molecule.C
  Patch.C
  PatchList.C
  ResultSet.C
  SimParameters.C
  spec_namd.C
)

speccpu2026_prepare_rundir()

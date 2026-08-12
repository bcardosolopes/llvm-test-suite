# 811.tealeaf_s
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
  2d/drivers/
  2d/c_kernels
)

list(APPEND LDFLAGS -lm)

## test ######################################################################

speccpu2026_remove_stale_output(
  RUN_TYPE test
  FILES
    tea.out
)

speccpu2026_run_test(
  STDOUT tea.stdout
  STDERR tea.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_remove_stale_output(
  RUN_TYPE train
  FILES
    tea.out
)

speccpu2026_run_test(
  STDOUT tea.stdout
  STDERR tea.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_remove_stale_output(
  RUN_TYPE ref
  FILES
    tea.out
)

speccpu2026_run_test(
  STDOUT tea.stdout
  STDERR tea.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output(
  ABSOLUTE_TOLERANCE 4e-09
  RELATIVE_TOLERANCE 4e-10
)

speccpu2026_add_executable(
  2d/chunk.c
  2d/comms.c
  2d/diffuse.c
  2d/initialise.c
  2d/main.c
  2d/parse_config.c
  2d/profiler.c
  2d/settings.c
  2d/shared.c
  2d/drivers/cg_driver.c
  2d/drivers/cheby_driver.c
  2d/drivers/eigenvalue_driver.c
  2d/drivers/field_summary_driver.c
  2d/drivers/halo_update_driver.c
  2d/drivers/jacobi_driver.c
  2d/drivers/kernel_initialise_driver.c
  2d/drivers/ppcg_driver.c
  2d/drivers/remote_halo_driver.c
  2d/drivers/set_chunk_data_driver.c
  2d/drivers/set_chunk_state_driver.c
  2d/drivers/solve_finished_driver.c
  2d/drivers/store_energy_driver.c
  2d/c_kernels/cg.c
  2d/c_kernels/cheby.c
  2d/c_kernels/field_summary.c
  2d/c_kernels/jacobi.c
  2d/c_kernels/kernel_initialise.c
  2d/c_kernels/kernel_interface.c
  2d/c_kernels/local_halos.c
  2d/c_kernels/pack_halos.c
  2d/c_kernels/ppcg.c
  2d/c_kernels/set_chunk_data.c
  2d/c_kernels/set_chunk_state.c
  2d/c_kernels/solver_methods.c
  2d/c_kernels/store_energy.c
  2d/c_kernels/diffuse_overload.c
  2d/getline/getline.c
)

speccpu2026_prepare_rundir()

# 731.astcenc_r
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
  .
  ThirdParty
  spec_inline_control
)

add_definitions(
  -DSPECMAIN
)

## test ######################################################################

speccpu2026_run_test(
  test-inputs.txt
  STDOUT astcenc_r.0.out
  STDERR astcenc_r.0.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  train-inputs.txt
  STDOUT astcenc_r.0.out
  STDERR astcenc_r.0.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  ref-inputs-linear.txt
  STDOUT astcenc_r.0.out
  STDERR astcenc_r.0.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  ref-inputs-hdr.txt
  STDOUT astcenc_r.1.out
  STDERR astcenc_r.1.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  ref-inputs-precision.txt
  STDOUT astcenc_r.2.out
  STDERR astcenc_r.2.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output(
  RELATIVE_TOLERANCE 0.01
)

speccpu2026_add_executable(
  astcenc_averages_and_directions.cpp
  astcenc_block_sizes.cpp
  astcenc_color_quantize.cpp
  astcenc_color_unquantize.cpp
  astcenc_compress_symbolic.cpp
  astcenc_compute_variance.cpp
  astcenc_decompress_symbolic.cpp
  astcenc_diagnostic_trace.cpp
  astcenc_entry.cpp
  astcenc_find_best_partitioning.cpp
  astcenc_ideal_endpoints_and_weights.cpp
  astcenc_image.cpp
  astcenc_integer_sequence.cpp
  astcenc_mathlib.cpp
  astcenc_mathlib_softfloat.cpp
  astcenc_partition_tables.cpp
  astcenc_percentile_tables.cpp
  astcenc_pick_best_endpoint_format.cpp
  astcenc_quantization.cpp
  astcenc_spec_main.cpp
  astcenc_symbolic_physical.cpp
  astcenc_weight_align.cpp
  astcenc_weight_quant_xfer_tables.cpp
  astcenccli_error_metrics.cpp
  astcenccli_image.cpp
  astcenccli_image_external.cpp
  astcenccli_image_load_store.cpp
  astcenccli_platform_dependents.cpp
  astcenccli_toplevel.cpp
  astcenccli_toplevel_help.cpp
)

speccpu2026_prepare_rundir()

# 706.stockfish_r
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
  spec_restrict
)

add_definitions(
  -DIS_64BIT
  -DUSE_MAGIC_MSB
)

## test ######################################################################

speccpu2026_run_test(
  bench 16 1 15 spec_test.fen depth nnue
  STDOUT stockfish_spec_test_nnue.out
  STDERR stockfish_spec_test_nnue.err
  RUN_TYPE test
)

speccpu2026_run_test(
  bench 16 1 15 spec_test.fen depth classical
  STDOUT stockfish_spec_test_classical.out
  STDERR stockfish_spec_test_classical.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  bench 1600 1 24 spec_train.fen depth nnue
  STDOUT stockfish_spec_train_nnue.out
  STDERR stockfish_spec_train_nnue.err
  RUN_TYPE train
)

speccpu2026_run_test(
  bench 1600 1 24 spec_train.fen depth classical
  STDOUT stockfish_spec_train_classical.out
  STDERR stockfish_spec_train_classical.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  bench 1600 1 26 spec_ref_pos_1to6.fen depth classical
  STDOUT stockfish_spec_ref_pos_1to6_classical.out
  STDERR stockfish_spec_ref_pos_1to6_classical.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  bench 1600 1 26 spec_ref_pos_1to6.fen depth nnue
  STDOUT stockfish_spec_ref_pos_1to6_nnue.out
  STDERR stockfish_spec_ref_pos_1to6_nnue.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  bench 1600 1 26 spec_ref_pos_7to11.fen depth nnue
  STDOUT stockfish_spec_ref_pos_7to11_nnue.out
  STDERR stockfish_spec_ref_pos_7to11_nnue.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output()

speccpu2026_add_executable(
  benchmark.cpp
  bitbase.cpp
  bitboard.cpp
  endgame.cpp
  evaluate.cpp
  main.cpp
  material.cpp
  misc.cpp
  movegen.cpp
  movepick.cpp
  pawns.cpp
  position.cpp
  psqt.cpp
  search.cpp
  thread.cpp
  timeman.cpp
  tt.cpp
  uci.cpp
  ucioption.cpp
  nnue/evaluate_nnue.cpp
  nnue/features/half_ka_v2_hm.cpp
)

speccpu2026_prepare_rundir()

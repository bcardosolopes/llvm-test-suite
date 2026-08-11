# 707.ntest_r
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
  specrand
)

## test ######################################################################

speccpu2026_run_test(
  OneGame.ggf 10 6
  STDOUT ntest.OneGame.10.6.out
  STDERR ntest.OneGame.10.6.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  Othello.60e4.ggf 19 19
  STDOUT ntest.Othello.60e4.19.19.out
  STDERR ntest.Othello.60e4.19.19.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  Othello.154.ggf 20 16
  STDOUT ntest.Othello.154.20.16.out
  STDERR ntest.Othello.154.20.16.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output()

speccpu2026_add_executable(
  BitBoard.cpp
  BitBoardTest.cpp
  Cache.cpp
  CalcParams.cpp
  EvalTest.cpp
  Evaluator.cpp
  FastFlip.cpp
  HeightInfo.cpp
  MPCStats.cpp
  MVK.cpp
  Moves.cpp
  NodeStats.cpp
  OsObjects.cpp
  Patterns.cpp
  Player.cpp
  PlayerComputer.cpp
  Pos2.cpp
  Pos2Test.cpp
  QPosition.cpp
  QPositionTest.cpp
  Search.cpp
  SearchParams.cpp
  SearchTest.cpp
  SpeedTest.cpp
  Stable.cpp
  bitExtractTest.cpp
  endgameSearch.cpp
  endgameSearchTest.cpp
  flips.cpp
  flipsTest.cpp
  hash.cpp
  hashTest.cpp
  lastFlipCountGenerator.cpp
  n64.cpp
  odkTest.cpp
  options.cpp
  port.cpp
  solve.cpp
  solveTest.cpp
  speed_test.cpp
  test.cpp
  utils.cpp
  utilsTest.cpp
  specrand/specrand.cc
)

speccpu2026_prepare_rundir()

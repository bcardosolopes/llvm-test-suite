# 807.ntest_s
# Generated from SPEC's own runcpu build and setup logs by
# clangir-upstream-report/spec2026-overlay/gen-cmakelists.py, then
# reviewed by hand. Sources, -D/-I flags and RUN lines are exactly what
# runcpu used for tune=base.
include(../../SpecCPU2026.cmake)
if (NOT TEST_SUITE_SPEC2026_ROOT)
  return ()
endif ()

speccpu2026_benchmark(SPEED ORIGIN 707.ntest_r)

# Not a speccpu2026_inherit(../../CINT2026rate/707.ntest_r): this builds
# identically to 707.ntest_r, but its run lines differ at every size, so an
# inherit would mean tagging nearly every run line in both files with
# SUITE_TYPE. Emitted in full instead.

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
  Othello.01e4.ggf 20 21
  STDOUT ntest.Othello.01e4.20.21.out
  STDERR ntest.Othello.01e4.20.21.err
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

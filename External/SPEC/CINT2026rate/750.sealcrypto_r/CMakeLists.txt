# 750.sealcrypto_r
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
  specrand
  specrand-distributions
  seal
  seal/util
  secure-query
  secure-query/include
)

## test ######################################################################

speccpu2026_run_test(
  test country_capital_test.csv Ecuador
  STDOUT homoencrypt.test_country_capital_test.csv_Ecuador.out
  STDERR homoencrypt.test_country_capital_test.csv_Ecuador.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  train australia_state_capitals_train.csv Victoria
  STDOUT homoencrypt.train_australia_state_capitals_train.csv_Victoria.out
  STDERR homoencrypt.train_australia_state_capitals_train.csv_Victoria.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  refrate ecuador_province_capitals_refrate.csv Galapagos
  STDOUT homoencrypt.refrate_ecuador_province_capitals_refrate.csv_Galapagos.out
  STDERR homoencrypt.refrate_ecuador_province_capitals_refrate.csv_Galapagos.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output()

speccpu2026_add_executable(
  specrand/specrand.cc
  seal/util/blake2b.c
  seal/util/blake2xb.c
  seal/util/fips202.c
  seal/batchencoder.cpp
  seal/ciphertext.cpp
  seal/ckks.cpp
  seal/context.cpp
  seal/decryptor.cpp
  seal/encryptionparams.cpp
  seal/encryptor.cpp
  seal/evaluator.cpp
  seal/keygenerator.cpp
  seal/kswitchkeys.cpp
  seal/memorymanager.cpp
  seal/modulus.cpp
  seal/plaintext.cpp
  seal/randomgen.cpp
  seal/serialization.cpp
  seal/valcheck.cpp
  seal/util/clipnormal.cpp
  seal/util/common.cpp
  seal/util/croots.cpp
  seal/util/globals.cpp
  seal/util/galois.cpp
  seal/util/hash.cpp
  seal/util/iterator.cpp
  seal/util/mempool.cpp
  seal/util/numth.cpp
  seal/util/polyarithsmallmod.cpp
  seal/util/rlwe.cpp
  seal/util/rns.cpp
  seal/util/scalingvariant.cpp
  seal/util/ntt.cpp
  seal/util/streambuf.cpp
  seal/util/uintarith.cpp
  seal/util/uintarithmod.cpp
  seal/util/uintarithsmallmod.cpp
  seal/util/uintcore.cpp
  seal/util/ztools.cpp
  secure-query/main.cpp
  secure-query/sqclient.cpp
  secure-query/sqserver.cpp
)

speccpu2026_prepare_rundir()

# 777.zstd_r
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
  lib
  lib/programs
  lib/common
  lib/compress
  lib/dictBuilder
)

add_definitions(
  -DXXH_NAMESPACE=ZSTD_
  -DZSTD_LEGACY_SUPPORT=0
  -DZSTD_NODICT
  -DSTATIC_BMI2=0
  -DDYNAMIC_BMI2=0
  -DZSTD_NO_INTRINSICS=1
  -DZSTD_DISABLE_ASM=1
  -DZSTD_NOTRACE=1
  -DZSTD_NO_TRACE=1
)

## test ######################################################################

speccpu2026_run_test(
  -b3 --verbose -i1
  STDOUT zstd.b3_verbose_i1.out
  STDERR zstd.b3_verbose_i1.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  -b3 -e12 --verbose -i15
  STDOUT zstd.b3_e12_verbose_i15.out
  STDERR zstd.b3_e12_verbose_i15.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  -b3 -e3 --verbose -i40 cld.tar
  STDOUT zstd.b3_e3_verbose_i40_cld.tar.out
  STDERR zstd.b3_e3_verbose_i40_cld.tar.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -b5 -e5 --verbose -i25 cld.tar
  STDOUT zstd.b5_e5_verbose_i25_cld.tar.out
  STDERR zstd.b5_e5_verbose_i25_cld.tar.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -b7 -e7 --verbose -i12 cld.tar
  STDOUT zstd.b7_e7_verbose_i12_cld.tar.out
  STDERR zstd.b7_e7_verbose_i12_cld.tar.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -b10 -e10 --verbose -i6 cld.tar
  STDOUT zstd.b10_e10_verbose_i6_cld.tar.out
  STDERR zstd.b10_e10_verbose_i6_cld.tar.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -b14 -e14 --verbose -i4 cld.tar
  STDOUT zstd.b14_e14_verbose_i4_cld.tar.out
  STDERR zstd.b14_e14_verbose_i4_cld.tar.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -b16 -e16 --verbose -i1 cld.tar
  STDOUT zstd.b16_e16_verbose_i1_cld.tar.out
  STDERR zstd.b16_e16_verbose_i1_cld.tar.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -b18 -e18 --verbose -i1 cld.tar
  STDOUT zstd.b18_e18_verbose_i1_cld.tar.out
  STDERR zstd.b18_e18_verbose_i1_cld.tar.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -b19 -e19 --verbose -i1 cld.tar
  STDOUT zstd.b19_e19_verbose_i1_cld.tar.out
  STDERR zstd.b19_e19_verbose_i1_cld.tar.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output()

speccpu2026_add_executable(
  zstd-1.5.6/programs/fileio.c
  zstd-1.5.6/programs/fileio_asyncio.c
  zstd-1.5.6/programs/util.c
  zstd-1.5.6/programs/timefn.c
  zstd-1.5.6/programs/zstdcli.c
  zstd-1.5.6/programs/benchzstd.c
  zstd-1.5.6/programs/datagen.c
  zstd-1.5.6/programs/benchfn.c
  zstd-1.5.6/programs/lorem.c
  zstd-1.5.6/lib/compress/zstd_double_fast.c
  zstd-1.5.6/lib/compress/zstd_fast.c
  zstd-1.5.6/lib/compress/zstd_compress_sequences.c
  zstd-1.5.6/lib/compress/zstd_ldm.c
  zstd-1.5.6/lib/compress/hist.c
  zstd-1.5.6/lib/compress/zstd_compress.c
  zstd-1.5.6/lib/compress/zstd_compress_superblock.c
  zstd-1.5.6/lib/compress/zstd_lazy.c
  zstd-1.5.6/lib/compress/zstd_compress_literals.c
  zstd-1.5.6/lib/compress/huf_compress.c
  zstd-1.5.6/lib/compress/zstd_opt.c
  zstd-1.5.6/lib/compress/fse_compress.c
  zstd-1.5.6/lib/decompress/zstd_ddict.c
  zstd-1.5.6/lib/decompress/huf_decompress.c
  zstd-1.5.6/lib/decompress/zstd_decompress.c
  zstd-1.5.6/lib/decompress/zstd_decompress_block.c
  zstd-1.5.6/lib/common/entropy_common.c
  zstd-1.5.6/lib/common/fse_decompress.c
  zstd-1.5.6/lib/common/debug.c
  zstd-1.5.6/lib/common/xxhash.c
  zstd-1.5.6/lib/common/pool.c
  zstd-1.5.6/lib/common/threading.c
  zstd-1.5.6/lib/common/zstd_common.c
  zstd-1.5.6/lib/common/error_private.c
)

speccpu2026_prepare_rundir()

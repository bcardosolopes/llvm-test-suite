# 801.xz_s
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
  .
  spec_mem_io
  spec_restrict
  sha-2
  common
  liblzma/api
  liblzma/lzma
  liblzma/common
  liblzma/check
  liblzma/simple
  liblzma/delta
  liblzma/lz
  liblzma/rangecoder
  spec_inline_control
)

add_definitions(
  -DHAVE_CONFIG_H=1
  -DSPEC_MEM_IO
  -DSPEC_XZ
)

add_compile_options(-pthread)
list(APPEND LDFLAGS -pthread)

## test ######################################################################

speccpu2026_run_test(
  cpu2006docs.tar.xz 4
  055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae
  1548636 1555348 0
  STDOUT cpu2006docs.tar-4-0.out
  STDERR cpu2006docs.tar-4-0.err
  RUN_TYPE test
)

speccpu2026_run_test(
  cpu2006docs.tar.xz 4
  055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae
  1462248 1467400 1
  STDOUT cpu2006docs.tar-4-1.out
  STDERR cpu2006docs.tar-4-1.err
  RUN_TYPE test
)

speccpu2026_run_test(
  cpu2006docs.tar.xz 4
  055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae
  1428548 1428556 2
  STDOUT cpu2006docs.tar-4-2.out
  STDERR cpu2006docs.tar-4-2.err
  RUN_TYPE test
)

speccpu2026_run_test(
  cpu2006docs.tar.xz 4
  055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae
  1034828 1034836 3e
  STDOUT cpu2006docs.tar-4-3e.out
  STDERR cpu2006docs.tar-4-3e.err
  RUN_TYPE test
)

speccpu2026_run_test(
  cpu2006docs.tar.xz 4
  055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae
  1061968 1061976 4
  STDOUT cpu2006docs.tar-4-4.out
  STDERR cpu2006docs.tar-4-4.err
  RUN_TYPE test
)

speccpu2026_run_test(
  cpu2006docs.tar.xz 4
  055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae
  1034588 1034596 4e
  STDOUT cpu2006docs.tar-4-4e.out
  STDERR cpu2006docs.tar-4-4e.err
  RUN_TYPE test
)

speccpu2026_run_test(
  cpu2006docs.tar.xz 1
  055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae
  650156 650160 0
  STDOUT cpu2006docs.tar-1-0.out
  STDERR cpu2006docs.tar-1-0.err
  RUN_TYPE test
)

speccpu2026_run_test(
  cpu2006docs.tar.xz 1
  055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae
  639996 640004 1
  STDOUT cpu2006docs.tar-1-1.out
  STDERR cpu2006docs.tar-1-1.err
  RUN_TYPE test
)

speccpu2026_run_test(
  cpu2006docs.tar.xz 1
  055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae
  637616 637624 2
  STDOUT cpu2006docs.tar-1-2.out
  STDERR cpu2006docs.tar-1-2.err
  RUN_TYPE test
)

speccpu2026_run_test(
  cpu2006docs.tar.xz 1
  055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae
  628996 629004 3e
  STDOUT cpu2006docs.tar-1-3e.out
  STDERR cpu2006docs.tar-1-3e.err
  RUN_TYPE test
)

speccpu2026_run_test(
  cpu2006docs.tar.xz 1
  055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae
  631912 631920 4
  STDOUT cpu2006docs.tar-1-4.out
  STDERR cpu2006docs.tar-1-4.err
  RUN_TYPE test
)

speccpu2026_run_test(
  cpu2006docs.tar.xz 1
  055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae
  629064 629072 4e
  STDOUT cpu2006docs.tar-1-4e.out
  STDERR cpu2006docs.tar-1-4e.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  input.combined.xz 40
  a841f68f38572a49d86226b7ff5baeb31bd19dc637a922a972b2e6d1257a890f6a544ecab967c313e370478c74f760eb229d4eef8a8d2836d233d3e9dd1430bf
  6356684 6356692 8
  STDOUT input.combined-40-8.out
  STDERR input.combined-40-8.err
  RUN_TYPE train
)

speccpu2026_run_test(
  IMG_2560.cr2.xz 40
  ec03e53b02deae89b6650f1de4bed76a012366fb3d4bdc791e8633d1a5964e03004523752ab008eff0d9e693689c53056533a05fc4b277f0086544c6c3cbbbf6
  40822692 40827404 4
  STDOUT IMG_2560.cr2-40-4.out
  STDERR IMG_2560.cr2-40-4.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  cpu2006docs.tar.xz 15000
  055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae
  2321296421 2523148284 4
  STDOUT cpu2006docs.tar-15000-4.out
  STDERR cpu2006docs.tar-15000-4.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  cld.tar.xz 2700
  19cf30ae51eddcbefda78dd06014b4b96281456e078ca7c13e1c0c9e6aaea8dff3efb4ad6b0456697718cede6bd5454852652806a657bb56e07d61128434b474
  959312906 1042731420 8
  STDOUT cld.tar-2700-8.out
  STDERR cld.tar-2700-8.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output()

speccpu2026_add_executable(
  spec.c
  spec_xz.c
  spec_mem_io/spec_mem_io.c
  sha-2/sha512.c
  common/tuklib_cpucores.c
  common/tuklib_exit.c
  common/tuklib_mbstr_fw.c
  common/tuklib_mbstr_nonprint.c
  common/tuklib_mbstr_width.c
  common/tuklib_mbstr_wrap.c
  common/tuklib_open_stdxxx.c
  common/tuklib_physmem.c
  common/tuklib_progname.c
  liblzma/check/check.c
  liblzma/check/crc32_fast.c
  liblzma/check/crc64_fast.c
  liblzma/check/sha256.c
  liblzma/common/alone_decoder.c
  liblzma/common/alone_encoder.c
  liblzma/common/auto_decoder.c
  liblzma/common/block_buffer_decoder.c
  liblzma/common/block_buffer_encoder.c
  liblzma/common/block_decoder.c
  liblzma/common/block_encoder.c
  liblzma/common/block_header_decoder.c
  liblzma/common/block_header_encoder.c
  liblzma/common/block_util.c
  liblzma/common/common.c
  liblzma/common/easy_buffer_encoder.c
  liblzma/common/easy_decoder_memusage.c
  liblzma/common/easy_encoder.c
  liblzma/common/easy_encoder_memusage.c
  liblzma/common/easy_preset.c
  liblzma/common/file_info.c
  liblzma/common/filter_buffer_decoder.c
  liblzma/common/filter_buffer_encoder.c
  liblzma/common/filter_common.c
  liblzma/common/filter_decoder.c
  liblzma/common/filter_encoder.c
  liblzma/common/filter_flags_decoder.c
  liblzma/common/filter_flags_encoder.c
  liblzma/common/hardware_cputhreads.c
  liblzma/common/hardware_physmem.c
  liblzma/common/index.c
  liblzma/common/index_decoder.c
  liblzma/common/index_encoder.c
  liblzma/common/index_hash.c
  liblzma/common/outqueue.c
  liblzma/common/stream_buffer_decoder.c
  liblzma/common/stream_buffer_encoder.c
  liblzma/common/stream_decoder.c
  liblzma/common/stream_decoder_mt.c
  liblzma/common/stream_encoder.c
  liblzma/common/stream_encoder_mt.c
  liblzma/common/stream_flags_common.c
  liblzma/common/stream_flags_decoder.c
  liblzma/common/stream_flags_encoder.c
  liblzma/common/string_conversion.c
  liblzma/common/vli_decoder.c
  liblzma/common/vli_encoder.c
  liblzma/common/vli_size.c
  liblzma/delta/delta_common.c
  liblzma/delta/delta_decoder.c
  liblzma/delta/delta_encoder.c
  liblzma/lz/lz_decoder.c
  liblzma/lz/lz_encoder.c
  liblzma/lz/lz_encoder_mf.c
  liblzma/lzma/fastpos_table.c
  liblzma/lzma/lzma2_decoder.c
  liblzma/lzma/lzma2_encoder.c
  liblzma/lzma/lzma_decoder.c
  liblzma/lzma/lzma_encoder.c
  liblzma/lzma/lzma_encoder_optimum_fast.c
  liblzma/lzma/lzma_encoder_optimum_normal.c
  liblzma/lzma/lzma_encoder_presets.c
  liblzma/rangecoder/price_table.c
  liblzma/simple/arm.c
  liblzma/simple/arm64.c
  liblzma/simple/armthumb.c
  liblzma/simple/ia64.c
  liblzma/simple/powerpc.c
  liblzma/simple/riscv.c
  liblzma/simple/simple_coder.c
  liblzma/simple/simple_decoder.c
  liblzma/simple/simple_encoder.c
  liblzma/simple/sparc.c
  liblzma/simple/x86.c
  xz/args.c
  xz/coder.c
  xz/file_io.c
  xz/hardware.c
  xz/list.c
  xz/main.c
  xz/message.c
  xz/mytime.c
  xz/options.c
  xz/sandbox.c
  xz/signals.c
  xz/suffix.c
  xz/util.c
  common/std_threads.cc
)

speccpu2026_prepare_rundir()

# 817.flac_s
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
  spec_restrict
  src/libFLAC/include
  include
  .
)

add_definitions(
  -DHAVE_CONFIG_H
)

add_compile_options(-pthread)
list(APPEND LDFLAGS -pthread)

## test ######################################################################

speccpu2026_remove_stale_output(
  RUN_TYPE test
  FILES
    amp_podcast_11.analysis.txt
)

speccpu2026_run_test(
  -7V -f amp_podcast_11.wav -o amp_podcast_11.flac --no-preserve-modtime -j 1
  STDOUT flac.amp_podcast_11.flac.out
  STDERR flac.amp_podcast_11.flac.err
  RUN_TYPE test
)

speccpu2026_run_test(
  -a -f amp_podcast_11.flac -o amp_podcast_11.analysis.txt
  --no-preserve-modtime --delete-input-file -j 1
  STDOUT flac.amp_podcast_11.analysis.txt.out
  STDERR flac.amp_podcast_11.analysis.txt.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  -8Ve -f git_etiquette_mono.wav -o git_etiquette_mono.flac
  --keep-foreign-metadata --no-preserve-modtime -j 1
  STDOUT flac.git_etiquette_mono.flac.out
  STDERR flac.git_etiquette_mono.flac.err
  RUN_TYPE train
)

speccpu2026_run_test(
  -t -f git_etiquette_mono.flac -o git_etiquette_test --delete-input-file -j 1
  STDOUT flac.git_etiquette_test.out
  STDERR flac.git_etiquette_test.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  -8Vep -f learning_is_the_new_literacy.wav
  -o learning_is_the_new_literacy1.flac --mid-side --replay-gain
  --keep-foreign-metadata --no-preserve-modtime -j 1
  STDOUT flac.learning_is_the_new_literacy1.flac.out
  STDERR flac.learning_is_the_new_literacy1.flac.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -7Vep -f learning_is_the_new_literacy.wav
  -o learning_is_the_new_literacy2.flac --mid-side --replay-gain
  --keep-foreign-metadata --no-preserve-modtime -j 1
  STDOUT flac.learning_is_the_new_literacy2.flac.out
  STDERR flac.learning_is_the_new_literacy2.flac.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -6Vep -f learning_is_the_new_literacy.wav
  -o learning_is_the_new_literacy3.flac --replay-gain --adaptive-mid-side
  --keep-foreign-metadata --no-preserve-modtime -j 1
  STDOUT flac.learning_is_the_new_literacy3.flac.out
  STDERR flac.learning_is_the_new_literacy3.flac.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -8Vep -f compiler_puzzles.wav -o compiler_puzzles1.flac --replay-gain
  --keep-foreign-metadata --no-preserve-modtime -j 1
  STDOUT flac.compiler_puzzles1.flac.out
  STDERR flac.compiler_puzzles1.flac.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -7Vep -f compiler_puzzles.wav -o compiler_puzzles2.flac --adaptive-mid-side
  --keep-foreign-metadata --no-preserve-modtime -j 1
  STDOUT flac.compiler_puzzles2.flac.out
  STDERR flac.compiler_puzzles2.flac.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -6Vep -f compiler_puzzles.wav -o compiler_puzzles3.flac --replay-gain
  --adaptive-mid-side --keep-foreign-metadata --no-preserve-modtime -j 1
  STDOUT flac.compiler_puzzles3.flac.out
  STDERR flac.compiler_puzzles3.flac.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -8Vep -f git_etiquette_stereo.wav -o git_etiquette_stereo1.flac --mid-side
  --replay-gain --keep-foreign-metadata --no-preserve-modtime -j 1
  STDOUT flac.git_etiquette_stereo1.flac.out
  STDERR flac.git_etiquette_stereo1.flac.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -7Vep -f git_etiquette_stereo.wav -o git_etiquette_stereo2.flac --mid-side
  --replay-gain --keep-foreign-metadata --no-preserve-modtime -j 1
  STDOUT flac.git_etiquette_stereo2.flac.out
  STDERR flac.git_etiquette_stereo2.flac.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -6Vep -f git_etiquette_stereo.wav -o git_etiquette_stereo3.flac
  --adaptive-mid-side --keep-foreign-metadata --no-preserve-modtime -j 1
  STDOUT flac.git_etiquette_stereo3.flac.out
  STDERR flac.git_etiquette_stereo3.flac.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -8Vep -f working_for_your_team.wav -o working_for_your_team1.flac --mid-side
  --replay-gain --keep-foreign-metadata --no-preserve-modtime -j 1
  STDOUT flac.working_for_your_team1.flac.out
  STDERR flac.working_for_your_team1.flac.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -7Vep -f working_for_your_team.wav -o working_for_your_team2.flac --mid-side
  --replay-gain --keep-foreign-metadata --no-preserve-modtime -j 1
  STDOUT flac.working_for_your_team2.flac.out
  STDERR flac.working_for_your_team2.flac.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -6Vep -f working_for_your_team.wav -o working_for_your_team3.flac
  --replay-gain --adaptive-mid-side --keep-foreign-metadata
  --no-preserve-modtime -j 1
  STDOUT flac.working_for_your_team3.flac.out
  STDERR flac.working_for_your_team3.flac.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -8Vep -f designing_a_motherboard.wav -o designing_a_motherboard1.flac
  --mid-side --replay-gain --keep-foreign-metadata --no-preserve-modtime -j 1
  STDOUT flac.designing_a_motherboard1.flac.out
  STDERR flac.designing_a_motherboard1.flac.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -7Vep -f designing_a_motherboard.wav -o designing_a_motherboard2.flac
  --mid-side -r 2 --keep-foreign-metadata --no-preserve-modtime -j 1
  STDOUT flac.designing_a_motherboard2.flac.out
  STDERR flac.designing_a_motherboard2.flac.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -6Vep -f designing_a_motherboard.wav -o designing_a_motherboard3.flac
  --max-lpc-order=10 --replay-gain --keep-foreign-metadata
  --no-preserve-modtime -j 1
  STDOUT flac.designing_a_motherboard3.flac.out
  STDERR flac.designing_a_motherboard3.flac.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -t -f *.flac --no-silent --no-decode-through-errors --delete-input-file -j 1
  STDOUT flac.--no-decode-through-errors.out
  STDERR flac.--no-decode-through-errors.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output(
  ABSOLUTE_TOLERANCE 16
)

speccpu2026_add_executable(
  src/libFLAC/bitmath.c
  src/libFLAC/bitreader.c
  src/libFLAC/bitwriter.c
  src/libFLAC/cpu.c
  src/libFLAC/crc.c
  src/libFLAC/fixed.c
  src/libFLAC/float.c
  src/libFLAC/format.c
  src/libFLAC/lpc.c
  src/libFLAC/md5.c
  src/libFLAC/memory.c
  src/libFLAC/metadata_iterators.c
  src/libFLAC/metadata_object.c
  src/libFLAC/stream_decoder.c
  src/libFLAC/stream_encoder_cpp_threads.cpp
  src/libFLAC/stream_encoder_framing.c
  src/libFLAC/window.c
  src/flac/analyze.c
  src/flac/decode.c
  src/flac/encode.c
  src/flac/foreign_metadata.c
  src/flac/main.c
  src/flac/local_string_utils.c
  src/flac/utils.c
  src/flac/vorbiscomment.c
  src/share/getopt/getopt.c
  src/share/getopt/getopt1.c
  src/share/grabbag/alloc.c
  src/share/grabbag/cuesheet.c
  src/share/grabbag/file.c
  src/share/grabbag/picture.c
  src/share/grabbag/replaygain.c
  src/share/grabbag/seektable.c
  src/share/grabbag/snprintf.c
  src/share/utf8/charset.c
  src/share/utf8/iconvert.c
  src/share/utf8/utf8.c
  src/share/replaygain_synthesis/replaygain_synthesis.c
  src/share/replaygain_analysis/replaygain_analysis.c
)

speccpu2026_prepare_rundir()

speccpu2026_generate_inputs_run(
  RUN_TYPE test
  STDOUT gen_amp_podcast_11.wav.out
  STDERR gen_amp_podcast_11.wav.err
  -d -f amp_podcast_11.flac.in --no-decode-through-errors
  -o amp_podcast_11.wav
)

speccpu2026_generate_inputs_run(
  RUN_TYPE train
  STDOUT gen_git_etiquette_mono.wav.out
  STDERR gen_git_etiquette_mono.wav.err
  -d -f git_etiquette_mono.flac.in --keep-foreign-metadata
  --no-decode-through-errors -o git_etiquette_mono.wav
)

speccpu2026_generate_inputs_run(
  RUN_TYPE ref
  STDOUT gen_learning_is_the_new_literacy.wav.out
  STDERR gen_learning_is_the_new_literacy.wav.err
  -d -f learning_is_the_new_literacy.flac.in --keep-foreign-metadata
  --no-decode-through-errors -o learning_is_the_new_literacy.wav
)

speccpu2026_generate_inputs_run(
  RUN_TYPE ref
  STDOUT gen_designing_a_motherboard.wav.out
  STDERR gen_designing_a_motherboard.wav.err
  -d -f designing_a_motherboard.flac.in --keep-foreign-metadata
  --no-decode-through-errors -o designing_a_motherboard.wav
)

speccpu2026_generate_inputs_run(
  RUN_TYPE ref
  STDOUT gen_working_for_your_team.wav.out
  STDERR gen_working_for_your_team.wav.err
  -d -f working_for_your_team.flac.in --keep-foreign-metadata
  --no-decode-through-errors -o working_for_your_team.wav
)

speccpu2026_generate_inputs_run(
  RUN_TYPE ref
  STDOUT gen_git_etiquette_stereo.wav.out
  STDERR gen_git_etiquette_stereo.wav.err
  -d -f git_etiquette_stereo.flac.in --keep-foreign-metadata
  --no-decode-through-errors -o git_etiquette_stereo.wav
)

speccpu2026_generate_inputs_run(
  RUN_TYPE ref
  STDOUT gen_compiler_puzzles.wav.out
  STDERR gen_compiler_puzzles.wav.err
  -d -f compiler_puzzles.flac.in --keep-foreign-metadata
  --no-decode-through-errors -o compiler_puzzles.wav
)

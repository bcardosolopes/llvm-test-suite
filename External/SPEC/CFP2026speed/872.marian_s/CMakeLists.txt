# 872.marian_s
# Generated from SPEC's own runcpu build and setup logs by
# clangir-upstream-report/spec2026-overlay/gen-cmakelists.py, then
# reviewed by hand. Sources, -D/-I flags and RUN lines are exactly what
# runcpu used for tune=base.
include(../../SpecCPU2026.cmake)
if (NOT TEST_SUITE_SPEC2026_ROOT)
  return ()
endif ()

speccpu2026_benchmark(SPEED ORIGIN 772.marian_r)

# Not a speccpu2026_inherit(../../CFP2026rate/772.marian_r): this builds
# identically to 772.marian_r, but its run lines differ at every size, so an
# inherit would mean tagging nearly every run line in both files with
# SUITE_TYPE. Emitted in full instead.

###############################################################################
# marian-decoder
###############################################################################

speccpu2026_add_include_dirs(
  marian/3rd_party/sentencepiece
  marian/3rd_party/sentencepiece/src/builtin_pb
  marian/3rd_party/sentencepiece/third_party/protobuf-lite
  marian/3rd_party
  marian/3rd_party/intgemm
  marian/data
  marian/common
  marian/tensors
  marian/graph
  marian
  specrand
)

add_definitions(
  -D_USE_INTERNAL_STRING_VIEW
  -DCOMPILE_CPU=1
  -DUSE_SENTENCEPIECE
  -DPHF_HAVE_COMPUTED_GOTOS=0
)

add_compile_options(-pthread)
list(APPEND LDFLAGS -pthread)

## test ######################################################################

speccpu2026_run_test(
  --cpu-threads 1 -m model.alphas.npz -v vocab.spm vocab.spm --beam-size 1
  --mini-batch 32 --maxi-batch 100 --maxi-batch-sort src -w 64 --skip-cost
  --gemm-type intgemm8 --intgemm-options precomputed-alpha standard-only
  --quiet --quiet-translation -i TildeMODEL-test.en --log TildeMODEL-test.log
  --log-level off -o TildeMODEL-test.out
  STDOUT run_TildeMODEL-test.out.out
  STDERR run_TildeMODEL-test.out.err
  RUN_TYPE test
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.text_compare
  TildeMODEL-test.out compare/TildeMODEL-test.out
  STDOUT compare_TildeMODEL-test.out.out
  STDERR compare_TildeMODEL-test.out.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  --cpu-threads 1 -m model.alphas.npz -v vocab.spm vocab.spm --beam-size 2
  --mini-batch 32 --maxi-batch 100 --maxi-batch-sort src -w 64 --skip-cost
  --gemm-type intgemm8 --intgemm-options precomputed-alpha standard-only
  --quiet --quiet-translation -i technology_and_courage.en
  --log technology_and_courage.log --log-level off
  -o technology_and_courage.out
  STDOUT run_technology_and_courage.out.out
  STDERR run_technology_and_courage.out.err
  RUN_TYPE train
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.text_compare
  technology_and_courage.out compare/technology_and_courage.out
  STDOUT compare_technology_and_courage.out.out
  STDERR compare_technology_and_courage.out.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  --cpu-threads 1 -m model.alphas.npz -v vocab.spm vocab.spm --beam-size 8
  --mini-batch 32 --maxi-batch 100 --maxi-batch-sort src -w 64 --skip-cost
  --gemm-type intgemm8 --intgemm-options precomputed-alpha standard-only
  --quiet --quiet-translation -i TildeMODEL-spec-long.en
  --log TildeMODEL-spec.log --log-level off -o TildeMODEL-spec.out
  STDOUT run_TildeMODEL-spec.out.out
  STDERR run_TildeMODEL-spec.out.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  --cpu-threads 1 -m model.alphas.npz -v vocab.spm vocab.spm --beam-size 8
  --mini-batch 32 --maxi-batch 100 --maxi-batch-sort trg -w 64 --skip-cost
  --gemm-type intgemm8 --intgemm-options precomputed-alpha standard-only
  --quiet --quiet-translation -i EuroPat-spec-long.en --log EuroPat-spec.log
  --log-level off -o EuroPat-spec.out
  STDOUT run_EuroPat-spec.out.out
  STDERR run_EuroPat-spec.out.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.text_compare
  TildeMODEL-spec.out compare/TildeMODEL-spec.out
  STDOUT compare_TildeMODEL-spec.out.out
  STDERR compare_TildeMODEL-spec.out.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.text_compare
  EuroPat-spec.out compare/EuroPat-spec.out
  STDOUT compare_EuroPat-spec.out.out
  STDERR compare_EuroPat-spec.out.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output(
  ABSOLUTE_TOLERANCE 0.01
  FILES
    compare_EuroPat-spec.out.out
    compare_TildeMODEL-spec.out.out
    compare_TildeMODEL-test.out.out
    compare_technology_and_courage.out.out
)

speccpu2026_add_executable(
  marian/command/marian_decoder.cpp
  marian/common/aliases.cpp
  marian/common/binary.cpp
  marian/common/cli_helper.cpp
  marian/common/cli_wrapper.cpp
  marian/common/config.cpp
  marian/common/config_parser.cpp
  marian/common/config_validator.cpp
  marian/common/fastopt.cpp
  marian/common/file_stream.cpp
  marian/common/file_utils.cpp
  marian/common/filesystem.cpp
  marian/common/io.cpp
  marian/common/logging.cpp
  marian/common/options.cpp
  marian/common/signal_handling.cpp
  marian/common/types.cpp
  marian/common/utils.cpp
  marian/common/version.cpp
  marian/data/alignment.cpp
  marian/data/corpus.cpp
  marian/data/corpus_base.cpp
  marian/data/corpus_nbest.cpp
  marian/data/default_vocab.cpp
  marian/data/factored_vocab.cpp
  marian/data/sentencepiece_vocab.cpp
  marian/data/shortlist.cpp
  marian/data/text_input.cpp
  marian/data/vocab.cpp
  marian/embedder/vector_collector.cpp
  marian/graph/expression_graph.cpp
  marian/graph/expression_operators.cpp
  marian/graph/node.cpp
  marian/graph/node_initializers.cpp
  marian/graph/node_operators.cpp
  marian/layers/convolution.cpp
  marian/layers/embedding.cpp
  marian/layers/generic.cpp
  marian/layers/logits.cpp
  marian/layers/loss.cpp
  marian/layers/lsh.cpp
  marian/layers/output.cpp
  marian/layers/weight.cpp
  marian/microsoft/quicksand.cpp
  marian/microsoft/shortlist/utils/Converter.cpp
  marian/microsoft/shortlist/utils/ParameterTree.cpp
  marian/microsoft/shortlist/utils/StringUtils.cpp
  marian/models/costs.cpp
  marian/models/encoder_decoder.cpp
  marian/models/model_factory.cpp
  marian/models/transformer_stub.cpp
  marian/rescorer/score_collector.cpp
  marian/rnn/attention.cpp
  marian/rnn/cells.cpp
  marian/tensors/backend.cpp
  marian/tensors/cpu/device.cpp
  marian/tensors/cpu/integer_common.cpp
  marian/tensors/cpu/prod.cpp
  marian/tensors/cpu/tensor_operators.cpp
  marian/tensors/cpu/topk.cpp
  marian/tensors/rand.cpp
  marian/tensors/tensor.cpp
  marian/translator/beam_search.cpp
  marian/translator/helpers.cpp
  marian/translator/history.cpp
  marian/translator/nth_element.cpp
  marian/translator/output_collector.cpp
  marian/translator/output_printer.cpp
  marian/translator/scorers.cpp
  marian/3rd_party/cnpy/cnpy.cpp
  marian/3rd_party/pathie-cpp/src/entry_iterator.cpp
  marian/3rd_party/pathie-cpp/src/errors.cpp
  marian/3rd_party/pathie-cpp/src/path.cpp
  marian/3rd_party/pathie-cpp/src/pathie.cpp
  marian/3rd_party/pathie-cpp/src/pathie_ifstream.cpp
  marian/3rd_party/pathie-cpp/src/pathie_ofstream.cpp
  marian/3rd_party/pathie-cpp/src/temp.cpp
  marian/3rd_party/phf/phf.cc
  marian/3rd_party/sentencepiece/src/bpe_model.cc
  marian/3rd_party/sentencepiece/src/builtin_pb/sentencepiece.pb.cc
  marian/3rd_party/sentencepiece/src/builtin_pb/sentencepiece_model.pb.cc
  marian/3rd_party/sentencepiece/src/case_encoder.cc
  marian/3rd_party/sentencepiece/src/char_model.cc
  marian/3rd_party/sentencepiece/src/error.cc
  marian/3rd_party/sentencepiece/src/filesystem.cc
  marian/3rd_party/sentencepiece/src/init.cc
  marian/3rd_party/sentencepiece/src/model_factory.cc
  marian/3rd_party/sentencepiece/src/model_interface.cc
  marian/3rd_party/sentencepiece/src/normalizer.cc
  marian/3rd_party/sentencepiece/src/sentencepiece_processor.cc
  marian/3rd_party/sentencepiece/src/unigram_model.cc
  marian/3rd_party/sentencepiece/src/util.cc
  marian/3rd_party/sentencepiece/src/word_model.cc
  marian/3rd_party/sentencepiece/third_party/absl/flags/flag.cc
  marian/3rd_party/sentencepiece/third_party/absl/strings/string_view.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/arena.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/arenastring.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/bytestream.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/coded_stream.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/common.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/extension_set.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/generated_message_table_driven_lite.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/generated_message_util.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/implicit_weak_message.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/int128.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/io_win32.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/message_lite.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/repeated_field.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/status.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/statusor.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/stringpiece.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/stringprintf.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/structurally_valid.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/strutil.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/time.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/wire_format_lite.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/zero_copy_stream.cc
  marian/3rd_party/sentencepiece/third_party/protobuf-lite/zero_copy_stream_impl_lite.cc
  marian/3rd_party/yaml-cpp/binary_renamed.cpp
  marian/3rd_party/yaml-cpp/convert.cpp
  marian/3rd_party/yaml-cpp/directives.cpp
  marian/3rd_party/yaml-cpp/emit.cpp
  marian/3rd_party/yaml-cpp/emitfromevents.cpp
  marian/3rd_party/yaml-cpp/emitter.cpp
  marian/3rd_party/yaml-cpp/emitterstate.cpp
  marian/3rd_party/yaml-cpp/emitterutils.cpp
  marian/3rd_party/yaml-cpp/exceptions.cpp
  marian/3rd_party/yaml-cpp/exp.cpp
  marian/3rd_party/yaml-cpp/memory.cpp
  marian/3rd_party/yaml-cpp/node_data.cpp
  marian/3rd_party/yaml-cpp/nodebuilder.cpp
  marian/3rd_party/yaml-cpp/nodeevents.cpp
  marian/3rd_party/yaml-cpp/null.cpp
  marian/3rd_party/yaml-cpp/ostream_wrapper.cpp
  marian/3rd_party/yaml-cpp/parse.cpp
  marian/3rd_party/yaml-cpp/parser.cpp
  marian/3rd_party/yaml-cpp/regex_yaml.cpp
  marian/3rd_party/yaml-cpp/scanner.cpp
  marian/3rd_party/yaml-cpp/scanscalar.cpp
  marian/3rd_party/yaml-cpp/scantag.cpp
  marian/3rd_party/yaml-cpp/scantoken.cpp
  marian/3rd_party/yaml-cpp/simplekey.cpp
  marian/3rd_party/yaml-cpp/singledocparser.cpp
  marian/3rd_party/yaml-cpp/stream.cpp
  marian/3rd_party/yaml-cpp/tag.cpp
  marian/3rd_party/yaml-cpp/yaml-node.cpp
  specrand/specrand.cc
)

speccpu2026_prepare_rundir()

###############################################################################
# text_compare
###############################################################################

set(PROG ${BENCHMARK}.text_compare)

# Same flags as the primary binary above; add_definitions() and
# include_directories() are directory-scoped, so they carry.

# text_compare is a post-run helper: SPEC's `sub compare_commands`
# runs it over the benchmark's output to distill the numbers
# the reference files hold. It gets no test of its own — its
# run lines are part of marian-decoder's test above — but it does
# have to be built.
set(_sources)
foreach (_f IN ITEMS
    compare/text_compare.cpp
  )
  list(APPEND _sources "${SRC_DIR}/${_f}")
endforeach ()
llvm_test_executable_no_test(${PROG} ${_sources})

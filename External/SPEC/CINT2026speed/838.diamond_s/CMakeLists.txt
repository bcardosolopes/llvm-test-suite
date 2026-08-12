# 838.diamond_s
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
  bbuchfink-diamond/src/lib/Eigen
  bbuchfink-diamond/src/lib
  zlib
  specrand
  specrand-distributions
  spec_restrict
  spec_inline_control
)

add_definitions(
  -DSEQ_MASK
  -DSTRICT_BAND
  -DDISPATCH_ARCH=ARCH_GENERIC
)

add_compile_options(-pthread)
list(APPEND LDFLAGS -pthread)

## test ######################################################################

speccpu2026_run_test(
  blastp -q astral-scopedom-seqres-gd-sel-gs-bib-40-2.07.fa.gz
  -d astral-scopedom-seqres-gd-sel-gs-bib-40-2.07.fa.gz --fast --outfmt 6
  qseqid sseqid slen mismatch gapopen qstart qend sstart send nident bitscore
  -o astral40.tsv -p 1
  STDOUT astral-scopedom-seqres-gd-sel-gs-bib-40-2.07.fa.gz.out
  STDERR astral-scopedom-seqres-gd-sel-gs-bib-40-2.07.fa.gz.err
  RUN_TYPE test
)

speccpu2026_run_test(
  SPEC_BINARY specperl
  sort.pl astral40.tsv
  STDOUT astral40.tsv.sort.out
  STDERR astral40.tsv.sort.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  blastp -q astral-scopedom-seqres-gd-sel-gs-bib-40-2.07.fa.gz
  -d astral-scopedom-seqres-gd-sel-gs-bib-40-2.07.fa.gz --mid-sensitive
  --outfmt 6 qseqid sseqid slen mismatch gapopen qstart qend sstart send
  nident bitscore -o astral40.tsv -p 1
  STDOUT astral-scopedom-seqres-gd-sel-gs-bib-40-2.07.fa.gz.out
  STDERR astral-scopedom-seqres-gd-sel-gs-bib-40-2.07.fa.gz.err
  RUN_TYPE train
)

speccpu2026_run_test(
  SPEC_BINARY specperl
  sort.pl astral40.tsv
  STDOUT astral40.tsv.sort.out
  STDERR astral40.tsv.sort.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  blastp -q uniprot_sprot.fasta.gz -d uniprot_sprot.fasta.gz --index-chunks 1
  --fast --masking tantan --outfmt 6 qseqid sseqid slen mismatch gapopen
  qstart qend sstart send -o uniprot.tsv -p 1
  STDOUT uniprot_sprot.fasta.gz.out
  STDERR uniprot_sprot.fasta.gz.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  blastp -q cRAP.fasta.gz -d swissprot.fasta --ultra-sensitive
  --index-chunks 4 --block-size 2.8 --masking seg --evalue 0.0005 --outfmt 6
  qseqid sseqid slen mismatch gapopen qstart qend sstart send -o cRAP.tsv -p 1
  STDOUT cRAP.fasta.gz.out
  STDERR cRAP.fasta.gz.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  SPEC_BINARY specperl
  sort.pl uniprot.tsv
  STDOUT uniprot.tsv.sort.out
  STDERR uniprot.tsv.sort.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  SPEC_BINARY specperl
  sort.pl cRAP.tsv
  STDOUT cRAP.tsv.sort.out
  STDERR cRAP.tsv.sort.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output()

speccpu2026_add_executable(
  specrand/specrand.cc
  bbuchfink-diamond/src/align/align.cpp
  bbuchfink-diamond/src/align/alt_hsp.cpp
  bbuchfink-diamond/src/align/culling.cpp
  bbuchfink-diamond/src/align/extend.cpp
  bbuchfink-diamond/src/align/full_db.cpp
  bbuchfink-diamond/src/align/gapped_filter.cpp
  bbuchfink-diamond/src/align/gapped_final.cpp
  bbuchfink-diamond/src/align/gapped_score.cpp
  bbuchfink-diamond/src/align/global_ranking/extend.cpp
  bbuchfink-diamond/src/align/global_ranking/global_ranking.cpp
  bbuchfink-diamond/src/align/global_ranking/table.cpp
  bbuchfink-diamond/src/align/legacy/banded_swipe_pipeline.cpp
  bbuchfink-diamond/src/align/legacy/query_mapper.cpp
  bbuchfink-diamond/src/align/output.cpp
  bbuchfink-diamond/src/align/short.cpp
  bbuchfink-diamond/src/align/ungapped.cpp
  bbuchfink-diamond/src/basic/basic.cpp
  bbuchfink-diamond/src/basic/config.cpp
  bbuchfink-diamond/src/basic/hssp.cpp
  bbuchfink-diamond/src/basic/value.cpp
  bbuchfink-diamond/src/chaining/backtrace.cpp
  bbuchfink-diamond/src/chaining/greedy_align.cpp
  bbuchfink-diamond/src/chaining/hamming_ext.cpp
  bbuchfink-diamond/src/chaining/smith_waterman.cpp
  bbuchfink-diamond/src/cluster/cascaded/cascaded.cpp
  bbuchfink-diamond/src/cluster/cascaded/helpers.cpp
  bbuchfink-diamond/src/cluster/cascaded/recluster.cpp
  bbuchfink-diamond/src/cluster/cascaded/wrapper.cpp
  bbuchfink-diamond/src/cluster/cluster_registry.cpp
  bbuchfink-diamond/src/cluster/helpers.cpp
  bbuchfink-diamond/src/cluster/incremental/config.cpp
  bbuchfink-diamond/src/cluster/incremental/run.cpp
  bbuchfink-diamond/src/cluster/output.cpp
  bbuchfink-diamond/src/cluster/realign.cpp
  bbuchfink-diamond/src/cluster/reassign.cpp
  bbuchfink-diamond/src/data/block/block.cpp
  bbuchfink-diamond/src/data/block/block_wrapper.cpp
  bbuchfink-diamond/src/data/dmnd/dmnd.cpp
  bbuchfink-diamond/src/data/fasta/fasta_file.cpp
  bbuchfink-diamond/src/data/frequent_seeds.cpp
  bbuchfink-diamond/src/data/index.cpp
  bbuchfink-diamond/src/data/queries.cpp
  bbuchfink-diamond/src/data/seed_array.cpp
  bbuchfink-diamond/src/data/seed_histogram.cpp
  bbuchfink-diamond/src/data/seed_set.cpp
  bbuchfink-diamond/src/data/sequence_file.cpp
  bbuchfink-diamond/src/data/sequence_set.cpp
  bbuchfink-diamond/src/data/taxon_list.cpp
  bbuchfink-diamond/src/data/taxonomy.cpp
  bbuchfink-diamond/src/data/taxonomy_nodes.cpp
  bbuchfink-diamond/src/dna/smith_watermann.cpp
  bbuchfink-diamond/src/dna/seed_set_dna.cpp
  bbuchfink-diamond/src/dna/dna_index.cpp
  bbuchfink-diamond/src/dp/pfscan/pfscan.cpp
  bbuchfink-diamond/src/dp/scalar/smith_waterman.cpp
  bbuchfink-diamond/src/dp/scan_diags.cpp
  bbuchfink-diamond/src/dp/score_profile.cpp
  bbuchfink-diamond/src/dp/swipe/anchored_wrapper.cpp
  bbuchfink-diamond/src/dp/swipe/banded_3frame_swipe.cpp
  bbuchfink-diamond/src/dp/swipe/swipe_wrapper.cpp
  bbuchfink-diamond/src/dp/ungapped_align.cpp
  bbuchfink-diamond/src/dp/ungapped_simd.cpp
  bbuchfink-diamond/src/lib/alp/njn_dynprogprob.cpp
  bbuchfink-diamond/src/lib/alp/njn_dynprogproblim.cpp
  bbuchfink-diamond/src/lib/alp/njn_dynprogprobproto.cpp
  bbuchfink-diamond/src/lib/alp/njn_ioutil.cpp
  bbuchfink-diamond/src/lib/alp/njn_localmaxstat.cpp
  bbuchfink-diamond/src/lib/alp/njn_localmaxstatmatrix.cpp
  bbuchfink-diamond/src/lib/alp/njn_localmaxstatutil.cpp
  bbuchfink-diamond/src/lib/alp/njn_random.cpp
  bbuchfink-diamond/src/lib/alp/sls_alignment_evaluer.cpp
  bbuchfink-diamond/src/lib/alp/sls_alp.cpp
  bbuchfink-diamond/src/lib/alp/sls_alp_data.cpp
  bbuchfink-diamond/src/lib/alp/sls_alp_regression.cpp
  bbuchfink-diamond/src/lib/alp/sls_alp_sim.cpp
  bbuchfink-diamond/src/lib/alp/sls_basic.cpp
  bbuchfink-diamond/src/lib/alp/sls_pvalues.cpp
  bbuchfink-diamond/src/lib/blast/blast_filter.cpp
  bbuchfink-diamond/src/lib/blast/blast_message.cpp
  bbuchfink-diamond/src/lib/blast/blast_seg.cpp
  bbuchfink-diamond/src/lib/blast/blast_stat.cpp
  bbuchfink-diamond/src/lib/blast/blastn_score.cpp
  bbuchfink-diamond/src/lib/blast/ncbi_std.cpp
  bbuchfink-diamond/src/lib/blast/nlm_linear_algebra.cpp
  bbuchfink-diamond/src/lib/tantan/LambdaCalculator.cc
  bbuchfink-diamond/src/masking/masking.cpp
  bbuchfink-diamond/src/masking/motifs.cpp
  bbuchfink-diamond/src/masking/tantan.cpp
  bbuchfink-diamond/src/output/blast_pairwise_format.cpp
  bbuchfink-diamond/src/output/blast_tab_format.cpp
  bbuchfink-diamond/src/output/clustering_format.cpp
  bbuchfink-diamond/src/output/clustering_variables.cpp
  bbuchfink-diamond/src/output/daa/daa_record.cpp
  bbuchfink-diamond/src/output/daa/daa_write.cpp
  bbuchfink-diamond/src/output/daa/merge.cpp
  bbuchfink-diamond/src/output/daa/view.cpp
  bbuchfink-diamond/src/output/join_blocks.cpp
  bbuchfink-diamond/src/output/output_format.cpp
  bbuchfink-diamond/src/output/output_sink.cpp
  bbuchfink-diamond/src/output/paf_format.cpp
  bbuchfink-diamond/src/output/sam_format.cpp
  bbuchfink-diamond/src/output/target_culling.cpp
  bbuchfink-diamond/src/output/taxon_format.cpp
  bbuchfink-diamond/src/output/xml_format.cpp
  bbuchfink-diamond/src/run/config.cpp
  bbuchfink-diamond/src/run/double_indexed.cpp
  bbuchfink-diamond/src/run/main.cpp
  bbuchfink-diamond/src/run/tools.cpp
  bbuchfink-diamond/src/search/kmer_ranking.cpp
  bbuchfink-diamond/src/search/seed_complexity.cpp
  bbuchfink-diamond/src/search/setup.cpp
  bbuchfink-diamond/src/search/stage0.cpp
  bbuchfink-diamond/src/search/stage2.cpp
  bbuchfink-diamond/src/stats/cbs.cpp
  bbuchfink-diamond/src/stats/comp_based_stats.cpp
  bbuchfink-diamond/src/stats/dna_scoring/build_score.cpp
  bbuchfink-diamond/src/stats/hauser_correction.cpp
  bbuchfink-diamond/src/stats/matrices/blosum45.cpp
  bbuchfink-diamond/src/stats/matrices/blosum50.cpp
  bbuchfink-diamond/src/stats/matrices/blosum62.cpp
  bbuchfink-diamond/src/stats/matrices/blosum80.cpp
  bbuchfink-diamond/src/stats/matrices/blosum90.cpp
  bbuchfink-diamond/src/stats/matrices/pam250.cpp
  bbuchfink-diamond/src/stats/matrices/pam30.cpp
  bbuchfink-diamond/src/stats/matrices/pam70.cpp
  bbuchfink-diamond/src/stats/matrix_adjust.cpp
  bbuchfink-diamond/src/stats/matrix_adjust_eigen.cpp
  bbuchfink-diamond/src/stats/score_matrix.cpp
  bbuchfink-diamond/src/stats/stats.cpp
  bbuchfink-diamond/src/test/data.cpp
  bbuchfink-diamond/src/test/test.cpp
  bbuchfink-diamond/src/test/test_cases.cpp
  bbuchfink-diamond/src/tools/benchmark.cpp
  bbuchfink-diamond/src/tools/benchmark_io.cpp
  bbuchfink-diamond/src/tools/find_shapes.cpp
  bbuchfink-diamond/src/tools/greedy_vertex_cover.cpp
  bbuchfink-diamond/src/tools/join.cpp
  bbuchfink-diamond/src/tools/roc.cpp
  bbuchfink-diamond/src/tools/rocid.cpp
  bbuchfink-diamond/src/tools/tools.cpp
  bbuchfink-diamond/src/tools/tsv_record.cpp
  bbuchfink-diamond/src/tools/tsv.cpp
  bbuchfink-diamond/src/tools/view.cpp
  bbuchfink-diamond/src/util/algo/MurmurHash3.cpp
  bbuchfink-diamond/src/util/algo/edge_vec.cpp
  bbuchfink-diamond/src/util/algo/greedy_vertex_cover.cpp
  bbuchfink-diamond/src/util/command_line_parser.cpp
  bbuchfink-diamond/src/util/io/compressed_stream.cpp
  bbuchfink-diamond/src/util/io/deserializer.cpp
  bbuchfink-diamond/src/util/io/file_sink.cpp
  bbuchfink-diamond/src/util/io/file_source.cpp
  bbuchfink-diamond/src/util/io/input_file.cpp
  bbuchfink-diamond/src/util/io/input_stream_buffer.cpp
  bbuchfink-diamond/src/util/io/output_file.cpp
  bbuchfink-diamond/src/util/io/output_stream_buffer.cpp
  bbuchfink-diamond/src/util/io/serializer.cpp
  bbuchfink-diamond/src/util/io/temp_file.cpp
  bbuchfink-diamond/src/util/io/text_input_file.cpp
  bbuchfink-diamond/src/util/parallel/filestack.cpp
  bbuchfink-diamond/src/util/parallel/multiprocessing.cpp
  bbuchfink-diamond/src/util/parallel/parallelizer.cpp
  bbuchfink-diamond/src/util/seq_file_format.cpp
  bbuchfink-diamond/src/util/sequence/sequence.cpp
  bbuchfink-diamond/src/util/simd.cpp
  bbuchfink-diamond/src/util/string/string.cpp
  bbuchfink-diamond/src/util/system/system.cpp
  bbuchfink-diamond/src/util/tsv/file.cpp
  bbuchfink-diamond/src/util/tsv/join.cpp
  bbuchfink-diamond/src/util/tsv/merge.cpp
  bbuchfink-diamond/src/util/tsv/read_tsv.cpp
  bbuchfink-diamond/src/util/tsv/record.cpp
  bbuchfink-diamond/src/util/tsv/table.cpp
  bbuchfink-diamond/src/util/tsv/tsv.cpp
  bbuchfink-diamond/src/util/util.cpp
  zlib/adler32.c
  zlib/compress.c
  zlib/crc32.c
  zlib/deflate.c
  zlib/gzread.c
  zlib/gzclose.c
  zlib/gzwrite.c
  zlib/gzlib.c
  zlib/infback.c
  zlib/inffast.c
  zlib/inflate.c
  zlib/inftrees.c
  zlib/trees.c
  zlib/uncompr.c
  zlib/zutil.c
)

speccpu2026_prepare_rundir()

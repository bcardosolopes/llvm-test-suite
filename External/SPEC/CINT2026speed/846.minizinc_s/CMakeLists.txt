# 846.minizinc_s
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
  mzn/include
  mzn/lib/cached
  .
  spec_inline_control
  specrand-distributions
)

add_definitions(
  -DHAS_CHUFFED
  -DHAS_GECODE
  -DGECODE_STATIC_LIBS
)

add_compile_options(-pthread)
list(APPEND LDFLAGS -pthread)

## test ######################################################################

speccpu2026_run_test(
  --stdlib-dir share/minizinc -r 214365 --output-mode json
  --solver share/minizinc/solvers/chuffed.msc -s -f radiation.mzn
  STDOUT radiation.mzn.out
  STDERR radiation.mzn.err
  RUN_TYPE test
)

speccpu2026_run_test(
  --stdlib-dir share/minizinc -r 214365 --output-mode json
  --solver gecode_presolver -s tennis_problem.mzn
  STDOUT tennis_problem.mzn.out
  STDERR tennis_problem.mzn.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  --stdlib-dir share/minizinc -r 214365 --output-mode json
  --solver share/minizinc/solvers/chuffed.msc -s -f sudoku_opt.mzn
  sudoku_p29.dzn
  STDOUT sudoku_p29.dzn.out
  STDERR sudoku_p29.dzn.err
  RUN_TYPE train
)

speccpu2026_run_test(
  --stdlib-dir share/minizinc -r 214365 --output-mode json
  --solver gecode_presolver -s farmer_and_cows.mzn
  STDOUT farmer_and_cows.mzn.out
  STDERR farmer_and_cows.mzn.err
  RUN_TYPE train
)

speccpu2026_run_test(
  --stdlib-dir share/minizinc -r 214365 --output-mode json
  --solver gecode_presolver --solver-statistics roster-sickness.mzn
  large-2-2.dzn -p 1
  STDOUT large-2-2.dzn.out
  STDERR large-2-2.dzn.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  --stdlib-dir share/minizinc -r 214365 --output-mode json
  --solver gecode_presolver --two-pass -s gunport_problem2.mzn
  STDOUT gunport_problem2.mzn.out
  STDERR gunport_problem2.mzn.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  --stdlib-dir share/minizinc -r 214365 --output-mode json
  --solver share/minizinc/solvers/chuffed.msc -f -s yumi-dynamic.mzn
  STDOUT yumi-dynamic.mzn.out
  STDERR yumi-dynamic.mzn.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  --stdlib-dir share/minizinc -r 214365 --output-mode json
  --solver gecode_presolver --solver-statistics pennies.mzn pennies_7_8.dzn
  -p 1
  STDOUT pennies_7_8.dzn.out
  STDERR pennies_7_8.dzn.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  --stdlib-dir share/minizinc -r 214365 --output-mode json
  --solver gecode_presolver --solver-statistics roster-sickness.mzn
  small-4.dzn -p 1
  STDOUT small-4.dzn.out
  STDERR small-4.dzn.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output(
  RELATIVE_TOLERANCE 3e-05
)

speccpu2026_add_executable(
  gecode/int/cumulative.cpp
  mzn/lib/builtins.cpp
  mzn/lib/eval_par.cpp
  mzn/lib/flatten.cpp
  mzn/lib/typecheck.cpp
  chuffed/branching/branching.cpp
  chuffed/branching/impact.cpp
  chuffed/core/conflict.cpp
  chuffed/core/engine.cpp
  chuffed/core/init.cpp
  chuffed/core/options.cpp
  chuffed/core/sat.cpp
  chuffed/core/stats.cpp
  chuffed/flatzinc/flatzinc.cpp
  chuffed/flatzinc/registry.cpp
  chuffed/globals/EdExplFinder.cpp
  chuffed/globals/alldiff.cpp
  chuffed/globals/bool_arg_max.cpp
  chuffed/globals/bounded_path.cpp
  chuffed/globals/circuit.cpp
  chuffed/globals/cumulative.cpp
  chuffed/globals/cumulativeCalendar.cpp
  chuffed/globals/dag.cpp
  chuffed/globals/dconnected.cpp
  chuffed/globals/directives.cpp
  chuffed/globals/disjunctive.cpp
  chuffed/globals/dtree.cpp
  chuffed/globals/edit_distance.cpp
  chuffed/globals/graph.cpp
  chuffed/globals/lex.cpp
  chuffed/globals/linear-bool-decomp.cpp
  chuffed/globals/linear-bool.cpp
  chuffed/globals/mddglobals.cpp
  chuffed/globals/minimum.cpp
  chuffed/globals/minimum_weight_tree.cpp
  chuffed/globals/mst.cpp
  chuffed/globals/regular.cpp
  chuffed/globals/subcircuit.cpp
  chuffed/globals/sym-break.cpp
  chuffed/globals/table.cpp
  chuffed/globals/template.cpp
  chuffed/globals/tree.cpp
  chuffed/globals/value-precede.cpp
  chuffed/globals/well-founded.cpp
  chuffed/ldsb/ldsb.cpp
  chuffed/mdd/MDD.cpp
  chuffed/mdd/mdd_prop.cpp
  chuffed/mdd/mdd_to_lgraph.cpp
  chuffed/mdd/opcache.cpp
  chuffed/mdd/weighted_dfa.cpp
  chuffed/mdd/wmdd_prop.cpp
  chuffed/mip/mip.cpp
  chuffed/mip/recalc.cpp
  chuffed/mip/simplex.cpp
  chuffed/primitives/arithmetic.cpp
  chuffed/primitives/binary.cpp
  chuffed/primitives/bool.cpp
  chuffed/primitives/domain.cpp
  chuffed/primitives/element.cpp
  chuffed/primitives/linear.cpp
  chuffed/support/dijkstra.cpp
  chuffed/support/kosaraju_scc.cpp
  chuffed/support/lengauer_tarjan.cpp
  chuffed/support/union_find.cpp
  chuffed/vars/bool-view.cpp
  chuffed/vars/int-var-el.cpp
  chuffed/vars/int-var-ll.cpp
  chuffed/vars/int-var-sl.cpp
  chuffed/vars/int-var.cpp
  chuffed/vars/modelling.cpp
  gecode/driver/options.cpp
  gecode/driver/script.cpp
  gecode/flatzinc/branch.cpp
  gecode/flatzinc/flatzinc.cpp
  gecode/flatzinc/lexer.yy.cpp
  gecode/flatzinc/parser.tab.cpp
  gecode/flatzinc/registry.cpp
  gecode/int/arithmetic.cpp
  gecode/int/arithmetic/mult.cpp
  gecode/int/array.cpp
  gecode/int/bin-packing.cpp
  gecode/int/bin-packing/conflict-graph.cpp
  gecode/int/bin-packing/propagate.cpp
  gecode/int/bool.cpp
  gecode/int/bool/eqv.cpp
  gecode/int/branch.cpp
  gecode/int/branch/action.cpp
  gecode/int/branch/chb.cpp
  gecode/int/branch/val-sel-commit.cpp
  gecode/int/branch/view-sel.cpp
  gecode/int/branch/view-values.cpp
  gecode/int/channel.cpp
  gecode/int/channel/link-multi.cpp
  gecode/int/channel/link-single.cpp
  gecode/int/circuit.cpp
  gecode/int/count.cpp
  gecode/int/cumulatives.cpp
  gecode/int/distinct.cpp
  gecode/int/distinct/cbs.cpp
  gecode/int/distinct/eqite.cpp
  gecode/int/dom.cpp
  gecode/int/element.cpp
  gecode/int/element/pair.cpp
  gecode/int/exception.cpp
  gecode/int/exec.cpp
  gecode/int/exec/when.cpp
  gecode/int/extensional-regular.cpp
  gecode/int/extensional-tuple-set.cpp
  gecode/int/extensional/dfa.cpp
  gecode/int/extensional/tuple-set.cpp
  gecode/int/gcc.cpp
  gecode/int/int-set.cpp
  gecode/int/ldsb.cpp
  gecode/int/ldsb/sym-imp.cpp
  gecode/int/ldsb/sym-obj.cpp
  gecode/int/linear-bool.cpp
  gecode/int/linear-int.cpp
  gecode/int/linear/bool-post.cpp
  gecode/int/linear/int-post.cpp
  gecode/int/member.cpp
  gecode/int/no-overlap.cpp
  gecode/int/nvalues.cpp
  gecode/int/order.cpp
  gecode/int/order/propagate.cpp
  gecode/int/precede.cpp
  gecode/int/rel.cpp
  gecode/int/relax.cpp
  gecode/int/sequence.cpp
  gecode/int/sorted.cpp
  gecode/int/trace.cpp
  gecode/int/trace/tracer.cpp
  gecode/int/unary.cpp
  gecode/int/unshare.cpp
  gecode/int/var-imp/bool.cpp
  gecode/int/var-imp/int.cpp
  gecode/int/var/bool.cpp
  gecode/int/var/int.cpp
  gecode/kernel/archive.cpp
  gecode/kernel/branch/action.cpp
  gecode/kernel/branch/afc.cpp
  gecode/kernel/branch/chb.cpp
  gecode/kernel/branch/function.cpp
  gecode/kernel/core.cpp
  gecode/kernel/data/array.cpp
  gecode/kernel/data/rnd.cpp
  gecode/kernel/exception.cpp
  gecode/kernel/gpi.cpp
  gecode/kernel/memory/manager.cpp
  gecode/kernel/memory/region.cpp
  gecode/kernel/trace/filter.cpp
  gecode/kernel/trace/general.cpp
  gecode/kernel/trace/recorder.cpp
  gecode/kernel/trace/tracer.cpp
  gecode/minimodel/bool-expr.cpp
  gecode/minimodel/dom.cpp
  gecode/minimodel/exception.cpp
  gecode/minimodel/float-arith.cpp
  gecode/minimodel/float-expr.cpp
  gecode/minimodel/float-rel.cpp
  gecode/minimodel/int-arith.cpp
  gecode/minimodel/int-expr.cpp
  gecode/minimodel/int-rel.cpp
  gecode/minimodel/ipl.cpp
  gecode/minimodel/optimize.cpp
  gecode/minimodel/reg.cpp
  gecode/minimodel/set-expr.cpp
  gecode/minimodel/set-rel.cpp
  gecode/search/bab.cpp
  gecode/search/cpprofiler/tracer.cpp
  gecode/search/cutoff.cpp
  gecode/search/dfs.cpp
  gecode/search/engine.cpp
  gecode/search/exception.cpp
  gecode/search/lds.cpp
  gecode/search/nogoods.cpp
  gecode/search/options.cpp
  gecode/search/par/pbs.cpp
  gecode/search/pbs.cpp
  gecode/search/rbs.cpp
  gecode/search/seq/dead.cpp
  gecode/search/seq/pbs.cpp
  gecode/search/seq/rbs.cpp
  gecode/search/stop.cpp
  gecode/search/tracer.cpp
  gecode/set/array.cpp
  gecode/set/bool.cpp
  gecode/set/branch.cpp
  gecode/set/branch/action.cpp
  gecode/set/branch/chb.cpp
  gecode/set/branch/ngl.cpp
  gecode/set/branch/val-sel-commit.cpp
  gecode/set/branch/view-sel.cpp
  gecode/set/cardinality.cpp
  gecode/set/channel.cpp
  gecode/set/convex.cpp
  gecode/set/convex/conv.cpp
  gecode/set/convex/hull.cpp
  gecode/set/distinct.cpp
  gecode/set/distinct/atmostOne.cpp
  gecode/set/dom.cpp
  gecode/set/element.cpp
  gecode/set/exception.cpp
  gecode/set/exec.cpp
  gecode/set/int.cpp
  gecode/set/ldsb.cpp
  gecode/set/ldsb/sym-imp.cpp
  gecode/set/precede.cpp
  gecode/set/rel-op-const-cvc.cpp
  gecode/set/rel-op-const-cvv.cpp
  gecode/set/rel-op-const-vcc.cpp
  gecode/set/rel-op-const-vcv.cpp
  gecode/set/rel-op-const-vvc.cpp
  gecode/set/rel-op-singleton.cpp
  gecode/set/rel-op-ternary.cpp
  gecode/set/rel-op.cpp
  gecode/set/rel-op/post-compl-cvc.cpp
  gecode/set/rel-op/post-compl-cvv.cpp
  gecode/set/rel-op/post-compl-vvc.cpp
  gecode/set/rel-op/post-compl.cpp
  gecode/set/rel-op/post-nocompl-cvc.cpp
  gecode/set/rel-op/post-nocompl-cvv.cpp
  gecode/set/rel-op/post-nocompl-vvc.cpp
  gecode/set/rel-op/post-nocompl.cpp
  gecode/set/rel.cpp
  gecode/set/relax.cpp
  gecode/set/sequence.cpp
  gecode/set/sequence/seq-u.cpp
  gecode/set/sequence/seq.cpp
  gecode/set/trace.cpp
  gecode/set/trace/tracer.cpp
  gecode/set/var-imp/integerset.cpp
  gecode/set/var-imp/set.cpp
  gecode/set/var/set.cpp
  gecode/support/allocator.cpp
  gecode/support/exception.cpp
  gecode/support/heap.cpp
  gecode/support/thread/cpp.cpp
  gecode/support/thread/thread.cpp
  mzn/lib/MIPdomains.cpp
  mzn/lib/algorithms/min_cut.cpp
  mzn/lib/ast.cpp
  mzn/lib/astexception.cpp
  mzn/lib/aststring.cpp
  mzn/lib/astvec.cpp
  mzn/lib/cached/lexer.yy.cpp
  mzn/lib/cached/parser.tab.cpp
  mzn/lib/cached/regex_lexer.yy.cpp
  mzn/lib/cached/regex_parser.tab.cpp
  mzn/lib/chain_compressor.cpp
  mzn/lib/copy.cpp
  mzn/lib/exception.cpp
  mzn/lib/file_utils.cpp
  mzn/lib/flatten/flat_exp.cpp
  mzn/lib/flatten/flatten_anon.cpp
  mzn/lib/flatten/flatten_arrayaccess.cpp
  mzn/lib/flatten/flatten_arraylit.cpp
  mzn/lib/flatten/flatten_binop.cpp
  mzn/lib/flatten/flatten_call.cpp
  mzn/lib/flatten/flatten_comp.cpp
  mzn/lib/flatten/flatten_fieldaccess.cpp
  mzn/lib/flatten/flatten_id.cpp
  mzn/lib/flatten/flatten_ite.cpp
  mzn/lib/flatten/flatten_let.cpp
  mzn/lib/flatten/flatten_par.cpp
  mzn/lib/flatten/flatten_setlit.cpp
  mzn/lib/flatten/flatten_unop.cpp
  mzn/lib/flatten/flatten_vardecl.cpp
  mzn/lib/flattener.cpp
  mzn/lib/gc.cpp
  mzn/lib/htmlprinter.cpp
  mzn/lib/json_parser.cpp
  mzn/lib/model.cpp
  mzn/lib/optimize.cpp
  mzn/lib/optimize_constraints.cpp
  mzn/lib/output.cpp
  mzn/lib/param_config.cpp
  mzn/lib/parser.cpp
  mzn/lib/passes/compile_pass.cpp
  mzn/lib/passes/gecode_pass.cpp
  mzn/lib/pathfileprinter.cpp
  mzn/lib/prettyprinter.cpp
  mzn/lib/solns2out.cpp
  mzn/lib/solver.cpp
  mzn/lib/solver_config.cpp
  mzn/lib/solver_instance_base.cpp
  mzn/lib/stackdump.cpp
  mzn/lib/statistics.cpp
  mzn/lib/thirdparty/cdecode.c
  mzn/lib/thirdparty/cencode.c
  mzn/lib/thirdparty/miniz.c
  mzn/lib/type.cpp
  mzn/lib/type_specialise.cpp
  mzn/lib/utils.cpp
  mzn/lib/utils_savestream.cpp
  mzn/lib/values.cpp
  mzn/lib/warning.cpp
  mzn/minizinc.cpp
  mzn/solvers/chuffed/chuffed_solverfactory.cpp
  mzn/solvers/chuffed/chuffed_solverinstance.cpp
  mzn/solvers/fzn/fzn_solverfactory.cpp
  mzn/solvers/fzn/fzn_solverinstance.cpp
  mzn/solvers/gecode/fzn_space.cpp
  mzn/solvers/gecode/gecode_constraints.cpp
  mzn/solvers/gecode/gecode_solverfactory.cpp
  mzn/solvers/gecode/gecode_solverinstance.cpp
  mzn/solvers/mzn/mzn_solverfactory.cpp
  mzn/solvers/mzn/mzn_solverinstance.cpp
  mzn/solvers/nl/nl_components.cpp
  mzn/solvers/nl/nl_file.cpp
  mzn/solvers/nl/nl_solreader.cpp
  mzn/solvers/nl/nl_solverfactory.cpp
  mzn/solvers/nl/nl_solverinstance.cpp
)

speccpu2026_prepare_rundir()

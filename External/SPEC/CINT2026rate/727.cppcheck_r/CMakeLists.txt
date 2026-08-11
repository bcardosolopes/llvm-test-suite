# 727.cppcheck_r
# Generated from SPEC's own runcpu build and setup logs by
# clangir-upstream-report/spec2026-overlay/gen-cmakelists.py, then
# reviewed by hand. Sources, -D/-I flags and RUN lines are exactly what
# runcpu used for tune=base.
include(../../SpecCPU2026.cmake)
if (NOT TEST_SUITE_SPEC2026_ROOT)
  return ()
endif ()

speccpu2026_benchmark(RATE)

###############################################################################
# cppcheck_r
###############################################################################

speccpu2026_add_include_dirs(
  externals
  externals/simplecpp
  externals/tinyxml2
  externals/picojson
  cli
  lib
  spec_inline_control
)

## test ######################################################################

speccpu2026_run_test(
  --force hello.c --output-file=hello_bogey.txt --platform=unix64
  STDOUT cppcheck_r.hello_bogey.out
  STDERR cppcheck_r.hello_bogey.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  --force lua-5.4.7/lcode.c --enable=all --checkers-report=lcode_report.txt
  --output-file=lcode_bogey.txt --suppress=missingIncludeSystem
  --platform=unix64
  STDOUT cppcheck_r.lcode_bogey.out
  STDERR cppcheck_r.lcode_bogey.err
  RUN_TYPE train
)

speccpu2026_run_test(
  --force automaticMeshSizeField.cpp meshGRegionBoundaryLayer.cpp
  meshGRegionLocalMeshMod.cpp --enable=all --checkers-report=mesh_report.txt
  --output-file=mesh_bogey.txt --enable=all --suppress=missingIncludeSystem
  --suppress=missingInclude --check-level=exhaustive --platform=unix64
  STDOUT cppcheck_r.mesh_bogey.out
  STDERR cppcheck_r.mesh_bogey.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  --force 738-diamond-record.cpp --checkers-report=738_report.txt --enable=all
  --output-file=738_bogey.txt --platform=unix64
  STDOUT cppcheck_r.738_bogey.out
  STDERR cppcheck_r.738_bogey.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  --force 747-dealii-data_out_base.cc --checkers-report=747_report.txt
  --enable=all --output-file=747_bogey.txt --platform=unix64
  STDOUT cppcheck_r.747_bogey.out
  STDERR cppcheck_r.747_bogey.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  --force 770-7z-SystemPage.cpp --checkers-report=770_report.txt
  --output-file=770_bogey.txt --platform=unix64
  STDOUT cppcheck_r.770_bogey.out
  STDERR cppcheck_r.770_bogey.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output(
  FILES
    738_bogey.txt
    738_report.txt
    747_bogey.txt
    747_report.txt
    770_bogey.txt
    770_report.txt
    cppcheck_r.738_bogey.out
    cppcheck_r.747_bogey.out
    cppcheck_r.770_bogey.out
    cppcheck_r.hello_bogey.out
    cppcheck_r.lcode_bogey.out
    cppcheck_r.mesh_bogey.out
    hello_bogey.txt
    lcode_bogey.txt
    lcode_report.txt
    mesh_bogey.txt
    mesh_report.txt
)

speccpu2026_add_executable(
  cli/main.cpp
  cli/cmdlineparser.cpp
  cli/signalhandler.cpp
  cli/singleexecutor.cpp
  cli/cppcheckexecutor.cpp
  cli/cppcheckexecutorseh.cpp
  cli/cppcheckexecutorsig.cpp
  cli/executor.cpp
  cli/filelister.cpp
  cli/processexecutor.cpp
  cli/stacktrace.cpp
  cli/threadexecutor.cpp
  lib/addoninfo.cpp
  lib/checkers.cpp
  lib/checkersreport.cpp
  lib/fwdanalysis.cpp
  lib/keywords.cpp
  lib/vfvalue.cpp
  lib/analyzerinfo.cpp
  lib/astutils.cpp
  lib/check64bit.cpp
  lib/checkassert.cpp
  lib/checkautovariables.cpp
  lib/checkbool.cpp
  lib/checkboost.cpp
  lib/checkbufferoverrun.cpp
  lib/checkclass.cpp
  lib/checkcondition.cpp
  lib/check.cpp
  lib/checkexceptionsafety.cpp
  lib/checkfunctions.cpp
  lib/checkinternal.cpp
  lib/checkio.cpp
  lib/checkleakautovar.cpp
  lib/checkmemoryleak.cpp
  lib/checknullpointer.cpp
  lib/checkother.cpp
  lib/checkpostfixoperator.cpp
  lib/checksizeof.cpp
  lib/checkstl.cpp
  lib/checkstring.cpp
  lib/checktype.cpp
  lib/checkuninitvar.cpp
  lib/checkunusedfunctions.cpp
  lib/checkunusedvar.cpp
  lib/checkvaarg.cpp
  lib/clangimport.cpp
  lib/color.cpp
  lib/cppcheck.cpp
  lib/ctu.cpp
  lib/errorlogger.cpp
  lib/errortypes.cpp
  lib/forwardanalyzer.cpp
  lib/importproject.cpp
  lib/infer.cpp
  lib/library.cpp
  lib/mathlib.cpp
  lib/pathanalysis.cpp
  lib/path.cpp
  lib/pathmatch.cpp
  lib/platform.cpp
  lib/preprocessor.cpp
  lib/programmemory.cpp
  lib/reverseanalyzer.cpp
  lib/settings.cpp
  lib/summaries.cpp
  lib/suppressions.cpp
  lib/symboldatabase.cpp
  lib/templatesimplifier.cpp
  lib/timer.cpp
  lib/token.cpp
  lib/tokenize.cpp
  lib/tokenlist.cpp
  lib/utils.cpp
  lib/valueflow.cpp
  lib/vf_array.cpp
  lib/vf_arraybool.cpp
  lib/vf_arrayelement.cpp
  lib/vf_bailout.cpp
  lib/vf_bitand.cpp
  lib/vf_common.cpp
  lib/vf_debug.cpp
  lib/vf_enumvalue.cpp
  lib/vf_functionreturn.cpp
  lib/vf_globalconstvar.cpp
  lib/vf_globalstaticvar.cpp
  lib/vf_impossiblevalues.cpp
  lib/vf_iteratorinfer.cpp
  lib/vf_iterators.cpp
  lib/vf_number.cpp
  lib/vf_pointeralias.cpp
  lib/vf_rightshift.cpp
  lib/vf_sameexpressions.cpp
  lib/vf_settokenvalue.cpp
  lib/vf_string.cpp
  lib/vf_symbolicinfer.cpp
  lib/vf_unknownfunctionreturn.cpp
  externals/simplecpp/simplecpp.cpp
  externals/tinyxml2/tinyxml2.cpp
)

speccpu2026_prepare_rundir()

###############################################################################
# testrunner_r
###############################################################################

set(PROG ${BENCHMARK}.testrunner_r)
speccpu2026_use_rundir(testrunner_r)

# Same flags as the primary binary above; add_definitions() and
# include_directories() are directory-scoped, so they carry.

## test ######################################################################

speccpu2026_run_test(
  STDOUT testrunner_r.out
  STDERR testrunner_r.err
  RUN_TYPE test
)

###############################################################################

speccpu2026_verify_output(
  FILES
    testrunner_r.out
)

speccpu2026_add_executable(
  cli/cmdlineparser.cpp
  cli/signalhandler.cpp
  cli/singleexecutor.cpp
  cli/cppcheckexecutor.cpp
  cli/cppcheckexecutorseh.cpp
  cli/cppcheckexecutorsig.cpp
  cli/executor.cpp
  cli/filelister.cpp
  cli/processexecutor.cpp
  cli/stacktrace.cpp
  cli/threadexecutor.cpp
  lib/addoninfo.cpp
  lib/checkers.cpp
  lib/checkersreport.cpp
  lib/fwdanalysis.cpp
  lib/keywords.cpp
  lib/vfvalue.cpp
  lib/analyzerinfo.cpp
  lib/astutils.cpp
  lib/check64bit.cpp
  lib/checkassert.cpp
  lib/checkautovariables.cpp
  lib/checkbool.cpp
  lib/checkboost.cpp
  lib/checkbufferoverrun.cpp
  lib/checkclass.cpp
  lib/checkcondition.cpp
  lib/check.cpp
  lib/checkexceptionsafety.cpp
  lib/checkfunctions.cpp
  lib/checkinternal.cpp
  lib/checkio.cpp
  lib/checkleakautovar.cpp
  lib/checkmemoryleak.cpp
  lib/checknullpointer.cpp
  lib/checkother.cpp
  lib/checkpostfixoperator.cpp
  lib/checksizeof.cpp
  lib/checkstl.cpp
  lib/checkstring.cpp
  lib/checktype.cpp
  lib/checkuninitvar.cpp
  lib/checkunusedfunctions.cpp
  lib/checkunusedvar.cpp
  lib/checkvaarg.cpp
  lib/clangimport.cpp
  lib/color.cpp
  lib/cppcheck.cpp
  lib/ctu.cpp
  lib/errorlogger.cpp
  lib/errortypes.cpp
  lib/forwardanalyzer.cpp
  lib/importproject.cpp
  lib/infer.cpp
  lib/library.cpp
  lib/mathlib.cpp
  lib/pathanalysis.cpp
  lib/path.cpp
  lib/pathmatch.cpp
  lib/platform.cpp
  lib/preprocessor.cpp
  lib/programmemory.cpp
  lib/reverseanalyzer.cpp
  lib/settings.cpp
  lib/summaries.cpp
  lib/suppressions.cpp
  lib/symboldatabase.cpp
  lib/templatesimplifier.cpp
  lib/timer.cpp
  lib/token.cpp
  lib/tokenize.cpp
  lib/tokenlist.cpp
  lib/utils.cpp
  lib/valueflow.cpp
  lib/vf_array.cpp
  lib/vf_arraybool.cpp
  lib/vf_arrayelement.cpp
  lib/vf_bailout.cpp
  lib/vf_bitand.cpp
  lib/vf_common.cpp
  lib/vf_debug.cpp
  lib/vf_enumvalue.cpp
  lib/vf_functionreturn.cpp
  lib/vf_globalconstvar.cpp
  lib/vf_globalstaticvar.cpp
  lib/vf_impossiblevalues.cpp
  lib/vf_iteratorinfer.cpp
  lib/vf_iterators.cpp
  lib/vf_number.cpp
  lib/vf_pointeralias.cpp
  lib/vf_rightshift.cpp
  lib/vf_sameexpressions.cpp
  lib/vf_settokenvalue.cpp
  lib/vf_string.cpp
  lib/vf_symbolicinfer.cpp
  lib/vf_unknownfunctionreturn.cpp
  externals/simplecpp/simplecpp.cpp
  externals/tinyxml2/tinyxml2.cpp
  test/options.cpp
  test/fixture.cpp
  test/helpers.cpp
  test/testcheck.cpp
  test/testcolor.cpp
  test/testsettings.cpp
  test/testsingleexecutor.cpp
  test/test64bit.cpp
  test/testanalyzerinformation.cpp
  test/testassert.cpp
  test/testastutils.cpp
  test/testautovariables.cpp
  test/testbool.cpp
  test/testboost.cpp
  test/testbufferoverrun.cpp
  test/testcharvar.cpp
  test/testclangimport.cpp
  test/testclass.cpp
  test/testcmdlineparser.cpp
  test/testcondition.cpp
  test/testconstructors.cpp
  test/testcppcheck.cpp
  test/testerrorlogger.cpp
  test/testexceptionsafety.cpp
  test/testfilelister.cpp
  test/testfilesettings.cpp
  test/testfunctions.cpp
  test/testgarbage.cpp
  test/testimportproject.cpp
  test/testincompletestatement.cpp
  test/testinternal.cpp
  test/testio.cpp
  test/testleakautovar.cpp
  test/testlibrary.cpp
  test/testmathlib.cpp
  test/testmemleak.cpp
  test/testnullpointer.cpp
  test/testoptions.cpp
  test/testother.cpp
  test/testpath.cpp
  test/testpathmatch.cpp
  test/testplatform.cpp
  test/testpostfixoperator.cpp
  test/testpreprocessor.cpp
  test/testprocessexecutor.cpp
  test/testprogrammemory.cpp
  test/testrunner.cpp
  test/testsimplifytemplate.cpp
  test/testsimplifytokens.cpp
  test/testsimplifytypedef.cpp
  test/testsimplifyusing.cpp
  test/testsizeof.cpp
  test/teststl.cpp
  test/teststring.cpp
  test/testsummaries.cpp
  test/testsuppressions.cpp
  test/testsymboldatabase.cpp
  test/testthreadexecutor.cpp
  test/testtimer.cpp
  test/testtoken.cpp
  test/testtokenize.cpp
  test/testtokenlist.cpp
  test/testtokenrange.cpp
  test/testtype.cpp
  test/testuninitvar.cpp
  test/testunusedfunctions.cpp
  test/testunusedprivfunc.cpp
  test/testunusedvar.cpp
  test/testutils.cpp
  test/testvaarg.cpp
  test/testvalueflow.cpp
  test/testvarid.cpp
)

speccpu2026_prepare_rundir()

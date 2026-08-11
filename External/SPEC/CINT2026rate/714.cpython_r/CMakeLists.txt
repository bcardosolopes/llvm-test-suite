# 714.cpython_r
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
  spec_restrict
  specrand
  cpython
  cpython/Include
  cpython/Include/internal
  cpython/Modules
  cpython/Objects
  cpython/Python
  cpython/Modules/_decimal/libmpdec
  cpython/PC
)

add_definitions(
  -DCONFIG_64
  -DANSI
  -DPy_NO_ENABLE_SHARED
  -DHAVE_PTHREAD_STUBS
)

list(APPEND LDFLAGS -lm)

## test ######################################################################

speccpu2026_run_test(
  -I -B coreml_pb.py -i 2 -d 20
  STDOUT cpython_r_0.out
  STDERR cpython_r_0.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  -I -B coreml_pb.py -i 10 -a -c -m PoseNetMobileNet100S16FP16.mlmodel
  STDOUT cpython_r_0.out
  STDERR cpython_r_0.err
  RUN_TYPE train
)

speccpu2026_run_test(
  -I -B dna_bench.py 200000
  STDOUT cpython_r_1.out
  STDERR cpython_r_1.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  -I -B coreml_pb.py -i 2 -a -m Resnet50Headless.mlmodel -d 10
  STDOUT cpython_r_0.out
  STDERR cpython_r_0.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -I -B coreml_pb.py -i 5 -a -c -m MobileNetV2.mlmodel -d 20
  STDOUT cpython_r_1.out
  STDERR cpython_r_1.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -I -B dna_bench.py 600000
  STDOUT cpython_r_2.out
  STDERR cpython_r_2.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output()

speccpu2026_add_executable(
  cpython/Modules/_abc.c
  cpython/Modules/_asynciomodule.c
  cpython/Modules/_bisectmodule.c
  cpython/Modules/_codecsmodule.c
  cpython/Modules/_collectionsmodule.c
  cpython/Modules/_csv.c
  cpython/Modules/_datetimemodule.c
  cpython/Modules/_decimal/_decimal.c
  cpython/Modules/_decimal/libmpdec/basearith.c
  cpython/Modules/_decimal/libmpdec/constants.c
  cpython/Modules/_decimal/libmpdec/context.c
  cpython/Modules/_decimal/libmpdec/convolute.c
  cpython/Modules/_decimal/libmpdec/crt.c
  cpython/Modules/_decimal/libmpdec/difradix2.c
  cpython/Modules/_decimal/libmpdec/fnt.c
  cpython/Modules/_decimal/libmpdec/fourstep.c
  cpython/Modules/_decimal/libmpdec/io.c
  cpython/Modules/_decimal/libmpdec/mpdecimal.c
  cpython/Modules/_decimal/libmpdec/numbertheory.c
  cpython/Modules/_decimal/libmpdec/sixstep.c
  cpython/Modules/_decimal/libmpdec/transpose.c
  cpython/Modules/_decimal/libmpdec/mpalloc.c
  cpython/Modules/_functoolsmodule.c
  cpython/Modules/_heapqmodule.c
  cpython/Modules/_io/_iomodule.c
  cpython/Modules/_io/bufferedio.c
  cpython/Modules/_io/bytesio.c
  cpython/Modules/_io/fileio.c
  cpython/Modules/_io/iobase.c
  cpython/Modules/_io/stringio.c
  cpython/Modules/_io/textio.c
  cpython/Modules/_io/winconsoleio.c
  cpython/Modules/_json.c
  cpython/Modules/_localemodule.c
  cpython/Modules/_lsprof.c
  cpython/Modules/_opcode.c
  cpython/Modules/_operator.c
  cpython/Modules/_randommodule.c
  cpython/Modules/_stat.c
  cpython/Modules/_struct.c
  cpython/Modules/_testbuffer.c
  cpython/Modules/_testimportmultiple.c
  cpython/Modules/_testmultiphase.c
  cpython/Modules/_threadmodule.c
  cpython/Modules/_tracemalloc.c
  cpython/Modules/_typingmodule.c
  cpython/Modules/_weakref.c
  cpython/Modules/_sre/sre.c
  cpython/Modules/_contextvarsmodule.c
  cpython/Modules/_queuemodule.c
  cpython/Modules/_xxsubinterpretersmodule.c
  cpython/Modules/_xxinterpchannelsmodule.c
  cpython/Modules/_statisticsmodule.c
  cpython/Modules/arraymodule.c
  cpython/Modules/atexitmodule.c
  cpython/Modules/binascii.c
  cpython/Modules/mathmodule.c
  cpython/Modules/cmathmodule.c
  cpython/Modules/config.c
  cpython/Modules/errnomodule.c
  cpython/Modules/gcmodule.c
  cpython/Modules/getbuildinfo.c
  cpython/Modules/getpath.c
  cpython/Modules/itertoolsmodule.c
  cpython/Modules/main.c
  cpython/Modules/posixmodule.c
  cpython/Modules/pwdmodule.c
  cpython/Modules/rotatingtree.c
  cpython/Modules/signalmodule.c
  cpython/Modules/symtablemodule.c
  cpython/Modules/timemodule.c
  cpython/Modules/unicodedata.c
  cpython/Modules/xxmodule.c
  cpython/Modules/xxsubtype.c
  cpython/Objects/abstract.c
  cpython/Objects/boolobject.c
  cpython/Objects/bytearrayobject.c
  cpython/Objects/bytes_methods.c
  cpython/Objects/bytesobject.c
  cpython/Objects/call.c
  cpython/Objects/capsule.c
  cpython/Objects/cellobject.c
  cpython/Objects/classobject.c
  cpython/Objects/codeobject.c
  cpython/Objects/complexobject.c
  cpython/Objects/descrobject.c
  cpython/Objects/dictobject.c
  cpython/Objects/enumobject.c
  cpython/Objects/exceptions.c
  cpython/Objects/fileobject.c
  cpython/Objects/floatobject.c
  cpython/Objects/frameobject.c
  cpython/Objects/funcobject.c
  cpython/Objects/genericaliasobject.c
  cpython/Objects/genobject.c
  cpython/Objects/interpreteridobject.c
  cpython/Objects/iterobject.c
  cpython/Objects/listobject.c
  cpython/Objects/longobject.c
  cpython/Objects/memoryobject.c
  cpython/Objects/methodobject.c
  cpython/Objects/moduleobject.c
  cpython/Objects/namespaceobject.c
  cpython/Objects/object.c
  cpython/Objects/obmalloc.c
  cpython/Objects/odictobject.c
  cpython/Objects/picklebufobject.c
  cpython/Objects/rangeobject.c
  cpython/Objects/setobject.c
  cpython/Objects/sliceobject.c
  cpython/Objects/structseq.c
  cpython/Objects/tupleobject.c
  cpython/Objects/typeobject.c
  cpython/Objects/typevarobject.c
  cpython/Objects/unicodectype.c
  cpython/Objects/unicodeobject.c
  cpython/Objects/unionobject.c
  cpython/Objects/weakrefobject.c
  cpython/Parser/action_helpers.c
  cpython/Parser/peg_api.c
  cpython/Parser/string_parser.c
  cpython/Parser/token.c
  cpython/Parser/tokenizer.c
  cpython/Parser/parser.c
  cpython/Parser/pegen.c
  cpython/Parser/pegen_errors.c
  cpython/Parser/myreadline.c
  cpython/PC/frozen_dllmain.c
  cpython/PC/invalid_parameter_handler.c
  cpython/PC/winreg.c
  cpython/Programs/python.c
  cpython/Python/Python-ast.c
  cpython/Python/_warnings.c
  cpython/Python/Python-tokenize.c
  cpython/Python/asdl.c
  cpython/Python/assemble.c
  cpython/Python/ast.c
  cpython/Python/ast_opt.c
  cpython/Python/ast_unparse.c
  cpython/Python/bltinmodule.c
  cpython/Python/ceval.c
  cpython/Python/ceval_gil.c
  cpython/Python/codecs.c
  cpython/Python/compile.c
  cpython/Python/context.c
  cpython/Python/dtoa.c
  cpython/Python/dup2.c
  cpython/Python/errors.c
  cpython/Python/fileutils.c
  cpython/Python/flowgraph.c
  cpython/Python/formatter_unicode.c
  cpython/Python/frame.c
  cpython/Python/frozen.c
  cpython/Python/future.c
  cpython/Python/getargs.c
  cpython/Python/getcompiler.c
  cpython/Python/getcopyright.c
  cpython/Python/getopt.c
  cpython/Python/getplatform.c
  cpython/Python/getversion.c
  cpython/Python/hamt.c
  cpython/Python/hashtable.c
  cpython/Python/import.c
  cpython/Python/initconfig.c
  cpython/Python/intrinsics.c
  cpython/Python/instrumentation.c
  cpython/Python/legacy_tracing.c
  cpython/Python/marshal.c
  cpython/Python/modsupport.c
  cpython/Python/mysnprintf.c
  cpython/Python/mystrtoul.c
  cpython/Python/pyarena.c
  cpython/Python/pathconfig.c
  cpython/Python/preconfig.c
  cpython/Python/pyctype.c
  cpython/Python/pyfpe.c
  cpython/Python/pyhash.c
  cpython/Python/pylifecycle.c
  cpython/Python/pymath.c
  cpython/Python/pystate.c
  cpython/Python/pystrcmp.c
  cpython/Python/pystrhex.c
  cpython/Python/pystrtod.c
  cpython/Python/pythonrun.c
  cpython/Python/pytime.c
  cpython/Python/bootstrap_hash.c
  cpython/Python/specialize.c
  cpython/Python/structmember.c
  cpython/Python/symtable.c
  cpython/Python/sysmodule.c
  cpython/Python/thread.c
  cpython/Python/tracemalloc.c
  cpython/Python/traceback.c
  cpython/Python/dynload_stub.c
  cpython/Python/suggestions.c
  cpython/Python/perf_trampoline.c
  cpython/Python/deepfreeze/deepfreeze.c
  specrand/specrand.c
)

speccpu2026_prepare_rundir()

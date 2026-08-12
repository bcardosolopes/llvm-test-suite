# SPEC CPU 2026
# https://www.spec.org/cpu2026/Docs/
#
# Modelled on SpecCPU2017.cmake. The differences are not cosmetic; SPEC changed
# which portability macros the harness emits between the two suites. See the
# SPEC_COMMON_DEFS block below.

include(External)
include(CopyDir)
include(Host)
include(Fortran)

# Where this file lives, captured at include() time. The macros below cannot
# ask for it themselves: CMAKE_CURRENT_LIST_DIR is the *including* benchmark's
# directory inside a macro, and CMAKE_CURRENT_FUNCTION_LIST_DIR is only set in
# a function.
set(SPEC2026_CMAKE_DIR "${CMAKE_CURRENT_LIST_DIR}")

# Search for SPEC CPU 2026 root directory.
llvm_externals_find(TEST_SUITE_SPEC2026_ROOT "speccpu2026" "SPEC CPU2026")
if (NOT TEST_SUITE_SPEC2026_ROOT)
  return ()
endif ()

# Print warnings once only, even if included multiple times.
if (NOT TARGET speccpu2026_dummy)

  file(READ ${TEST_SUITE_SPEC2026_ROOT}/version.txt VERSION)
  if (VERSION VERSION_LESS 1.0.1)
    message(WARNING
      "Expected SPEC2026 version 1.0.1 or newer, found ${VERSION}")
  endif ()

  # SPEC supports three "run types": ref, train and test.
  set(_available_run_types test train ref)
  if (NOT TEST_SUITE_RUN_TYPE IN_LIST _available_run_types)
    message(FATAL_ERROR
      "TEST_SUITE_RUN_TYPE must be 'train', 'test' or 'ref' for SPEC")
  endif()

  if (TEST_SUITE_CLANGIR_ENABLE)
    message(STATUS "Enabling ClangIR for SPEC CPU 2026")
  endif ()

  add_custom_target(speccpu2026_dummy)
endif ()


# Set the variables and common compile flags for a SPEC CPU 2026 benchmark.
#
# SPEED/RATE Kind of benchmark suite
#
# ORIGIN     Allows the reuse of source files, input data, and reference
#            output from another benchmark.
macro (speccpu2026_benchmark)
  cmake_parse_arguments(_arg "SPEED;RATE" "ORIGIN" "" ${ARGN})

  # If BENCHMARK is set, another benchmark inherits from this benchmark.
  # The relevant variables are already set in this case.
  if (NOT DEFINED BENCHMARK)

    get_filename_component(BENCHMARK "${CMAKE_CURRENT_SOURCE_DIR}" NAME)
    string(SUBSTRING ${BENCHMARK} 0 3 BENCHMARK_NO)
    set(PROG ${BENCHMARK})

    if (_arg_SPEED)
      set(BENCHMARK_SUITE_TYPE speed)
      set(SPEED ON)
      set(SUFFIX s)
    elseif (_arg_RATE)
      set(BENCHMARK_SUITE_TYPE rate)
      set(RATE ON)
      set(SUFFIX r)
    else ()
      message(FATAL_ERROR "Must define the benchmark type (RATE or SPEED)")
    endif ()

    if (DEFINED _arg_ORIGIN)
      set(ORIGIN ${_arg_ORIGIN})
    else ()
      set(ORIGIN ${BENCHMARK})
    endif ()

    set(BENCHMARK_DIR "${TEST_SUITE_SPEC2026_ROOT}/benchspec/CPU/${BENCHMARK}")
    set(ORIGIN_DIR "${TEST_SUITE_SPEC2026_ROOT}/benchspec/CPU/${ORIGIN}")

    set(SRC_DIR "${ORIGIN_DIR}/src")

    set(DATA_DIR "${BENCHMARK_DIR}/data")
    if (NOT EXISTS "${DATA_DIR}")
      set(DATA_DIR "${ORIGIN_DIR}/data")
    endif ()

    set(DATA_all_DIR "${DATA_DIR}/all")
    set(DATA_test_DIR "${DATA_DIR}/test")
    set(DATA_train_DIR "${DATA_DIR}/train")

    set(DATA_ref_DIR "${DATA_DIR}/refrate")
    if (SPEED AND EXISTS "${DATA_DIR}/refspeed")
      set(DATA_ref_DIR "${DATA_DIR}/refspeed")
    endif ()

    set(INPUT_all_DIR "${DATA_all_DIR}/input")
    set(OUTPUT_all_DIR "${DATA_all_DIR}/output")

    set(INPUT_test_DIR "${DATA_test_DIR}/input")
    set(OUTPUT_test_DIR "${DATA_test_DIR}/output")

    set(INPUT_train_DIR "${DATA_train_DIR}/input")
    set(OUTPUT_train_DIR "${DATA_train_DIR}/output")

    set(INPUT_ref_DIR "${DATA_ref_DIR}/input")
    set(OUTPUT_ref_DIR "${DATA_ref_DIR}/output")

    # Create benchmark working directories.
    foreach (_run_type IN LISTS TEST_SUITE_RUN_TYPE)
      set(RUN_${_run_type}_DIR "${CMAKE_CURRENT_BINARY_DIR}/run_${_run_type}")
      set(RUN_${_run_type}_DIR_REL "%S/run_${_run_type}")
      file(MAKE_DIRECTORY ${RUN_${_run_type}_DIR})
    endforeach ()


    # Language standards.
    #
    # Every compile line runcpu emitted for CINT2026rate uses exactly these
    # two, with no per-benchmark or per-file variation, so they belong here
    # rather than in the generated per-benchmark files. They are not cosmetic:
    # -std=c++17 rather than -std=gnu++17 is what keeps the GNU extension
    # macros (`linux`, `unix`, `i386`) undefined, and 735.gem5_r has a
    # `GEM5_DEPRECATED_NAMESPACE(Linux, linux)` that does not compile if
    # `linux` is predefined to 1.
    add_compile_options(
      $<$<COMPILE_LANGUAGE:C>:-std=c18>
      $<$<COMPILE_LANGUAGE:CXX>:-std=c++17>
    )

    if (TEST_SUITE_CLANGIR_ENABLE)
      add_compile_options(
        $<$<COMPILE_LANGUAGE:C>:-fclangir>
        $<$<COMPILE_LANGUAGE:CXX>:-fclangir>
      )
    endif ()

    # Mandatory SPEC definitions.
    #
    # This is a much shorter list than SPEC CPU 2017's, and deliberately so.
    # runcpu was run over all of CINT2026rate with an upstream clang and the
    # resulting compile lines contain only -DSPEC and -DNDEBUG universally; the
    # 2017-era -DSPEC_CPU, -DSPEC_LP64/-DSPEC_ILP32, -DSPEC_LINUX*,
    # -DSPEC_MACOSX and -DSPEC_AUTO_SUPPRESS_OPENMP are emitted by no 2026
    # benchmark and referenced by no 2026 source file. -DSPEC_WINDOWS is used
    # by the sources but only ever negatively (#ifdef ... #else), so nothing has
    # to be defined on Linux. Everything else is per-benchmark and lives in the
    # benchmark's own CMakeLists.txt.
    set(SPEC_COMMON_DEFS)
    list(APPEND SPEC_COMMON_DEFS "-DSPEC;-DNDEBUG")

    if (RATE)
      # rate benchmarks never use parallelism. 2026 spells this
      # SPEC_AUTO_SUPPRESS_THREADING; SPEC_AUTO_SUPPRESS_OPENMP is gone.
      list(APPEND SPEC_COMMON_DEFS "-DSPEC_AUTO_SUPPRESS_THREADING")
    endif ()

    if (SPEED)
      # No OpenMP for the moment, even for the _s suites -- same call
      # SpecCPU2017.cmake makes, and for the same reason: the harness has no
      # way to pick an OpenMP runtime, and several of the clangs we test are
      # built without one.
      #
      # SPEC_AUTO_SUPPRESS_THREADING (used for RATE above) is not the right
      # macro here: it switches off *all* threading, including the C++
      # std::thread use in the cxxthreads benchmarks, which the _s suites do
      # keep. The 2026 sources guard their OpenMP regions with
      #   #if (defined(SPEC_OPENMP) || defined(SPEC_OPENMP_TARGET)) &&
      #       !(defined(SPEC_SUPPRESS_OPENMP) || defined(SPEC_AUTO_SUPPRESS_OPENMP))
      # so defining SPEC_SUPPRESS_OPENMP -- and never defining SPEC_OPENMP --
      # is what turns the parallel regions into ordinary serial loops.
      list(APPEND SPEC_COMMON_DEFS "-DSPEC_SUPPRESS_OPENMP")
    endif ()

    # Byte order. Only some benchmarks read this macro, but defining it
    # unconditionally is harmless and matches what runcpu does.
    if (ENDIAN STREQUAL "little")
      list(APPEND SPEC_COMMON_DEFS "-DSPEC_AUTO_BYTEORDER=0x12345678")
    elseif (ENDIAN STREQUAL "big")
      list(APPEND SPEC_COMMON_DEFS "-DSPEC_AUTO_BYTEORDER=0x87654321")
    endif ()

    check_type_size("long long" SIZEOF_LONG_LONG)
    check_type_size("long" SIZEOF_LONG)
    check_type_size("int" SIZEOF_INT)
    if (NOT (CMAKE_SIZEOF_VOID_P EQUAL 4 OR CMAKE_SIZEOF_VOID_P EQUAL 8))
      message(FATAL_ERROR "SPEC CPU 2026 unsupported data model")
    endif ()

    if (ARCH STREQUAL "LoongArch" OR ARCH STREQUAL "riscv64")
      list(APPEND SPEC_COMMON_DEFS "-DSPEC_MANUAL_CONFIG")
    endif ()

    # Add SPEC_COMMON_DEFS
    add_definitions(${SPEC_COMMON_DEFS})

    if (TEST_SUITE_FORTRAN)
      check_fortran_compiler_flag("-fallow-argument-mismatch" SUPPORTS_FALLOW_ARGUMENT_MISMATCH)
    endif ()

  endif ()
endmacro()


# Reuse the CMakeLists.txt of another benchmark.
macro(speccpu2026_inherit _origin_path)
  include("${_origin_path}/CMakeLists.txt")
endmacro ()


# Point the RUN_*_DIR variables at a per-executable working directory.
#
# A handful of 2026 benchmarks build more than one binary out of one source
# tree (727.cppcheck_r builds cppcheck_r and testrunner_r, 999.specrand_r
# builds specrand_r and distributions_r). runcpu runs those in a single
# rundir, but llvm-test-suite runs every .test independently and in an
# arbitrary order, so they need working directories of their own. Call this,
# together with set(PROG ...), before emitting the second binary's run lines.
macro (speccpu2026_use_rundir _suffix)
  foreach (_run_type IN LISTS TEST_SUITE_RUN_TYPE)
    set(RUN_${_run_type}_DIR
      "${CMAKE_CURRENT_BINARY_DIR}/run_${_run_type}_${_suffix}")
    set(RUN_${_run_type}_DIR_REL "%S/run_${_run_type}_${_suffix}")
    file(MAKE_DIRECTORY ${RUN_${_run_type}_DIR})
  endforeach ()
endmacro ()


# Add include directories relative to SRC_DIR.
macro (speccpu2026_add_include_dirs)
  foreach(_dirname ${ARGN})
    get_filename_component(_absdirname "${_dirname}" ABSOLUTE BASE_DIR ${SRC_DIR})
    include_directories("${_absdirname}")
  endforeach()
endmacro ()


# Add a "PREPARE:" line deleting output files left over from an earlier run.
#
# The rundir is built once, at build time, but lit may run the test in it any
# number of times. Most outputs are stdout/stderr redirections, which truncate,
# but a benchmark that opens its own output file gets to choose -- 737.gmsh_r
# appends to spec.val -- and the second run then compares a doubled file
# against the reference and fails. Only files the benchmark itself writes
# belong here; deleting anything an earlier step produced would break the run.
#
# RUN_TYPE  (test, train or ref)
# FILES     Files in the rundir to delete
macro (speccpu2026_remove_stale_output)
  cmake_parse_arguments(_arg "" "RUN_TYPE" "FILES" ${ARGN})

  if ((NOT DEFINED _arg_RUN_TYPE) OR
      (_arg_RUN_TYPE IN_LIST TEST_SUITE_RUN_TYPE))
    set(_files)
    foreach (_f IN LISTS _arg_FILES)
      list(APPEND _files "${RUN_${_arg_RUN_TYPE}_DIR_REL}/${_f}")
    endforeach ()
    llvm_test_prepare(RUN_TYPE ${_arg_RUN_TYPE}
      "${CMAKE_COMMAND}" -E rm -f ${_files})
  endif ()
endmacro ()


# Add a "RUN:" line.
#
# RUN_TYPE   (test,train or ref)
#            Only run if this TEST_SUITE_RUN_TYPE is is selected.
#
# SUITE_TYPE (rate or speed)
#            Only run in the _r or _s benchmark suites.
#
# STDOUT     Write the benchmark's stdout into this file in the rundir.
#
# STDERR     Write the benchmark's stderr into this file in the rundir.
#
# BINARY     Run this sibling binary instead of ${PROG}.
#
# SPEC_BINARY
#            Run this tool out of the SPEC install's bin/ instead of ${PROG}.
#
# ARGN       Benchmark's command line arguments
macro (speccpu2026_run_test)
  cmake_parse_arguments(_arg
    "" "RUN_TYPE;SUITE_TYPE;STDOUT;STDERR;BINARY;SPEC_BINARY" "" ${ARGN})

  if ((NOT DEFINED _arg_SUITE_TYPE) OR
      (BENCHMARK_SUITE_TYPE IN_LIST _arg_SUITE_TYPE))
    if ((NOT DEFINED _arg_RUN_TYPE) OR
        (_arg_RUN_TYPE IN_LIST TEST_SUITE_RUN_TYPE))

      set(_stdout)
      if (DEFINED _arg_STDOUT)
        set(_stdout > "${RUN_${_arg_RUN_TYPE}_DIR_REL}/${_arg_STDOUT}")
      endif ()

      set(_stderr)
      if (DEFINED _arg_STDERR)
        set(_stderr 2> "${RUN_${_arg_RUN_TYPE}_DIR_REL}/${_arg_STDERR}")
      endif ()

      # Which binary this line runs. Defaults to ${PROG}. 734.vpr_r and
      # 735.gem5_r have a `sub compare_commands` in their object.pm: after the
      # benchmark itself has run, runcpu runs a helper binary (vpr_out_compare,
      # gem5stats) in the same rundir to distill the run's output down to the
      # handful of numbers that are actually stable enough to diff, and it is
      # the helper's output that the reference files correspond to. Those steps
      # are run lines of *this* test, not tests of their own, so they need to
      # name a sibling binary.
      set(_binary "${PROG}")
      if (DEFINED _arg_BINARY)
        set(_binary "${_arg_BINARY}")
      endif ()

      # SPEC_BINARY names a tool out of the SPEC install's bin/ instead, and is
      # used as-is. 827.cppcheck_s and 838.diamond_s distil their output with
      # `specperl sort.pl <file>` -- the benchmarks emit their findings in a
      # nondeterministic order, so the reference outputs are of the sorted
      # form. specperl is SPEC's own perl; nothing here builds it, and it runs
      # fine without SPEC's environment (the sort.pl scripts are pure core
      # perl).
      if (DEFINED _arg_SPEC_BINARY)
        set(_executable
            EXECUTABLE "${TEST_SUITE_SPEC2026_ROOT}/bin/${_arg_SPEC_BINARY}")
      else ()
        # Some benchmarks must be invoked with a relative path (SPEC made
        # modifications that prepend another path to find the rundir).
        file(RELATIVE_PATH _executable
            "${RUN_${_arg_RUN_TYPE}_DIR}"
            "${CMAKE_CURRENT_BINARY_DIR}/${_binary}")
        set (_executable EXECUTABLE "${_executable}")
      endif ()

      llvm_test_run(
        ${_arg_UNPARSED_ARGUMENTS} ${_stdout} ${_stderr}
        RUN_TYPE ${_arg_RUN_TYPE}
        WORKDIR "${RUN_${_arg_RUN_TYPE}_DIR_REL}"
        ${_executable}
      )
    endif ()
  endif ()
endmacro ()


# Add a "VERIFY:" line that compares all of the benchmark's reference outputs
# with files in the rundir.
#
# FILES  Restrict the comparison to these reference outputs. Only needed by
#        the benchmarks that build several binaries, where the data directory
#        holds the reference outputs of all of them and each .test must only
#        check the ones its own binary produces.
macro(speccpu2026_verify_output)
  cmake_parse_arguments(_arg
    "IGNORE_WHITESPACE" "ABSOLUTE_TOLERANCE;RELATIVE_TOLERANCE" "FILES" ${ARGN})

  set(_abstol)
  if (DEFINED _arg_ABSOLUTE_TOLERANCE)
    set(_abstol -a "${_arg_ABSOLUTE_TOLERANCE}")
  endif ()

  set(_reltol)
  if (DEFINED _arg_RELATIVE_TOLERANCE)
    set(_reltol -r "${_arg_RELATIVE_TOLERANCE}")
  endif ()

  set(_ignorewhitespace)
  if (DEFINED _arg_IGNORE_WHITESPACE)
    set(_ignorewhitespace "-i")
  endif ()

  foreach (_runtype IN LISTS TEST_SUITE_RUN_TYPE ITEMS all)
    file(GLOB_RECURSE _reffiles "${OUTPUT_${_runtype}_DIR}/*")
    foreach (_reffile IN LISTS _reffiles)
      file(RELATIVE_PATH _filename "${OUTPUT_${_runtype}_DIR}" "${_reffile}")
      if (_arg_FILES AND NOT "${_filename}" IN_LIST _arg_FILES)
        continue ()
      endif ()
      set(_outfile "${RUN_${_runtype}_DIR_REL}/${_filename}")
      set(_comparefile "${RUN_${_runtype}_DIR_REL}/compare/${_filename}")
      llvm_test_verify(RUN_TYPE ${_runtype}
        "%b/${FPCMP}" ${_abstol} ${_reltol} ${_ignorewhitespace}
          "${_comparefile}" "${_outfile}"
      )
    endforeach ()
  endforeach ()
endmacro()


# Add a SPEC CPU 2026 benchmark.
#
# Must be used after speccpu2026_run_test and speccpu2026_verify_output
# because those add lines to the ${BENCHMARK}.test file that is written here.
macro(speccpu2026_add_executable)
  set(_sources ${ARGN})
  if (_sources)
    set(_sources)
    foreach(_filename ${ARGN})
      get_filename_component(_absfilename "${_filename}"
        ABSOLUTE BASE_DIR ${SRC_DIR})
      list(APPEND _sources "${_absfilename}")
    endforeach()
  else ()
    file(GLOB_RECURSE _sources
      ${SRC_DIR}/*.c ${SRC_DIR}/*.cpp ${SRC_DIR}/*.cc ${SRC_DIR}/*.C ${SRC_DIR}/*.f ${SRC_DIR}/*.F ${SRC_DIR}/*.f90 ${SRC_DIR}/*.F90)
  endif ()

  llvm_test_executable(${PROG} ${_sources})
endmacro()


# Copy the input and comparison data to the rundir.
macro(speccpu2026_prepare_rundir)
  foreach (_runtype IN LISTS TEST_SUITE_RUN_TYPE)
    if (EXISTS "${INPUT_all_DIR}")
      llvm_copy_dir(${PROG} "${RUN_${_runtype}_DIR}" "${INPUT_all_DIR}")
    endif ()
    llvm_copy_dir(${PROG} "${RUN_${_runtype}_DIR}" "${INPUT_${_runtype}_DIR}")

    file(MAKE_DIRECTORY "${RUN_${_runtype}_DIR}/compare")
    llvm_copy_dir(${PROG}
      "${RUN_${_runtype}_DIR}/compare" "${OUTPUT_${_runtype}_DIR}")
    if (EXISTS "${OUTPUT_${_runtype}_DIR}/../compare")
        llvm_copy_dir(${PROG}
          "${RUN_${_runtype}_DIR}/compare" "${OUTPUT_${_runtype}_DIR}/../compare")
    endif ()
  endforeach ()
endmacro()


# Decompress inputs that SPEC ships xz-compressed.
#
# 734.vpr_r and 735.gem5_r have a `sub generate_inputs` in their object.pm and
# the benchmark cannot open the .xz itself; runcpu records what it ran in the
# rundir's inputgen.cmd. Decompressing here rather than from a RUN: line keeps
# it out of the measured execution time, and SPEC's own specxz is used so this
# does not add a dependency on the host having xz.
#
# Call this *after* speccpu2026_prepare_rundir(): both hang POST_BUILD commands
# off ${PROG} and those run in registration order, so the archives have to be
# copied into the rundir before there is anything to decompress. -dkf rather
# than SPEC's -dk/-d because a POST_BUILD command reruns on every relink, and
# neither an already-present output nor a consumed archive should fail it.
macro (speccpu2026_generate_inputs)
  cmake_parse_arguments(_arg "" "RUN_TYPE" "FILES" ${ARGN})
  if ((NOT DEFINED _arg_RUN_TYPE) OR
      (_arg_RUN_TYPE IN_LIST TEST_SUITE_RUN_TYPE))
    foreach (_archive IN LISTS _arg_FILES)
      add_custom_command(TARGET ${PROG} POST_BUILD
        COMMAND "${TEST_SUITE_SPEC2026_ROOT}/bin/specxz" -dkf "${_archive}"
        WORKING_DIRECTORY "${RUN_${_arg_RUN_TYPE}_DIR}"
        COMMENT "Decompressing ${_archive} for ${PROG} (${_arg_RUN_TYPE})"
        VERBATIM)
    endforeach ()
  endif ()
endmacro ()


# Generate an input by running the benchmark binary itself.
#
# 817.flac_s and 854.graph500_s have a `sub generate_inputs` that unpacks
# nothing: it runs the benchmark once and that run's output is the next run's
# input. flac decodes the shipped .flac back to the .wav it then re-encodes;
# graph500 writes the graph file its BFS then reads. Without this the rundir
# is missing a file and the first RUN: line fails outright.
#
# A POST_BUILD command rather than a RUN: line, for the same reason
# speccpu2026_generate_inputs() is one: SPEC does not time input generation,
# so neither may we. STDOUT is not optional bookkeeping -- graph500's
# bfs_data_prep.out is one of the reference outputs the VERIFY: lines compare.
#
# Call this *after* speccpu2026_prepare_rundir(), like generate_inputs: the
# POST_BUILD commands run in registration order and the inputs have to be in
# the rundir first.
#
# STDOUT/STDERR  files in the rundir to redirect into
# ARGN           the benchmark's command line arguments
macro (speccpu2026_generate_inputs_run)
  cmake_parse_arguments(_arg "" "RUN_TYPE;STDOUT;STDERR" "" ${ARGN})
  if ((NOT DEFINED _arg_RUN_TYPE) OR
      (_arg_RUN_TYPE IN_LIST TEST_SUITE_RUN_TYPE))
    add_custom_command(TARGET ${PROG} POST_BUILD
      COMMAND "${CMAKE_COMMAND}"
        "-DCMD=$<TARGET_FILE:${PROG}>;${_arg_UNPARSED_ARGUMENTS}"
        "-DWORKDIR=${RUN_${_arg_RUN_TYPE}_DIR}"
        "-DOUT=${RUN_${_arg_RUN_TYPE}_DIR}/${_arg_STDOUT}"
        "-DERR=${RUN_${_arg_RUN_TYPE}_DIR}/${_arg_STDERR}"
        -P "${SPEC2026_CMAKE_DIR}/SpecCPU2026RunInputgen.cmake"
      COMMENT "Generating ${_arg_STDOUT} inputs for ${PROG} (${_arg_RUN_TYPE})"
      VERBATIM)
  endif ()
endmacro ()

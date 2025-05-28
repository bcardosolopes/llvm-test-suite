if (TEST_SUITE_CLANGIR_ENABLE)
  message(STATUS "Enabling ClangIR for SingleSource tests")
  add_compile_options(
    $<$<COMPILE_LANGUAGE:C>:-fclangir>
    $<$<COMPILE_LANGUAGE:CXX>:-fclangir>
  )
endif()

add_subdirectory(Benchmarks)
if(NOT TEST_SUITE_BENCHMARKING_ONLY)
  add_subdirectory(UnitTests)
  add_subdirectory(Regression)
endif()

file(COPY lit.local.cfg DESTINATION "${CMAKE_CURRENT_BINARY_DIR}")

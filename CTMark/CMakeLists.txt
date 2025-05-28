if (TEST_SUITE_CLANGIR_ENABLE)
  message(STATUS "Enabling ClangIR for SingleSource tests")
  add_compile_options(
    $<$<COMPILE_LANGUAGE:C>:-fclangir>
    $<$<COMPILE_LANGUAGE:CXX>:-fclangir>
  )
endif()

add_subdirectory(7zip)
add_subdirectory(Bullet)
add_subdirectory(tramp3d-v4)
add_subdirectory(kimwitu++)
add_subdirectory(lencod)
add_subdirectory(SPASS)
add_subdirectory(ClamAV)
add_subdirectory(sqlite3)
add_subdirectory(consumer-typeset)
add_subdirectory(mafft)

file(COPY lit.local.cfg DESTINATION "${CMAKE_CURRENT_BINARY_DIR}")

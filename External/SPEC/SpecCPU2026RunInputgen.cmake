# Helper for speccpu2026_generate_inputs_run(), run as `cmake -P`.
#
# add_custom_command() has no output redirection and `cmake -E` offers none
# either, but execute_process() does, so the redirection happens here.
#
# CMD      the command line, as a ;-list
# WORKDIR  where to run it
# OUT/ERR  files to redirect stdout/stderr into

execute_process(
  COMMAND ${CMD}
  WORKING_DIRECTORY "${WORKDIR}"
  OUTPUT_FILE "${OUT}"
  ERROR_FILE "${ERR}"
  RESULT_VARIABLE _rc)

if (NOT _rc EQUAL 0)
  message(FATAL_ERROR "input generation failed (${_rc}): ${CMD}")
endif ()

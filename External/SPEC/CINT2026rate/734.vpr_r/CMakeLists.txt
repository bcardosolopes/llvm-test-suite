# 734.vpr_r
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
# vpr
###############################################################################

speccpu2026_add_include_dirs(
  vtr-vpr/vpr/src/analysis
  vtr-vpr/vpr/src/base
  vtr-vpr/vpr/src/base/gen
  vtr-vpr/vpr/src/noc
  vtr-vpr/vpr/src/pack
  vtr-vpr/vpr/src/place
  vtr-vpr/vpr/src/power
  vtr-vpr/vpr/src/route
  vtr-vpr/vpr/src/timing
  vtr-vpr/vpr/src/util
  vtr-vpr/libs/libvtrutil/src
  vtr-vpr/libs/liblog/src
  vtr-vpr/libs/libarchfpga/src
  vtr-vpr/libs/EXTERNAL/libpugixml/src
  vtr-vpr/libs/libpugiutil/src
  vtr-vpr/libs/EXTERNAL/libsdcparse/src
  vtr-vpr/libs/EXTERNAL/libsdcparse
  vtr-vpr/libs/EXTERNAL/libblifparse/src
  vtr-vpr/libs/EXTERNAL/libblifparse
  vtr-vpr/libs/EXTERNAL/libtatum/libtatum
  vtr-vpr/libs/EXTERNAL/libargparse/src
  vtr-vpr/libs/librrgraph/src/base
  vtr-vpr/libs/librrgraph/src/io/gen
  vtr-vpr/libs/librrgraph/src/io
  vtr-vpr/libs/librrgraph/src/utils
  getdelim
  specrand
  spec_include
)

add_definitions(
  -DNO_GRAPHICS
)

## test ######################################################################

speccpu2026_run_test(
  stratixiv_arch.timing.xml murax_stratixiv_arch_timing.blif
  --place_algorithm bounding_box --RL_agent_placement off
  --max_criticality 0.0 --init_t 512 --alpha_t 0.75 --exit_t 1
  --router_initial_timing all_critical --routing_failure_predictor off
  --route_chan_width 300 --max_router_iterations 20 --router_lookahead classic
  --initial_pres_fac 1.0 --pres_fac_mult 2.0 --astar_fac 1.5
  --router_profiler_astar_fac 1.5 --seed 3
  --sdc_file murax_stratixiv_arch_timing.sdc --pack_verbosity 0
  --netlist_verbosity 0 --base_cost_type demand_only --inner_num 4
  --read_initial_place_file ref_murax_stratixiv_arch_timing.init.place --place
  STDOUT murax_stratixiv_arch_timing.blif.place.out
  STDERR murax_stratixiv_arch_timing.blif.place.err
  RUN_TYPE test
)

speccpu2026_run_test(
  stratixiv_arch.timing.xml murax_stratixiv_arch_timing.blif
  --place_algorithm bounding_box --place_static_notiming_move_prob 50 25 25
  --max_criticality 0.0 --router_initial_timing all_critical
  --routing_failure_predictor off --route_chan_width 300
  --max_router_iterations 20 --router_lookahead classic --initial_pres_fac 1.0
  --pres_fac_mult 2.0 --astar_fac 1.5 --router_profiler_astar_fac 1.5 --seed 3
  --sdc_file murax_stratixiv_arch_timing.sdc --pack_verbosity 0
  --netlist_verbosity 0 --place_file ref_murax_stratixiv_arch_timing.place
  --base_cost_type demand_only --analysis --route
  STDOUT murax_stratixiv_arch_timing.blif.route.out
  STDERR murax_stratixiv_arch_timing.blif.route.err
  RUN_TYPE test
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  swap_call compare/murax_stratixiv_arch_timing.blif.place.log
  murax_stratixiv_arch_timing.blif.place.log
  STDOUT compare_murax_stratixiv_arch_timing.blif.place.log.swap_call.out
  STDERR compare_murax_stratixiv_arch_timing.blif.place.log.swap_call.err
  RUN_TYPE test
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  swap_accepted compare/murax_stratixiv_arch_timing.blif.place.log
  murax_stratixiv_arch_timing.blif.place.log
  STDOUT compare_murax_stratixiv_arch_timing.blif.place.log.swap_accepted.out
  STDERR compare_murax_stratixiv_arch_timing.blif.place.log.swap_accepted.err
  RUN_TYPE test
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  swap_rejected compare/murax_stratixiv_arch_timing.blif.place.log
  murax_stratixiv_arch_timing.blif.place.log
  STDOUT compare_murax_stratixiv_arch_timing.blif.place.log.swap_rejected.out
  STDERR compare_murax_stratixiv_arch_timing.blif.place.log.swap_rejected.err
  RUN_TYPE test
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  num_rr_nodes compare/murax_stratixiv_arch_timing.blif.route.log
  murax_stratixiv_arch_timing.blif.route.log
  STDOUT compare_murax_stratixiv_arch_timing.blif.route.log.num_rr_nodes.out
  STDERR compare_murax_stratixiv_arch_timing.blif.route.log.num_rr_nodes.err
  RUN_TYPE test
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  num_rr_edges compare/murax_stratixiv_arch_timing.blif.route.log
  murax_stratixiv_arch_timing.blif.route.log
  STDOUT compare_murax_stratixiv_arch_timing.blif.route.log.num_rr_edges.out
  STDERR compare_murax_stratixiv_arch_timing.blif.route.log.num_rr_edges.err
  RUN_TYPE test
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  heap_pushes compare/murax_stratixiv_arch_timing.blif.route.log
  murax_stratixiv_arch_timing.blif.route.log
  STDOUT compare_murax_stratixiv_arch_timing.blif.route.log.heap_pushes.out
  STDERR compare_murax_stratixiv_arch_timing.blif.route.log.heap_pushes.err
  RUN_TYPE test
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  heap_pops compare/murax_stratixiv_arch_timing.blif.route.log
  murax_stratixiv_arch_timing.blif.route.log
  STDOUT compare_murax_stratixiv_arch_timing.blif.route.log.heap_pops.out
  STDERR compare_murax_stratixiv_arch_timing.blif.route.log.heap_pops.err
  RUN_TYPE test
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  critical_path_delay compare/murax_stratixiv_arch_timing.blif.route.log
  murax_stratixiv_arch_timing.blif.route.log
  STDOUT compare_murax_stratixiv_arch_timing.blif.route.log.critical_path_delay.out
  STDERR compare_murax_stratixiv_arch_timing.blif.route.log.critical_path_delay.err
  RUN_TYPE test
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  routed_wire_length compare/murax_stratixiv_arch_timing.blif.route.log
  murax_stratixiv_arch_timing.blif.route.log
  STDOUT compare_murax_stratixiv_arch_timing.blif.route.log.routed_wire_length.out
  STDERR compare_murax_stratixiv_arch_timing.blif.route.log.routed_wire_length.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  stratixiv_arch.timing.xml sudoku_check_stratixiv_arch_timing.blif
  --place_algorithm bounding_box --RL_agent_placement off
  --max_criticality 0.0 --init_t 512 --alpha_t 0.75 --exit_t 1
  --router_initial_timing all_critical --routing_failure_predictor off
  --route_chan_width 300 --max_router_iterations 20 --router_lookahead classic
  --initial_pres_fac 1.0 --pres_fac_mult 2.0 --astar_fac 1.5
  --router_profiler_astar_fac 1.5 --seed 3
  --sdc_file sudoku_check_stratixiv_arch_timing.sdc --pack_verbosity 0
  --netlist_verbosity 0 --base_cost_type demand_only --inner_num 4
  --read_initial_place_file ref_sudoku_check_stratixiv_arch_timing.init.place
  --place
  STDOUT sudoku_check_stratixiv_arch_timing.blif.place.out
  STDERR sudoku_check_stratixiv_arch_timing.blif.place.err
  RUN_TYPE train
)

speccpu2026_run_test(
  stratixiv_arch.timing.xml sudoku_check_stratixiv_arch_timing.blif
  --place_algorithm bounding_box --place_static_notiming_move_prob 50 25 25
  --max_criticality 0.0 --router_initial_timing all_critical
  --routing_failure_predictor off --route_chan_width 300
  --max_router_iterations 20 --router_lookahead classic --initial_pres_fac 1.0
  --pres_fac_mult 2.0 --astar_fac 1.5 --router_profiler_astar_fac 1.5 --seed 3
  --sdc_file sudoku_check_stratixiv_arch_timing.sdc --pack_verbosity 0
  --netlist_verbosity 0 --base_cost_type demand_only
  --place_file ref_sudoku_check_stratixiv_arch_timing.place --analysis --route
  STDOUT sudoku_check_stratixiv_arch_timing.blif.route.out
  STDERR sudoku_check_stratixiv_arch_timing.blif.route.err
  RUN_TYPE train
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  swap_call compare/sudoku_check_stratixiv_arch_timing.blif.place.log
  sudoku_check_stratixiv_arch_timing.blif.place.log
  STDOUT compare_sudoku_check_stratixiv_arch_timing.blif.place.log.swap_call.out
  STDERR compare_sudoku_check_stratixiv_arch_timing.blif.place.log.swap_call.err
  RUN_TYPE train
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  swap_accepted compare/sudoku_check_stratixiv_arch_timing.blif.place.log
  sudoku_check_stratixiv_arch_timing.blif.place.log
  STDOUT compare_sudoku_check_stratixiv_arch_timing.blif.place.log.swap_accepted.out
  STDERR compare_sudoku_check_stratixiv_arch_timing.blif.place.log.swap_accepted.err
  RUN_TYPE train
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  swap_rejected compare/sudoku_check_stratixiv_arch_timing.blif.place.log
  sudoku_check_stratixiv_arch_timing.blif.place.log
  STDOUT compare_sudoku_check_stratixiv_arch_timing.blif.place.log.swap_rejected.out
  STDERR compare_sudoku_check_stratixiv_arch_timing.blif.place.log.swap_rejected.err
  RUN_TYPE train
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  num_rr_nodes compare/sudoku_check_stratixiv_arch_timing.blif.route.log
  sudoku_check_stratixiv_arch_timing.blif.route.log
  STDOUT compare_sudoku_check_stratixiv_arch_timing.blif.route.log.num_rr_nodes.out
  STDERR compare_sudoku_check_stratixiv_arch_timing.blif.route.log.num_rr_nodes.err
  RUN_TYPE train
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  num_rr_edges compare/sudoku_check_stratixiv_arch_timing.blif.route.log
  sudoku_check_stratixiv_arch_timing.blif.route.log
  STDOUT compare_sudoku_check_stratixiv_arch_timing.blif.route.log.num_rr_edges.out
  STDERR compare_sudoku_check_stratixiv_arch_timing.blif.route.log.num_rr_edges.err
  RUN_TYPE train
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  heap_pushes compare/sudoku_check_stratixiv_arch_timing.blif.route.log
  sudoku_check_stratixiv_arch_timing.blif.route.log
  STDOUT compare_sudoku_check_stratixiv_arch_timing.blif.route.log.heap_pushes.out
  STDERR compare_sudoku_check_stratixiv_arch_timing.blif.route.log.heap_pushes.err
  RUN_TYPE train
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  heap_pops compare/sudoku_check_stratixiv_arch_timing.blif.route.log
  sudoku_check_stratixiv_arch_timing.blif.route.log
  STDOUT compare_sudoku_check_stratixiv_arch_timing.blif.route.log.heap_pops.out
  STDERR compare_sudoku_check_stratixiv_arch_timing.blif.route.log.heap_pops.err
  RUN_TYPE train
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  critical_path_delay
  compare/sudoku_check_stratixiv_arch_timing.blif.route.log
  sudoku_check_stratixiv_arch_timing.blif.route.log
  STDOUT compare_sudoku_check_stratixiv_arch_timing.blif.route.log.critical_path_delay.out
  STDERR compare_sudoku_check_stratixiv_arch_timing.blif.route.log.critical_path_delay.err
  RUN_TYPE train
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  routed_wire_length compare/sudoku_check_stratixiv_arch_timing.blif.route.log
  sudoku_check_stratixiv_arch_timing.blif.route.log
  STDOUT compare_sudoku_check_stratixiv_arch_timing.blif.route.log.routed_wire_length.out
  STDERR compare_sudoku_check_stratixiv_arch_timing.blif.route.log.routed_wire_length.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  stratixiv_arch.timing.xml JPEG_stratixiv_arch_timing.blif
  --RL_agent_placement off --place_algorithm bounding_box
  --max_criticality 0.0 --init_t 512 --alpha_t 0.75 --exit_t 1
  --router_initial_timing all_critical --routing_failure_predictor off
  --route_chan_width 300 --max_router_iterations 20 --router_lookahead classic
  --initial_pres_fac 1.0 --pres_fac_mult 2.0 --astar_fac 1.5
  --router_profiler_astar_fac 1.5 --seed 3
  --sdc_file JPEG_stratixiv_arch_timing.sdc --pack_verbosity 0
  --netlist_verbosity 0 --base_cost_type demand_only --inner_num 4
  --read_initial_place_file ref_JPEG_stratixiv_arch_timing.init.place --place
  STDOUT JPEG_stratixiv_arch_timing.blif.place.out
  STDERR JPEG_stratixiv_arch_timing.blif.place.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  stratixiv_arch.timing.xml JPEG_stratixiv_arch_timing.blif
  --place_algorithm bounding_box --place_static_notiming_move_prob 50 25 25
  --max_criticality 0.0 --router_initial_timing all_critical
  --routing_failure_predictor off --route_chan_width 300
  --max_router_iterations 20 --router_lookahead classic --initial_pres_fac 1.0
  --pres_fac_mult 2.0 --astar_fac 1.5 --router_profiler_astar_fac 1.5 --seed 3
  --sdc_file JPEG_stratixiv_arch_timing.sdc --pack_verbosity 0
  --netlist_verbosity 0 --base_cost_type demand_only
  --place_file ref_JPEG_stratixiv_arch_timing.place --analysis --route
  STDOUT JPEG_stratixiv_arch_timing.blif.route.out
  STDERR JPEG_stratixiv_arch_timing.blif.route.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  stratixiv_arch.timing.xml smithwaterman_stratixiv_arch_timing.blif
  --RL_agent_placement off --place_algorithm bounding_box
  --max_criticality 0.0 --init_t 512 --alpha_t 0.75 --exit_t 1
  --router_initial_timing all_critical --routing_failure_predictor off
  --route_chan_width 300 --max_router_iterations 20 --router_lookahead classic
  --initial_pres_fac 1.0 --pres_fac_mult 2.0 --astar_fac 1.5
  --router_profiler_astar_fac 1.5 --seed 3
  --sdc_file smithwaterman_stratixiv_arch_timing.sdc --pack_verbosity 0
  --netlist_verbosity 0 --base_cost_type demand_only --inner_num 1.8
  --read_initial_place_file ref_smithwaterman_stratixiv_arch_timing.init.place
  --place
  STDOUT smithwaterman_stratixiv_arch_timing.blif.place.out
  STDERR smithwaterman_stratixiv_arch_timing.blif.place.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  stratixiv_arch.timing.xml smithwaterman_stratixiv_arch_timing.blif
  --place_algorithm bounding_box --place_static_notiming_move_prob 50 25 25
  --max_criticality 0.0 --router_initial_timing all_critical
  --routing_failure_predictor off --route_chan_width 300
  --max_router_iterations 20 --router_lookahead classic --initial_pres_fac 1.0
  --pres_fac_mult 2.0 --astar_fac 1.5 --router_profiler_astar_fac 1.5 --seed 3
  --sdc_file smithwaterman_stratixiv_arch_timing.sdc --pack_verbosity 0
  --netlist_verbosity 0 --base_cost_type demand_only
  --place_file ref_smithwaterman_stratixiv_arch_timing.place --analysis
  --route
  STDOUT smithwaterman_stratixiv_arch_timing.blif.route.out
  STDERR smithwaterman_stratixiv_arch_timing.blif.route.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  swap_call compare/JPEG_stratixiv_arch_timing.blif.place.log
  JPEG_stratixiv_arch_timing.blif.place.log
  STDOUT compare_JPEG_stratixiv_arch_timing.blif.place.log.swap_call.out
  STDERR compare_JPEG_stratixiv_arch_timing.blif.place.log.swap_call.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  swap_accepted compare/JPEG_stratixiv_arch_timing.blif.place.log
  JPEG_stratixiv_arch_timing.blif.place.log
  STDOUT compare_JPEG_stratixiv_arch_timing.blif.place.log.swap_accepted.out
  STDERR compare_JPEG_stratixiv_arch_timing.blif.place.log.swap_accepted.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  swap_rejected compare/JPEG_stratixiv_arch_timing.blif.place.log
  JPEG_stratixiv_arch_timing.blif.place.log
  STDOUT compare_JPEG_stratixiv_arch_timing.blif.place.log.swap_rejected.out
  STDERR compare_JPEG_stratixiv_arch_timing.blif.place.log.swap_rejected.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  num_rr_nodes compare/JPEG_stratixiv_arch_timing.blif.route.log
  JPEG_stratixiv_arch_timing.blif.route.log
  STDOUT compare_JPEG_stratixiv_arch_timing.blif.route.log.num_rr_nodes.out
  STDERR compare_JPEG_stratixiv_arch_timing.blif.route.log.num_rr_nodes.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  num_rr_edges compare/JPEG_stratixiv_arch_timing.blif.route.log
  JPEG_stratixiv_arch_timing.blif.route.log
  STDOUT compare_JPEG_stratixiv_arch_timing.blif.route.log.num_rr_edges.out
  STDERR compare_JPEG_stratixiv_arch_timing.blif.route.log.num_rr_edges.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  heap_pushes compare/JPEG_stratixiv_arch_timing.blif.route.log
  JPEG_stratixiv_arch_timing.blif.route.log
  STDOUT compare_JPEG_stratixiv_arch_timing.blif.route.log.heap_pushes.out
  STDERR compare_JPEG_stratixiv_arch_timing.blif.route.log.heap_pushes.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  heap_pops compare/JPEG_stratixiv_arch_timing.blif.route.log
  JPEG_stratixiv_arch_timing.blif.route.log
  STDOUT compare_JPEG_stratixiv_arch_timing.blif.route.log.heap_pops.out
  STDERR compare_JPEG_stratixiv_arch_timing.blif.route.log.heap_pops.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  critical_path_delay compare/JPEG_stratixiv_arch_timing.blif.route.log
  JPEG_stratixiv_arch_timing.blif.route.log
  STDOUT compare_JPEG_stratixiv_arch_timing.blif.route.log.critical_path_delay.out
  STDERR compare_JPEG_stratixiv_arch_timing.blif.route.log.critical_path_delay.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  routed_wire_length compare/JPEG_stratixiv_arch_timing.blif.route.log
  JPEG_stratixiv_arch_timing.blif.route.log
  STDOUT compare_JPEG_stratixiv_arch_timing.blif.route.log.routed_wire_length.out
  STDERR compare_JPEG_stratixiv_arch_timing.blif.route.log.routed_wire_length.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  swap_call compare/smithwaterman_stratixiv_arch_timing.blif.place.log
  smithwaterman_stratixiv_arch_timing.blif.place.log
  STDOUT compare_smithwaterman_stratixiv_arch_timing.blif.place.log.swap_call.out
  STDERR compare_smithwaterman_stratixiv_arch_timing.blif.place.log.swap_call.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  swap_accepted compare/smithwaterman_stratixiv_arch_timing.blif.place.log
  smithwaterman_stratixiv_arch_timing.blif.place.log
  STDOUT compare_smithwaterman_stratixiv_arch_timing.blif.place.log.swap_accepted.out
  STDERR compare_smithwaterman_stratixiv_arch_timing.blif.place.log.swap_accepted.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  swap_rejected compare/smithwaterman_stratixiv_arch_timing.blif.place.log
  smithwaterman_stratixiv_arch_timing.blif.place.log
  STDOUT compare_smithwaterman_stratixiv_arch_timing.blif.place.log.swap_rejected.out
  STDERR compare_smithwaterman_stratixiv_arch_timing.blif.place.log.swap_rejected.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  num_rr_nodes compare/smithwaterman_stratixiv_arch_timing.blif.route.log
  smithwaterman_stratixiv_arch_timing.blif.route.log
  STDOUT compare_smithwaterman_stratixiv_arch_timing.blif.route.log.num_rr_nodes.out
  STDERR compare_smithwaterman_stratixiv_arch_timing.blif.route.log.num_rr_nodes.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  num_rr_edges compare/smithwaterman_stratixiv_arch_timing.blif.route.log
  smithwaterman_stratixiv_arch_timing.blif.route.log
  STDOUT compare_smithwaterman_stratixiv_arch_timing.blif.route.log.num_rr_edges.out
  STDERR compare_smithwaterman_stratixiv_arch_timing.blif.route.log.num_rr_edges.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  heap_pushes compare/smithwaterman_stratixiv_arch_timing.blif.route.log
  smithwaterman_stratixiv_arch_timing.blif.route.log
  STDOUT compare_smithwaterman_stratixiv_arch_timing.blif.route.log.heap_pushes.out
  STDERR compare_smithwaterman_stratixiv_arch_timing.blif.route.log.heap_pushes.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  heap_pops compare/smithwaterman_stratixiv_arch_timing.blif.route.log
  smithwaterman_stratixiv_arch_timing.blif.route.log
  STDOUT compare_smithwaterman_stratixiv_arch_timing.blif.route.log.heap_pops.out
  STDERR compare_smithwaterman_stratixiv_arch_timing.blif.route.log.heap_pops.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  critical_path_delay
  compare/smithwaterman_stratixiv_arch_timing.blif.route.log
  smithwaterman_stratixiv_arch_timing.blif.route.log
  STDOUT compare_smithwaterman_stratixiv_arch_timing.blif.route.log.critical_path_delay.out
  STDERR compare_smithwaterman_stratixiv_arch_timing.blif.route.log.critical_path_delay.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  BINARY ${BENCHMARK}.vpr_out_compare
  routed_wire_length
  compare/smithwaterman_stratixiv_arch_timing.blif.route.log
  smithwaterman_stratixiv_arch_timing.blif.route.log
  STDOUT compare_smithwaterman_stratixiv_arch_timing.blif.route.log.routed_wire_length.out
  STDERR compare_smithwaterman_stratixiv_arch_timing.blif.route.log.routed_wire_length.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output(
  FILES
    compare_JPEG_stratixiv_arch_timing.blif.place.log.swap_accepted.out
    compare_JPEG_stratixiv_arch_timing.blif.place.log.swap_call.out
    compare_JPEG_stratixiv_arch_timing.blif.place.log.swap_rejected.out
    compare_JPEG_stratixiv_arch_timing.blif.route.log.critical_path_delay.out
    compare_JPEG_stratixiv_arch_timing.blif.route.log.heap_pops.out
    compare_JPEG_stratixiv_arch_timing.blif.route.log.heap_pushes.out
    compare_JPEG_stratixiv_arch_timing.blif.route.log.num_rr_edges.out
    compare_JPEG_stratixiv_arch_timing.blif.route.log.num_rr_nodes.out
    compare_JPEG_stratixiv_arch_timing.blif.route.log.routed_wire_length.out
    compare_murax_stratixiv_arch_timing.blif.place.log.swap_accepted.out
    compare_murax_stratixiv_arch_timing.blif.place.log.swap_call.out
    compare_murax_stratixiv_arch_timing.blif.place.log.swap_rejected.out
    compare_murax_stratixiv_arch_timing.blif.route.log.critical_path_delay.out
    compare_murax_stratixiv_arch_timing.blif.route.log.heap_pops.out
    compare_murax_stratixiv_arch_timing.blif.route.log.heap_pushes.out
    compare_murax_stratixiv_arch_timing.blif.route.log.num_rr_edges.out
    compare_murax_stratixiv_arch_timing.blif.route.log.num_rr_nodes.out
    compare_murax_stratixiv_arch_timing.blif.route.log.routed_wire_length.out
    compare_smithwaterman_stratixiv_arch_timing.blif.place.log.swap_accepted.out
    compare_smithwaterman_stratixiv_arch_timing.blif.place.log.swap_call.out
    compare_smithwaterman_stratixiv_arch_timing.blif.place.log.swap_rejected.out
    compare_smithwaterman_stratixiv_arch_timing.blif.route.log.critical_path_delay.out
    compare_smithwaterman_stratixiv_arch_timing.blif.route.log.heap_pops.out
    compare_smithwaterman_stratixiv_arch_timing.blif.route.log.heap_pushes.out
    compare_smithwaterman_stratixiv_arch_timing.blif.route.log.num_rr_edges.out
    compare_smithwaterman_stratixiv_arch_timing.blif.route.log.num_rr_nodes.out
    compare_smithwaterman_stratixiv_arch_timing.blif.route.log.routed_wire_length.out
    compare_sudoku_check_stratixiv_arch_timing.blif.place.log.swap_accepted.out
    compare_sudoku_check_stratixiv_arch_timing.blif.place.log.swap_call.out
    compare_sudoku_check_stratixiv_arch_timing.blif.place.log.swap_rejected.out
    compare_sudoku_check_stratixiv_arch_timing.blif.route.log.critical_path_delay.out
    compare_sudoku_check_stratixiv_arch_timing.blif.route.log.heap_pops.out
    compare_sudoku_check_stratixiv_arch_timing.blif.route.log.heap_pushes.out
    compare_sudoku_check_stratixiv_arch_timing.blif.route.log.num_rr_edges.out
    compare_sudoku_check_stratixiv_arch_timing.blif.route.log.num_rr_nodes.out
    compare_sudoku_check_stratixiv_arch_timing.blif.route.log.routed_wire_length.out
)

speccpu2026_add_executable(
  vtr-vpr/vpr/src/main.cpp
  vtr-vpr/vpr/src/analysis/timing_reports.cpp
  vtr-vpr/vpr/src/base/CheckArch.cpp
  vtr-vpr/vpr/src/base/CheckSetup.cpp
  vtr-vpr/vpr/src/base/SetupGrid.cpp
  vtr-vpr/vpr/src/base/SetupVPR.cpp
  vtr-vpr/vpr/src/base/ShowSetup.cpp
  vtr-vpr/vpr/src/base/atom_lookup.cpp
  vtr-vpr/vpr/src/base/atom_netlist.cpp
  vtr-vpr/vpr/src/base/atom_netlist_utils.cpp
  vtr-vpr/vpr/src/base/check_netlist.cpp
  vtr-vpr/vpr/src/base/clock_modeling.cpp
  vtr-vpr/vpr/src/base/clustered_netlist.cpp
  vtr-vpr/vpr/src/base/clustered_netlist_utils.cpp
  vtr-vpr/vpr/src/base/constant_nets.cpp
  vtr-vpr/vpr/src/base/constraints_load.cpp
  vtr-vpr/vpr/src/base/echo_files.cpp
  vtr-vpr/vpr/src/base/globals.cpp
  vtr-vpr/vpr/src/base/logic_vec.cpp
  vtr-vpr/vpr/src/base/netlist_walker.cpp
  vtr-vpr/vpr/src/base/netlist_writer.cpp
  vtr-vpr/vpr/src/base/partition.cpp
  vtr-vpr/vpr/src/base/partition_region.cpp
  vtr-vpr/vpr/src/base/place_and_route.cpp
  vtr-vpr/vpr/src/base/read_activity.cpp
  vtr-vpr/vpr/src/base/read_blif.cpp
  vtr-vpr/vpr/src/base/read_circuit.cpp
  vtr-vpr/vpr/src/base/read_netlist.cpp
  vtr-vpr/vpr/src/base/read_options.cpp
  vtr-vpr/vpr/src/base/read_place.cpp
  vtr-vpr/vpr/src/base/read_route.cpp
  vtr-vpr/vpr/src/base/region.cpp
  vtr-vpr/vpr/src/base/setup_clocks.cpp
  vtr-vpr/vpr/src/base/setup_noc.cpp
  vtr-vpr/vpr/src/base/stats.cpp
  vtr-vpr/vpr/src/base/vpr_api.cpp
  vtr-vpr/vpr/src/base/vpr_constraints.cpp
  vtr-vpr/vpr/src/base/vpr_constraints_reader.cpp
  vtr-vpr/vpr/src/base/vpr_constraints_writer.cpp
  vtr-vpr/vpr/src/base/vpr_signal_handler.cpp
  vtr-vpr/vpr/src/base/vpr_tatum_error.cpp
  vtr-vpr/vpr/src/base/vpr_types.cpp
  vtr-vpr/vpr/src/noc/bfs_routing.cpp
  vtr-vpr/vpr/src/noc/noc_link.cpp
  vtr-vpr/vpr/src/noc/noc_router.cpp
  vtr-vpr/vpr/src/noc/noc_routing_algorithm_creator.cpp
  vtr-vpr/vpr/src/noc/noc_storage.cpp
  vtr-vpr/vpr/src/noc/noc_traffic_flows.cpp
  vtr-vpr/vpr/src/noc/read_xml_noc_traffic_flows_file.cpp
  vtr-vpr/vpr/src/noc/xy_routing.cpp
  vtr-vpr/vpr/src/pack/attraction_groups.cpp
  vtr-vpr/vpr/src/pack/cluster.cpp
  vtr-vpr/vpr/src/pack/cluster_feasibility_filter.cpp
  vtr-vpr/vpr/src/pack/cluster_placement.cpp
  vtr-vpr/vpr/src/pack/cluster_router.cpp
  vtr-vpr/vpr/src/pack/cluster_util.cpp
  vtr-vpr/vpr/src/pack/constraints_report.cpp
  vtr-vpr/vpr/src/pack/lb_type_rr_graph.cpp
  vtr-vpr/vpr/src/pack/output_clustering.cpp
  vtr-vpr/vpr/src/pack/pack.cpp
  vtr-vpr/vpr/src/pack/pack_report.cpp
  vtr-vpr/vpr/src/pack/pb_type_graph.cpp
  vtr-vpr/vpr/src/pack/pb_type_graph_annotations.cpp
  vtr-vpr/vpr/src/pack/post_routing_pb_pin_fixup.cpp
  vtr-vpr/vpr/src/pack/prepack.cpp
  vtr-vpr/vpr/src/pack/re_cluster.cpp
  vtr-vpr/vpr/src/pack/re_cluster_util.cpp
  vtr-vpr/vpr/src/place/RL_agent_util.cpp
  vtr-vpr/vpr/src/place/analytic_placer.cpp
  vtr-vpr/vpr/src/place/centroid_move_generator.cpp
  vtr-vpr/vpr/src/place/compressed_grid.cpp
  vtr-vpr/vpr/src/place/critical_uniform_move_generator.cpp
  vtr-vpr/vpr/src/place/cut_spreader.cpp
  vtr-vpr/vpr/src/place/directed_moves_util.cpp
  vtr-vpr/vpr/src/place/feasible_region_move_generator.cpp
  vtr-vpr/vpr/src/place/grid_tile_lookup.cpp
  vtr-vpr/vpr/src/place/initial_placement.cpp
  vtr-vpr/vpr/src/place/manual_move_generator.cpp
  vtr-vpr/vpr/src/place/median_move_generator.cpp
  vtr-vpr/vpr/src/place/move_transactions.cpp
  vtr-vpr/vpr/src/place/move_utils.cpp
  vtr-vpr/vpr/src/place/place.cpp
  vtr-vpr/vpr/src/place/place_checkpoint.cpp
  vtr-vpr/vpr/src/place/place_constraints.cpp
  vtr-vpr/vpr/src/place/place_delay_model.cpp
  vtr-vpr/vpr/src/place/place_macro.cpp
  vtr-vpr/vpr/src/place/place_timing_update.cpp
  vtr-vpr/vpr/src/place/place_util.cpp
  vtr-vpr/vpr/src/place/placer_breakpoint.cpp
  vtr-vpr/vpr/src/place/placer_globals.cpp
  vtr-vpr/vpr/src/place/simpleRL_move_generator.cpp
  vtr-vpr/vpr/src/place/static_move_generator.cpp
  vtr-vpr/vpr/src/place/timing_place.cpp
  vtr-vpr/vpr/src/place/timing_place_lookup.cpp
  vtr-vpr/vpr/src/place/uniform_move_generator.cpp
  vtr-vpr/vpr/src/place/weighted_centroid_move_generator.cpp
  vtr-vpr/vpr/src/place/weighted_median_move_generator.cpp
  vtr-vpr/vpr/src/power/PowerSpicedComponent.cpp
  vtr-vpr/vpr/src/power/power.cpp
  vtr-vpr/vpr/src/power/power_callibrate.cpp
  vtr-vpr/vpr/src/power/power_cmos_tech.cpp
  vtr-vpr/vpr/src/power/power_components.cpp
  vtr-vpr/vpr/src/power/power_lowlevel.cpp
  vtr-vpr/vpr/src/power/power_sizing.cpp
  vtr-vpr/vpr/src/power/power_util.cpp
  vtr-vpr/vpr/src/route/annotate_routing.cpp
  vtr-vpr/vpr/src/route/binary_heap.cpp
  vtr-vpr/vpr/src/route/bucket.cpp
  vtr-vpr/vpr/src/route/build_switchblocks.cpp
  vtr-vpr/vpr/src/route/cb_metrics.cpp
  vtr-vpr/vpr/src/route/channel_stats.cpp
  vtr-vpr/vpr/src/route/check_route.cpp
  vtr-vpr/vpr/src/route/clock_connection_builders.cpp
  vtr-vpr/vpr/src/route/clock_network_builders.cpp
  vtr-vpr/vpr/src/route/connection_based_routing.cpp
  vtr-vpr/vpr/src/route/connection_router.cpp
  vtr-vpr/vpr/src/route/edge_groups.cpp
  vtr-vpr/vpr/src/route/heap_type.cpp
  vtr-vpr/vpr/src/route/overuse_report.cpp
  vtr-vpr/vpr/src/route/route_breadth_first.cpp
  vtr-vpr/vpr/src/route/route_budgets.cpp
  vtr-vpr/vpr/src/route/route_common.cpp
  vtr-vpr/vpr/src/route/route_path_manager.cpp
  vtr-vpr/vpr/src/route/route_profiling.cpp
  vtr-vpr/vpr/src/route/route_timing.cpp
  vtr-vpr/vpr/src/route/route_traceback.cpp
  vtr-vpr/vpr/src/route/route_tree_timing.cpp
  vtr-vpr/vpr/src/route/route_util.cpp
  vtr-vpr/vpr/src/route/router_delay_profiling.cpp
  vtr-vpr/vpr/src/route/router_lookahead.cpp
  vtr-vpr/vpr/src/route/router_lookahead_cost_map.cpp
  vtr-vpr/vpr/src/route/router_lookahead_extended_map.cpp
  vtr-vpr/vpr/src/route/router_lookahead_map.cpp
  vtr-vpr/vpr/src/route/router_lookahead_map_utils.cpp
  vtr-vpr/vpr/src/route/router_lookahead_sampling.cpp
  vtr-vpr/vpr/src/route/routing_predictor.cpp
  vtr-vpr/vpr/src/route/rr_graph.cpp
  vtr-vpr/vpr/src/route/rr_graph2.cpp
  vtr-vpr/vpr/src/route/rr_graph_area.cpp
  vtr-vpr/vpr/src/route/rr_graph_clock.cpp
  vtr-vpr/vpr/src/route/rr_graph_indexed_data.cpp
  vtr-vpr/vpr/src/route/rr_graph_sbox.cpp
  vtr-vpr/vpr/src/route/rr_graph_timing_params.cpp
  vtr-vpr/vpr/src/route/segment_stats.cpp
  vtr-vpr/vpr/src/route/spatial_route_tree_lookup.cpp
  vtr-vpr/vpr/src/timing/PreClusterTimingGraphResolver.cpp
  vtr-vpr/vpr/src/timing/VprTimingGraphResolver.cpp
  vtr-vpr/vpr/src/timing/concrete_timing_info.cpp
  vtr-vpr/vpr/src/timing/net_delay.cpp
  vtr-vpr/vpr/src/timing/read_sdc.cpp
  vtr-vpr/vpr/src/timing/slack_evaluation.cpp
  vtr-vpr/vpr/src/timing/timing_fail_error.cpp
  vtr-vpr/vpr/src/timing/timing_graph_builder.cpp
  vtr-vpr/vpr/src/timing/timing_util.cpp
  vtr-vpr/vpr/src/util/hash.cpp
  vtr-vpr/vpr/src/util/vpr_utils.cpp
  vtr-vpr/libs/liblog/src/log.cpp
  vtr-vpr/libs/libvtrutil/src/vpr_error.cpp
  vtr-vpr/libs/libvtrutil/src/vtr_assert.cpp
  vtr-vpr/libs/libvtrutil/src/vtr_color_map.cpp
  vtr-vpr/libs/libvtrutil/src/vtr_digest.cpp
  vtr-vpr/libs/libvtrutil/src/vtr_expr_eval.cpp
  vtr-vpr/libs/libvtrutil/src/vtr_list.cpp
  vtr-vpr/libs/libvtrutil/src/vtr_log.cpp
  vtr-vpr/libs/libvtrutil/src/vtr_math.cpp
  vtr-vpr/libs/libvtrutil/src/vtr_memory.cpp
  vtr-vpr/libs/libvtrutil/src/vtr_path.cpp
  vtr-vpr/libs/libvtrutil/src/vtr_random.cpp
  vtr-vpr/libs/libvtrutil/src/vtr_rusage.cpp
  vtr-vpr/libs/libvtrutil/src/vtr_time.cpp
  vtr-vpr/libs/libvtrutil/src/vtr_token.cpp
  vtr-vpr/libs/libvtrutil/src/vtr_util.cpp
  vtr-vpr/libs/libvtrutil/src/vtr_version.cpp
  specrand/specrand.cc
  vtr-vpr/libs/libpugiutil/src/pugixml_loc.cpp
  vtr-vpr/libs/libpugiutil/src/pugixml_util.cpp
  vtr-vpr/libs/libarchfpga/src/arch_check.cpp
  vtr-vpr/libs/libarchfpga/src/arch_error.cpp
  vtr-vpr/libs/libarchfpga/src/arch_util.cpp
  vtr-vpr/libs/libarchfpga/src/device_grid.cpp
  vtr-vpr/libs/libarchfpga/src/echo_arch.cpp
  vtr-vpr/libs/libarchfpga/src/histogram.cpp
  vtr-vpr/libs/libarchfpga/src/parse_switchblocks.cpp
  vtr-vpr/libs/libarchfpga/src/physical_types.cpp
  vtr-vpr/libs/libarchfpga/src/physical_types_util.cpp
  vtr-vpr/libs/libarchfpga/src/read_xml_arch_file.cpp
  vtr-vpr/libs/libarchfpga/src/read_xml_util.cpp
  vtr-vpr/libs/libarchfpga/src/write_models_bb.cpp
  vtr-vpr/libs/librrgraph/src/base/check_rr_graph.cpp
  vtr-vpr/libs/librrgraph/src/base/check_rr_graph_obj.cpp
  vtr-vpr/libs/librrgraph/src/base/get_parallel_segs.cpp
  vtr-vpr/libs/librrgraph/src/base/rr_graph_builder.cpp
  vtr-vpr/libs/librrgraph/src/base/rr_graph_obj.cpp
  vtr-vpr/libs/librrgraph/src/base/rr_graph_storage.cpp
  vtr-vpr/libs/librrgraph/src/base/rr_graph_utils.cpp
  vtr-vpr/libs/librrgraph/src/base/rr_graph_view.cpp
  vtr-vpr/libs/librrgraph/src/base/rr_metadata.cpp
  vtr-vpr/libs/librrgraph/src/base/rr_node.cpp
  vtr-vpr/libs/librrgraph/src/base/rr_rc_data.cpp
  vtr-vpr/libs/librrgraph/src/base/rr_spatial_lookup.cpp
  vtr-vpr/libs/librrgraph/src/io/rr_graph_reader.cpp
  vtr-vpr/libs/librrgraph/src/io/rr_graph_writer.cpp
  vtr-vpr/libs/librrgraph/src/utils/alloc_and_load_rr_indexed_data.cpp
  vtr-vpr/libs/librrgraph/src/utils/describe_rr_node.cpp
  vtr-vpr/libs/EXTERNAL/libpugixml/src/pugixml.cpp
  vtr-vpr/libs/EXTERNAL/libargparse/src/argparse.cpp
  vtr-vpr/libs/EXTERNAL/libargparse/src/argparse_formatter.cpp
  vtr-vpr/libs/EXTERNAL/libargparse/src/argparse_util.cpp
  vtr-vpr/libs/EXTERNAL/libsdcparse/src/sdc_common.cpp
  vtr-vpr/libs/EXTERNAL/libsdcparse/src/sdc_error.cpp
  vtr-vpr/libs/EXTERNAL/libsdcparse/src/sdc_lexer.gen.cpp
  vtr-vpr/libs/EXTERNAL/libsdcparse/src/sdc_parser.gen.cpp
  vtr-vpr/libs/EXTERNAL/libsdcparse/src/sdcparse.cpp
  vtr-vpr/libs/EXTERNAL/libsdcparse/src/sdc_lexer.cpp
  vtr-vpr/libs/EXTERNAL/libblifparse/src/blif_common.cpp
  vtr-vpr/libs/EXTERNAL/libblifparse/src/blif_error.cpp
  vtr-vpr/libs/EXTERNAL/libblifparse/src/blif_lexer.cpp
  vtr-vpr/libs/EXTERNAL/libblifparse/src/blif_pretty_print.cpp
  vtr-vpr/libs/EXTERNAL/libblifparse/src/blifparse.cpp
  vtr-vpr/libs/EXTERNAL/libblifparse/src/blif_lexer.gen.cpp
  vtr-vpr/libs/EXTERNAL/libblifparse/src/blif_parser.gen.cpp
  vtr-vpr/libs/EXTERNAL/libtatum/libtatum/tatum/TimingConstraints.cpp
  vtr-vpr/libs/EXTERNAL/libtatum/libtatum/tatum/TimingGraph.cpp
  vtr-vpr/libs/EXTERNAL/libtatum/libtatum/tatum/TimingReporter.cpp
  vtr-vpr/libs/EXTERNAL/libtatum/libtatum/tatum/base/loop_detect.cpp
  vtr-vpr/libs/EXTERNAL/libtatum/libtatum/tatum/base/sta_util.cpp
  vtr-vpr/libs/EXTERNAL/libtatum/libtatum/tatum/base/validate_timing_graph_constraints.cpp
  vtr-vpr/libs/EXTERNAL/libtatum/libtatum/tatum/echo_writer.cpp
  vtr-vpr/libs/EXTERNAL/libtatum/libtatum/tatum/report/TimingPathCollector.cpp
  vtr-vpr/libs/EXTERNAL/libtatum/libtatum/tatum/report/graphviz_dot_writer.cpp
  vtr-vpr/libs/EXTERNAL/libtatum/libtatum/tatum/report/timing_path_tracing.cpp
  vtr-vpr/libs/EXTERNAL/libtatum/libtatum/tatum/tags/TimingTags.cpp
  vtr-vpr/libs/EXTERNAL/libtatum/libtatum/tatum/timing_paths.cpp
  vtr-vpr/libs/EXTERNAL/libtatum/libtatum/tatum/util/tatum_assert.cpp
  getdelim/getdelim.c
)

speccpu2026_prepare_rundir()

speccpu2026_generate_inputs(
  RUN_TYPE test
  FILES
    murax_stratixiv_arch_timing.blif.xz
    murax_stratixiv_arch_timing.net.xz
    ref_murax_stratixiv_arch_timing.init.place.xz
    ref_murax_stratixiv_arch_timing.place.xz
)

speccpu2026_generate_inputs(
  RUN_TYPE train
  FILES
    ref_sudoku_check_stratixiv_arch_timing.init.place.xz
    ref_sudoku_check_stratixiv_arch_timing.place.xz
    sudoku_check_stratixiv_arch_timing.blif.xz
    sudoku_check_stratixiv_arch_timing.net.xz
)

speccpu2026_generate_inputs(
  RUN_TYPE ref
  FILES
    JPEG_stratixiv_arch_timing.blif.xz
    JPEG_stratixiv_arch_timing.net.xz
    ref_JPEG_stratixiv_arch_timing.init.place.xz
    ref_JPEG_stratixiv_arch_timing.place.xz
    ref_smithwaterman_stratixiv_arch_timing.init.place.xz
    ref_smithwaterman_stratixiv_arch_timing.place.xz
    smithwaterman_stratixiv_arch_timing.blif.xz
    smithwaterman_stratixiv_arch_timing.net.xz
)

###############################################################################
# vpr_out_compare
###############################################################################

set(PROG ${BENCHMARK}.vpr_out_compare)

# Same flags as the primary binary above; add_definitions() and
# include_directories() are directory-scoped, so they carry.

# vpr_out_compare is a post-run helper: SPEC's `sub compare_commands`
# runs it over the benchmark's output to distill the numbers
# the reference files hold. It gets no test of its own — its
# run lines are part of vpr's test above — but it does
# have to be built.
set(_sources)
foreach (_f IN ITEMS
    compare/vpr_out_compare.cpp
  )
  list(APPEND _sources "${SRC_DIR}/${_f}")
endforeach ()
llvm_test_executable_no_test(${PROG} ${_sources})

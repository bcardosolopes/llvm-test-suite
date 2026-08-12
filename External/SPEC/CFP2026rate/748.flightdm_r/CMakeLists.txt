# 748.flightdm_r
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
  JSB-FlightSim/src
  JSB-FlightSim/src/simgear/xml
)

add_definitions(
  -DXML_POOR_ENTROPY
  -DJSBSIM_STATIC_LINK
)

add_compile_options(-fno-fast-math)

## test ######################################################################

speccpu2026_run_test(
  --nohighlight scripts/c1722.xml
  STDOUT c1722.xml.out
  STDERR c1722.xml.err
  RUN_TYPE test
)

speccpu2026_run_test(
  --nohighlight scripts/J2461.xml
  STDOUT J2461.xml.out
  STDERR J2461.xml.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_run_test(
  --nohighlight scripts/weather-balloon.xml
  STDOUT weather-balloon.xml.out
  STDERR weather-balloon.xml.err
  RUN_TYPE train
)

speccpu2026_run_test(
  --nohighlight scripts/f16_test.xml
  STDOUT f16_test.xml.out
  STDERR f16_test.xml.err
  RUN_TYPE train
)

speccpu2026_run_test(
  --nohighlight scripts/c3105.xml
  STDOUT c3105.xml.out
  STDERR c3105.xml.err
  RUN_TYPE train
)

speccpu2026_run_test(
  --nohighlight scripts/Short_S23_2.xml
  STDOUT Short_S23_2.xml.out
  STDERR Short_S23_2.xml.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_run_test(
  --nohighlight scripts/weather-balloon2.xml
  STDOUT weather-balloon2.xml.out
  STDERR weather-balloon2.xml.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  --nohighlight scripts/B747_script1.xml
  STDOUT B747_script1.xml.out
  STDERR B747_script1.xml.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  --nohighlight scripts/x153.xml
  STDOUT x153.xml.out
  STDERR x153.xml.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  --nohighlight scripts/c3104.xml
  STDOUT c3104.xml.out
  STDERR c3104.xml.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  --nohighlight scripts/ah1s_flight_test.xml
  STDOUT ah1s_flight_test.xml.out
  STDERR ah1s_flight_test.xml.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  --nohighlight scripts/ball_orbit_g_torque.xml
  STDOUT ball_orbit_g_torque.xml.out
  STDERR ball_orbit_g_torque.xml.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  --nohighlight scripts/ball_orbit_g_torque2.xml
  STDOUT ball_orbit_g_torque2.xml.out
  STDERR ball_orbit_g_torque2.xml.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  --nohighlight scripts/ball_orbit.xml
  STDOUT ball_orbit.xml.out
  STDERR ball_orbit.xml.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output(
  ABSOLUTE_TOLERANCE 0.09
  RELATIVE_TOLERANCE 0.001
)

speccpu2026_add_executable(
  JSB-FlightSim/src/FGFDMExec.cpp
  JSB-FlightSim/src/FGJSBBase.cpp
  JSB-FlightSim/src/GeographicLib/Geodesic.cpp
  JSB-FlightSim/src/GeographicLib/GeodesicLine.cpp
  JSB-FlightSim/src/GeographicLib/Math.cpp
  JSB-FlightSim/src/JSBSim.cpp
  JSB-FlightSim/src/initialization/FGInitialCondition.cpp
  JSB-FlightSim/src/initialization/FGLinearization.cpp
  JSB-FlightSim/src/initialization/FGTrim.cpp
  JSB-FlightSim/src/initialization/FGTrimAxis.cpp
  JSB-FlightSim/src/input_output/FGGroundCallback.cpp
  JSB-FlightSim/src/input_output/FGInputType.cpp
  JSB-FlightSim/src/input_output/FGModelLoader.cpp
  JSB-FlightSim/src/input_output/FGOutputFile.cpp
  JSB-FlightSim/src/input_output/FGOutputTextFile.cpp
  JSB-FlightSim/src/input_output/FGOutputType.cpp
  JSB-FlightSim/src/input_output/FGPropertyManager.cpp
  JSB-FlightSim/src/input_output/FGPropertyReader.cpp
  JSB-FlightSim/src/input_output/FGScript.cpp
  JSB-FlightSim/src/input_output/FGXMLElement.cpp
  JSB-FlightSim/src/input_output/FGXMLFileRead.cpp
  JSB-FlightSim/src/input_output/FGXMLParse.cpp
  JSB-FlightSim/src/input_output/string_utilities.cpp
  JSB-FlightSim/src/math/FGColumnVector3.cpp
  JSB-FlightSim/src/math/FGCondition.cpp
  JSB-FlightSim/src/math/FGFunction.cpp
  JSB-FlightSim/src/math/FGLocation.cpp
  JSB-FlightSim/src/math/FGMatrix33.cpp
  JSB-FlightSim/src/math/FGModelFunctions.cpp
  JSB-FlightSim/src/math/FGNelderMead.cpp
  JSB-FlightSim/src/math/FGPropertyValue.cpp
  JSB-FlightSim/src/math/FGQuaternion.cpp
  JSB-FlightSim/src/math/FGRealValue.cpp
  JSB-FlightSim/src/math/FGRungeKutta.cpp
  JSB-FlightSim/src/math/FGStateSpace.cpp
  JSB-FlightSim/src/math/FGTable.cpp
  JSB-FlightSim/src/math/FGTemplateFunc.cpp
  JSB-FlightSim/src/models/FGAccelerations.cpp
  JSB-FlightSim/src/models/FGAerodynamics.cpp
  JSB-FlightSim/src/models/FGAircraft.cpp
  JSB-FlightSim/src/models/FGAtmosphere.cpp
  JSB-FlightSim/src/models/FGAuxiliary.cpp
  JSB-FlightSim/src/models/FGBuoyantForces.cpp
  JSB-FlightSim/src/models/FGExternalForce.cpp
  JSB-FlightSim/src/models/FGExternalReactions.cpp
  JSB-FlightSim/src/models/FGFCS.cpp
  JSB-FlightSim/src/models/FGGasCell.cpp
  JSB-FlightSim/src/models/FGGroundReactions.cpp
  JSB-FlightSim/src/models/FGInertial.cpp
  JSB-FlightSim/src/models/FGInput.cpp
  JSB-FlightSim/src/models/FGLGear.cpp
  JSB-FlightSim/src/models/FGMassBalance.cpp
  JSB-FlightSim/src/models/FGModel.cpp
  JSB-FlightSim/src/models/FGOutput.cpp
  JSB-FlightSim/src/models/FGPropagate.cpp
  JSB-FlightSim/src/models/FGPropulsion.cpp
  JSB-FlightSim/src/models/FGSurface.cpp
  JSB-FlightSim/src/models/atmosphere/FGMSIS.cpp
  JSB-FlightSim/src/models/atmosphere/FGMSISData.cpp
  JSB-FlightSim/src/models/atmosphere/FGMars.cpp
  JSB-FlightSim/src/models/atmosphere/FGStandardAtmosphere.cpp
  JSB-FlightSim/src/models/atmosphere/FGWinds.cpp
  JSB-FlightSim/src/models/flight_control/FGAccelerometer.cpp
  JSB-FlightSim/src/models/flight_control/FGActuator.cpp
  JSB-FlightSim/src/models/flight_control/FGAngles.cpp
  JSB-FlightSim/src/models/flight_control/FGDeadBand.cpp
  JSB-FlightSim/src/models/flight_control/FGDistributor.cpp
  JSB-FlightSim/src/models/flight_control/FGFCSComponent.cpp
  JSB-FlightSim/src/models/flight_control/FGFCSFunction.cpp
  JSB-FlightSim/src/models/flight_control/FGFilter.cpp
  JSB-FlightSim/src/models/flight_control/FGGain.cpp
  JSB-FlightSim/src/models/flight_control/FGGyro.cpp
  JSB-FlightSim/src/models/flight_control/FGKinemat.cpp
  JSB-FlightSim/src/models/flight_control/FGLinearActuator.cpp
  JSB-FlightSim/src/models/flight_control/FGMagnetometer.cpp
  JSB-FlightSim/src/models/flight_control/FGPID.cpp
  JSB-FlightSim/src/models/flight_control/FGSensor.cpp
  JSB-FlightSim/src/models/flight_control/FGSummer.cpp
  JSB-FlightSim/src/models/flight_control/FGSwitch.cpp
  JSB-FlightSim/src/models/flight_control/FGWaypoint.cpp
  JSB-FlightSim/src/models/propulsion/FGBrushLessDCMotor.cpp
  JSB-FlightSim/src/models/propulsion/FGElectric.cpp
  JSB-FlightSim/src/models/propulsion/FGEngine.cpp
  JSB-FlightSim/src/models/propulsion/FGForce.cpp
  JSB-FlightSim/src/models/propulsion/FGNozzle.cpp
  JSB-FlightSim/src/models/propulsion/FGPiston.cpp
  JSB-FlightSim/src/models/propulsion/FGPropeller.cpp
  JSB-FlightSim/src/models/propulsion/FGRocket.cpp
  JSB-FlightSim/src/models/propulsion/FGRotor.cpp
  JSB-FlightSim/src/models/propulsion/FGTank.cpp
  JSB-FlightSim/src/models/propulsion/FGThruster.cpp
  JSB-FlightSim/src/models/propulsion/FGTransmission.cpp
  JSB-FlightSim/src/models/propulsion/FGTurbine.cpp
  JSB-FlightSim/src/models/propulsion/FGTurboProp.cpp
  JSB-FlightSim/src/simgear/xml/easyxml.cxx
  JSB-FlightSim/src/simgear/xml/xmlparse.cpp
  JSB-FlightSim/src/simgear/xml/xmlrole.cpp
  JSB-FlightSim/src/simgear/xml/xmltok.cpp
  JSB-FlightSim/src/simgear/io/iostreams/sgstream.cxx
  JSB-FlightSim/src/simgear/magvar/coremag.cxx
  JSB-FlightSim/src/simgear/misc/sg_path.cxx
  JSB-FlightSim/src/simgear/misc/strutils.cxx
  JSB-FlightSim/src/simgear/props/props.cxx
)

speccpu2026_prepare_rundir()

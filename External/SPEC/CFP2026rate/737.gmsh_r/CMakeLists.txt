# 737.gmsh_r
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
  specrand
  spec_restrict
  spec_inline_control
  gmsh/contrib/hxt/tetMesh/include
  gmsh/contrib/hxt/tetBR/include
  gmsh/contrib/hxt/predicates/include
  gmsh/contrib/hxt/core/include
  gmsh/contrib/eigen
  gmsh/contrib/ALGLIB
  gmsh/contrib/HighOrderMeshOptimizer
  gmsh/contrib/MeshOptimizer
  gmsh/contrib/MeshQualityOptimizer
  gmsh/contrib/QuadTri
  gmsh/contrib/Netgen
  gmsh/contrib/Netgen/libsrc/include
  gmsh/contrib/Netgen/nglib
  gmsh/src/common
  gmsh/src/geo
  gmsh/src/mesh
  gmsh/src/numeric
  gmsh/src/parser
  gmsh/api
)

add_definitions(
  -DNO_PARALLEL_THREADS
)

add_compile_options(-fno-fast-math)

## test ######################################################################

speccpu2026_remove_stale_output(
  RUN_TYPE test
  FILES
    spec.val
)

speccpu2026_run_test(
  -option gmsh.opts -nt 0 spec.geo -smooth 0 -clscale .60
  STDOUT spec.geo.out
  STDERR spec.geo.err
  RUN_TYPE test
)

## train #####################################################################

speccpu2026_remove_stale_output(
  RUN_TYPE train
  FILES
    spec.val
    sphere-discrete.val
)

speccpu2026_run_test(
  -option gmsh.opts -nt 0 sphere-discrete.geo
  STDOUT sphere-discrete.geo.out
  STDERR sphere-discrete.geo.err
  RUN_TYPE train
)

speccpu2026_run_test(
  -option gmsh.opts -nt 0 spec.geo -smooth 2 -clscale .27
  STDOUT spec.geo.out
  STDERR spec.geo.err
  RUN_TYPE train
)

## ref #######################################################################

speccpu2026_remove_stale_output(
  RUN_TYPE ref
  FILES
    Torus.val
    choi.val
    gasdis.val
    mediterranean.val
    p19.val
    projection.val
    spec.val
)

speccpu2026_run_test(
  -option gmsh.opts -nt 0 choi.geo
  STDOUT choi.geo.out
  STDERR choi.geo.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -option gmsh.opts -nt 0 mediterranean.geo
  STDOUT mediterranean.geo.out
  STDERR mediterranean.geo.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -option gmsh.opts -nt 0 projection.geo
  STDOUT projection.geo.out
  STDERR projection.geo.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -option gmsh.opts -nt 0 gasdis.geo
  STDOUT gasdis.geo.out
  STDERR gasdis.geo.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -option gmsh.opts -nt 0 Torus.geo
  STDOUT Torus.geo.out
  STDERR Torus.geo.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -option gmsh.opts -nt 0 spec.geo -clscale 0.175 -algo del2d -algo hxt
  STDOUT spec.geo.out
  STDERR spec.geo.err
  RUN_TYPE ref
)

speccpu2026_run_test(
  -option gmsh.opts -nt 0 p19.geo
  STDOUT p19.geo.out
  STDERR p19.geo.err
  RUN_TYPE ref
)

###############################################################################

speccpu2026_verify_output(
  RELATIVE_TOLERANCE 0.035
)

speccpu2026_add_executable(
  gmsh/src/geo/GFace.cpp
  gmsh/src/numeric/Numeric.cpp
  gmsh/src/geo/MQuadrangle.cpp
  gmsh/src/mesh/meshMetric.cpp
  gmsh/src/geo/STensor3.cpp
  gmsh/contrib/ALGLIB/alglibinternal.cpp
  gmsh/contrib/ALGLIB/alglibmisc.cpp
  gmsh/contrib/ALGLIB/ap.cpp
  gmsh/contrib/ALGLIB/linalg.cpp
  gmsh/contrib/ALGLIB/optimization.cpp
  gmsh/contrib/ALGLIB/solvers.cpp
  gmsh/contrib/HighOrderMeshOptimizer/BoundaryLayerCurver2D.cpp
  gmsh/contrib/HighOrderMeshOptimizer/BoundaryLayerCurver3D.cpp
  gmsh/contrib/HighOrderMeshOptimizer/HighOrderMeshElasticAnalogy.cpp
  gmsh/contrib/HighOrderMeshOptimizer/HighOrderMeshFastCurving.cpp
  gmsh/contrib/HighOrderMeshOptimizer/HighOrderMeshOptimizer.cpp
  gmsh/contrib/HighOrderMeshOptimizer/HighOrderMeshPeriodicity.cpp
  gmsh/contrib/HighOrderMeshOptimizer/MetaEl.cpp
  gmsh/contrib/MeshOptimizer/CADDistances.cpp
  gmsh/contrib/MeshOptimizer/IntegralBoundaryDist.cpp
  gmsh/contrib/MeshOptimizer/MeshOpt.cpp
  gmsh/contrib/MeshOptimizer/MeshOptCommon.cpp
  gmsh/contrib/MeshOptimizer/MeshOptimizer.cpp
  gmsh/contrib/MeshOptimizer/ObjContrib.cpp
  gmsh/contrib/MeshOptimizer/ObjContribFunc.cpp
  gmsh/contrib/MeshOptimizer/ObjectiveFunction.cpp
  gmsh/contrib/MeshOptimizer/Patch.cpp
  gmsh/contrib/MeshOptimizer/VertexCoord.cpp
  gmsh/contrib/MeshQualityOptimizer/MeshQualityOptimizer.cpp
  gmsh/contrib/Netgen/libsrc/general/array.cpp
  gmsh/contrib/Netgen/libsrc/general/bitarray.cpp
  gmsh/contrib/Netgen/libsrc/general/dynamicmem.cpp
  gmsh/contrib/Netgen/libsrc/general/flags.cpp
  gmsh/contrib/Netgen/libsrc/general/hashtabl.cpp
  gmsh/contrib/Netgen/libsrc/general/mystring.cpp
  gmsh/contrib/Netgen/libsrc/general/ngexception.cpp
  gmsh/contrib/Netgen/libsrc/general/optmem.cpp
  gmsh/contrib/Netgen/libsrc/general/parthreads.cpp
  gmsh/contrib/Netgen/libsrc/general/profiler.cpp
  gmsh/contrib/Netgen/libsrc/general/seti.cpp
  gmsh/contrib/Netgen/libsrc/general/sort.cpp
  gmsh/contrib/Netgen/libsrc/general/spbita2d.cpp
  gmsh/contrib/Netgen/libsrc/general/symbolta.cpp
  gmsh/contrib/Netgen/libsrc/general/table.cpp
  gmsh/contrib/Netgen/libsrc/gprim/adtree.cpp
  gmsh/contrib/Netgen/libsrc/gprim/geom2d.cpp
  gmsh/contrib/Netgen/libsrc/gprim/geom3d.cpp
  gmsh/contrib/Netgen/libsrc/gprim/geomfuncs.cpp
  gmsh/contrib/Netgen/libsrc/gprim/geomtest3d.cpp
  gmsh/contrib/Netgen/libsrc/gprim/transform3d.cpp
  gmsh/contrib/Netgen/libsrc/linalg/bfgs.cpp
  gmsh/contrib/Netgen/libsrc/linalg/densemat.cpp
  gmsh/contrib/Netgen/libsrc/linalg/linopt.cpp
  gmsh/contrib/Netgen/libsrc/linalg/linsearch.cpp
  gmsh/contrib/Netgen/libsrc/linalg/polynomial.cpp
  gmsh/contrib/Netgen/libsrc/meshing/adfront2.cpp
  gmsh/contrib/Netgen/libsrc/meshing/adfront3.cpp
  gmsh/contrib/Netgen/libsrc/meshing/basegeom.cpp
  gmsh/contrib/Netgen/libsrc/meshing/bisect.cpp
  gmsh/contrib/Netgen/libsrc/meshing/boundarylayer.cpp
  gmsh/contrib/Netgen/libsrc/meshing/clusters.cpp
  gmsh/contrib/Netgen/libsrc/meshing/curvedelems.cpp
  gmsh/contrib/Netgen/libsrc/meshing/delaunay.cpp
  gmsh/contrib/Netgen/libsrc/meshing/geomsearch.cpp
  gmsh/contrib/Netgen/libsrc/meshing/global.cpp
  gmsh/contrib/Netgen/libsrc/meshing/improve2.cpp
  gmsh/contrib/Netgen/libsrc/meshing/improve2gen.cpp
  gmsh/contrib/Netgen/libsrc/meshing/improve3.cpp
  gmsh/contrib/Netgen/libsrc/meshing/localh.cpp
  gmsh/contrib/Netgen/libsrc/meshing/meshclass.cpp
  gmsh/contrib/Netgen/libsrc/meshing/meshfunc.cpp
  gmsh/contrib/Netgen/libsrc/meshing/meshing2.cpp
  gmsh/contrib/Netgen/libsrc/meshing/meshing3.cpp
  gmsh/contrib/Netgen/libsrc/meshing/meshtool.cpp
  gmsh/contrib/Netgen/libsrc/meshing/meshtype.cpp
  gmsh/contrib/Netgen/libsrc/meshing/msghandler.cpp
  gmsh/contrib/Netgen/libsrc/meshing/netrule2.cpp
  gmsh/contrib/Netgen/libsrc/meshing/netrule3.cpp
  gmsh/contrib/Netgen/libsrc/meshing/parser2.cpp
  gmsh/contrib/Netgen/libsrc/meshing/parser3.cpp
  gmsh/contrib/Netgen/libsrc/meshing/prism2rls.cpp
  gmsh/contrib/Netgen/libsrc/meshing/pyramid2rls.cpp
  gmsh/contrib/Netgen/libsrc/meshing/pyramidrls.cpp
  gmsh/contrib/Netgen/libsrc/meshing/quadrls.cpp
  gmsh/contrib/Netgen/libsrc/meshing/refine.cpp
  gmsh/contrib/Netgen/libsrc/meshing/ruler2.cpp
  gmsh/contrib/Netgen/libsrc/meshing/ruler3.cpp
  gmsh/contrib/Netgen/libsrc/meshing/smoothing2.5.cpp
  gmsh/contrib/Netgen/libsrc/meshing/smoothing2.cpp
  gmsh/contrib/Netgen/libsrc/meshing/smoothing3.cpp
  gmsh/contrib/Netgen/libsrc/meshing/specials.cpp
  gmsh/contrib/Netgen/libsrc/meshing/tetrarls.cpp
  gmsh/contrib/Netgen/libsrc/meshing/topology.cpp
  gmsh/contrib/Netgen/libsrc/meshing/triarls.cpp
  gmsh/contrib/Netgen/libsrc/meshing/validate.cpp
  gmsh/contrib/Netgen/nglib_gmsh.cpp
  gmsh/contrib/QuadTri/QuadTriExtruded2D.cpp
  gmsh/contrib/QuadTri/QuadTriExtruded3D.cpp
  gmsh/contrib/QuadTri/QuadTriTransfinite3D.cpp
  gmsh/contrib/QuadTri/QuadTriUtils.cpp
  gmsh/contrib/hxt/core/src/hxt_bbox.c
  gmsh/contrib/hxt/core/src/hxt_mesh.c
  gmsh/contrib/hxt/core/src/hxt_message.c
  gmsh/contrib/hxt/core/src/hxt_sort.c
  gmsh/contrib/hxt/predicates/src/predicates.c
  gmsh/contrib/hxt/tetBR/src/hxt_boundary_recovery.cxx
  gmsh/contrib/hxt/tetMesh/src/HXTSPR.c
  gmsh/contrib/hxt/tetMesh/src/hxt_edgeRemoval.c
  gmsh/contrib/hxt/tetMesh/src/hxt_smoothing.c
  gmsh/contrib/hxt/tetMesh/src/hxt_tetColor.c
  gmsh/contrib/hxt/tetMesh/src/hxt_tetDelaunay.c
  gmsh/contrib/hxt/tetMesh/src/hxt_tetDelaunayReshape.c
  gmsh/contrib/hxt/tetMesh/src/hxt_tetFlag.c
  gmsh/contrib/hxt/tetMesh/src/hxt_tetMesh.c
  gmsh/contrib/hxt/tetMesh/src/hxt_tetNodalSize.c
  gmsh/contrib/hxt/tetMesh/src/hxt_tetOpti.c
  gmsh/contrib/hxt/tetMesh/src/hxt_tetQuality.c
  gmsh/contrib/hxt/tetMesh/src/hxt_tetRefine.c
  gmsh/contrib/hxt/tetMesh/src/hxt_tetRepair.c
  gmsh/contrib/hxt/tetMesh/src/hxt_tetSync.c
  gmsh/contrib/hxt/tetMesh/src/hxt_tetUtils.c
  gmsh/contrib/hxt/tetMesh/src/hxt_vertices.c
  gmsh/src/common/CommandLine.cpp
  gmsh/src/common/Context.cpp
  gmsh/src/common/CreateFile.cpp
  gmsh/src/common/GamePad.cpp
  gmsh/src/common/GmshGlobal.cpp
  gmsh/src/common/GmshMessage.cpp
  gmsh/src/common/GmshRemote.cpp
  gmsh/src/common/ListUtils.cpp
  gmsh/src/common/Main.cpp
  gmsh/src/common/MallocUtils.cpp
  gmsh/src/common/OS.cpp
  gmsh/src/common/Octree.cpp
  gmsh/src/common/OctreeInternals.cpp
  gmsh/src/common/OpenFile.cpp
  gmsh/src/common/Options.cpp
  gmsh/src/common/SmoothData.cpp
  gmsh/src/common/StringUtils.cpp
  gmsh/src/common/TreeUtils.cpp
  gmsh/src/common/VertexArray.cpp
  gmsh/src/common/avl.cpp
  gmsh/src/common/gmsh.cpp
  gmsh/src/common/gmshLocalNetworkClient.cpp
  gmsh/src/common/gmshPopplerWrapper.cpp
  gmsh/src/common/libol1.c
  gmsh/src/geo/CGNSCommon.cpp
  gmsh/src/geo/CGNSConventions.cpp
  gmsh/src/geo/CGNSRead.cpp
  gmsh/src/geo/CGNSWrite.cpp
  gmsh/src/geo/CGNSWriteStruct.cpp
  gmsh/src/geo/CGNSZone.cpp
  gmsh/src/geo/CGNSZoneStruct.cpp
  gmsh/src/geo/CGNSZoneUnstruct.cpp
  gmsh/src/geo/Cell.cpp
  gmsh/src/geo/CellComplex.cpp
  gmsh/src/geo/Chain.cpp
  gmsh/src/geo/ChainComplex.cpp
  gmsh/src/geo/ExtrudeParams.cpp
  gmsh/src/geo/GEdge.cpp
  gmsh/src/geo/GEdgeLoop.cpp
  gmsh/src/geo/GEntity.cpp
  gmsh/src/geo/GModel.cpp
  gmsh/src/geo/GModelAutoExtrude.cpp
  gmsh/src/geo/GModelCreateTopologyFromMesh.cpp
  gmsh/src/geo/GModelIO_ACTRAN.cpp
  gmsh/src/geo/GModelIO_BDF.cpp
  gmsh/src/geo/GModelIO_CELUM.cpp
  gmsh/src/geo/GModelIO_CGNS.cpp
  gmsh/src/geo/GModelIO_DIFF.cpp
  gmsh/src/geo/GModelIO_GEO.cpp
  gmsh/src/geo/GModelIO_GEOM.cpp
  gmsh/src/geo/GModelIO_INP.cpp
  gmsh/src/geo/GModelIO_IR3.cpp
  gmsh/src/geo/GModelIO_KEY.cpp
  gmsh/src/geo/GModelIO_MAIL.cpp
  gmsh/src/geo/GModelIO_MATLAB.cpp
  gmsh/src/geo/GModelIO_MED.cpp
  gmsh/src/geo/GModelIO_MESH.cpp
  gmsh/src/geo/GModelIO_MSH.cpp
  gmsh/src/geo/GModelIO_MSH2.cpp
  gmsh/src/geo/GModelIO_MSH3.cpp
  gmsh/src/geo/GModelIO_MSH4.cpp
  gmsh/src/geo/GModelIO_NEU.cpp
  gmsh/src/geo/GModelIO_NIfTI.cpp
  gmsh/src/geo/GModelIO_OCC.cpp
  gmsh/src/geo/GModelIO_OFF.cpp
  gmsh/src/geo/GModelIO_P3D.cpp
  gmsh/src/geo/GModelIO_PLY.cpp
  gmsh/src/geo/GModelIO_POS.cpp
  gmsh/src/geo/GModelIO_RAD.cpp
  gmsh/src/geo/GModelIO_SAMCEF.cpp
  gmsh/src/geo/GModelIO_STL.cpp
  gmsh/src/geo/GModelIO_SU2.cpp
  gmsh/src/geo/GModelIO_TOCHNOG.cpp
  gmsh/src/geo/GModelIO_UNV.cpp
  gmsh/src/geo/GModelIO_VRML.cpp
  gmsh/src/geo/GModelIO_VTK.cpp
  gmsh/src/geo/GModelIO_X3D.cpp
  gmsh/src/geo/GModelParametrize.cpp
  gmsh/src/geo/GModelVertexArrays.cpp
  gmsh/src/geo/GRegion.cpp
  gmsh/src/geo/GVertex.cpp
  gmsh/src/geo/Geo.cpp
  gmsh/src/geo/GeoInterpolation.cpp
  gmsh/src/geo/GeomMeshMatcher.cpp
  gmsh/src/geo/Homology.cpp
  gmsh/src/geo/MEdge.cpp
  gmsh/src/geo/MElement.cpp
  gmsh/src/geo/MElementCut.cpp
  gmsh/src/geo/MElementOctree.cpp
  gmsh/src/geo/MFace.cpp
  gmsh/src/geo/MHexahedron.cpp
  gmsh/src/geo/MLine.cpp
  gmsh/src/geo/MPrism.cpp
  gmsh/src/geo/MPyramid.cpp
  gmsh/src/geo/MSubElement.cpp
  gmsh/src/geo/MTetrahedron.cpp
  gmsh/src/geo/MTriangle.cpp
  gmsh/src/geo/MTrihedron.cpp
  gmsh/src/geo/MVertex.cpp
  gmsh/src/geo/MVertexBoundaryLayerData.cpp
  gmsh/src/geo/OCCEdge.cpp
  gmsh/src/geo/OCCFace.cpp
  gmsh/src/geo/OCCRegion.cpp
  gmsh/src/geo/OCCVertex.cpp
  gmsh/src/geo/SOrientedBoundingBox.cpp
  gmsh/src/geo/affineTransformation.cpp
  gmsh/src/geo/boundaryLayersData.cpp
  gmsh/src/geo/closestPoint.cpp
  gmsh/src/geo/closestVertex.cpp
  gmsh/src/geo/discreteEdge.cpp
  gmsh/src/geo/discreteFace.cpp
  gmsh/src/geo/discreteRegion.cpp
  gmsh/src/geo/discreteVertex.cpp
  gmsh/src/geo/findLinks.cpp
  gmsh/src/geo/gmshEdge.cpp
  gmsh/src/geo/gmshFace.cpp
  gmsh/src/geo/gmshLevelset.cpp
  gmsh/src/geo/gmshRegion.cpp
  gmsh/src/geo/gmshSurface.cpp
  gmsh/src/geo/gmshVertex.cpp
  gmsh/src/geo/intersectCurveSurface.cpp
  gmsh/src/geo/scriptStringInterface.cpp
  gmsh/src/mesh/BDS.cpp
  gmsh/src/mesh/BackgroundMesh.cpp
  gmsh/src/mesh/BackgroundMeshTools.cpp
  gmsh/src/mesh/BoundaryLayers.cpp
  gmsh/src/mesh/DivideAndConquer.cpp
  gmsh/src/mesh/Field.cpp
  gmsh/src/mesh/Generator.cpp
  gmsh/src/mesh/HighOrder.cpp
  gmsh/src/mesh/alphaShapes.cpp
  gmsh/src/mesh/automaticMeshSizeField.cpp
  gmsh/src/mesh/delaunay3d.cpp
  gmsh/src/mesh/filterElements.cpp
  gmsh/src/mesh/gmshCrossFields.cpp
  gmsh/src/mesh/meshCombine3D.cpp
  gmsh/src/mesh/meshGEdge.cpp
  gmsh/src/mesh/meshGEdgeExtruded.cpp
  gmsh/src/mesh/meshGFace.cpp
  gmsh/src/mesh/meshGFaceBDS.cpp
  gmsh/src/mesh/meshGFaceBamg.cpp
  gmsh/src/mesh/meshGFaceBipartiteLabelling.cpp
  gmsh/src/mesh/meshGFaceDelaunayInsertion.cpp
  gmsh/src/mesh/meshGFaceExtruded.cpp
  gmsh/src/mesh/meshGFaceOptimize.cpp
  gmsh/src/mesh/meshGFacePack.cpp
  gmsh/src/mesh/meshGFaceTransfinite.cpp
  gmsh/src/mesh/meshGRegion.cpp
  gmsh/src/mesh/meshGRegionBoundaryLayer.cpp
  gmsh/src/mesh/meshGRegionBoundaryRecovery.cpp
  gmsh/src/mesh/meshGRegionCarveHole.cpp
  gmsh/src/mesh/meshGRegionDelaunayInsertion.cpp
  gmsh/src/mesh/meshGRegionExtruded.cpp
  gmsh/src/mesh/meshGRegionHxt.cpp
  gmsh/src/mesh/meshGRegionLocalMeshMod.cpp
  gmsh/src/mesh/meshGRegionMMG.cpp
  gmsh/src/mesh/meshGRegionNetgen.cpp
  gmsh/src/mesh/meshGRegionTransfinite.cpp
  gmsh/src/mesh/meshMesquite.cpp
  gmsh/src/mesh/meshOctreeLibOL.cpp
  gmsh/src/mesh/meshPartition.cpp
  gmsh/src/mesh/meshQuadQuasiStructured.cpp
  gmsh/src/mesh/meshRefine.cpp
  gmsh/src/mesh/meshRelocateVertex.cpp
  gmsh/src/mesh/meshRenumber.cpp
  gmsh/src/mesh/meshTriangulation.cpp
  gmsh/src/mesh/meshUntangle.cpp
  gmsh/src/mesh/qualityMeasures.cpp
  gmsh/src/mesh/qualityMeasuresJacobian.cpp
  gmsh/src/numeric/BasisFactory.cpp
  gmsh/src/numeric/BergotBasis.cpp
  gmsh/src/numeric/CondNumBasis.cpp
  gmsh/src/numeric/ConjugateGradients.cpp
  gmsh/src/numeric/ElementType.cpp
  gmsh/src/numeric/FuncSpaceData.cpp
  gmsh/src/numeric/GaussIntegration.cpp
  gmsh/src/numeric/GaussJacobi1D.cpp
  gmsh/src/numeric/GaussLegendreSimplex.cpp
  gmsh/src/numeric/GaussQuadratureHex.cpp
  gmsh/src/numeric/GaussQuadratureLin.cpp
  gmsh/src/numeric/GaussQuadraturePri.cpp
  gmsh/src/numeric/GaussQuadraturePyr.cpp
  gmsh/src/numeric/GaussQuadratureQuad.cpp
  gmsh/src/numeric/GaussQuadratureTet.cpp
  gmsh/src/numeric/GaussQuadratureTri.cpp
  gmsh/src/numeric/HierarchicalBasis.cpp
  gmsh/src/numeric/HierarchicalBasisH1.cpp
  gmsh/src/numeric/HierarchicalBasisH1Brick.cpp
  gmsh/src/numeric/HierarchicalBasisH1Line.cpp
  gmsh/src/numeric/HierarchicalBasisH1Point.cpp
  gmsh/src/numeric/HierarchicalBasisH1Pri.cpp
  gmsh/src/numeric/HierarchicalBasisH1Quad.cpp
  gmsh/src/numeric/HierarchicalBasisH1Tetra.cpp
  gmsh/src/numeric/HierarchicalBasisH1Tria.cpp
  gmsh/src/numeric/HierarchicalBasisHcurl.cpp
  gmsh/src/numeric/HierarchicalBasisHcurlBrick.cpp
  gmsh/src/numeric/HierarchicalBasisHcurlLine.cpp
  gmsh/src/numeric/HierarchicalBasisHcurlPri.cpp
  gmsh/src/numeric/HierarchicalBasisHcurlQuad.cpp
  gmsh/src/numeric/HierarchicalBasisHcurlTetra.cpp
  gmsh/src/numeric/HierarchicalBasisHcurlTria.cpp
  gmsh/src/numeric/HilbertCurve.cpp
  gmsh/src/numeric/InnerVertexPlacement.cpp
  gmsh/src/numeric/Iso.cpp
  gmsh/src/numeric/JacobianBasis.cpp
  gmsh/src/numeric/OrthogonalPoly.cpp
  gmsh/src/numeric/approximationError.cpp
  gmsh/src/numeric/bezierBasis.cpp
  gmsh/src/numeric/curvature.cpp
  gmsh/src/numeric/decasteljau.cpp
  gmsh/src/numeric/discreteFrechetDistance.cpp
  gmsh/src/numeric/fullMatrix.cpp
  gmsh/src/numeric/incompleteBasis.cpp
  gmsh/src/numeric/mathEvaluator.cpp
  gmsh/src/numeric/miniBasis.cpp
  gmsh/src/numeric/nodalBasis.cpp
  gmsh/src/numeric/orthogonalBasis.cpp
  gmsh/src/numeric/pointsGenerators.cpp
  gmsh/src/numeric/polynomialBasis.cpp
  gmsh/src/numeric/pyramidalBasis.cpp
  gmsh/src/numeric/robustPredicates.cpp
  gmsh/src/parser/FunctionManager.cpp
  gmsh/src/parser/Gmsh.tab.cpp
  gmsh/src/parser/Gmsh.yy.cpp
  specrand/specrand.c
)

speccpu2026_prepare_rundir()

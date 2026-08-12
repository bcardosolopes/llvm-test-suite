add_subdirectory(709.cactus_r)     # C++, C
add_subdirectory(731.astcenc_r)    # C++
add_subdirectory(736.ocio_r)       # C++, C
add_subdirectory(737.gmsh_r)       # C++, C
add_subdirectory(748.flightdm_r)   # C++, C
add_subdirectory(766.femflow_r)    # C++
add_subdirectory(767.nest_r)       # C++, C
add_subdirectory(772.marian_r)     # C++
add_subdirectory(782.lbm_r)        # C

# Not here, on purpose:
#
#   722.palm_r, 749.fotonik3d_r, 765.roms_r   Fortran. Unlike SPEC CPU 2017,
#       these are not gated behind TEST_SUITE_FORTRAN -- they have not been
#       ported at all, so there is no directory to add_subdirectory().
#
#   999.specrand_r  fprate and intrate share one specrand in SPEC CPU 2026
#       (2017 had a separate 997.specrand_fr). CINT2026rate builds it; two
#       directories cannot both define the 999.specrand_r target.

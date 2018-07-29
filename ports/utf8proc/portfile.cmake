include(vcpkg_common_functions)
#vcpkg_from_github(
#    OUT_SOURCE_PATH SOURCE_PATH
#    REPO JuliaLang/utf8proc
#    REF v2.2.0
#    SHA512 ae19287e33bc4807475063963557c4d1d2f7d95577d61882ba8df380883662860eeb868e7391ac1b8111614ca2c1855f631925ade6eaa827d07d28cc4cdbab9c)

set(SOURCE_PATH C:/Users/joel/local_dev/utf8proc)
#vcpkg_apply_patches(SOURCE_PATH ${SOURCE_PATH}
#    PATCHES ${CMAKE_CURRENT_LIST_DIR}/fix-buildsystem.patch)

if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    set(BUILD_SHARED ON)
else()
    set(BUILD_SHARED OFF)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS 
    -DBUILD_SHARED_LIBS=${BUILD_SHARED}
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

#file(READ ${CURRENT_PACKAGES_DIR}/include/utf8proc.h UTF8PROC_H)
#if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
#    string(REPLACE "defined UTF8PROC_SHARED" "0" UTF8PROC_H "${UTF8PROC_H}")
#else()
#    string(REPLACE "defined UTF8PROC_SHARED" "1" UTF8PROC_H "${UTF8PROC_H}")
#endif()
#file(WRITE ${CURRENT_PACKAGES_DIR}/include/utf8proc.h "${UTF8PROC_H}")

file(COPY ${SOURCE_PATH}/LICENSE.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/utf8proc)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/utf8proc/LICENSE.md ${CURRENT_PACKAGES_DIR}/share/utf8proc/copyright)

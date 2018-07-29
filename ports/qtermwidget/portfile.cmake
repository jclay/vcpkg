# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#

include(vcpkg_common_functions)
#set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/zlib1211-2)
#vcpkg_download_distfile(ARCHIVE
#    URLS "http://zlib.net/zlib1211.zip"
#    FILENAME "zlib1211-2.zip"
#    SHA512 9069fe4a9bfae1d45bcf000404c9f89605741b67987b8ca412b84ba937ed1b7bba4b8b174b6f9bc6814776def5f4b34ec7785cd84aa410002d87ddd1b507f11a
#)
#vcpkg_extract_source_archive(${ARCHIVE})
set(SOURCE_PATH C:/Users/joel/local_dev/qtermwidget)

if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    set(BUILD_SHARED ON)
else()
    set(BUILD_SHARED OFF)
endif()
vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS
    -DQt5_DIR=C:/Qt/5.11.1/msvc2017_64/lib/cmake/Qt5
    -DQt5Widgets_DIR=C:/Qt/5.11.1/msvc2017_64/lib/cmake/Qt5Widgets
    -DQt5Network_DIR=C:/Qt/5.11.1/msvc2017_64/lib/cmake/Qt5Network
    -DQt5LinguistTools_DIR=C:/Qt/5.11.1/msvc2017_64/lib/cmake/Qt5LinguistTools
    -DBUILD_SHARED_LIBS=${BUILD_SHARED}
    # OPTIONS -DUSE_THIS_IN_ALL_BUILDS=1 -DUSE_THIS_TOO=2
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/qtermwidget RENAME copyright)

# Try to find PYSIDE utilities, pyuic4 and pyrcc5:
# PYUIC4BINARY - Location of pyuic4 executable
# PYRCC4BINARY - Location of pyrcc4 executable
# PYSIDE_FOUND - PYSIDE utilities found.

# Also provides macro similar to FindQt4.cmake's WRAP_UI and WRAP_RC,
# for the automatic generation of Python code from Qt4's user interface
# ('.ui') and resource ('.qrc') files. These macros are called:
# - PYSIDE_WRAP_UI
# - PYSIDE_WRAP_RC

IF(PYUIC4BINARY AND PYRCC4BINARY)
  # Already in cache, be silent
  set(PYSIDE_FIND_QUIETLY FALSE)
ENDIF(PYUIC4BINARY AND PYRCC4BINARY)

if(WIN32)
	FIND_PROGRAM(PYUIC4BINARY pyuic4.bat)
	FIND_PROGRAM(PYRCC4BINARY pyrcc4)
endif(WIN32)
if(APPLE OR UNIX)
	FIND_PROGRAM( PYUIC4BINARY pyuic4
		HINTS ${PYTHON_BIN_DIR} 
		)
	FIND_PROGRAM(PYRCC4BINARY pyrcc4
		HINTS ${PYTHON_BIN_DIR} 
		)
endif(APPLE OR UNIX)
message(STATUS "PYUIC4BINARY ${PYUIC4BINARY}" )
message(STATUS "PYRCC4BINARY ${PYRCC4BINARY}" )

MACRO(PYSIDE_WRAP_UI outfiles)
  FOREACH(it ${ARGN})
    GET_FILENAME_COMPONENT(outfile ${it} NAME_WE)
    GET_FILENAME_COMPONENT(infile ${it} ABSOLUTE)
    SET(outfile ${CMAKE_CURRENT_SOURCE_DIR}/ui_${outfile}.py)
    ADD_CUSTOM_TARGET(${it} ALL
      DEPENDS ${outfile}
    )
    ADD_CUSTOM_COMMAND(OUTPUT ${outfile}
      COMMAND ${PYUIC4BINARY} ${infile} -o ${outfile}
      MAIN_DEPENDENCY ${infile}
    )
    SET(${outfiles} ${${outfiles}} ${outfile})
  ENDFOREACH(it)
ENDMACRO (PYSIDE_WRAP_UI)

MACRO(PYSIDE_WRAP_RC outfiles)
  FOREACH(it ${ARGN})
    GET_FILENAME_COMPONENT(outfile ${it} NAME_WE)
    GET_FILENAME_COMPONENT(infile ${it} ABSOLUTE)
    SET(outfile ${CMAKE_CURRENT_SOURCE_DIR}/${outfile}_rc.py)
    message("target: ${it}")
    # remove slashes from the filename because target names can't have slashes in them
	string(REPLACE "/" "-" target-name ${it} )
    
    ADD_CUSTOM_TARGET(${target-name} ALL
      DEPENDS ${outfile}
    )
    ADD_CUSTOM_COMMAND(OUTPUT ${outfile}
      COMMAND ${PYRCC4BINARY} ${infile} -o ${outfile}
      MAIN_DEPENDENCY ${infile}
    )
    SET(${outfiles} ${${outfiles}} ${outfile})
  ENDFOREACH(it)
ENDMACRO (PYSIDE_WRAP_RC)

IF(EXISTS ${PYUIC4BINARY} AND EXISTS ${PYRCC4BINARY})
    set(PYSIDE_FOUND TRUE)
ENDIF(EXISTS ${PYUIC4BINARY} AND EXISTS ${PYRCC4BINARY})

if(PYSIDE_FOUND)
    if(NOT PYSIDE_FIND_QUIETLY)
        message(STATUS "Found PYSIDE: ${PYUIC4BINARY}, ${PYRCC4BINARY}")
    endif(NOT PYSIDE_FIND_QUIETLY)
endif(PYSIDE_FOUND)

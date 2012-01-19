# Copyright (C) 2007-2011 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( lyaml C )
cmake_minimum_required ( VERSION 2.6 )
include ( dist.cmake )

# Find libyaml
find_package ( LibYAML REQUIRED )
include_directories ( ${CMAKE_CURRENT_SOURCE_DIR} ${LIBYAML_INCLUDE_DIR})

# Build Lua Yaml module
# api.c
# dumper.c
# emitter.c
# loader.c
# parser.c
# reader.c
# scanner.c
# writer.c

install_lua_module ( lyaml lyaml.c b64.c )
target_link_libraries ( lyaml ${LIBYAML_LIBRARIES} )

# Install Lua Yaml
install_lua_module ( yaml yaml.lua )
install_data ( README )
#install_doc ( doc/ )
#install_test ( tests/ )

# add_lua_test ( test.lua
#   ${CMAKE_CURRENT_SOURCE_DIR}/src # workaround to add modules to package.path (improve?)
# )

# Default installation prefix
PREFIX=/usr/local

# System's libraries directory (where binary libraries are installed)
LUA_LIBDIR=$(PREFIX)/lib/lua/5.1

# System's lua directory (where Lua libraries are installed)
LUA_DIR=$(PREFIX)/share/lua/5.1

LUAINC=$(PREFIX)/include
LUALIB=$(PREFIX)/lib

OSX_CFLAGS=-undefined dynamic_lookup
CC=gcc
# -fexceptions is necessary if your Lua was built with a C++ compiler and
# uses exceptions internally; can be removed
CFLAGS= -O3 -Wall $(INC) -shared -fPIC -fexceptions
LDFLAGS=-shared -L$(LUALIB) $(OSX_CFLAGS)
INC=-I$(LUAINC)

OBJS=lyaml.o b64.o

all: lyaml.so

install:
	cp -f lyaml.so $(LUA_LIBDIR)
	cp -f yaml.lua ${LUA_DIR}

uninstall:
	rm -f $(LUA_LIBDIR)/lyaml.so
	rm -f $(LUA_DIR}/yaml.lua

lyaml.so: $(OBJS)
	$(CC) -o $@ $(LDFLAGS) $(OBJS) -lyaml

clean:
	rm -f $(OBJS) lyaml.so core core.* a.out

#!/usr/bin/env bash

MONO_PREFIX=/opt/mono

export DYLD_FALLBACK_LIBRARY_PATH=$MONO_PREFIX/lib:$DYLD_LIBRARY_FALLBACK_PATH
export LD_LIBRARY_PATH=$MONO_PREFIX/lib:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=$MONO_PREFIX/include
export ACLOCAL_PATH=$MONO_PREFIX/share/aclocal
export PKG_CONFIG_PATH=$MONO_PREFIX/lib/pkgconfig

export PATH=$MONO_PREFIX/bin:$PATH

monodevelop $*

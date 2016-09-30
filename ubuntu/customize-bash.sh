#!/usr/bin/bash

######################## COMMAND ########################

function cfind()
{
	find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.h' -o -name '*.hpp' \) -print0 | xargs -0 grep --color -n "$@" 
}


######################### CTAG ##########################

function ctags-kernel()
{
	ctags -R -f .tags --exclude=alpha --exclude=arc --exclude=avr32 --exclude=blackfin --exclude=c6x --exclude=cris --exclude=frv --exclude=hexagon --exclude=ia64 --exclude=Kconfi --exclude=m32r --exclude=m68k --exclude=metag --exclude=microblaze --exclude=mips --exclude=mn10300 --exclude=openrisc --exclude=parisc --exclude=powerpc --exclude=s390 --exclude=score --exclude=sh --exclude=sparc --exclude=tile --exclude=um --exclude=unicore32 --exclude=x86 --exclude=xtensa $@
}



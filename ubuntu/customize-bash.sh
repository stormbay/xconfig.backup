#!/usr/bin/bash


######################### ALIAS #########################

alias ll='ls -lF'
alias lla='ls -alF'
alias la='ls -A'
alias l='ls -CF'

######################## EXPORT #########################

export PATH=~/bin:$PATH
export PATH=$PATH:~/toolchain/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabi/bin
export PATH=$PATH:~/toolchain/gcc-linaro-5.3.1-2016.05-x86_64_aarch64-linux-gnu/bin
export PATH=$PATH:~/tools/linux-bug/share/redhat-crash

export T32SYS=/opt/t32
#export T32SYS=/opt/t32mini
export T32TMP=/tmp
export T32ID=T32
export PATH=$PATH:/opt/t32/bin/pc_linux64

export OPENGROK_INSTANCE_BASE=~/tools/opengrok/var

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

#################### RAMDUMP PARSER ####################

function f5start()
{
	sudo f5fpc -s -u xinsu -t https://globalvpn.ras.qualcomm.com
}

function f5stop()
{
	sudo f5fpc -o
}

function f5info()
{
	f5fpc --info
}

#################### RAMDUMP PARSER ####################

function rdp64()
{
	dumppath=$1
	chipset=$2

	VMLINUX=${dumppath}/vmlinux
	OUTPUT=${dumppath}/parser

	parser_path=/home/ranger/tools/caf-tools/linux-ramdump-parser-v2
#	parser_path=/home/ranger/tools/tools.linux-bug.git/linux-ramdump-parser-v2
	PARSER=${parser_path}/ramparse.py

	prefix=aarch64-linux-gnu-
	toolchain_path=/home/ranger/toolchain/gcc-linaro-5.3.1-2016.05-x86_64_aarch64-linux-gnu/bin
	GDB=${toolchain_path}/${prefix}gdb
	NM=${toolchain_path}/${prefix}nm
	OBJDUMP=${toolchain_path}/${prefix}objdump

	echo "python ${PARSER} -v ${VMLINUX} -o ${OUTPUT} -g ${GDB} -n ${NM} -j ${OBJDUMP} -a ${dumppath} --64-bit -x --force-hardware ${chipset}"
	python ${PARSER} -v ${VMLINUX} -o ${OUTPUT} -g ${GDB} -n ${NM} -j ${OBJDUMP} -a ${dumppath} --64-bit -x --force-hardware ${chipset}
}

function rdp32()
{
	dumppath=$1
	chipset=$2

	VMLINUX=${dumppath}/vmlinux
	OUTPUT=${dumppath}/parser

	parser_path=/home/ranger/tools/caf-tools/linux-ramdump-parser-v2
#	parser_path=/home/ranger/tools/tools.linux-bug.git/linux-ramdump-parser-v2
	PARSER=${parser_path}/ramparse.py

	prefix=arm-linux-gnueabi-
	toolchain_path=/home/ranger/toolchain/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabi/bin
	GDB=${toolchain_path}/${prefix}gdb
	NM=${toolchain_path}/${prefix}nm
	OBJDUMP=${toolchain_path}/${prefix}objdump

	echo "python ${PARSER} -v ${VMLINUX} -o ${OUTPUT} -g ${GDB} -n ${NM} -j ${OBJDUMP} -a ${dumppath} --32-bit -x --force-hardware ${chipset}"
	python ${PARSER} -v ${VMLINUX} -o ${OUTPUT} -g ${GDB} -n ${NM} -j ${OBJDUMP} -a ${dumppath} --32-bit -x --force-hardware ${chipset}
}

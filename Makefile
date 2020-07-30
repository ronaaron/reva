os=$(shell uname)
CROSS=0

ifeq ($(CROSS),1)
OSPATH=win
REVA=bin/$(OSPATH)/reva.exe
CORE=bin/$(OSPATH)/core.exe
BUILD=bin/$(OSPATH)/build.exe
OSCORE=src/windows.asm
OSNUM=0 -fwin32
LINKCMD=kernel32 src/revares.o
GCC=i686-pc-mingw32-gcc
else
ifeq ($(os),Linux)
OSPATH=lin
REVA=bin/$(OSPATH)/reva
CORE=bin/$(OSPATH)/core
BUILD=bin/$(OSPATH)/build
OSCORE=src/linux.asm
OSNUM=1 -felf
LINKCMD=dl -m32
GCC=gcc
else
OSPATH=mac
REVA=bin/$(OSPATH)/reva
CORE=bin/$(OSPATH)/core
BUILD=bin/$(OSPATH)/build
OSCORE=src/macosx.asm
OSNUM=2 -fmacho
LINKCMD=dl -Wl,-allow_stack_execute
GCC=gcc
endif
endif

$(REVA):  src/reva.f  $(BUILD) $(CORE)
	$(BUILD)

$(CORE): src/newcore.asm src/brieflz.asm  src/common.asm $(OSCORE)
	$(BUILD) core

$(BUILD): tools/build.f
	$(REVA) $<

test: $(REVA)
	$(BUILD) test

core: $(CORE)

reva: $(REVA)

bench: $(REVA)
	(cd bench; ../$(REVA) bench.f)

revagui:
	make -C fltk CROSS=$(CROSS)

# build core first:
bootstrap:
	nasm -Ox -o core.o -DOS=$(OSNUM) src/newcore.asm
	$(GCC) -s -nostartfiles -o $(CORE) core.o -l$(LINKCMD)
	-strip $(CORE)
	-upx $(CORE)

ifeq ($(os),Darwin)
	cat src/zero >> $(CORE)
endif
	
	$(CORE) src/reva.f
	$(REVA) tools/build.f

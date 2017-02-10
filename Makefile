CC = gcc
AR = ar rcv
ifeq ($(windir),)
EXE =
RM = rm -f
else
EXE = .exe
RM = del
endif

CFLAGS = -ffunction-sections -O3 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
INC = \
	-Iinclude \
	-Iinclude/futility \
	-Ilibvboot_util/cgptlib/include \
	-Ilibvboot_util/cryptolib/include \
	-Ilibvboot_util/firmware/include \
	-Ilibvboot_util/host/include

OBJS = \
	src/futility.o \
	src/cmd_dump_fmap.o \
	src/cmd_gbb_utility.o \
	src/misc.o \
	src/cmd_dump_kernel_config.o \
	src/cmd_load_fmap.o \
	src/cmd_pcr.o \
	src/cmd_show.o \
	src/cmd_sign.o \
	src/cmd_vbutil_firmware.o \
	src/cmd_vbutil_kernel.o \
	src/cmd_vbutil_key.o \
	src/cmd_vbutil_keyblock.o \
	src/file_type.o \
	src/traversal.o \
	src/vb1_helper.o \
	src/futility_cmds.o

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
    LDFLAGS += -Wl,-dead_strip
else
    LDFLAGS += -Wl,--gc-sections
endif

all:libvboot_util.a futility$(EXE)

static:libvboot_util.a futility-static$(EXE)

libvboot_util.a:
	make -C libvboot_util

futility$(EXE):$(OBJS)
	$(CROSS_COMPILE)$(CC) -o $@ $^ -L. -lvboot_util -lcrypto $(LDFLAGS) -s

futility-static$(EXE):$(OBJS)
	$(CROSS_COMPILE)$(CC) -o $@ $^ -L. -lvboot_util -lcrypto_static $(LDFLAGS) -static -s

%.o:%.c
	$(CROSS_COMPILE)$(CC) -o $@ $(CFLAGS) -c $< $(INC)

clean:
	$(RM) futility futility-static futility.exe futility-static.exe
	$(RM) $(OBJS) libvboot_util.a Makefile.~
	make -C libvboot_util clean


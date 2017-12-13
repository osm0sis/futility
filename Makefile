ifeq ($(CC),cc)
CC = gcc
endif
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

ifneq (,$(findstring android,$(CROSS_COMPILE)))
    LDFLAGS += -lcrypto_static
else
    LDFLAGS += -lcrypto -ldl
endif
ifneq (,$(findstring darwin,$(CROSS_COMPILE)))
    UNAME_S := Darwin
else
    UNAME_S := $(shell uname -s)
endif
ifeq ($(UNAME_S),Darwin)
    CFLAGS += -DHAVE_MACOS
    LDFLAGS += -Wl,-dead_strip
else
    LDFLAGS += -Wl,--gc-sections -s
endif


all:libvboot_util.a futility$(EXE)

static:
	make LDFLAGS="$(LDFLAGS) -static"

libvboot_util.a:
	make -C libvboot_util

futility$(EXE):$(OBJS)
	$(CROSS_COMPILE)$(CC) -o $@ $^ -L. -lvboot_util $(LDFLAGS)

%.o:%.c
	$(CROSS_COMPILE)$(CC) -o $@ $(CFLAGS) -c $< $(INC)

clean:
	$(RM) futility
	$(RM) $(OBJS) *.a *.~ *.exe
	make -C libvboot_util clean


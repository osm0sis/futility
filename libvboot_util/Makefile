ifeq ($(CC),cc)
CC = gcc
endif
AR = ar rc
ifeq ($(windir),)
RM = rm -f
CP = cp
else
RM = del
CP = copy /y
endif

CFLAGS = -ffunction-sections -O3 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
EXT = a
INC = \
	-I../include \
	-I../include/futility \
	-Icgptlib/include \
	-Icryptolib/include \
	-Ifirmware/include \
	-Ihost/include \
	-Istub/include

LIB = libvboot_util.$(EXT)
LIB_OBJS = \
	firmware/crc8.o \
	firmware/utility.o \
	firmware/vboot_api_init.o \
	firmware/vboot_common_init.o \
	firmware/vboot_nvstorage.o \
	firmware/vboot_nvstorage_rollback.o \
	firmware/region-init.o \
	stub/tpm_lite_stub.o \
	stub/utility_stub.o \
	stub/vboot_api_stub_init.o \
	stub/vboot_api_stub_region.o \
	cryptolib/padding.o \
	cryptolib/rsa.o \
	cryptolib/rsa_utility.o \
	cryptolib/sha1.o \
	cryptolib/sha256.o \
	cryptolib/sha512.o \
	cryptolib/sha_utility.o \
	firmware/stateful_util.o \
	firmware/vboot_api_firmware.o \
	firmware/vboot_common.o \
	firmware/vboot_firmware.o \
	firmware/region-fw.o \
	stub/vboot_api_stub_sf.o \
	cgptlib/cgptlib.o \
	cgptlib/cgptlib_internal.o \
	cgptlib/crc32.o \
	firmware/gpt_misc.o \
	firmware/utility_string.o \
	firmware/vboot_api_kernel.o \
	firmware/vboot_audio.o \
	firmware/vboot_display.o \
	firmware/vboot_kernel.o \
	firmware/region-kernel.o \
	stub/vboot_api_stub.o \
	stub/vboot_api_stub_disk.o \
	stub/vboot_api_stub_stream.o \
	cgpt/cgpt_create.o \
	cgpt/cgpt_add.o \
	cgpt/cgpt_boot.o \
	cgpt/cgpt_show.o \
	cgpt/cgpt_repair.o \
	cgpt/cgpt_prioritize.o \
	cgpt/cgpt_common.o \
	futility/dump_kernel_config_lib.o \
	host/crossystem.o \
	host/file_keys.o \
	host/fmap.o \
	host/host_common.o \
	host/host_key.o \
	host/host_keyblock.o \
	host/host_misc.o \
	host/util_misc.o \
	host/host_signature.o \
	host/signature_digest.o

ifneq (,$(findstring darwin,$(CROSS_COMPILE)))
    UNAME_S := Darwin
else
    UNAME_S := $(shell uname -s)
endif
ifeq ($(UNAME_S),Darwin)
    CFLAGS += -DHAVE_MACOS
endif

all:$(LIB)

clean:
	$(RM) $(LIB_OBJS) $(LIB)

$(LIB):$(LIB_OBJS)
	$(CROSS_COMPILE)$(AR) $@ $^
	$(CP) $@ ..

%.o:%.c
	$(CROSS_COMPILE)$(CC) -o $@ $(CFLAGS) -c $< $(INC)


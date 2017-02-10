const char futility_version[] = "v0.0.1370-4b06fde";
#define _CMD(NAME) extern const struct futil_cmd_t __cmd_##NAME;
_CMD(dump_fmap)
_CMD(dump_kernel_config)
_CMD(gbb_utility)
_CMD(load_fmap)
_CMD(pcr)
_CMD(show)
_CMD(verify)
_CMD(sign)
_CMD(vbutil_firmware)
_CMD(vbutil_kernel)
_CMD(vbutil_key)
_CMD(vbutil_keyblock)
_CMD(help)
_CMD(version)
#undef _CMD
#define _CMD(NAME) &__cmd_##NAME,
const struct futil_cmd_t *const futil_cmds[] = {
_CMD(dump_fmap)
_CMD(dump_kernel_config)
_CMD(gbb_utility)
_CMD(load_fmap)
_CMD(pcr)
_CMD(show)
_CMD(verify)
_CMD(sign)
_CMD(vbutil_firmware)
_CMD(vbutil_kernel)
_CMD(vbutil_key)
_CMD(vbutil_keyblock)
_CMD(help)
_CMD(version)
0};  /* null-terminated */
#undef _CMD

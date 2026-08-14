### AnyKernel3 Ramdisk Mod Script
## Build by TomHjy

### AnyKernel setup
properties() { '
kernel.string=AnyKernel3 by KernelSU Developers | Build by TomHjy
do.devicecheck=0
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0

# OPPO / OnePlus / realme SM8750 Universal
device.name1=
device.name2=
device.name3=
device.name4=
device.name5=

supported.versions=
supported.patchlevels=
supported.vendorpatchlevels=
'; }

### AnyKernel install

BLOCK=boot
IS_SLOT_DEVICE=auto
RAMDISK_COMPRESSION=auto
PATCH_VBMETA_FLAG=auto
NO_MAGISK_CHECK=1

# import functions/variables and setup patching
. tools/ak3-core.sh


# ============================================================
# Kernel Information
# ============================================================

ui_print " "
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ui_print "          TomHjy Kernel"
ui_print "    OPPO / OnePlus / realme"
ui_print "          Qualcomm SM8750"
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ui_print " "

ui_print "内核构建者: Coolapk@TomHjy"


# ============================================================
# SM8750 SoC Detection
# ============================================================

SOC_CHECK="$AKHOME/tools/soc_check.sh"

if [ ! -f "$SOC_CHECK" ]; then
    ui_print " "
    ui_print "✗ SoC 检测脚本不存在"
    ui_print " "
    ui_print "缺少：tools/soc_check.sh"
    ui_print "为避免设备无法启动，安装已终止。"
    ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    abort "缺少 soc_check.sh"
fi

chmod 755 "$SOC_CHECK"

ui_print " "
ui_print "正在检测设备 SoC..."

if ! "$SOC_CHECK"; then
    abort "设备验证失败：不支持当前 SoC 或机型"
fi

ui_print "✓ SoC / 设备验证通过"
ui_print " "


# ============================================================
# File System Preparation
# ============================================================

sync
sleep 0.5

chmod -R 755 "$AKHOME/tools"


# ============================================================
# Boot Installation
# ============================================================

ui_print "正在处理 Boot 镜像..."
ui_print " "

split_boot

if [ -f "split_img/ramdisk.cpio" ]; then

    ui_print "检测到 Ramdisk"
    ui_print "正在解包 Ramdisk..."

    unpack_ramdisk

    ui_print "正在写入 Boot 镜像..."

    write_boot

else

    ui_print "未检测到 Ramdisk"
    ui_print "正在直接处理 Boot 镜像..."

    flash_boot

fi

ui_print " "
ui_print "✓ Kernel 安装完成"


# ============================================================
# ZRAM Module Installation
# ============================================================

if [ -f "$AKHOME/zram.zip" ]; then

    MODULE_PATH="$AKHOME/zram.zip"
    KSUD_PATH="/data/adb/ksud"

    if [ -x "$KSUD_PATH" ]; then

        ui_print " "
        ui_print "正在安装 ZRAM 模块..."

        if "$KSUD_PATH" module install "$MODULE_PATH"; then
            ui_print "✓ ZRAM 模块安装成功"
        else
            ui_print "✗ ZRAM 模块安装失败"
        fi

    else

        ui_print "⚠ 未找到 KSUD"
        ui_print "⚠ 跳过 ZRAM 模块安装"

    fi

else

    ui_print "ℹ 未找到 zram.zip"
    ui_print "ℹ 跳过 ZRAM 模块安装"

fi


# ============================================================
# KP-N Module Installation
# ============================================================

if [ -f "$AKHOME/kpn.zip" ]; then

    MODULE_PATH="$AKHOME/kpn.zip"
    KSUD_PATH="/data/adb/ksud"

    if [ -x "$KSUD_PATH" ]; then

        ui_print " "
        ui_print "正在安装 KP-N 模块..."

        if "$KSUD_PATH" module install "$MODULE_PATH"; then
            ui_print "✓ KP-N 模块安装成功"
        else
            ui_print "✗ KP-N 模块安装失败"
        fi

    else

        ui_print "⚠ 未找到 KSUD"
        ui_print "⚠ 跳过 KP-N 模块安装"

    fi

else

    ui_print "ℹ 未找到 kpn.zip"
    ui_print "ℹ 跳过 KP-N 模块安装"

fi


# ============================================================
# Installation Complete
# ============================================================

ui_print " "
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ui_print "             安装完成"
ui_print " "
ui_print "Kernel : 已安装"
ui_print "SoC    : SM8750"
ui_print "Target : OPPO / OnePlus / realme"
ui_print " "
ui_print "请重启设备使内核生效。"
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ui_print " "

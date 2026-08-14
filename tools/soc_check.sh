#!/system/bin/sh

# ============================================================
# SoC Verification
# Only allow Qualcomm SM8750 or MediaTek MT6991.
# This check is performed before any Boot operation.
# ============================================================

SOC_MODEL="$(getprop ro.soc.model)"
BOARD_PLATFORM="$(getprop ro.board.platform)"

ui_print " "
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ui_print "          Device SoC Verification"
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ui_print " "
ui_print "SoC     : ${SOC_MODEL:-unknown}"
ui_print "Platform: ${BOARD_PLATFORM:-unknown}"
ui_print " "

# ro.soc.model is the primary SoC identifier.
# ro.board.platform is used only as a fallback when ro.soc.model is unavailable.
if [ -n "$SOC_MODEL" ]; then
    DETECTED_SOC="$SOC_MODEL"
else
    DETECTED_SOC="$BOARD_PLATFORM"
fi

case "$DETECTED_SOC" in
    SM8750)
        ui_print "✓ Qualcomm SM8750 SoC 验证通过"
        exit 0
        ;;

    MT6991)
        ui_print "✓ MediaTek MT6991 SoC 验证通过"
        exit 0
        ;;

    *)
        ui_print "✗ SoC 验证失败"
        ui_print " "
        ui_print "检测到: ${DETECTED_SOC:-unknown}"
        ui_print " "
        ui_print "仅支持: SM8750 / MT6991"
        ui_print "为避免设备无法启动，安装已终止。"
        ui_print " "
        exit 1
        ;;
esac

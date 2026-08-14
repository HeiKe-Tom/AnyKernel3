#!/system/bin/sh

SOC_MODEL="$(getprop ro.soc.model)"
BOARD_PLATFORM="$(getprop ro.board.platform)"

ui_print " "
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ui_print "          Device SoC Verification"
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ui_print " "
ui_print "SoC     : $SOC_MODEL"
ui_print "Platform: $BOARD_PLATFORM"
ui_print " "

case "$SOC_MODEL:$BOARD_PLATFORM" in

    SM8750:*|*:SM8750)
        ui_print "✓ Qualcomm SM8750 SoC 验证通过"
        exit 0
        ;;

    MT6991:*|*:MT6991)
        ui_print "✓ MediaTek MT6991 SoC 验证通过"
        exit 0
        ;;

    *)
        ui_print "✗ 不支持的 SoC"
        ui_print " "
        ui_print "当前 SoC     : $SOC_MODEL"
        ui_print "当前 Platform : $BOARD_PLATFORM"
        ui_print " "
        ui_print "仅支持: SM8750 MT6991"
        exit 1
        ;;

esac

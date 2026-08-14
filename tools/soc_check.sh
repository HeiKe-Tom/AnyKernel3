#!/system/bin/sh

SOC_MODEL="$(getprop ro.soc.model)"
BOARD_PLATFORM="$(getprop ro.board.platform)"
DEVICE="$(getprop ro.product.device)"

ui_print " "
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ui_print "          Device Soc Verification"
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ui_print " "
ui_print "Device : $DEVICE"
ui_print "SoC    : $SOC_MODEL"
ui_print "Platform: $BOARD_PLATFORM"
ui_print " "

# ============================================================
# SoC Verification
# ============================================================

SOC=""

case "$SOC_MODEL:$BOARD_PLATFORM" in

    SM8750:*|*:SM8750)
        SOC="SM8750"
        ;;

    MT6991:*|*:MT6991)
        SOC="MT6991"
        ;;

    *)
        ui_print "✗ 不支持的 SoC"
        ui_print " "
        ui_print "当前 SoC: $SOC_MODEL"
        ui_print "当前平台: $BOARD_PLATFORM"
        ui_print " "
        ui_print "支持:"
        ui_print "  Qualcomm SM8750"
        ui_print "  MediaTek MT6991"
        ui_print " "
        exit 1
        ;;
esac

ui_print "✓ SoC 验证通过: $SOC"
ui_print " "

# ============================================================
# Device Verification
# ============================================================

case "$SOC" in

    SM8750)

        case "$DEVICE" in
            PKR110|OP60EBL1)
                ui_print "✓ 设备验证通过: $DEVICE"
                ;;

            *)
                ui_print "非 SM8750 设备不受支持"
                ui_print "当前设备: $DEVICE"
                exit 1
                ;;
        esac

        ;;

    MT6991)

        case "$DEVICE" in
            这里填写MT6991支持的机型)
                ui_print "✓ 设备验证通过: $DEVICE"
                ;;

            *)
                ui_print "非 MT6991 设备不受支持"
                ui_print "当前设备: $DEVICE"
                exit 1
                ;;
        esac

        ;;

esac

ui_print " "
ui_print "✓ 所有设备验证通过"
ui_print " "

exit 0

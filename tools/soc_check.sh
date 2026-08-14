#!/system/bin/sh

# ============================================================
# SM8750 Only SoC Checker
# OPPO / OnePlus / realme SM8750 Universal Kernel
# Build by TomHjy
#
# 仅检测：
#     Qualcomm SM8750
#
# 其他 SoC：
#     一律拒绝
# ============================================================

SOC_MODEL="$(getprop ro.soc.model 2>/dev/null)"

ui_print " "
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ui_print "          SM8750 SoC 检测"
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

ui_print "检测到的 SoC：${SOC_MODEL:-Unknown}"

# 严格匹配 SM8750
case "$SOC_MODEL" in
    SM8750)
        ui_print " "
        ui_print "✓ Qualcomm MTK SM8750"
        ui_print "✓ SoC 检测通过"
        ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        ui_print " "
        exit 0
        ;;
esac

ui_print " "
ui_print "✗ SoC 检测失败"
ui_print "✗ 当前设备不是 Qualcomm MTK SM8750"
ui_print " "
ui_print "当前 SoC：${SOC_MODEL:-Unknown}"
ui_print " "
ui_print "此内核仅支持 Qualcomm SM8750。"
ui_print "为避免设备无法启动，安装已终止。"
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

exit 1

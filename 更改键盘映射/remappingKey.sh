

# ⚠ 更改键盘映射的脚本 ⚠

# https://developer.apple.com/library/content/technotes/tn2450/_index.html
# https://opensource.apple.com/source/IOHIDFamily/IOHIDFamily-1035.41.2/IOHIDFamily/IOHIDUsageTables.h.auto.html
# https://opensource.apple.com/source/IOHIDFamily/IOHIDFamily-1035.41.2/IOHIDFamily/AppleHIDUsageTables.h.auto.html

# 直接使用终端运行
# hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000052,"HIDKeyboardModifierMappingDst":0x700000058},{"HIDKeyboardModifierMappingSrc":0x700000058,"HIDKeyboardModifierMappingDst":0x700000052}]}'

# 检查映射状态
# hidutil property --get "UserKeyMapping"

# launchctl load 启动plist运行
# launchctl list 查看
# launchctl start 开始plist任务
# <!-- launchctl load /Users/admin/Library/LaunchAgents/yuans.remap_keys.plist -->

FROM="\"HIDKeyboardModifierMappingSrc\""
TO="\"HIDKeyboardModifierMappingDst\""


UpArrow="0x700000052" 
Keypad_Enter="0x700000058"

Keypad_4="0x70000005C" #4
Keypad_5="0x70000005D" #5
Keypad_6="0x70000005E" #6
Keypad_clear="0x700000053" #clear
Keypad_eq="0x700000067"    # =
Keypad_slash="0x700000054" # /符号

hidutil property --matching '{"ProductID":0x220, "VendorID":0x5ac}' --set "{\"UserKeyMapping\":[
{$FROM: $Keypad_Enter,$TO: $UpArrow},
{$FROM: $Keypad_clear,$TO: $Keypad_4},
{$FROM: $Keypad_eq,$TO: $Keypad_5},
{$FROM: $Keypad_slash,$TO: $Keypad_6}
]}"

echo 更改键盘映射完成！

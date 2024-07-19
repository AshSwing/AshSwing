#!/usr/bin/env bash

# MacOS 一键配置
# 参考资料: https://mths.be/macos

# 1. 关闭系统设置防止配置冲突
osascript -e 'tell application "System Preferences" to quit'

# 2. 预请求管理员权限并保活
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

COMPUTER_UUID=`ioreg -rd1 -c IOPlatformExpertDevice | grep -E '(UUID)' | awk '{print $3}' | tr -d \"`
KEYBOARD_UUID=`defaults -currentHost read .GlobalPreferences | grep '"com.apple.keyboard.modifiermapping' | sed -n 's/.*"\([^"]*\)".*/\1/p'`

# 3. 系统基础配置
echo "MacOS UUID: $COMPUTER_UUID"
echo "➜ Enter custom name: "
read name
sudo scutil --set ComputerName $name
sudo scutil --set HostName "local"
sudo scutil --set LocalHostName $name
echo "✔︎ Computer Name: $(scutil --get ComputerName)"
echo "✔︎ Host Name: $(scutil --get HostName)"
echo "✔︎ Localhost Name: $(scutil --get LocalHostName)"

## 立刻需要密码
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# 4. 外观配置
defaults write com.apple.dock autohide -bool true # Dock 自动隐藏
defaults write com.apple.dock show-recents -bool false # 不显示最近的文件
defaults write com.apple.dock orientation left # 停靠左侧
defaults write com.apple.dock tilesize -int 50 # 停靠图标大小

killall "Dock" &> /dev/null

if [ $(defaults read com.apple.dock autohide) -eq 1 ]; then
    echo "✔︎ Dock Autohide"
else
    echo "✘ Dock Autohide"
fi

if [ $(defaults read com.apple.dock show-recents) -eq 1 ]; then
    echo "✔︎ Dock Show Recent"
else
    echo "✘ Dock Show Recent"
fi

echo "✔︎ Docker Apperence: $(defaults read com.apple.dock orientation)($(defaults read com.apple.dock tilesize))"

# 5. 操控增强
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false # 禁用自动大写
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false # 禁用智能破折号
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false # 禁用智能引号
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false # 禁用智能拼写矫正

## 轻点触控
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

## 三指拖移
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

## 修饰键调整
# defaults -currentHost read .GlobalPreferences $KEYBOARD_UUID
# https://developer.apple.com/library/archive/technotes/tn2450/_index.html#//apple_ref/doc/uid/DTS40017618-CH1-TNTAG4
# https://apple.stackexchange.com/questions/13598/updating-modifier-key-mappings-through-defaults-command-tool
# 30064771129 - Casp
# 30064771300 - Control
# 
killall "SystemUIServer" &> /dev/null




# for app in "Dock" "Finder" "SystemUIServer"; do
# 	killall "${app}" &> /dev/null
# done
# echo "配置完成, 部分配置需要重启生效"


# ZMK board definition for [DYA Dash](https://github.com/cormoran/dya-dash-keyboard) keyboard

DYA Dash のキーボード定義レポジトリです。
`このテンプレートを使用する` (`Use this template`) からレポジトリをクローンすることで、キーマップやパラメータのチューニングができます。
クローンしたレポジトリは [keymap-editor](https://nickcoutsos.github.io/keymap-editor/) での編集にも対応しています。

This repository contains ZMK board definition for [DYA Dash](https://github.com/cormoran/dya-dash-keyboard) keyboard.
You can configure keymap and tune parameters by forking this repository.
This repository supports [keymap-editor](https://nickcoutsos.github.io/keymap-editor/) to edit keymap from web UI.

## Getting started

1. Clone this repository by "Use this template" button in github.
2. Edit files under `config` directory as you like. Please check [ZMK official document](https://zmk.dev/docs/customization)
   - keymap is defined in `dya_dash.keymap`
   - You can define configuration in `dya_dash.conf`, `dya_dash_left.conf` or `dya_dash.conf` to tune parameters.
3. Build firmware on github actions or in your local PC as described in below.

## Build on github actions

It's configured by default thanks to ZMK's template. Just pushing commit to github starts github actions.
The firmware will be available in "Actions" tab's latest build artifacts as `firmware.zip`.

## Local development in this repository

Install `west` command ([official document](https://docs.zephyrproject.org/latest/develop/west/install.html)) and GNU make. Execute below command.

```
# 1. Initialize west workspace
## Option1: download under ../
west init -l . --mf config/west.yml
## Option2: download under ./dependencies
west init -l config --mf west-standalone.yml

# 2. Download dependencies
west update --narrow
west zephyr-export

# 3. Build
west zmk-build -q
## Build with debug
west zmk-build -S zmk-usb-logging
```

If build succeeds, the firmware shows up under `../build/<artifact>/zephyr/zmk.uf2`.

## Trackball enable/disable with snippet

Trackball setting is enabled by specifying snippet `left-trackball` or `right-trackball`. (see `local_build.sh`.).
If neither snippet is specified, trackball feature is disabled.

## Default keymap

![](keymap-drawer/dya_dash.svg)

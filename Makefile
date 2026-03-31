# Download dependencies under ./dependencies
init-standalone:
	west init -l config --mf west-standalone.yml
	west update --narrow
	west zephyr-export

# Download dependencies under ../
init-workspace:
	west init -l . --mf config/west.yml
	west update --narrow
	west zephyr-export

build-all: build-v2 build-v3

build-v2:
	west zmk-build -d ./build -q -as v2

build-v3:
	west zmk-build -d ./build -q -as v3

debug-all:
	west zmk-build -S zmk-usb-logging

draw-keymap-v2:
	mkdir -p keymap-drawer
	keymap -c keymap_drawer.config.yaml parse -z config/dya_dash.keymap -o keymap-drawer/dya_dash.yaml
	keymap -c keymap_drawer.config.yaml draw keymap-drawer/dya_dash.yaml -j config/dya_dash.json -o keymap-drawer/dya_dash.svg


draw-keymap-v3:
	mkdir -p keymap-drawer
	keymap -c keymap_drawer.config.yaml parse -z config/dya_dash_v3.keymap -o keymap-drawer/dya_dash_v3.yaml
	keymap -c keymap_drawer.config.yaml draw keymap-drawer/dya_dash_v3.yaml -j config/dya_dash_v3.json -o keymap-drawer/dya_dash_v3.svg

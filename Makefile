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

build-all:
	west zmk-build -d ./build -q

debug-all:
	west zmk-build -S zmk-usb-logging

draw-keymap:
	mkdir -p keymap-drawer
	keymap -c keymap_drawer.config.yaml parse -z config/dya_dash.keymap -o keymap-drawer/dya_dash.yaml
	keymap -c keymap_drawer.config.yaml draw keymap-drawer/dya_dash.yaml -j config/dya_dash.json -o keymap-drawer/dya_dash.svg



draw-keymap:
	mkdir -p keymap-drawer
	keymap -c keymap_drawer.config.yaml parse -z config/dya_dash.keymap -o keymap-drawer/dya_dash.yaml
	keymap -c keymap_drawer.config.yaml draw keymap-drawer/dya_dash.yaml -j config/dya_dash.json -o keymap-drawer/dya_dash.svg

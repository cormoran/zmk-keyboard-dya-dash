.PHONY: init build-all clean build debug


build-all: build-all-v2 build-all-v3

build-all-v2:
	bash local_build.sh v2 left
	bash local_build.sh v2 right
	bash local_build.sh v2 left-ball
	bash local_build.sh v2 right-ball
	bash local_build.sh v2 left -r
	bash local_build.sh v2 right -r

build-all-v3:
	bash local_build.sh v3 left-ball
	bash local_build.sh v3 right-ball
	bash local_build.sh v3 left-switch
	bash local_build.sh v3 right-switch
	bash local_build.sh v3 left-encoder
	bash local_build.sh v3 right-encoder
	bash local_build.sh v3 left -r
	bash local_build.sh v3 right -r

init:
	west init -l config
	west update --narrow

clean:
	rm -rf .west build external

clean-build:
	rm -rf build

draw-keymap:
	mkdir -p keymap-drawer
	keymap -c keymap_drawer.config.yaml parse -z config/dya_dash.keymap -o keymap-drawer/dya_dash.yaml
	keymap -c keymap_drawer.config.yaml draw keymap-drawer/dya_dash.yaml -j config/dya_dash.json -o keymap-drawer/dya_dash.svg

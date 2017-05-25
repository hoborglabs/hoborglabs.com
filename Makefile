
DS_ENV ?= prod
GEM_HOME ?= .gem

PATH := $(PWD)/.gem/bin:$(shell printenv PATH)
SHELL := env PATH=$(PATH) /bin/bash

export DS_ENV
export DS_HOSTDIR
export GEM_HOME
export PATH

.PHONY : public

build: public build_html build_css

build_html: displayService.phar
	php displayService.phar ds:generate \
	--source='/' \
	--output='public'

build_css: .gem
	mkdir -p "public/static/styles/css"
	sass \
		--style compressed \
		"styles/sass/main.scss" \
		"public/static/styles/css/main.css"
	find styles/gfx \
		-name "*.png" \
		-or -name "*.gif" \
		-or -name "*.jpg" \
	| xargs -I% cp % out/%

public:
	find styles/gfx \
		-name "*.png" \
		-or -name "*.gif" \
		-or -name "*.jpg" \
	| xargs -I% bash -c 'mkdir -p "public/static/`dirname $$1`"' -- "%"
	cd site && find . \
		-name "*.page" \
	| xargs -I% bash -c 'mkdir -p "../public/`dirname $$1`"' -- "%"

serve:
	php -S localhost:4000 -t public "public/.router.php"

displayService.phar:
	curl -O http://get.hoborglabs.com/displayService.phar

.gem:
	gem install sass

clean:
	rm -rf .gem
	rm displayService.phar

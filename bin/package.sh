#!/usr/bin/env bash

set -xeuo pipefail
IFS=$'\n\t'

function clean() {
	rm -rf dist
	mkdir ./dist
}

function compile_plugin() {
	DHQ_ANALYTICS_SCRIPT="https://www.floorlytics.broadlu.me/ff8/scitylana.min.js"
	export DHQ_ANALYTICS_SCRIPT

	/usr/local/Cellar/gettext/0.20.1/bin/envsubst '$DHQ_ANALYTICS_SCRIPT' < ./dealerhq-wordpress-plugin.php.tmpl > ./dist/dealerhq-wordpress-plugin.php
}

function validate() {
	php -l ./dist/dealerhq-wordpress-plugin.php
}

function package() {
	cd dist
	zip -r dealerhq-wordpress-plugin.zip dealerhq-wordpress-plugin.php
	cd ..
}

clean
compile_plugin
validate
package

echo 'Success!'

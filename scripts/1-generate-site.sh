#!/bin/bash

TMP_DIR=${1:-/tmp/blog-build-tmp}
DEST_DIR=${2:-./docs}

mkdir -p "$TMP_DIR"
mkdir -p "$DEST_DIR"

echo "$(date)"
echo "Building site into $DEST_DIR"
echo "Using tmp directory: $TMP_DIR"

# Prepare to generate two sites and merge them together
if [ ! -x `which rsync` ];
then
	sudo apt-get update
	sudo apt-get install -qq -y rsync
fi

rm -rf $TMP_DIR/_site_{1,2,3} $TMP_DIR/_site

# Build old structure site into site_1
bundle exec jekyll build --config _config.yml,_config_domains.yml --destination $TMP_DIR/_site_1

# Build new structure site
bundle exec jekyll build --config _config.yml,_config_ymd.yml,_config_domains.yml --destination $TMP_DIR/_site_2

# Build new structure site with index.html files for each post
# This is to ensure that a post can be found both at =domain/y/m/d/post/= and =domain/y/m/d/post=
# Note the missing forward slash in the second part
bundle exec jekyll build --config _config.yml,_config_ymd_slash.yml,_config_domains.yml --destination $TMP_DIR/_site_3

rsync -r $TMP_DIR/_site_{1,2,3}/ $DEST_DIR

rm -rf $TMP_DIR/_site_{1,2,3}

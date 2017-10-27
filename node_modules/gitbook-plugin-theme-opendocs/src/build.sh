#! /bin/bash

# Cleanup folder
rm -rf _assets

# Recreate folder
mkdir -p _assets/website/

# Compile Website CSS
lessc -clean-css --include-path=$(node -e "console.log(require('gitbook-styleguide').less.paths.join(':'))") src/less/website.less _assets/website/style.css

cp -r node_modules/gitbook-styleguide/static/* _assets/website/
cp -r assets/* _assets/

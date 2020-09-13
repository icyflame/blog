set -xe

post_stub="$1"

if [[ -z "$post_stub" ]]; then
    echo "ERROR: Must provide at least one argument"
    echo "Example: ./new-post.sh blog-post-spring"
    exit 42;
fi

file_name="`date +%F`-$post_stub.md"

file_path="_posts/$file_name"

touch "$file_path";

cat <<EOF > "$file_path"
---
layout: post
comments: true
title:
categories:
---

<!--more-->
EOF

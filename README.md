# Blog

A blog-aware site, using Jekyll, hosted on GitHub Pages.

## Development

```sh
$ rbenv local 2.5.0
$ gem install jekyll
$ make serve-dev
```

## Scripts

### Publish an org file inside the `posts-org` directory

``` sh
make publish-single FILENAME=posts-org/post.org
```

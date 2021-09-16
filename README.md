# Blog

> A blog-aware site, using Jekyll, hosted on GitHub Pages.

## Deployment

This is a blog-aware site that is built using the static site generator Jekyll.

The initial configuration of this site put the list of tags in the link of each blog post. The link
structure was `/tag1/tag2/.../tagN/YYYY/MM/DD/post-stub/`. These links are long. More importantly,
they prevent recategorization of posts as that would break the link of the posts. So, I switched to
the concise link structure `/YYYY/MM/DD/post-stub/`.

However, the blog had already been online for several years when I made this switch. So, I wanted to
support both the initial link structure and the new link structure for **all** posts. To do this, I
wrote a simple GitHub Actions workflow which generated the website using both link structures and
merged the two folders together using `rsync`.

### Current configuration

- Branch with the posts: `master`
- Branch with built site: `published`
- Path of the site inside the `published` branch: `docs/`

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

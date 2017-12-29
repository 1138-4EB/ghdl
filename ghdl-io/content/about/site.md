---
title: About this site
---

##  Lightweight markup language

This static site is rendered from [Markdown](https://en.wikipedia.org/wiki/Markdown) and [reStructuredText](https://en.wikipedia.org/wiki/ReStructuredText) sources in a continuously integrated workflow. Almost every page includes a link to the corresponding sources, to allow for fast contributions (fixes and/or enhancements). Moreover, all of them are included in [git](https://git-scm.com/) repositories hosted on [GitHub](https://github.com/):

- Main sources (about, contribute, guides, tutorials, performance, etc.): [ghdl/ghdl/tree/master/ghdl-io/content](https://github.com/1138-4EB/ghdl/tree/builders/ghdl-io/content)
- [WIP] User Guide (all execution options, command reference, implementation details, precompilation of vendor primitives, etc.): [ghdl/ghdl/tree/master/doc](https://github.com/1138-4EB/ghdl/tree/builders/doc)
- [WIP] Licenses and changelog: [ghdl/ghdl/tree/master](https://github.com/1138-4EB/ghdl/tree/builders)
- [WIP] Wiki: [ghdl/ghdl/wiki](https://github.com/ghdl/ghdl/wiki)

## Dependencies

- Backend:
  - [gohugo.io](https://gohugo.io/)
     - git
     - py3-docutils
         - rst2html
- Frontend:
 - [tachyons.io](http://tachyons.io/)
  - jQueryUI
     - jQuery

A minified version of each of the frontend dependencies is already included in the repo (see [static](https://github.com/1138-4EB/ghdl/tree/builders/ghdl-io/themes/ghdl-io-theme/static)). However, if you want to get them from CDNs, you can modify [partials/head.html](https://github.com/1138-4EB/ghdl/blob/builders/ghdl-io/themes/ghdl-io-theme/layouts/partials/head.html) and [partials/js.html](https://github.com/1138-4EB/ghdl/blob/builders/ghdl-io/themes/ghdl-io-theme/layouts/partials/js.html).

## Local

If you installed all the backend dependencies and cloned the repos with the sources, a local server with livereload can be started:

```
hugo server -DEF --disableFastRender
```

Browse `localhost:1313` (check the specific URL in stdout). Now you can edit any of the sources and the site will be automatically updated. Pretty easy!

### Docker image

A ready-to-use docker image ([ghdl/ext:hugo](https://hub.docker.com/r/ghdl/ext/tags/)) is available. I.e., all the dependencies are already installed and properly configured. You can run a local server as above:

```
$(command -v winpty) docker run --rm -it \
  -v /$(pwd):/src \
  -w //src/ghdl-io \
  -p 127.0.0.1:1313:1313 \
  ghdl/ext:hugo server -DEF --disableFastRender --bind 0.0.0.0
```

NOTE: `winpty` is only required in some shells on Windows (such as MinGW), in order to kill the server (and the container) when we are done. Alternatively, `--rm -it` can be replaced with `-d`. See [Docker Primer](guides/docker).

WARNING: on some contexts, docker containers can not properly get file modification signals from the host, which will prevent the livereload feature from working. The server will work, thus, the user must restart the container to see changes in the served site.

This is the same image that is used to build this site you are browsing. It is done in one of the stages executed in [Travis CI ](https://travis-ci.org/ghdl/ghdl) after each push to the main repository. See [ghdl/ghdl/blob/builders/dist/linux/gh-pages.sh](https://github.com/1138-4EB/ghdl/blob/builders/dist/linux/gh-pages.sh).

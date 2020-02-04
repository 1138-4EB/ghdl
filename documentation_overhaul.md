From ghdl/ghdl#477. See ghdl/ghdl#506.

# Documentation overhaul

Related to ghdl/ghdl#280 and ghdl/ghdl#296, I am concerned about how much docker-related info I shall put into the docs. At first, it was just how to build GHDL locally using a container. That is tightly coupled with travis-ci now. Therefore, I believe that the first comment in ghdl/ghdl#489 should be added to a 'Continuous Integration' section, which should be referenced from 'Getting GHDL > Docker containers'. Moreover, 'getting docker containers' is not the best description, because it is 'getting base/build docker containers'. There should be a different section in 'GHDL Usage' named 'Running GHDL in docker containers', which would include `shell only`, `shell + X-based GUI`, and `shell + web-based GUI`.

At this point, I feel that docker is going to take almost as much space in the documentation as GHDL itself. It makes sense from my point of view, but I think that it is not fair for users who want to use GHDL standalone. Therefore, I want to make the following proposal (ping @tgingold @Paebbels):

- Create two separate spaces:
  - RTD:
    - Building GHDL
      - Locally
      - Inside a docker container
      - Continuous Integration
    - Precompile Vendor Primitives
    - Invoking GHDL
    - Simulation and runtime
    - Implementation References
    - Copyright | Licenses
  - GitHub Pages:
    - 'Fancy' theme
      - Landing page
      - About
      - Contributing
      - Getting GHDL (link below)
      - Guides/tutorials (list with links below)
    - 'Doc' theme
      - Getting GHDL
        - Releases
        - Building (link to `RTD:Building GHDL`)
        - Ready-to-use docker containers
          - Batch
          - Interactive (shell + vim/nano/emacs)
          - Graphical (shell + X11 + gtkwave)
          - Web lightweight?
          - Eclipse/che
        - Customize your
      - Quick Start Guides
        - Software perspective: Hello world
        - Hardware perspective: heartbeat
      - Starting with a design
      - Tutorials
        - full adder
        - dossmatik
        - closed loop PID
        - docker primer
          - Portainer
          - run, `--rm`, `-i` (winpty), `-t`
          - bind/volumes
          - ports
          - envvars
          - `-d`, exec

I think that the best tool for such a 'migration' is [gohugo.io](https://gohugo.io/). It is a static site generator, similar to [Jekyll](https://jekyllrb.com/) (which was created for GitHub pages). Although the main source format is Markdown, hugo [supports](https://gohugo.io/content-management/formats/#additional-formats-through-external-helpers) rst. Just as rst is the default for Sphinx, but md is supported too. This allows to just move sources with minimum edition.

Hugo is written in go, so it is a single static binary. Moreover, it has an embedded web server. Thus, livereload while editing the sources is straightforward: `hugo server`.

[Compared](https://stackshare.io/stackups/hugo-vs-sphinx) to sphinx, they are simply meant for different purposes. Sphinx has nothing to do when it comes to customization, mixing templates, content structure... However, there are two features that Sphinx can do better:

- Generate a different version for each branch. I believe we can do this just created the site corresponding to each branch in a subdir.
- Generate a PDF. We can use https://pandoc.org/ to convert sources to LaTeX and then generate the PDF. This is what Sphinx does internally. Maybe the same template can be used.

How do we generate GitHub Pages automatically? With travis, of course:

No container is required to run hugo. Since it is a single static binary, a script is enough. Shall LaTeX, pandoc or any other external tool be required, the images from [BuildTheDocs](https://github.com/buildthedocs/btdhttps://github.com/buildthedocs/btd) can be used or any custom image can be created.

The tricky part here is to deploy the result to the repo. It is not complex, but you need to generate a ssh key pair, encrypt the private key with travis cli, and upload the public key to the "Deploy keys" setting of the repo. As with the dockerhub credentials, this needs to be only once. Indeed, I generate them inside a local docker container and then drop both keys.

This provides read/write access from travis to all the branches in the repo. It does not expand to other repos of the same owner, but limiting per branch is not supported. This is what I don't like. No hard reset/push is done in the script, but I think that it is not worth the risk. Therefore, see [Project organization](#project).

<a name="project"></a>
# Project organization

In order to 'protect' the main repo, I suggest creating `ghdl/ghdl.github.io` and moving `1138-4EB/ghdl-io` to `ghdl/ghdl-io`. The first one would provide a specific repo to host the site. The sources of the site would be kept in `ghdl/ghdl-io`, and the sources of the documentation would remain in `ghdl/ghdl` (subdir `doc`).

Therefore, a push `ghdl-io` would trigger a travis build that would get doc sources from `ghdl/ghdl` and push the results to `ghdl.github.io`.

---

- [x] Write a shell script to build and deploy in separate tasks: `dist/linux/travis/gh-pages.sh`
  - [ ] Retrieve metadata from `ghdl/pkg`
  - [ ] Run gnatdoc (#484)
  - [ ] Run Pandoc?
  - [ ] Deploy PDF to GitHub releases of ghdl.github.io?
- [x] Encrypt private key using travis CLI
  - [x] Write shell script to automate: `dist/linux/travis/travis-enc-deploy.sh`
  - [x] 1138-4EB/ghdl
  - [ ] ghdl/ghdl.github.io (to push from ghdl/ghdl-io)
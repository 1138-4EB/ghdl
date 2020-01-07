<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
* {
  box-sizing: border-box;
}

body {
  background-color: #343131;
  font-family: Helvetica, sans-serif;
  color: #b3b3b3;
}

.timeline {
  position: relative;
  max-width: 1200px;
  margin: 0 auto;
}

.timeline::after {
  content: '';
  position: absolute;
  width: 2px;
  background-color: #fcfcfc;
  margin: 0;
  top: 0;
  bottom: 0;
}

.container {
  padding: 0px 20px;
  position: relative;
  background-color: inherit;
  width: 100%;
}

.ref {
  position: absolute;
  width: 20px;
  height: 20px;
  background-color: #343131;
  border: 3px solid #fcfcfc;
  top: 10px;
  border-radius: 33%;
  z-index: 1;
  left: -10px;
}

.content {
  padding: 10px 10px;
  background-color: #343131;
  position: relative;
}

.content > ul {
  margin: .5em 0em;
  padding-left: 1.5em;
}

a {
  color: white;
  text-decoration: none;
}

.content-title {
  display: flex;
  flex-direction: row;
}

.content-title > .meta {
  flex-grow: 1;
  text-align: right;
}

.header {
  text-align: center;
}

.meta > a {
  margin: 0px 2px;
}

/* Media queries - Responsive timeline on screens less than 600px wide */
/*
@media screen and (max-width: 600px) {
  .timeline::after {
  left: 31px;
  }

  .container {
  width: 100%;
  padding-left: 70px;
  padding-right: 25px;
  left: 0%;
  }

  .container::after {
  left: 15px;
  }
}
*/
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

<div class="header">
  <p>
  <a title="github.com/ghdl" href="https://github.com/ghdl"><img src="https://img.shields.io/badge/-ghdl/ghdl-4183c4.svg?style=flat-square&logo=github&longCache=true"></a><!--
  -->
  <a title="stargazers" href="https://github.com/ghdl/ghdl/stargazers"><img src="https://img.shields.io/github/stars/ghdl/ghdl.svg?style=flat-square&longCache=true"></a><!--
  -->
  <a title="forks" href="https://github.com/ghdl/ghdl/network"><img src="https://img.shields.io/github/forks/ghdl/ghdl.svg?style=flat-square&longCache=true"></a><!--
  -->
  <a title="watchers" href="https://github.com/ghdl/ghdl/watchers"><img src="https://img.shields.io/github/watchers/ghdl/ghdl.svg?style=flat-square&longCache=true"></a><!--
  -->
  <a title="GPLv2+" href="https://1138-4eb.github.io/ghdl-io/licenses"><img src="https://img.shields.io/badge/code%20license-GPLv2+-bd0000.svg?label=license&logo=gnu&style=flat-square&longCache=true"></a><!--
  -->
  <a title="CC-BY-SA-4.0" href="https://1138-4eb.github.io/ghdl-io/licenses"><img src="https://img.shields.io/badge/doc%20license-CC--BY--SA--4.0-aab2ab.svg?style=flat-square&longCache=true"></a><!--
  -->
  </p>
  <p>
  <strong style="font-size: 6rem; color: white">GHDL</strong>
  </br>
  <strong style="font-size: 2rem; margin-top: 0">the open-source analyzer, compiler and simulator for VHDL</strong>
  </p>
  <p>
  <a title="Join the chat at https://gitter.im/ghdl1/Lobby" href="https://gitter.im/ghdl1/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge"><img src="https://img.shields.io/badge/chat-on%20gitter-4db797.svg?longCache=true&style=flat-square&logo=gitter&logoColor=e8ecef"></a><!--
  -->
  <a title="CII Best Practices" href="https://bestpractices.coreinfrastructure.org/en/projects/3157"><img src="https://img.shields.io/cii/percentage/3157??longCache=true&style=flat-square"></a><!--
  -->
  <a title="Linux/Mac boxes at Travis-CI" href="https://travis-ci.org/ghdl/ghdl/branches"><img src="https://img.shields.io/travis/ghdl/ghdl/master.svg?longCache=true&style=flat-square&logo=travis-ci&logoColor=e8ecef"></a><!--
  -->
  <a title="AppVeyor branch" href="https://ci.appveyor.com/project/tgingold/ghdl-psgys/history"><img src="https://img.shields.io/appveyor/ci/tgingold/ghdl-psgys/master.svg?logo=appveyor&logoColor=e8ecef&style=flat-square"></a><!--
  -->
  <a title="Docker Images" href="https://github.com/ghdl/docker"><img src="https://img.shields.io/docker/pulls/ghdl/ghdl.svg?logo=docker&logoColor=e8ecef&style=flat-square&label=docker"></a><!--
  -->
  <a title="Releases" href="https://github.com/ghdl/ghdl/releases"><img src="https://img.shields.io/github/commits-since/ghdl/ghdl/latest.svg?longCache=true&style=flat-square"></a>
  </p>
</div>

<div style="margin: 0 20px;">
<div class="timeline">
  {% for ver in changelog %}
  <div id="v{{ ver.name }}" class="container">
      <a href="#v{{ ver.name }}" class="ref"></a>
    <div class="content">
      <div class="content-title">
        <div>
          {% if "release" in ver %}<a title="Download binaries" href="{{ ver.release }}">{% endif %}
          <strong style="color: white">{{ ver.name }}</strong>
          {% if "release" in ver %}<i class="fa fa-download"></i></a>{% endif %}
          {% if ver.date != '-' %} ({{ ver.date }}){% endif %}
        </div>
        <div class="meta">
          {% if "html" in ver %}<a title="See documentation" href="{{ ver.html }}"><i class="fa fa-book"></i></a>{% endif %}
          {% if "htmltar" in ver %}<a title="Download HTML" href="{{ ver.htmltar }}"><i class="fa fa-file-o"></i></a>{% endif %}
          {% if "pdf" in ver %}<a title="Download PDF" href="{{ ver.pdf }}"><i class="fa fa-file-pdf-o"></i></a>{% endif %}
          {% if "tgz" in ver %}<a title="Download doc tarball" href="{{ ver.tgz }}"><i class="fa fa-file-archive-o"></i></a>{% endif %}
          {% if "man" in ver %}<a title="Download man" href="{{ ver.man }}"><i class="fa fa-file-text-o"></i></a>{% endif %}
        </div>
      </div>
      {{ ver.body }}
    </div>
  </div>
  {% endfor %}
</div>
</div>

</body>
</html>

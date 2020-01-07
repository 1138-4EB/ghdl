"""
Command line utility to build documentation/website
"""

import sys
import re
from os.path import join, dirname, isdir, isfile
from os import popen, mkdir
from jinja2 import Template
from markdown2 import markdown
from json import loads, dump
from urllib.request import urlretrieve


ROOT = dirname(__file__)


def version():
    """
    Extract version from file 'configure'
    """
    with open(join(ROOT, '..', 'configure')) as verin:
        for line in verin:
            ver = re.search(r'^ghdl_version=\"(.+)\"$', line)
            if ver:
                return ver.group(1)


def site():
    """
    Update home (changelog)
    """
    regexp = re.compile(r"^\*\*(.*)\*\* \((.*)\)$")
    changelog = [{}]
    ind = 0
    for line in open(join(ROOT, '..', 'NEWS.md')):
        match = regexp.search(line)
        if match:
            ind += 1
            changelog.append({
                "name": match.group(1),
                "date": match.group(2),
                "body": ""
            })
        elif ind:
            changelog[ind]["body"] += line
    changelog.pop(0)

    versions = [ "0.37-dev", "0.36", "0.35" ]

    with open(join(ROOT, '_site', 'versions.json'), "w") as fptr:
        dump(versions, fptr)

    for d in changelog:
        d["body"] = markdown(d["body"])
        if d["date"] == "XXXX-XX-XX":
            d["date"] = "master"
        name = d["name"]
        if name in versions:
            docpre = "GHDL_doc_v%s" % name
            d["html"] = "%s/index.html" % ('master' if name[-4:] == '-dev' else 'v'+name)
            d["htmltar"] = "%s_html.tgz" % docpre
            d["pdf"] = "%s.pdf" % docpre
            d["tgz"] = "%s.tgz" % docpre
            d["man"] = "%s_man.1" % docpre
            if d["date"] != "master":
                d["release"] = "https://github.com/ghdl/ghdl/releases/tag/v%s" % name

    with open(join(ROOT, '_site', 'index.html'), "w") as fptr:
        fptr.write(Template(open(join(ROOT, 'index.html.tpl')).read()).render({
            "changelog": changelog
        }))


def get_btdpy(location):
    btdpy = join(location, 'btd.py')
    if not isfile(btdpy):
        urlretrieve(
            "https://github.com/buildthedocs/btd/raw/py/btd.py",
            btdpy
        )


def preset():
    """
    Preset theme and context.json
    """
    get_btdpy(ROOT)
    import btd
    btd.get_theme()
    btd.custom_last('ghdl', 'ghdl')


if __name__ == "__main__":
    if '--preset' in sys.argv:
        preset()
    elif '--site' in sys.argv:
        site()
    else:
        print("Undefined default behaviour; use '--preset' or '--site'")
        exit(1)

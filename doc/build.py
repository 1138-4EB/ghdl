"""
Command line utility to build documentation/website
"""

import json
import inspect
from subprocess import check_call
from sys import executable
from os.path import join, dirname, isabs, isdir, isfile
from os import popen, mkdir, environ, listdir
from shutil import copyfile


ROOT = join(dirname(__file__))


def get_theme(url, strip=None, tarfilter=None):
    """
    Check if the theme is available locally, retrieve it with curl otherwise
    """
    if not isdir(join(ROOT, '_theme')) or not isfile(join(ROOT, '_theme', 'theme.conf')):
        if not isdir(join(ROOT, '_theme')):
            mkdir(join(ROOT, '_theme'))
        if not isfile(join(ROOT, 'theme.tgz')):
            print(popen(' '.join([
                'curl',
                '-fsSL',
                url,
                '-o', join(ROOT, 'theme.tgz')
            ])).read())
        tar_cmd = [
            'tar',
            '-C',
            join(ROOT, '_theme'),
            '-xvzf',
            join(ROOT, 'theme.tgz')
        ]

        if tarfilter:
            tar_cmd += [tarfilter]
        if strip:
            tar_cmd += ['--strip-component', str(strip)]
        print(popen(' '.join(tar_cmd)).read())


def custom_last(user, repo, cidomain='travis-ci.org'):
    """
    Build a custom 'Last updated on' field with CI info
    """
    custom = {'last': None, 'pre': None}
    try:
        slug = user + '/' + repo
        commit = environ['TRAVIS_COMMIT']
        custom['pre'] = 'Last updated on '
        custom['last'] = ''.join([
            '[',
            '<a href="https://github.com/', slug, '/commit/', commit, '">', commit[0:8], '</a>',
            ' - ',
            '<a href="https://', cidomain, '/', slug, '/builds/', environ['TRAVIS_BUILD_ID'], '">',
            environ['TRAVIS_BUILD_NUMBER'], '</a>',
            '.',
            '<a href="https://', cidomain, '/', slug, '/jobs/', environ['TRAVIS_JOB_ID'], '">',
            environ['TRAVIS_JOB_NUMBER'].split('.')[1], '</a>',
            ']',
        ])
    except KeyError as err:
        print('Could not retrieve CI build info: envvar', err, 'not found.')

    context = {}
    if custom['pre']:
        context['custom_last_pre'] = custom['pre']
    if custom['last']:
        context['custom_last'] = custom['last']

    if context:
        with open(join(ROOT, 'context.json'), 'w') as fptr:
            json.dump(context, fptr)


def main():
    """
    Build documentation/website
    """
    get_theme(
        url='https://codeload.github.com/buildthedocs/sphinx_btd_theme/tar.gz/vunit',
        strip=2,
        tarfilter='sphinx_btd_theme-vunit/sphinx_rtd_theme'
    )

    #for typ in ['html', 'latex']:
    check_call([
        executable, "-m", "sphinx",
        "-T", "-b", "html",
        dirname(__file__), join(ROOT, '_build', 'html')
    ])


if __name__ == "__main__":
    main()

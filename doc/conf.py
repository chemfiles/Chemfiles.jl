# -*- coding: utf-8 -*-
import sys
import os
import toml
import sphinx_bootstrap_theme

DOC_ROOT = os.path.abspath(os.path.dirname(__file__))
sys.path.append(DOC_ROOT)

# -- General configuration ------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
    'sphinxjulia.juliadomain',
    'sphinxjulia.juliaautodoc',
    'htmlhidden',
]

# The suffix of source filenames.
source_suffix = '.rst'

# The master toctree document.
master_doc = 'index'


def version():
    parsed = toml.loads(open(os.path.join("..", "Project.toml")).read())
    release = parsed["version"]
    version = ".".join(release.split(".")[:2])
    return version, release


# General information about the project.
project = u'Julia interface to chemfiles'
copyright = u'2015-2018, Guillaume Fraux & contributors — BSD license'
version, release = version()

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
exclude_patterns = []

# Add any paths that contain templates here, relative to this directory.
templates_path = [os.path.join(DOC_ROOT, "templates")]

# The name of the Pygments (syntax highlighting) style to use.
pygments_style = 'sphinx'

# -- Options for HTML output ----------------------------------------------

html_theme = 'bootstrap'
html_theme_path = sphinx_bootstrap_theme.get_html_theme_path()

html_theme_options = {
    'navbar_site_name': "Navigation",
    'navbar_pagenav': False,
    'source_link_position': None,
    'bootswatch_theme': "flatly",
    'bootstrap_version': "3",
}

html_sidebars = {
    '**': ['sidebar-toc.html', 'searchbox.html']
}

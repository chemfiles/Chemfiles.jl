# -*- coding: utf-8 -*-
import sys
import os
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
]

# The suffix of source filenames.
source_suffix = '.rst'

# The master toctree document.
master_doc = 'index'

# General information about the project.
project = u'Julia interface to chemfiles'
copyright = u'2015-2018, Guillaume Fraux & contributors — BSD licence'

version = "0.6"
release = "0.6.0"

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
exclude_patterns = []

# The name of the Pygments (syntax highlighting) style to use.
pygments_style = 'sphinx'

# -- Options for HTML output ----------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
html_theme = 'bootstrap'
html_theme_path = sphinx_bootstrap_theme.get_html_theme_path()

# Output file base name for HTML help builder.
htmlhelp_basename = 'chemfiles'

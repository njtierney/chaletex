
<!-- README.md is generated from README.Rmd. Please edit that file -->

# chaletex

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.org/njtierney/chaletex.svg?branch=master)](https://travis-ci.org/njtierney/chaletex)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/njtierney/chaletex?branch=master&svg=true)](https://ci.appveyor.com/project/njtierney/chaletex)
<!-- badges: end -->

Trying to compile LaTeX files can be frustrating when you need to stop
at every attempted compile and install the missing packages.The goal of
chaletex is to make it easy to extract packages you need to install from
LaTeX.

It is named `chaletex` as we want this to be like walking into a Chalet
after a big day - a nice, friendly, cozy place for your TeX problems.

It is entirely possible that this functionality already exists,
somewhere, perhaps in [tinytex](https://github.com/yihui/tinytex), but
we could not find it easily. This package was co-written with
grep-master [Claire Miller](http://clairemmiller.com/).

## Installation

You can install the released version of chaletex from GitHub with

``` r
# install.packages("remotes")
remotes::install_github("njtierney/chaletex")
```

## Example usage

The primary use it to extract a list of packages out of a .tex file
string:

``` r
library(chaletex)
tex_extract_pkgs(tex_example)
#>  [1] "geometry"   "amsmath"    "amssymb"    "changepage" "inputenc"  
#>  [6] "textcomp"   "marvosym"   "cite"       "nameref"    "hyperref"  
#> [11] "lineno"     "microtype"  "xcolor"     "array"      "setspace"  
#> [16] "caption"    "lastpage"   "fancyhdr"   "graphicx"   "epstopdf"
```

You can also extract only the preamble, the part before
`\begin{document}`, if you want to cut down on your string processing:

``` r
# read in example tex file
tex_extract_preamble(tex_example) %>%
  tex_extract_pkgs()
#>  [1] "geometry"   "amsmath"    "amssymb"    "changepage" "inputenc"  
#>  [6] "textcomp"   "marvosym"   "cite"       "nameref"    "hyperref"  
#> [11] "lineno"     "microtype"  "xcolor"     "array"      "setspace"  
#> [16] "caption"    "lastpage"   "fancyhdr"   "graphicx"   "epstopdf"
```

You can also read in a tex file into a string using `read_tex`:

``` r
tex_string <- read_tex("path/to/file.tex")
```

And you can install tex files using `tex_install_pkgs()`, which is a
wrapper around the amazing `tinytex::tlmgr_install()` (not run, but
example shown).

``` r
read_tex("path/to/file.tex") %>%
  tex_extract_preamble() %>%
  tex_extract_pkgs() %>%
  tex_install_pkgs()
```

Please note that the ‘chaletex’ project is released with a [Contributor
Code of Conduct](.github/CODE_OF_CONDUCT.md). By contributing to this
project, you agree to abide by its terms.

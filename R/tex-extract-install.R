#' read tex file into R
#'
#' @param path file path
#' @param ... extra options to pass to readChar
#'
#' @return text string
#' @export
#'
#' @examples
#' \dontrun{
#' tex_chars <- read_tex("path/to/file.tex")
#' }
read_tex <- function(path, ...){
  readChar(con = path,
           nchars = file.info(path)$size,
           ...)
}


#' Extract preamble from tex string
#'
#' @param tex_string tex string, could be read in with read_tex
#'
#' @return text string containing all text before `\\begin{document}`
#' @export
#'
#' @examples
#' \dontrun{
#' tex_preamble <- tex_extract_preamble(tex_example)
#' }
tex_extract_preamble <- function(tex_string){
  where_begin_document <- stringr::str_locate(tex_string,
                                              "begin\\{document\\}")
  substr(tex_string,
         start = 1,
         stop = where_begin_document[1])
}

#' Extract packages from tex string
#'
#' @param tex_string text string
#'
#' @return text string of package names
#' @export
#'
#' @examples
#' tex_preamble <- tex_extract_preamble(tex_example)
#' tex_extract_pkgs(tex_preamble)
#' tex_extract_pkgs(tex_example)
tex_extract_pkgs <- function(tex_string){

  tex_pkg_names <- stringr::str_extract_all(tex_string,
                                            "(?<=usepackage).+?(\\})") %>%
    purrr::pluck(1) %>%
    stringr::str_extract_all(., "(?<=\\{).+?(?=\\})") %>%
    purrr::flatten_chr() %>%
    strsplit(",") %>%
    purrr::flatten_chr()

  return(tex_pkg_names)

}

#' Install tex packages
#'
#' Install tex packages using `tinytex::tlmgr_install()`
#'
#' @param tex_pkg_string string
#' @param ... extra options to pass to `tinytex::tlmgr_install()` .
#'
#' @return nothing, this installs packages
#' @export
#'
#' @examples
#' \dontrun{
#' # in a pipeline
#' read_tex(tex_path) %>%
#'   tex_extract_preamble() %>%
#'   tex_extract_pkgs() %>%
#'   tex_install_pkgs()
#'   }
tex_install_pkgs <- function(tex_pkg_string, ...){
  tinytex::tlmgr_install(tex_pkg_string, ...)
}




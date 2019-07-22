## code to prepare `DATASET` dataset goes here
tex_example <- read_tex(here::here("data-raw", "plos_one_template.tex"))
usethis::use_data(tex_example)

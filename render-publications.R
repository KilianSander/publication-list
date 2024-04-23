# Render publications for github.io
library(magrittr)
quarto::quarto_render(
  input = "publications-template.qmd",
  output_file = "publications.md"
)
pub_file <-
  readr::read_lines(
    file = "publications.md"
  )
last_line <-
  which(pub_file == "## All Publications") - 1
pub_file <-
  pub_file[3:last_line]  %>%
  stringr::str_replace(
    pattern = "Google Magenta\\*\\*",
    replacement = "Google Magenta"
  )  %>%
  c(
    '---',
    'title: "Publications"',
    'format:',
    '  html:',
    '    other-links:',
    '    - text: "Download Zotero-json file"',
    '      href: "https://raw.githubusercontent.com/KilianSander/publication-list/main/publications.json"',
    '      icon: download',
    '---',
    .,
    '',
    '```{r time}',
    '#| echo: false',
    'current_time <- Sys.time() |> strftime(format = "%Y-%m-%d %H:%M:%S %Z")',
    '```',
    'This page was last updated on `r current_time`.'
  )
readr::write_lines(
  pub_file,
  file = "publications.qmd"
)

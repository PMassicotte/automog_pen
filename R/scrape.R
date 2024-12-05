library(rvest)
library(httr2)

url <- "https://www.autmog.com/products/40-clipless-click-pen-6al-4v-titanium-6061-aluminum-mechanism-round-nose-grip-lines-pentel-energel-1"

html <- read_html(url)

available <- html |>
  html_elements(".product-form__buttons span") |>
  html_text2() |>
  head(1L)

if (available != "Sold out") {
  msg <- "The pen is available!"
  request("https://ntfy.sh/") |>
    req_url_path("autmog_alert") |>
    req_body_raw(msg) |>
    req_headers(Title = "Update at Weston Lambert", Click = url) |>
    req_perform()
}

library(rvest)
library(dplyr)
library(stringr)
library(tidytext)
trim <- function(x) gsub("^\\s+|\\s+$", "", x)

base_url <- 'https://movie.naver.com'
start_url <- '/movie/bi/mi/point.nhn?code=101966'
url1 <- paste0(base_url,start_url)
html <- read_html(url1)
toy_result <- data.frame(title=c(), writer=c(), price=c())

html %>%
  html_node('iframe') %>%
  html_attr('src') -> url2

iframe_url <- paste0(base_url, url2)


html1 <- read_html(iframe_url)
html1 %>%
  html_node('div.score_result') %>%
  html_nodes('li') -> lis


html2 <- read_html(iframe_url)
html2 %>%
  html_node('div.paging') %>%
  html_node('a') %>%
  html_attr('href') -> url3
url4<- gsub('page=1','page=', url3)
round(4397 / 10)

score  <- c()
review <- c()
user   <- c()
w_date <- c()

for ( i in 1:440) {
  page_url <- paste0(base_url, url4, i)
  html3 <- read_html(page_url)

  html3 %>%
    html_node('div.score_result') %>%
    html_nodes('li') -> lis

    for (li in lis) { 
      score <- c(score, html_node(li, '.star_score') %>% html_text('em') %>% trim())
      li %>%
        html_node('.score_reple') %>%
        html_text('p') %>%
        trim() -> tmp
      idx <- str_locate(tmp, "\r")
      review <- c(review, str_sub(tmp, 1, idx[1]-1))
      tmp <- trim(str_sub(tmp, idx[1], -1))
      idx <- str_locate(tmp, "\r")
      user <- c(user, str_sub(tmp, 1, idx[1]-1))
      tmp <- trim(str_sub(tmp, idx[1], -1))
      idx <- str_locate(tmp, "\r")
      w_date <- c(w_date, str_sub(tmp, 1, idx[1]-1))
  }
}
al <- data.frame(score=score, review=review, user=user, w_date=w_date)
View(al)
writexl::write_xlsx(al, path = "D:/workspace/R_Project/01_Crawling/toy.xlsx")  
  
  
  
  
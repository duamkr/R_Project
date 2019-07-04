install.packages("wordcloud")
install.packages("RColorBrewer")
install.packages("KoNLP")
library(wordcloud)
library(RColorBrewer)
library(KoNLP)

trim <- function(x) gsub("^\\s+|\\s+$", "", x)

# 영화 평점 페이지 기본 베이스 url설정 (어벤져스 1)
base_url <- 'https://movie.naver.com'
sub_url <-'/movie/bi/mi/point.nhn?code=72363'
url_1 <- paste0(base_url,sub_url)
html <- read_html(url_1)


# iframe 구조의 hmtl src 가져오기
html %>%
  html_node('iframe') %>%
  html_attr('src') -> url_2

iframe_url <- paste0(base_url, url_2)

# 평점 페이지 넘어가는 url 수정 (for loop을 돌리기 위해 'page=1' -> 'page='로 넣어주고 i값을 뒤에 대입할 예정(i는 총 리뷰 남긴 데이터 건수)
read_html(iframe_url) %>%
  html_node('div.paging') %>%
  html_node('a') %>%
  html_attr('href') -> page_url_test
page_url <- gsub('page=1', 'page=', page_url_test)

# div class = socore_result <- 평점 정보 lis에 저장
html1 <- read_html(iframe_url)
html1 %>%
  html_node('div.score_result') %>%
  html_nodes('li') -> lis

# 평점 및 리뷰 남긴 총 데이터 건수만큼 for loop을 돌리기 위한 계산식
html2 <- read_html(iframe_url)
html2 %>%
  html_node('div.score_total') %>%
  html_nodes('em') -> ems
pages <- ems[2] %>% html_text()
pages <- gsub(",","",pages)
total_page <- ceiling(as.numeric(pages)/10)

score  <- c()
review <- c()
user   <- c()
w_date <- c()

for ( i in 1:total_page) {
  total_url <- paste0(base_url, page_url, i)
  html3 <- read_html(total_url)
  
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
avengers1_result <- data.frame(score=score, review=review, user=user, w_date=w_date)
View(avengers1_result)
write_xlsx(avengers1_result, path = "D:/workspace/R_Project/01_Crawling/avengers1.xlsx")  





# 영화 평점 페이지 기본 베이스 url설정 (어벤져스 2)
base_url <- 'https://movie.naver.com'
sub_url <-'/movie/bi/mi/point.nhn?code=98438'
url_1 <- paste0(base_url,sub_url)
html <- read_html(url_1)


# iframe 구조의 hmtl src 가져오기
html %>%
  html_node('iframe') %>%
  html_attr('src') -> url_2

iframe_url <- paste0(base_url, url_2)

# 평점 페이지 넘어가는 url 수정 (for loop을 돌리기 위해 'page=1' -> 'page='로 넣어주고 i값을 뒤에 대입할 예정(i는 총 리뷰 남긴 데이터 건수)
read_html(iframe_url) %>%
  html_node('div.paging') %>%
  html_node('a') %>%
  html_attr('href') -> page_url_test
page_url <- gsub('page=1', 'page=', page_url_test)

# div class = socore_result <- 평점 정보 lis에 저장
html1 <- read_html(iframe_url)
html1 %>%
  html_node('div.score_result') %>%
  html_nodes('li') -> lis

# 평점 및 리뷰 남긴 총 데이터 건수만큼 for loop을 돌리기 위한 계산식
html2 <- read_html(iframe_url)
html2 %>%
  html_node('div.score_total') %>%
  html_nodes('em') -> ems
pages <- ems[2] %>% html_text()
pages <- gsub(",","",pages)
total_page <- ceiling(as.numeric(pages)/10)

score  <- c()
review <- c()
user   <- c()
w_date <- c()

for ( i in 1:total_page) {
  total_url <- paste0(base_url, page_url, i)
  html3 <- read_html(total_url)
  
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
avengers2_result <- data.frame(score=score, review=review, user=user, w_date=w_date)
View(avengers2_result)
write_xlsx(avengers2_result, path = "D:/workspace/R_Project/01_Crawling/avengers2.xlsx")  




# 영화 평점 페이지 기본 베이스 url설정 (어벤져스 3)
base_url <- 'https://movie.naver.com'
sub_url <-'/movie/bi/mi/point.nhn?code=136315'
url_1 <- paste0(base_url,sub_url)
html <- read_html(url_1)


# iframe 구조의 hmtl src 가져오기
html %>%
  html_node('iframe') %>%
  html_attr('src') -> url_2

iframe_url <- paste0(base_url, url_2)

# 평점 페이지 넘어가는 url 수정 (for loop을 돌리기 위해 'page=1' -> 'page='로 넣어주고 i값을 뒤에 대입할 예정(i는 총 리뷰 남긴 데이터 건수)
read_html(iframe_url) %>%
  html_node('div.paging') %>%
  html_node('a') %>%
  html_attr('href') -> page_url_test
page_url <- gsub('page=1', 'page=', page_url_test)

# div class = socore_result <- 평점 정보 lis에 저장
html1 <- read_html(iframe_url)
html1 %>%
  html_node('div.score_result') %>%
  html_nodes('li') -> lis

# 평점 및 리뷰 남긴 총 데이터 건수만큼 for loop을 돌리기 위한 계산식
html2 <- read_html(iframe_url)
html2 %>%
  html_node('div.score_total') %>%
  html_nodes('em') -> ems
pages <- ems[2] %>% html_text()
pages <- gsub(",","",pages)
total_page <- ceiling(as.numeric(pages)/10)

score  <- c()
review <- c()
user   <- c()
w_date <- c()

for ( i in 1:total_page) {
  total_url <- paste0(base_url, page_url, i)
  html3 <- read_html(total_url)
  
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
avengers3_result <- data.frame(score=score, review=review, user=user, w_date=w_date)
View(avengers3_result)
write_xlsx(avengers3_result, path = "D:/workspace/R_Project/01_Crawling/avengers3.xlsx")  




# 영화 평점 페이지 기본 베이스 url설정 (어벤져스 4)
base_url <- 'https://movie.naver.com'
sub_url <-'/movie/bi/mi/point.nhn?code=136900'
url_1 <- paste0(base_url,sub_url)
html <- read_html(url_1)


# iframe 구조의 hmtl src 가져오기
html %>%
  html_node('iframe') %>%
  html_attr('src') -> url_2

iframe_url <- paste0(base_url, url_2)

# 평점 페이지 넘어가는 url 수정 (for loop을 돌리기 위해 'page=1' -> 'page='로 넣어주고 i값을 뒤에 대입할 예정(i는 총 리뷰 남긴 데이터 건수)
read_html(iframe_url) %>%
  html_node('div.paging') %>%
  html_node('a') %>%
  html_attr('href') -> page_url_test
page_url <- gsub('page=1', 'page=', page_url_test)

# div class = socore_result <- 평점 정보 lis에 저장
html1 <- read_html(iframe_url)
html1 %>%
  html_node('div.score_result') %>%
  html_nodes('li') -> lis

# 평점 및 리뷰 남긴 총 데이터 건수만큼 for loop을 돌리기 위한 계산식
html2 <- read_html(iframe_url)
html2 %>%
  html_node('div.score_total') %>%
  html_nodes('em') -> ems
pages <- ems[2] %>% html_text()
pages <- gsub(",","",pages)
total_page <- ceiling(as.numeric(pages)/10)

score  <- c()
review <- c()
user   <- c()
w_date <- c()

for ( i in 1:total_page) {
  total_url <- paste0(base_url, page_url, i)
  html3 <- read_html(total_url)
  
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
avengers4_result <- data.frame(score=score, review=review, user=user, w_date=w_date)
View(avengers4_result)
write_xlsx(avengers4_result, path = "D:/workspace/R_Project/01_Crawling/avengers4.xlsx")  

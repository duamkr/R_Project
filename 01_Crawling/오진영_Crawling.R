install.packages("rvest")
library(dplyr)
library(stringr)
library(openxlsx)
library(xlsx)


trim <- function(x) gsub("^\\s+|\\s+$", "", x)
cat_names <- c('슈퍼시드피자', '프리미엄', '클래식')
categories <- c('C010', 'C010', 'C010')

base_url <- 'https://web.dominos.co.kr/goods/list?dsp_ctgr='


wb <- createWorkbook()
  for (i in 1:3) {
    df_pizza <- data.frame(title=c(), L_pirce=c(), M_price=c())
    url1 <- paste0(base_url,categories,i)
    print(url1)

    read_html(url1) %>%
      html_node('.lst_prd_type') %>%
      html_nodes('li') -> lis
    lis
    
    L_price <- c()
    M_price <- c()
    title <- c()
    for (li in lis) {
      pr <- html_node(li, '.price_large') %>% html_text()
      pr <- gsub("\\\\", "", pr)
      L_price <- c(L_price,pr)
      #L_price <- c(L_price, html_node(li, '.price_large') %>% html_text())
      M_price <- c(M_price, html_node(li, '.price_medium') %>% html_text())
      title <- c(title, html_node(li, '.prd_title') %>% html_text())
    }
 pizza <- data.frame(title=title, L_price=L_price, M_price=M_price)
 df_pizza <- rbind.data.frame(df_pizza, pizza)
}
saveWorkbook(wb, file="D:/workspace/R_Project/01_Crawling/domino_pizza.xlsx")
repair_encoding(title, from = 'utf-8q')

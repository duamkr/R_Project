install.packages("extrafont")
install.packages("lawstat")

fonttable()
font_import(pattern = "HUJingo340")


ggplot(kobis_avengers,aes(day, acc_sales, color = series)) +
  geom_line(linetype = 6, size = 1) +
  scale_y_continuous(labels = paste0(acc_sales %/% 10000),c("만원")) #+
                     ggtitle("어벤져스1~4, 누적관람객(개봉 ~30일)") +
                       theme(plot.title = element_text(face='bold', size=12.5, hjust=0.5)) +
                       labs(x = '개봉일~30일', y = '누적 관람객') 
                     
                     
                     # 어벤져스 ~ 어벤져스:엔드게임 까지 시리즈별 비교를 위한 간단한 테이블 생성(평점/댓글 크롤링 데이터 사용)
                     people <- c(7075607)
                     review <- nrow(aven_1_n)
                     score <- aven_1_n %>%
                       summarise(mean = round(mean(score),1))
                     series <- 'avengers1'
                     aven1_table <- data.frame(people, review, score, series)
                     
                     
                     people <- c(10494840)
                     review <- nrow(aven_2_n)
                     score <- aven_2_n %>%
                       summarise(mean = round(mean(score),1))
                     series <- 'avengers2'
                     aven2_table <- data.frame(people, review, score, series)
                     
                     
                     people <- c(11212710)
                     review <- nrow(aven_3_n)
                     score <- aven_3_n %>%
                       summarise(mean = round(mean(score),1))
                     series <- 'avengers3'
                     aven3_table <- data.frame(people, review, score, series)
                     
                     
                     people <- c(13922090)
                     review <-nrow(aven_4_n)
                     score <- aven_4_n %>%
                       summarise(mean = round(mean(score),1))
                     series <- 'avengers4'
                     aven4_table <- data.frame(people, review, score, series)
                     
                     all_aven <- rbind(aven1_table, aven2_table, aven3_table, aven4_table)
                     
                     
                     ggplot(all_aven, aes(x=series, y= people, fill = series)) +
                       geom_bar(stat = 'identity', size = 0.5) +
                       geom_text(aes(label=scales::comma(people), size=3.5, hjust=0.5, vjust=1.25, color = '#FFFFFF') +
                                   ggtitle("어벤져스 시리즈별 누적 관람객")) +
                       scale_y_continuous(labels = scales::comma) +
                       theme(plot.title = element_text(face='bold', size=12.5, hjust=0.5)) +
                       labs(x = '시리즈', y = '누적 관람객') 
                     
                     ggplot(all_aven, aes(x=series, y= review, fill = series)) +
                       geom_col() + 
                       geom_text(aes(label=scales::comma(review)), size=3.5, hjust=0.5, vjust=1.25, color = '#FFFFFF') +
                       ggtitle("어벤져스 시리즈별 누적 댓글 수") +
                       scale_y_continuous(labels = scales::comma) +
                       theme(plot.title = element_text(face='bold', size=12.5, hjust=0.5)) +
                       labs(x = '시리즈', y = '누적 평점/댓글 수') 
                     
                     ggplot(all_aven, aes(x=series, y= mean, fill = series)) +
                       geom_col() +
                       ggtitle("어벤져스 시리즈별 누적 평균 평점") +
                       scale_y_continuous(labels = scales::comma) +
                       geom_text(aes(label=mean), size=3.5, hjust=0.5, vjust=1.25, color = '#FFFFFF') +
                       theme(plot.title = element_text(face='bold', size=12.5, hjust=0.5)) +
                       labs(x = '시리즈', y = '누적 평점') 
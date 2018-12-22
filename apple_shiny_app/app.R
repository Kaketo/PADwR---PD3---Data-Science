library(dplyr)
library(stringi)
library(ggplot2)
library(shiny)
options(stringsAsFactors=FALSE)

setwd("C:/Users/tomas/OneDrive/Documents/Studies/PW-IAD/PADwR/zadania_domowe/03")

# Załadowanie potrzebnych danych
posts <- read.csv(file="C:/Users/tomas/Downloads/Apple/apple.stackexchange.com/Posts.csv", header=TRUE, sep=",")
users_countries <- read.csv(file = "C:/Users/tomas/Downloads/Apple/apple.stackexchange.com/Users_countries.csv", header = TRUE, sep =",")
users_stacked_count <- read.csv(file = "C:/Users/tomas/OneDrive/Documents/Studies/PW-IAD/PADwR/zadania_domowe/03/PADwR---PD3---Data-Science/users_stacked_join_date.csv", header = TRUE, sep =",")
# Przefiltrowanie interesujacych nas danych
posts2 <- posts %>% select(Id, CreationDate, PostTypeId, AcceptedAnswerId, OwnerUserId)
users2 <- users_countries %>% select(Id, Reputation, CreationDate, Country, State)
rm(posts,users_countries)
posts3 <- inner_join(posts2,posts2, by = c("AcceptedAnswerId" = "Id")) %>%
  select(CreationDate = CreationDate.x, 
         OwnerQuestionUserId = OwnerUserId.x, 
         CommentDate = CreationDate.y,
         OwnerAnswerUserId = OwnerUserId.y
  )
posts4 <- inner_join(posts3,users2, by = c("OwnerQuestionUserId" = "Id")) %>% 
  select(CreationDate = CreationDate.x,
         OwnerQuestionUserId,
         CommentDate,
         OwnerAnswerUserId,
         OwnerReputation = Reputation,
         OwnerJoinDate = CreationDate.y,
         OwnerCountry = Country,
         OwnerState = State)
posts5 <- inner_join(posts4,users2, by = c("OwnerAnswerUserId" = "Id")) %>% 
  select(CreationDate = CreationDate.x,
         OwnerQuestionUserId,
         OwnerReputation,
         OwnerJoinDate,
         OwnerCountry,
         OwnerState,
         CommentDate,
         AnswerUserId = OwnerAnswerUserId,
         AnswerReputation = Reputation,
         AnswerJoinDate = CreationDate.y,
         AnswerCountry = Country,
         AnswerState = State)



# Operacje potrzebne do wyłuskania daty
posts5$CreationDate <- stri_join(stri_sub(posts5$CreationDate,1,10),stri_sub(posts5$CreationDate,12,19),sep = " ")          
posts5$CreationDate <- stri_datetime_parse(posts5$CreationDate, format = "yyyy-MM-dd HH:mm:ss")
posts5$CommentDate <- stri_join(stri_sub(posts5$CommentDate,1,10),stri_sub(posts5$CommentDate,12,19),sep = " ")          
posts5$CommentDate <- stri_datetime_parse(posts5$CommentDate, format = "yyyy-MM-dd HH:mm:ss")
posts5$AnswerJoinDate <- stri_join(stri_sub(posts5$AnswerJoinDate,1,10),stri_sub(posts5$AnswerJoinDate,12,19),sep = " ")          
posts5$AnswerJoinDate <- stri_datetime_parse(posts5$AnswerJoinDate, format = "yyyy-MM-dd HH:mm:ss")
posts5$OwnerJoinDate <- stri_join(stri_sub(posts5$OwnerJoinDate,1,10),stri_sub(posts5$OwnerJoinDate,12,19),sep = " ")          
posts5$OwnerJoinDate <- stri_datetime_parse(posts5$OwnerJoinDate, format = "yyyy-MM-dd HH:mm:ss")

posts5$AcceptedTimeDiff <- difftime(posts5$CommentDate,posts5$CreationDate, units = "hours")

# Dodanie informacji o całkowitej liczbie użytkowników w danym kraju - ZAPISANE DO PLIKU
# users3 <- users2 %>%
#   group_by(Country,CreationDate = stri_sub(CreationDate,1,7)) %>%
#   summarise(CountTotalUsers = sum(CreationDate == CreationDate)
#   )
# users3$CountTotalUsersStack <- NA
# #Dluga petla - dlatego dane zapisane do CSV
# for(i in 1:nrow(users3)){
#   date_i <- users3$CreationDate[i]
#   country_i <- users3$Country[i]
#   t <- users3 %>% filter(CreationDate <= date_i, Country == country_i)
#   users3$CountTotalUsersStack[i] <- sum(t$CountTotalUsers)
#   rm(t)
# }
# write.csv(users3,"C:/Users/tomas/OneDrive/Documents/Studies/PW-IAD/PADwR/zadania_domowe/03/PADwR---PD3---Data-Science/users_stacked_join_date_month.csv")


# Shiny!
ui <- shinyUI(fluidPage(
  titlePanel("Ilość odpowiedzi w danym kraju w podziale na miesiące"),
  sidebarLayout(
    sidebarPanel(
      dateRangeInput(inputId = "data",
                     label = "Wybierz przedzial dat",
                     start  = "2009-02-10",
                     end    = "2018-12-01",
                     min    = "2009-02-10",
                     max    = "2018-12-01",
                     format = "yyyy-mm-dd"),
      selectInput(inputId = "kraj1", 
                  label = "Wybierz jedno z państwo do porównania", 
                  choices = unique(posts5$AnswerCountry),
                  selected = "United States"
      ),
      selectInput(inputId = "kraj2", 
                  label = "Wybierz jedno z państwo do porównania", 
                  choices = unique(posts5$AnswerCountry),
                  selected = "India"
      ),
      selectInput(inputId = "kraj3", 
                  label = "Wybierz jedno z państwo do porównania", 
                  choices = unique(posts5$AnswerCountry),
                  selected = "Switzerland"
      )
    ),
    mainPanel(
      plotOutput("answer_curve")
    )
  )
))

server <- shinyServer(function(input, output) {
  dane_react <- reactive({
    print(input$data)
    dt <- posts5 %>% 
      filter(stri_sub(CommentDate,1,10) >= input$data[1] & stri_sub(CommentDate,1,10) <= input$data[2]) %>%
      group_by(CommentMonth = stri_sub(CommentDate,1,7),AnswerCountry) %>%
      summarise(CntAnswer = n()) %>%
      filter(AnswerCountry %in% cbind(input$kraj1,input$kraj2,input$kraj3))
      
    dt <- inner_join(dt,users3, by = c("AnswerCountry" = "Country", "CommentMonth" = "CreationDate"))
    dt$PercentAnswer <- dt$CntAnswer / dt$CountTotalUsersStack
    dt$CommentDay <- stri_datetime_parse(stri_join(dt$CommentMonth,"-01"),format = "yyyy-MM-dd")
    return(dt)
  })
  output$answer_curve = renderPlot({
    ggplot(dane_react()) + 
      geom_line(aes(x = CommentDay, y = PercentAnswer, color = AnswerCountry, group = AnswerCountry)) + 
      theme_minimal()
  })
})

shinyApp(ui, server)

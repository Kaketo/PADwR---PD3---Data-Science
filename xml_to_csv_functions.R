setwd("C:/Users/tomas/OneDrive/Documents/Studies/PW-IAD/PADwR/zadania_domowe/03")
library(xml2)
library(dplyr)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)

options(stringsAsFactors=FALSE)

# Funkcje które sa w pliku, pozwalają na zamianę wszystkich XML z bazy stacka na pliki CSV. Należy tylko zmienić wszędzie ścieżki


cleanHTMLTags <- function(htmlString) {
  return(gsub("<.*?>", "", htmlString))
}
cleanBackslash <- function(htmlString) {
  return(gsub("\\", "", htmlString, fixed = TRUE))
}
cleanNewLine <- function(htmlString) {
  return(gsub("\n","",htmlString, fixed = TRUE))
}


badgesToDF <- function(sciezka){
  x<-read_xml(sciezka)
  recs <- xml_find_all(x, "//row")
  df<-bind_rows(lapply(xml_attrs(recs), function(x) data.frame(as.list(x), stringsAsFactors=FALSE)))  
  return(df)
}
commentsToDF <- function(sciezka){
  x<-read_xml(sciezka)
  recs <- xml_find_all(x, "//row")
  df<-bind_rows(lapply(xml_attrs(recs), function(x) data.frame(as.list(x), stringsAsFactors=FALSE)))  
  return(df)
}
posthistoryToDF <- function(sciezka){
  x<-read_xml(sciezka)
  recs <- xml_find_all(x, "//row")
  df<-bind_rows(lapply(xml_attrs(recs), function(x) data.frame(as.list(x), stringsAsFactors=FALSE)))  
  return(df)
}
postlinksToDF <- function(sciezka){
x<-read_xml(sciezka)
recs <- xml_find_all(x, "//row")
df<-bind_rows(lapply(xml_attrs(recs), function(x) data.frame(as.list(x), stringsAsFactors=FALSE)))  
return(df)
}

postsToDF <- function(sciezka){
  x<-read_xml(sciezka)
  recs <- xml_find_all(x, "//row")
  df<-bind_rows(lapply(xml_attrs(recs), function(x) data.frame(as.list(x), stringsAsFactors=FALSE)))  
  df$Body <- cleanHTMLTags(df$Body)
  df$Body <- cleanBackslash(df$Body)
  df$Body <- cleanNewLine(df$Body)
  return(df)
}
tagsToDF <- function(sciezka){
  x<-read_xml(sciezka)
  recs <- xml_find_all(x, "//row")
  df<-bind_rows(lapply(xml_attrs(recs), function(x) data.frame(as.list(x), stringsAsFactors=FALSE)))  
  return(df)
}
usersToDF <- function(sciezka){
  x<-read_xml(sciezka)
  recs <- xml_find_all(x, "//row")
  df<-bind_rows(lapply(xml_attrs(recs), function(x) data.frame(as.list(x), stringsAsFactors=FALSE)))  
  df$AboutMe <- cleanHTMLTags(df$AboutMe)
  df$AboutMe <- cleanBackslash(df$AboutMe)
  df$AboutMe <- cleanNewLine(df$AboutMe)
  return(df)
}
votesToDF <- function(sciezka){
  x<-read_xml(sciezka)
  recs <- xml_find_all(x, "//row")
  df<-bind_rows(lapply(xml_attrs(recs), function(x) data.frame(as.list(x), stringsAsFactors=FALSE)))  
  return(df)
}

x <- badgesToDF("C:/Users/tomas/Downloads/Apple/apple.stackexchange.com/Badges.xml")
write.csv(x, "C:/Users/tomas/Downloads/Apple/apple.stackexchange.com/Badges.csv")

x <- commentsToDF("C:/Users/tomas/Downloads/Apple/apple.stackexchange.com/Comments.xml")
write.csv(x, "C:/Users/tomas/Downloads/Apple/apple.stackexchange.com/Comments.csv")

x <- posthistoryToDF("C:/Users/tomas/Downloads/Apple/apple.stackexchange.com/PostHistory.xml")
write.csv(x, "C:/Users/tomas/Downloads/Apple/apple.stackexchange.com/PostHistory.csv")

x <- postlinksToDF("C:/Users/tomas/Downloads/Apple/apple.stackexchange.com/PostLinks.xml")
write.csv(x, "C:/Users/tomas/Downloads/Apple/apple.stackexchange.com/PostLinks.csv")

x <- postsToDF("C:/Users/tomas/Downloads/Apple/apple.stackexchange.com/Posts.xml")
write.csv(x, "C:/Users/tomas/Downloads/Apple/apple.stackexchange.com/Posts.csv")

x <- tagsToDF("C:/Users/tomas/Downloads/Apple/apple.stackexchange.com/Tags.xml")
write.csv(x, "C:/Users/tomas/Downloads/Apple/apple.stackexchange.com/Tags.csv")

x <- usersToDF("C:/Users/tomas/Downloads/Apple/apple.stackexchange.com/Users.xml")
write.csv(x, "C:/Users/tomas/Downloads/Apple/apple.stackexchange.com/Users.csv")

x <- votesToDF("C:/Users/tomas/Downloads/Apple/apple.stackexchange.com/Votes.xml")
write.csv(x, "C:/Users/tomas/Downloads/Apple/apple.stackexchange.com/Votes.csv")

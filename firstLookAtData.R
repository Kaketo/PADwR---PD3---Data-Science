setwd("C:/Users/tomas/OneDrive/Documents/Studies/PW-IAD/PADwR/zadania_domowe/03")
library(xml2)
library(dplyr)

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
#posthistory
#postlinks
postsToDF <- function(sciezka){
  x<-read_xml(sciezka)
  recs <- xml_find_all(x, "//row")
  df<-bind_rows(lapply(xml_attrs(recs), function(x) data.frame(as.list(x), stringsAsFactors=FALSE)))  
  df$Body <- cleanHTMLTags(df$Body)
  df$Body <- cleanBackslash(df$Body)
  df$Body <- cleanNewLine(df$Body)
  return(df)
}
#tags
usersToDF <- function(sciezka){
  x<-read_xml(sciezka)
  recs <- xml_find_all(x, "//row")
  df<-bind_rows(lapply(xml_attrs(recs), function(x) data.frame(as.list(x), stringsAsFactors=FALSE)))  
  df$AboutMe <- cleanHTMLTags(df$AboutMe)
  df$AboutMe <- cleanBackslash(df$AboutMe)
  df$AboutMe <- cleanNewLine(df$AboutMe)
  return(df)
}
#votes

x<-usersToDF("C:/Users/tomas/Downloads/Apple/apple.stackexchange.com/Users.xml")
x<-commentsToDF("C:/Users/tomas/Downloads/Apple/apple.stackexchange.com/Comments.xml")


# Tests
sciezka <- "./hinduism/Posts.xml"
sciezka <- "C:/Users/tomas/Downloads/Stack/Users.xml"
x <- xmlToDF(sciezka)

library(XML)
x<-xmlParse("./hinduism/Badges.xml")
x2<-x[["//row/@Name"]]
x2<-x[["//row/@Name"]]
as.character(x2)

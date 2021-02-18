library(dplyr)
library(stringr)
library(tidytext)
library(tidyr)

#read files
con <- file("../final/en_US/en_US.twitter.txt", "r")
lineTwitter <- readLines(con, encoding = "UTF-8", skipNul = TRUE)
close(con)

con <- file("../final/en_US/en_US.blogs.txt", "r")
lineBlogs <- readLines(con, encoding = "UTF-8", skipNul = TRUE)
close(con)

con <- file("../final/en_US/en_US.news.txt", "r")
lineNews <- suppressWarnings(readLines(con, encoding = "UTF-8", skipNul = TRUE))
close(con)


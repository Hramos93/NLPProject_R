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

# Function for tidy the textlines
tidyLines <- function(textLines){ 
  
  #removal of non-English text
  textLines <- iconv(textLines, "latin1", "ASCII", sub="")
  textLines <- gsub("[[:digit:]]", "", textLines)
  textLines <- gsub("http[[:alnum:]]*", "", textLines)
  
  #split at all ".", ",", ":", ";" ...
  Textlines <- unlist(strsplit(textLines, "[.,:;!?(){}<>]+"))
  
  #remove multiple sapce
  textLines <- gsub("\\s+", " ", textLines)
  #remove spaces at the begining and the end of the line
  textLines <- str_trim(textLines)
  #conver all the text in lower case.
  lines <- tolower(textLines)
}

# Tidy the text.
lineNews <- tidyLines(lineNews)
lineBlogs <- tidyLines(lineBlogs)
lineTwitter <- tidyLines(lineTwitter)


# Change the textlines into data frame format.
lineNews <- as.data.frame(lineNews)
lineBlogs <- as.data.frame(lineBlogs)
lineTwitter <- as.data.frame(lineTwitter)



# Create the bigram for the News data set.
bigramsNews <- lineNews %>%
  unnest_tokens(bigram, lineNews  , token = "ngrams", to_lower = FALSE, n = 2) %>%
  separate(bigram, c("bigram1", "bigram2"), sep = " ") %>%
  count(bigram1, bigram2, sort = TRUE)


# Create the trigram for the News data set.
trigramsNews <- lineNews %>%
  unnest_tokens(trigram, lineNews, token = "ngrams", to_lower = FALSE, n = 3) 

trigramsNews <- separate(trigramsNews, trigram, c("trigram1", "trigram2", "trigram3"), sep = " ")

trigramsNews <-  count(trigramsNews, trigram1, trigram2, trigram3, sort = TRUE)




# Create the bigram for the Blogs data set.
bigramsBlogs <- lineBlogs %>%
  unnest_tokens(bigram, lineBlogs, token = "ngrams", to_lower = FALSE, n = 2) %>%
  separate(bigram, c("bigram1", "bigram2"), sep = " ") %>%
  count(bigram1, bigram2, sort = TRUE)

# Create the trigram for the Blogs data set.
trigramsBlogs <- lineBlogs %>%
  unnest_tokens(trigram, lineBlogs, token = "ngrams", to_lower = FALSE, n = 3)

trigramsBlogs <- separate(trigramsBlogs, trigram, c("trigram1", "trigram2", "trigram3"), sep = " ")

trigramsBlogs <- count(trigramsBlogs, trigram1, trigram2, trigram3, sort = TRUE)



# Create the bigram for the Twitter data set.
bigramsTwitter <- lineTwitter %>%
  unnest_tokens(bigram, lineTwitter, token = "ngrams", to_lower = FALSE, n = 2) %>%
  separate(bigram, c("bigram1", "bigram2"), sep = " ") %>%
  count(bigram1, bigram2, sort = TRUE)

# Create the trigram for the Twitter data set.
trigramsTwitter <- lineTwitter %>%
  unnest_tokens(trigram, lineTwitter, token = "ngrams", to_lower = FALSE, n = 3) %>%
  separate(trigram, c("trigram1", "trigram2", "trigram3"), sep = " ") %>%
  count(trigram1, trigram2, trigram3, sort = TRUE)


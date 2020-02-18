library(tm)
library(wordcloud)
library(memoise)

# WORD CLOUD
# Build a word cloud based on a car review dataset found on Kaggle.

# read in .csv using readlines - creates vector and not dataframe
dta <- readLines("carReviews.csv")

marques <- list("Alfa-Romeo" = "Alfa-Romeo",    
                "Aston-Martin"  = "Aston-Martin",
                "Audi" = "Audi",          
                "Bentley" = "Bentley",       
                "BMW" = "BMW",          
                "Bugatti" = "Bugatti",      
                "Honda" = "Honda",       
                "Lotus" = "Lotus",        
                "Mercedes-benz" = "Mercedes-benz",
                "Tesla" = "Tesla",        
                "Toyota" = "Toyota",      
                "Volkswagen" = "Volkswagen")

# create corpus - similar to dataframe with specified columns (text)
docs <- Corpus(VectorSource(dta))
# inspect the object
inspect(docs)

# DATA CLEANSING

# # Remove special chars
# toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
# docs <- tm_map(docs, toSpace, "/")
# docs <- tm_map(docs, toSpace, "@")
# docs <- tm_map(docs, toSpace, "\\|")
# 
# # Remove unnecessary whitespace, make everything lowercase and remove stopwords (the, it, etc.)
# # Convert the text to lower case
# docs <- tm_map(docs, content_transformer(tolower))
# # Remove numbers
# docs <- tm_map(docs, removeNumbers)
# # Remove english common stopwords
# docs <- tm_map(docs, removeWords, stopwords("english"))
# # Remove your own stop word
# # specify your stopwords as a character vector
# docs <- tm_map(docs, removeWords, c('fuck', 'shit', 'cunt', 'wank', 'arse', 'car')) 
# # Remove punctuations
# docs <- tm_map(docs, removePunctuation)
# # Eliminate extra white spaces
# docs <- tm_map(docs, stripWhitespace)
# # Text stemming - reduces words to their root form (moved becomes move, etc.)
# docs <- tm_map(docs, stemDocument)

# DOCUMENT MATRIX
# This is a frequency table of the remaining words and is necessary for the wordcloud
dtm <- TermDocumentMatrix(docs, control = list(minWordLength = 1))
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)

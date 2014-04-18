setwd("/MSAN/MSANSpring/MSAN622/DataViz/testing")
library(ggplot2)
library(wordcloud)
library(shiny)
require(tm)        # corpus
require(SnowballC)

barplt <- function(which_book) {
  if(which_book=="Harry_Potter1") {
    book_title <- "Harry Potter & the Philosopher's Stone"
  } 
  else if (which_book =="Harry_Potter2") {
    book_title <- "Harry Potter & the Chamber of Secrets"
  }
  else if (which_book == "Harry_Potter3") {
    book_title <- "Harry Potter & the Prisoner of Azkaban"
  }
  else if (which_book =="Harry_Potter4") {
    book_title <- "Harry Potter & the Goblet of Fire"
  }
  else if (which_book == "Harry_Potter5") {
    book_title <- "Harry Potter & the Order of the Phoenix"
  }
  else if (which_book == "Harry_Potter6") {
    book_title <- "Harry Potter & the Half Blood Prince"
  }
  else if (which_book == "Harry_Potter7") {
    book_title <- "Harry Potter & the Deathly Hallows"
  }
  
  book_source <- DirSource(
    # indicate directory
    directory = file.path("."),
    encoding = "UTF-8",     # encoding
    pattern = paste(which_book,".txt",sep=""),      # filename pattern
    recursive = FALSE,      # visit subdirectories?
    ignore.case = FALSE)    # ignore case in pattern?
  
  book_corpus <- Corpus(
    book_source, 
    readerControl = list(
      reader = readPlain, # read as plain text
      language = "en"))
  
  book_corpus <- tm_map(book_corpus, function(x) iconv(x, to='UTF-8-MAC', sub='byte'))
  book_corpus <- tm_map(book_corpus, tolower)
  
  book_corpus <- tm_map(
    book_corpus, 
    removePunctuation,
    preserve_intra_word_dashes = TRUE)
  
  book_corpus <- tm_map(
    book_corpus, 
    removeWords, 
    stopwords("english"))
  
#   book_corpus <- tm_map(
#     book_corpus, 
#     stemDocument,
#     lang = "porter") 
  
  book_corpus <- tm_map(
    book_corpus, 
    stripWhitespace)
  
  book_corpus <- tm_map(
    book_corpus, 
    removeWords, 
    c("will", "can", "get", "that", "year", "let","said"))
  
  book_tdm <- TermDocumentMatrix(book_corpus)
  
  book_matrix <- as.matrix(book_tdm)
  
  book_df <- data.frame(
    word = rownames(book_matrix), 
    # necessary to call rowSums if have more than 1 document
    freq = rowSums(book_matrix),
    stringsAsFactors = FALSE) 
  
  book_df <- book_df[with(
    book_df, 
    order(freq, decreasing = TRUE)), ]
  
  rownames(book_df) <- NULL
  
  
  #####
  # barplot
  
  bar_df <- head(book_df, 10)
  bar_df$word <- factor(bar_df$word, 
                        levels = bar_df$word, 
                        ordered = TRUE)
  
  p <- ggplot(bar_df, aes(x = word, y = freq)) +
     geom_bar(stat = "identity", fill = "grey60") +
     ggtitle(book_title) +
     xlab("Top 10 Word Stems (Stop Words Removed)") +
     ylab("Frequency") +
     theme_minimal() +
     scale_x_discrete(expand = c(0, 0)) +
     scale_y_continuous(expand = c(0, 0)) +
     theme(panel.grid = element_blank()) +
     theme(axis.ticks = element_blank())
  return(p)
}

#### SHINY SERVER ####

shinyServer(function(input, output) {
  cat("Press \'ESC\' to exit…\n")
  output$wordCloud <- renderPlot(
  {
  bar <- barplt(input$whichbk)
  print(bar)
  }
)
}
)



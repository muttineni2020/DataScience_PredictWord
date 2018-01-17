#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# VENKATA MUTTINENI
# 01/16/2018

library(SnowballC)
library(tm)
library(shiny)
library(stringi)
library(RWeka)
library(PredictWord)
library(dplyr)
library(ggplot2)
library(shinythemes)





# Clean the input
cleanInputPhrase <- function(phrase){

  inputPhrase <- tolower(phrase)
  inputPhrase <- removePunctuation(inputPhrase)
  inputPhrase <- removeNumbers(inputPhrase)
  #inputPhrase <- stri_replace_all(inputPhrase, "[^[:alnum:]]", " ")
  inputPhrase <- stripWhitespace(inputPhrase)
  #inputPhrase <- txt.to.words.ext(inputPhrase, language="English.all", preserve.case = TRUE)
  inputPhrase <- strsplit(inputPhrase," ")[[1]]
  return(inputPhrase)

}


# Get the predicted word
nextWordPredict <- function(phrase){

  # Cleaning the input
  phraseInput <- cleanInputPhrase(phrase)
  #Getting the number of words in the input
  wordCnt <- length(phraseInput)
  #Initializing response
  prediction <- c()

  #Trimming input to the last three words
  if(wordCnt>3)
  {
    phraseInput <- phraseInput[(wordCnt-2):wordCnt]
    prediction <- matchQuadGram(phraseInput[1],phraseInput[2],phraseInput[3])
  }

  #Four Gram Match
  if(wordCnt ==3)
  {
    prediction <- matchQuadGram(phraseInput[1],phraseInput[2],phraseInput[3])
  }

  #Three Gram Match
  if(wordCnt ==2)
  {
    prediction <- matchTriGram(phraseInput[1],phraseInput[2])
  }

  #Two gram match
  if(wordCnt ==1)
  {
    prediction <- matchBiGram(phraseInput[1])
  }

   #No word entered
    if(wordCnt == 0)
    {
      prediction <- "Please enter correct phrase/word to predict"
    }

  #Unknown words
  if(length(prediction)==0)
  {
    prediction <- matchUniGram()  #Oops!!! unfortunately  I was not able to make sense of what you told me
  }

  #Returning response
  if(length(prediction) < 5)
  {
    prediction
  }
  else
  {
    prediction[1:5]
  }

}


#Match string in Four Gram and get probable word
matchQuadGram <- function (iWord2,iWord3,iWord4){
  predictWord <- head(quadGram[quadGram[2]==iWord2&quadGram[3]==iWord3&quadGram[4]==iWord4,5],1)

  if(length(predictWord) == 0)
  {

    predictWord <- head(quadGram[quadGram[3]==iWord3&quadGram[4]==iWord4,5],1)

    if(length(predictWord) == 0)
    {
      predictWord <- head(quadGram[quadGram[2]==iWord3&quadGram[3]==iWord4,4],1)


      if(length(predictWord) ==0)
      {
        predictWord <- matchTriGram(iWord3,iWord4)
      }

    }

  }

  predictWord

}



#Match string in Three Gram and get probable word
matchTriGram <- function(iWord2,iWord3){
  predictWord <- head(triGram[triGram[2]==iWord2&triGram[3]==iWord3,4],1)
  if(length(predictWord)==0)
  {
    predictWord <- head(triGram[triGram[3]==iWord3,4],1)

    if(length(predictWord)== 0)
    {
      predictWord <- head(triGram[triGram[2]==iWord3,3],1)

      if(length(predictWord) ==0 )
      {
        predictWord <- matchBiGram(iWord3)
      }

    }
  }
  predictWord
}

#Match string in Two Gram and get probable word
matchBiGram <- function(iWord2){
  predictWord <-  head(biGram[biGram[2]==iWord2,3],1)

  predictWord

}

#Get most frequent term
 matchUniGram <- function(){

   predictWord <- "will" #head(unigramFreq$word[1],1)
   predictWord
 }

 #plot
 # makePlot <- function(data, label) {
 #     ggplot(data[1:30,], aes(reorder(word, -freq), freq)) +
 #         labs(x = label, y = "Frequency") +
 #         theme(axis.text.x = element_text(angle = 60, size = 12, hjust = 1)) +
 #         geom_bar(stat = "identity", fill="#00c0ef")
 #
 # }


# Define server logic to rednder output
shinyServer(
  function(input, output, session) {

  output$phrase <-

    renderText(
      if(input$phrase=="")
      {
        "Please enter phrase to predict next word"
      }
      else
      {
        input$phrase
      }

    )

  output$word <- #reactive(length(input$phrase))
     renderText(
       if(input$phrase=="")
       {
         "No input entered, Please type your input"
       }
       else
       {
         nextWordPredict(input$phrase)
       }

     )

  # output$uniplot <- renderPlot({
  #   uniGraph
  # })
  # #   renderPlot({
  # #
  # #     Sys.sleep(0.25)
  # #     makePlot(unigramFreq,"max = common unigrams")
  # #
  # # })
  # output$biplot <- renderPlot({
  #   biGraph
  # })
  # # renderPlot({
  # #
  # #     Sys.sleep(0.25)
  # #     makePlot(bigramFreq,"30 most common unigrams")
  # # })
  # output$triplot <- renderPlot({
  #   triGraph
  # })
  # # renderPlot({
  # #
  # #
  # #     Sys.sleep(0.25)
  # #     makePlot(trigramFreq,"30 most common unigrams")
  # # })

})

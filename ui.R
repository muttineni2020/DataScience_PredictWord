#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# VENKATA MUTTINENI
# 01/16/2018

library(shiny)
library(shinythemes)
library(shinycssloaders)

# Define UI for application that draws a histogram

shinyUI(
  ui=tagList(
    fluidPage(theme = shinytheme("cerulean"),

              # Application title
              #titlePanel("Word Prediction",list(tags$head(tags$style("h2 {background-color: #E95420 !important; }")))),
##E95420##00c0ef
              # Header panel with word prediction
              headerPanel("Word Prediction",list(tags$head
                                                 (
                                                   tags$style(".col-sm-12 {background-color:#17a2b8 !important; text-align:center; color:white }
                                                              #txt {text-align:right;}"),
                                                   #tags$link(rel = "stylesheet", type = "text/css", href = "boot.css"),
                                                   tags$link(rel="stylesheet", type="text/css", href="united.css")))),
              tags$h2("Venkata Muttineni",class="text-info",id="txt"),
              sidebarLayout(

                sidebarPanel(

                  textInput("phrase", "Please enter phrase to predict next word")
                  #sliderInput("slider", "Slider input:", 1, 100, 30),
                 # actionButton("predictButton", "Predict next word", class = "btn-primary btn-lg")

#border-primary
                ),

                # Main panel withmultiple out puts listed.
                mainPanel(

                  tabsetPanel(
                    tabPanel("Word Prediction",
                             tags$br(),
                             tags$br(),
                             tags$br(),
                             tags$div(class="card mb-3",
                                      tags$div(class="card-header",
                                               tags$h4("Entered Input :",class="text-primary")),
                                               tags$div(class="card-body text-info",

                                                        tags$h3(textOutput("phrase"),class="card-title")

                                               )
                             ),
                            tags$br(),
                             tags$div(class="card mb-3",
                                      tags$div(class="card-header",
                                               tags$h4("Predicted Word :",class="text-primary")),
                                               tags$div(class="card-body text-info",

                                                        tags$h3(textOutput("word"),class="card-title")
                                               )
                             )


                    )
                    # tabPanel("Ngram Model",
                    #          tags$div(
                    #             tags$h2("Ngram Model", class="text-info"),
                    #             tags$p("N-Grams is a word prediction algorithm using probabilistic methods
                    #                    to predict next word after observing N-1 words.  Therefore, computing
                    #                    the probability of the next word is closely related to computing the probability of a sequence of words.
                    #                    An n-gram of size 1 is referred to as a Uni-Gram, size 2 is a Bi-Gram, size 3 is a Tri-Gram.")
                    #          ),
                    #     #tags$div(class="progress",
                    #       # tags$div(class="progress-bar progress-bar-striped progress-bar-animated",
                    #          tags$div(
                    #            tags$h3("Tri-Gram model",class="text-info"),
                    #            tags$p("N-Grams size of THREE.")
                    #
                    #          ),
                    #
                    #          tags$div(
                    #              withSpinner(plotOutput("triplot"))
                    #          ),
                    #          tags$div(
                    #              tags$h3("Bi-Gram model",class="text-info"),
                    #              tags$p("N-Grams size of TWO.")
                    #          ),
                    #          tags$div(
                    #              withSpinner(plotOutput("biplot"))
                    #          ),
                    #          tags$div(
                    #              tags$h3("Uni-Gram model",class="text-info"),
                    #              tags$p("N-Grams size of ONE.")
                    #          ),
                    #          tags$div(
                    #             withSpinner(plotOutput("uniplot"))
                    #          )
                    #        #)
                    #     #)
                    # )
                  )
                )
              )

    )
  )
)

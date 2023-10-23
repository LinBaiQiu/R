
library(shiny)
library(rhandsontable)


data <- data.frame(
  Question = c(
    "What is your favorite color?",
    "How did you get into this field?",
    "What are your strengths and weaknesses?",
    "Can you describe a challenging project you've worked on?",
    "Where do you see yourself in five years?"
  ),
  Answer = c(
    "My favorite color is blue.",
    "I got into this field through my passion for coding.",
    "My strengths include problem-solving and teamwork, while my weakness is public speaking.",
    "I once worked on a complex software project that required extensive debugging.",
    "In five years, I hope to be in a leadership role within the company."
  )
)


ui <- fluidPage(
  titlePanel("Interview Questions and Answers"),
  rHandsontableOutput("table")
)


server <- function(input, output) {
  output$table <- renderRHandsontable({
    rhandsontable(data)
  })
}


shinyApp(ui, server)

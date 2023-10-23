install.packages("shiny")
library(shiny)


questions <- c(
  "Question 1: What is your favorite color?",
  "Question 2: How did you get into this field?",
  "Question 3: What are your strengths and weaknesses?",
  "Question 4: Can you describe a challenging project you've worked on?",
  "Question 5: Where do you see yourself in five years?"
)

answers <- c(
  "Answer 1: My favorite color is blue.</br>
   Answer 1: My favorite color is blue.",
  "Answer 2: I got into this field through my passion for coding.",
  "Answer 3: My strengths include problem-solving and teamwork, while my weakness is public speaking.",
  "Answer 4: I once worked on a complex software project that required extensive debugging.",
  "Answer 5: In five years, I hope to be in a leadership role within the company."
)


ui <- fluidPage(
  titlePanel("Interview Questions and Answers"),
  actionButton("nextQuestion", "Next Question"),
  verbatimTextOutput("questionText"),
  verbatimTextOutput("answerText")
)


server <- function(input, output) {
  currentQuestion <- reactiveVal(1)
  
  observeEvent(input$nextQuestion, {
    if (currentQuestion() < length(questions)) {
      currentQuestion(currentQuestion() + 1)
    } else {
      showModal(
        modalDialog(
          title = "End of Questions",
          "You have reached the end of the interview questions.",
          footer = modalButton("OK")
        )
      )
    }
  })
  
  output$questionText <- renderText({
    questions[currentQuestion()]
  })
  
  output$answerText <- renderText({
    answers[currentQuestion()]
  })
}


shinyApp(ui, server)

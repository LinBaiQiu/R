# Load the 'shiny' package if not already loaded
if (!require(shiny)) {
  install.packages("shiny")
  library(shiny)
}

# Define the UI for the Shiny app
ui <- fluidPage(
  titlePanel("Random Winner Picker for Focus Group Interview Question"),
  actionButton("pickWinner", "Pick a Winner"),
  verbatimTextOutput("winnerOutput")
)

# Define the server logic for the app
server <- function(input, output) {
  students <- list(
    list(ID = 101, Name = "Alice"),
    list(ID = 102, Name = "Bob"),
    list(ID = 103, Name = "Charlie"),
    list(ID = 104, Name = "David")
  )

  observeEvent(input$pickWinner, {
    # Check if there are students left to select
    if (length(students) == 0) {
      winner <- "No more students to select."
    } else {
      # Randomly select a student
      selected_index <- sample(1:length(students), 1)
      selected_student <- students[[selected_index]]
      students <- students[-selected_index]

      # Prepare the message for the winner
      winner <- paste(
        "<span style='color: red; font-weight: bold;'>Winner:</span><br>",
        selected_student$Name
      )

      # Show a modal dialog with the winner's name
      showModal(
        modalDialog(
          title = "Winner",
          HTML(winner),
          footer = NULL,
          easyClose = TRUE,
          style = "background-color: lightblue;"
        )
      )
    }
  })

}

# Run the Shiny app
shinyApp(ui, server)

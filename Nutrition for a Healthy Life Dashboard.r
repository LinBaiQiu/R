# Load required libraries
library(shiny)   # For creating Shiny apps
library(DT)      # For interactive data tables
library(ggplot2) # For data visualization

# Sample data
sample_data <- data.frame(
  FoodName = c("Apple", "Banana", "Carrot", "Chicken", "Salmon"),
  FoodCategory = c("Fruits", "Fruits", "Vegetables", "Proteins", "Proteins"),
  Calories = c(52, 89, 41, 335, 206),
  Protein = c(0.3, 1.1, 0.9, 25.0, 22.0)
)

# Define UI for the Shiny app
ui <- fluidPage(
  # Application title
  titlePanel("Nutrition for a Healthy Life Dashboard"),
  
  # Sidebar layout with input and output
  sidebarLayout(
    # Sidebar panel
    sidebarPanel(
      # Widgets for user interaction
      selectInput("category", "Select Food Category:",
                  choices = c("All", "Fruits", "Vegetables", "Proteins"))
      # You can add more widgets here as needed
    ),
    
    # Main panel with outputs
    mainPanel(
      # Display visualizations and data tables
      plotOutput("bar_chart"), # Bar chart
      DTOutput("data_table")   # Interactive data table
      # You can add more outputs here as needed
    )
  )
)

# Define server logic for the Shiny app
server <- function(input, output) {
  # Create a reactive data subset based on user input
  filtered_data <- reactive({
    if (input$category == "All") {
      return(sample_data)  # Use sample_data if category is "All"
    } else {
      return(sample_data[sample_data$FoodCategory == input$category, ])
    }
  })
  
  # Render a bar chart based on the filtered data
  output$bar_chart <- renderPlot({
    ggplot(filtered_data(), aes(x = FoodName, y = Calories, fill = FoodCategory)) +
      geom_bar(stat = "identity") +
      labs(title = "Calories by Food Name", x = "Food Name", y = "Calories")
  })
  
  # Render an interactive data table based on the filtered data
  output$data_table <- renderDT({
    datatable(filtered_data(), options = list(pageLength = 10))
  })
}

# Run the Shiny app
shinyApp(ui, server)

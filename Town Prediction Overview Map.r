install.packages("leaflet")
library(leaflet)

# Load necessary libraries
if (!require(shiny)) install.packages("shiny")
if (!require(leaflet)) install.packages("leaflet")  # Add this line
library(shiny)
library(leaflet)  # Add this line

# Sample data (replace with your actual data)
bike_data <- data.frame(
  lat = c(51.5074, 40.7128, 34.0522),
  lon = c(-0.1278, -74.0060, -118.2437),
  prediction = c(10, 15, 8),
  city = c("London", "New York", "Los Angeles")
)

# Define UI
ui <- fluidPage(
  titlePanel("Max Bike Prediction Overview"),
  selectInput("selected_city", "Select a City:", choices = unique(bike_data$city)),
  leafletOutput("bikeMap")
)

# Define server
server <- function(input, output) {
  output$bikeMap <- renderLeaflet({
    selected_city <- input$selected_city
    filtered_data <- subset(bike_data, city == selected_city)
    
    leaflet() %>%
      addTiles() %>%
      addCircleMarkers(
        data = filtered_data,
        lat = ~lat,
        lng = ~lon,
        label = ~prediction,
        radius = ~prediction * 2
      )
  })
}

# Run the Shiny app
shinyApp(ui, server)

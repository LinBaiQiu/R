# Load necessary libraries
if (!require(shiny)) install.packages("shiny")
if (!require(plotly)) install.packages("plotly")
library(shiny)
library(plotly)

# Sample data (replace with your actual data)
bike_data <- data.frame(
  date = seq(as.Date("2023-01-01"), as.Date("2023-12-31"), by = "days"),
  demand = rnorm(365, mean = 100, sd = 20)  # Replace with your demand prediction values
)

temperature_data <- data.frame(
  date = seq(as.Date("2023-01-01"), as.Date("2023-12-31"), by = "days"),
  temperature = rnorm(365, mean = 25, sd = 5)  # Replace with your temperature values
)

humidity_data <- data.frame(
  date = seq(as.Date("2023-01-01"), as.Date("2023-12-31"), by = "days"),
  humidity = rnorm(365, mean = 60, sd = 10)  # Replace with your humidity values
)

# Shiny App to display all plots
ui <- fluidPage(
  titlePanel("Data Visualization"),
  plotlyOutput("bike_plot"),
  plotOutput("temperature_plot"),
  plotOutput("correlation_plot")
)

server <- function(input, output) {
  # Create an interactive bike-sharing demand prediction trend line (Plotly)
  output$bike_plot <- renderPlotly({
    plot_ly(data = bike_data, x = ~date, y = ~demand, type = 'scatter', mode = 'lines') %>%
      layout(title = "Bike-Sharing Demand Prediction Trend",
             xaxis = list(title = "Date"),
             yaxis = list(title = "Demand"))
  })

  # Create a static temperature trend line (ggplot2)
  output$temperature_plot <- renderPlot({
    ggplot(temperature_data, aes(x = date, y = temperature)) +
      geom_line() +
      labs(title = "Temperature Trend",
           x = "Date",
           y = "Temperature (°C)")
  })

  # Create a static humidity and bike-sharing demand prediction correlation plot (ggplot2)
  combined_data <- merge(bike_data, humidity_data, by = "date")
  output$correlation_plot <- renderPlot({
    ggplot(combined_data, aes(x = humidity, y = demand)) +
      geom_point() +
      geom_smooth(method = "lm", se = FALSE, color = "blue") +
      labs(title = "Humidity vs. Bike-Sharing Demand Correlation",
           x = "Humidity (%)",
           y = "Demand")
  })
}

shinyApp(ui, server)

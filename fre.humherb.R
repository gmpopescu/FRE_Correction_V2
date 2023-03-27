# This code defines a shiny app with a UI and server component.
# This app's purpose is to help user correct the freshwater reservoir effect of radiocarbon dates, 
# when paired human-herbivore sample based dates, from the same archaeological context, (same burial,
# house, supply pit, hearth or other dwelling structures), are securely connected.
# The UI component contains input widgets for the variables that the user must upload (see the code
# below and read the readme file for more details).
# The server component calculates the FRE offset and the FRE offset, percentage of aquatic diet, and 
# the corrected 14C date and standard deviation, and generates the output plot and table output. 
# To run the app, save the code as a .R file and run it in RStudio or any R environment that supports
# Shiny applications.

# Install (if not already installed) and load the required packges.
# install.packages("shiny")
# install.packages("readr")

# library(shiny)
# library(readr)

# # Define the UI and its components.
ui <- fluidPage(
  titlePanel("Freshwater Reservoir Effect correction of radiocarbon dates for \n human-herbivore
             paired dates"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("herbivore_date", "Herbivore 14C date", NULL),
      numericInput("herbivore_sd", "Herbivore 14C date standard deviation", NULL),
      numericInput("human_date", "Human 14C date", NULL),
      numericInput("human_sd", "Human 14C date standard deviation", NULL),
      numericInput("C13_herbivore", "Carbon 13 stable isotope value (herbivore)", NULL),
      numericInput("C13_human", "Carbon 13 stable isotope value (human)", NULL),
      numericInput("N15_herbivore", "Nitrogen 15 stable isotope value (herbivore)", NULL),
      numericInput("N15_human", "Nitrogen 15 stable isotope value (human)", NULL),
      numericInput("C13_terrestrial", "Carbon 13 stable isotope value (100% terrestrial diet)", NULL),
      numericInput("C13_aquatic", "Carbon 13 stable isotope value (100% aquatic diet)", NULL),
      numericInput("N15_terrestrial", "Nitrogen 15 stable isotope value (100% terrestrial diet)", NULL),
      numericInput("N15_aquatic", "Nitrogen 15 stable isotope value (100% aquatic diet)", NULL),
      actionButton("calculate", "Calculate")
    ),
    mainPanel(
      plotOutput("plot"),
      tableOutput("table")
    )
  )
)

# Perform the calculations for the FRE correction.
server <- function(input, output, session) {
  
  observeEvent(input$file, {
    data <- read_csv(input$file$datapath)
    updateNumericInput(session, "herbivore_date", value = data$herbivore_date)
    updateNumericInput(session, "herbivore_sd", value = data$herbivore_sd)
    updateNumericInput(session, "human_date", value = data$human_date)
    updateNumericInput(session, "human_sd", value = data$human_sd)
    updateNumericInput(session, "C13_herbivore", value = data$C13_herbivore)
    updateNumericInput(session, "C13_human", value = data$C13_human)
    updateNumericInput(session, "N15_herbivore", value = data$N15_herbivore)
    updateNumericInput(session, "N15_human", value = data$N15_human)
    updateNumericInput(session, "C13_terrestrial", value = data$C13_terrestrial)
    updateNumericInput(session, "C13_aquatic", value = data$C13_aquatic)
    updateNumericInput(session, "N15_terrestrial", value = data$N15_terrestrial)
    updateNumericInput(session, "N15_aquatic", value = data$N15_aquatic)
  })
  
  observeEvent(input$calculate, {
    # Perform calculations
    offset <- input$human_date - input$herbivore_date
    offset_sd <- sqrt(input$herbivore_sd^2 + input$human_sd^2)
    aquatic_diet <- (input$N15_human - input$N15_terrestrial) / (input$N15_aquatic - input$N15_terrestrial)
    correction_sd <- offset_sd * aquatic_diet
    corrected_date <- input$human_date - (aquatic_diet * offset)
    corrected_date_sd <- sqrt(input$human_sd^2 + correction_sd^2)
    # Store results in a data frame
    results <- data.frame(FRE_offset = offset,
                          FRE_offset_sd = offset_sd,
                          Aquatic_diet = aquatic_diet,
                          Corrected_14C = corrected_date,
                          Corrected_14C_SD = corrected_date_sd)
    
    # Update the output table
    output$table <- renderTable(results)
    
    # Update the output plot
    output$plot <- renderPlot({
      plot(results$Corrected_14C,
           main = "FRE Corrected Radiocarbon Dates",
           xlab = "Sample Index",
           ylab = "Corrected 14C Date",
           ylim = c(min(results$Corrected_14C - 2 * results$Corrected_14C_SD),
                    max(results$Corrected_14C + 2 * results$Corrected_14C_SD)),
           pch = 19, cex = 2, col = "red")
      
      # Add error bars
      segments(x0 = 1:length(results$Corrected_14C),
               y0 = results$Corrected_14C - results$Corrected_14C_SD,
               x1 = 1:length(results$Corrected_14C),
               y1 = results$Corrected_14C + results$Corrected_14C_SD)
    })
  })
}

# Run the Shiny app for the correction of FRE.
shinyApp(ui = ui, server = server)


# This Shiny application allows you to input data one by one or upload a CSV file with the required 
# columns. After you click the "Calculate" button, the app will perform the FRE correction using 
# the offset method and display the corrected radiocarbon dates in a table and a plot.

    
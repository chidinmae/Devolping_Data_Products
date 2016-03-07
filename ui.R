library(shiny)

# Define UI for debt management application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Debt Management"),
  
  sidebarPanel(
    numericInput("amount", "Amount to pay back:", 1000.00,min=0,step=100),
    numericInput("term", "Term Length in months:", 48, min=1, max=360, step=12),
    numericInput("rate", "Interest Rate per year %:", 5.0, min=0.1, max=100, step=0.1),
    dateInput("start_dt", "Loan Start Date:", Sys.Date())
  ),
  
  mainPanel(
    h2("Loan Summary"),
    h4("Total Paid:"),
    verbatimTextOutput("tot_payment"),
    h4("Total Paid in Interest:"),
    verbatimTextOutput("tot_interest"),
    h2("Amortization Schedule"),
    tableOutput("schedule")
  )
))
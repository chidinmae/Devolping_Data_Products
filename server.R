library(shiny)

# Define server logic required to display interest and principal payments over the duration 
# of the loan
shinyServer(function(input, output) {
  
  schedule <- reactive({
    worksheet <- data.frame(
      Period = format(seq.Date(input$start_dt,by="month",length.out = input$term),"%B %Y"),
      Payment = round(input$amount*((input$rate/1200)/(1-(1+(input$rate/1200))^-input$term)),digits=2),
      Towards_Interest = NA,
      Towards_Principal = NA,
      Balance = input$amount
    )
    running_balance <- input$amount
    
    for(index in 1:nrow(worksheet)){
      row <- worksheet[index,]
      row[3] <- running_balance*input$rate/1200
      row[4] <- row[2] - row[3]
      if(running_balance < row[4])
        {
          row[4] <- running_balance
          row[2] <- running_balance
          running_balance <- running_balance - row[4]
        } else {
          running_balance <- running_balance - row[4]
        }
      row[5] <- running_balance
      worksheet[index,] <- row
      }
    
    worksheet
  })

  output$schedule <- renderTable({
    schedule()
  })
  
  output$tot_interest <- renderPrint({
    
    Total_Interest <- sum(schedule()[,3])
    Total_Interest
  })
  
  output$tot_payment <- renderPrint({
    
    Total_Payment <- sum(schedule()[,2])
    Total_Payment
  })
  
})


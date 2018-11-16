
library(shiny)
library(ggplot2)
library(plotly)
library(readxl)

function(input, output) {
  
 
  # display 10 rows initially
  output$ex1 <- DT::renderDataTable(DT::datatable({
    data <- crim_bind
    if (input$ct != "All") {
      data <- data[data$count == input$ct,]
    }
    if (input$wanted_by != "All") {
      data <- data[data$wanted_by == input$wanted_by,]
    }
    if (input$sex != "All") {
      data <- data[data$sex == input$sex,]
    }
    if (input$age_bin != "All") {
      data <- data[data$age_bin == input$age_bin,]
    }
    data
  }))
  
  output$ex2 <- DT::renderDataTable(DT::datatable({
    data <- crim_gather
    if (input$Nature != "All") {
      data <- data[data$Nature == input$Nature,]
    }
    if (input$Status != "All") {
      data <- data[data$Status == input$Status,]
    }
    data
  }))
  

  # -1 means no pagination; the 2nd element contains menu labels
  output$plot1 <- renderPlotly({
    plotly::ggplotly(ggplot(crim_bind, aes(sex)) +
                       geom_bar(fill = "tomato2") +
                       labs(x= "Gender", y = "Count", title = "Interpol Gender Metrics"))
  })
  
  
  # you can also use paging = FALSE to disable pagination
  output$plot2 <- renderPlotly({
    plotly::ggplotly(ggplot(crime_count_df, aes(reorder(word, Frequency), Frequency, fill = Frequency, text = word)) +
                       geom_bar(stat = "identity") +
                       coord_flip() +
                       scale_fill_gradient(low="yellow", high="red") +
                       labs(y = "Crime Count", x = "Nature of Crime"))
  })
  
  # turn off filtering (no searching boxes)
  output$plot3 <- renderPlotly({
    plotly::ggplotly(ggplot(crim_bind, aes(factor(count))) +
      geom_bar(fill = "tomato2") +
      labs(x = "above figure illustrates the no. of crimes committed by all criminals", y= "crime count"))
  })
  
  
  output$plot4 <- renderPlotly({
    plotly::ggplotly(ggplot(wanted_count, aes(reorder(wanted_by, count_1), count_1, fill = sex)) +
                       geom_bar(stat = "identity", color = "white", position = "stack") +
                       labs(x= "Wanted By Country", y = "Criminal Count", title = "Wanted-by Vs. Criminals") +
                       coord_flip())
  })
  output$plot5 <- renderPlotly({
    plotly::ggplotly(ggplot(crim_bind, aes(age_bin)) +
                       geom_bar(fill = "tomato2") +
                       labs(x= "Age", y = "Count", title = "Interpol Age Metrics"))
    
  })
  output$plot6 <- renderPlotly({
    gen_nat <- crim_gather %>%
      select(Nature, sex) %>%
      group_by(Nature, sex) %>%
      summarise(cnt = n())
    
    plotly::ggplotly(ggplot(gen_nat, aes(Nature, cnt, fill = sex)) +
                       geom_bar(stat = "identity", color = "white", position = "dodge") +
                       labs(x= "Crime", y = "Count", title = "Interpol Crime Vs. Gender Metrics") +
                       coord_flip())
    
  })
  output$plot7 <- renderPlotly({
    plotly::ggplotly(ggplot(crim_gather, aes(Nature, ..count..)) +
                       geom_bar(aes(fill = age_bin), position = "dodge") +
                       labs(x= "Crime", y = "Count", title = "Interpol Crime Vs. Age Metrics") +
                       coord_flip())
})
}




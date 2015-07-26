library(lubridate)
  ageCurCal <- function(dob) year(Sys.Date()) - year(dob)

library(shiny)
  shinyServer(
    function(input, output){
      n <- reactive({input$ageRet - ageCurCal(input$dob)})
      CBin <- reactive({input$IFplot})
      sal <- reactive({input$salI})
      pf <- reactive({input$pfI})
      IF <- reactive({input$IFI})
      IFselInput <- reactive({
            switch(input$IFsel, "Low RoI Less Volatile" = "IF1", "Moderate RoI Medium Volatile" = "IF2", "Heavy RoI High Volatile" = "IF3")
        })
      output$IFContMon <- renderPrint({
        IFopt <- IFselInput()
        if (IFopt == "IF1") {
          contMon <- 3000
        } else if (IFopt == "IF2") {
          contMon <- 5000
        } else {
          contMon <- 7000
        }
        return(contMon)
      })
      output$RoI <- renderPlot({
        if (CBin() == FALSE) {
          
        } else {
          IFopt <- IFselInput()
          if (IFopt == "IF1") {
            set.seed(123)
            RoIF <- rep(13, n()) + rnorm(n(), 0, 3)
          } else if (IFopt == "IF2") {
            set.seed(1234)
            RoIF <- rep(15, n()) + rnorm(n(), 0, 5)
          } else {
            set.seed(12345)
            RoIF <- rep(17, n()) + rnorm(n(), 0, 7)
          }
          plot(RoIF, col = "red", type = "l", xlab = "Year in Service", ylab = "Rate of Interest")
        }
        #return(RoIF)
      })
      output$sav <- renderPrint({
        IFopt <- IFselInput()
        if (IFopt == "IF1") {
          contMon <- 3000
          set.seed(123)
          RoIA <- rep(13, n()) + rnorm(n(), 0, 3)
        } else if (IFopt == "IF2") {
          contMon <- 5000
          set.seed(1234)
          RoIA <- rep(15, n()) + rnorm(n(), 0, 5)
        } else {
          contMon <- 7000
          set.seed(12345)
          RoIA <- rep(17, n()) + rnorm(n(), 0, 7)
        }
        pfCal <- pf()
        IFCal <- IF()
        salCal <- sal()
        RoICal <- RoIA
        IFContCal <- contMon
        for (i in 1:n()){
          #pfCal <- RoICal[i]
          pfCal <- (0.12 * 0.4 * salCal + pfCal) * 1.08
          IFCal <- (12 * IFContCal + IFCal) * (1 + 0.01 * RoICal[i]) 
          # print(IF)
          salCal <- salCal + 0.05 * salCal
          #ssavV[i] <- pfCal + IFCal
          }
        savO <- pfCal + IFCal
        #savO <- RoICal
        return(savO)
      })
      output$savP <- renderPlot({
        IFopt <- IFselInput()
        if (IFopt == "IF1") {
          contMon <- 3000
          set.seed(123)
          RoIA <- rep(13, n()) + rnorm(n(), 0, 3)
        } else if (IFopt == "IF2") {
          contMon <- 5000
          set.seed(1234)
          RoIA <- rep(15, n()) + rnorm(n(), 0, 5)
        } else {
          contMon <- 7000
          set.seed(12345)
          RoIA <- rep(17, n()) + rnorm(n(), 0, 7)
        }
        pfCal <- pf()
        IFCal <- IF()
        salCal <- sal()
        RoICal <- RoIA
        IFContCal <- contMon
        savV <- c()
        for (i in 1:n()){
          #pfCal <- RoICal[i]
          pfCal <- (0.12 * 0.4 * salCal + pfCal) * 1.08
          IFCal <- (12 * IFContCal + IFCal) * (1 + 0.01 * RoICal[i]) 
          # print(IF)
          salCal <- salCal + 0.05 * salCal
          savV[i] <- pfCal + IFCal
        }
        plot(savV, col = "blue", type = "l", xlab = "Year in Service", ylab = "Savings")
        #return(savV)
      })
      output$term <- renderPrint({n()})
      output$yourAge <- renderPrint({ageCurCal(input$dob)})
    })
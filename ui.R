library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Predict your Future: Your Savings when you Retire!"), 
  sidebarPanel(
    sliderInput("salI", "Current Salary:", min = 500000, max = 2500000, value = 700000, step = 50000),
    numericInput("pfI", "Current Provident Fund Balance:", min = 0, max = 100000, value = 0, step = 1000),
    numericInput("IFI", "Current Investment Fund Balance:", min = 0, max = 100000, value = 0, step = 1000),
    selectInput("IFsel", "Select Investment Fund:", choices =  c("Low RoI Less Volatile" , "Moderate RoI Medium Volatile" , "Heavy RoI High Volatile")),
    checkboxInput("IFplot", "Plot Investment Fund", FALSE),
    dateInput("dob", "Date of Birth:"),
    numericInput("ageRet", "Retirement Age:", min = 20, max = 70, value = 60),
    submitButton("Submit")
    ),
  mainPanel(
    h3("Let's see what your future beholds!!"),
    h4("Your age is:"),
    verbatimTextOutput("yourAge"),
    h4("Yours years left in Service:"),
    verbatimTextOutput("term"),
    h4("You selected Investment Fund which requires monthly contribution of:"),
    verbatimTextOutput("IFContMon"),
    h4("Expected RoI for the selected fund"),
    plotOutput("RoI"),
    #verbatimTextOutput("RoI"),
    h4("Your savings:"),
    verbatimTextOutput("sav")
  )
))
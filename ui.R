library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Predict your Future: Your Savings when you Retire!"), 
  sidebarPanel(
    sliderInput("salI", "Current Annual Salary:", min = 500000, max = 2500000, value = 700000, step = 50000),
    numericInput("pfI", "Current Provident Fund Balance:", min = 0, max = 100000, value = 0, step = 1000),
    numericInput("IFI", "Current Investment Fund Balance:", min = 0, max = 100000, value = 0, step = 1000),
    selectInput("IFsel", "Select Investment Fund:", choices =  c("Low RoI Less Volatile" , "Moderate RoI Medium Volatile" , "Heavy RoI High Volatile")),
    checkboxInput("IFplot", "Plot Investment Fund", FALSE),
    dateInput("dob", "Date of Birth:"),
    numericInput("ageRet", "Retirement Age:", min = 20, max = 70, value = 60),
    submitButton("Submit"),
    h6("App design based on INR and Indian Context"),
    h6("Provident Fund is the Govt. scheme"),
    h6("Investment Fund for additional savings and growth"),
    h6("12% of 40% of Salary gets deposited in PF by default"),
    h6("8% interest on PF every year"),
    h6("3 different investment funds available with varying deposit and Rate of Interest"),
    h6("Savings are calculated based on PF and IF balance including interest at the time of Retirement")
    ),
  mainPanel(
    h3("Let's see what your future beholds!!"),
    h4("Your age is:"),
    verbatimTextOutput("yourAge"),
    h4("Yours years left in Service:"),
    verbatimTextOutput("term"),
    h4("You selected Investment Fund which requires monthly contribution of:"),
    verbatimTextOutput("IFContMon"),
    h4("Expected Rate of Interest change for the selected fund"),
    plotOutput("RoI"),
    h4("Your savings:"),
    verbatimTextOutput("sav"),
    h4("This is how your savings grow:"),
    plotOutput("savP")
  )
))
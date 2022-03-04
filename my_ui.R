library(ggplot2)
library(plotly)
library(bslib)

climate_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

intro_tab <- tabPanel(
  "Introduction",
  fluidPage(theme = bs_theme(primary = "#091F43", font_scale = NULL, bootswatch = "cerulean"),
    h1("Introduction"),
    p("In this project, I've chosen to analyze ___ in my Shiny app to ____"),
    h3("Who collected the data?"),
    p("The data was collected by Our World in Data, an online publication that focuses on large problems affecting the world, such as poverty, disease, and climate change."),
    h3("How was the data collected or generated?"),
    p("The data is collected from four main sources: specialized institutes, research articles, international institutions/statistical agencies, and official government sources. Some examples of these sources would be UN institutions, the Peace Research Institute Oslo, and the World Bank."),
    h3("Why was the data collected?"),
    p("The data was collected to make use of preexisting research and data in an accessible way so that it progress can be made on the world's largest problems. A few issues that OWID seeks to solve are paywalls, jargon, and outdated data."),
    h3("What are possible limitations or problems with this data?"),
    p("The data contains many NA values, limiting the conclusions that can be drawn from it. Because of this, I have to be aware of when assumptions are made when cleaning and analyzing the data.
        As a result of being removed from the collection of the data, I need to make sure that I don't suppress voices or exclude key information just to emphasize clarity and cleanliness in my visualizations.
        Finally, the data's country column contains more than just countries - World, Africa, and Asia are all examples of this mislabeling, something I'll have to account for in my analysis."),
    p("Through analyzing the data, "),
  )
)

plot_sidebar <- sidebarPanel(
  selectInput(
    inputId = "user_category",
    label = "Select Country",
    choices =  climate_data$country,
    selected = "United States",
    multiple = TRUE)
)

plot_main <- mainPanel(
  plotlyOutput(outputId = "climatePlot")
)

plot_tab <- tabPanel(
  "Interactive Visualization",
  sidebarLayout(
    plot_sidebar,
    plot_main
  )
)

value_tab <- tabPanel(
  "Value Sensitive Design",
  fluidPage(theme = bs_theme(primary = "#091F43", font_scale = NULL, bootswatch = "cerulean"),
    p("Prompt: Envision your system in use by a single stakeholder. Now imagine 100 such individuals interacting with the system. Then 1,000 individuals. Then 100,00. What new interactions might emerge from widespread use? Find three synergistic benefits of widespread use and three potential breakdowns.")
  )
)


ui <- navbarPage(
  "Climate Change",
  intro_tab,
  plot_tab,
  value_tab
)

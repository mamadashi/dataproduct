shinyUI(fluidPage(
  titlePanel("Palette builder"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose file to upload',
                accept = c(
                  '.jpg'
                )
      ),
      imageOutput("image1",width=50, height=50),
      
      tags$hr(),
      sliderInput("psize", label = h4("Palette size"),
                  min = 3, max = 10, value = 5),
      
      checkboxInput("m1", label = "K-means", value = TRUE),
      checkboxInput("m2", label = "Ward Hierarchical with euclidean dist", value = FALSE),
      checkboxInput("m3", label = "Ward Hierarchical with canberra dist", value = FALSE),
      checkboxInput("m4", label = "Ward Hierarchical with manhattan dist", value = FALSE),
      checkboxInput("m5", label = "Ward Hierarchical with maximum dist", value = FALSE),
      checkboxInput("m6", label = "Ward Hierarchical with minkowski dist", value = FALSE),
      
      tags$hr(),
      
      actionButton("goButton", "Go!")
     
     
     
    ),
    mainPanel( 
      plotOutput("plot")
      
    )
  )
))
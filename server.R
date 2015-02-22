# By default, the file size limit is 5MB.
options(shiny.maxRequestSize = 9*1024^2)

shinyServer(function(input, output, session) {
 
  library(jpeg)
  library(grid)
  colors <- data.frame()
  
  # hierarchical clustering
  clust.centroid = function(i, dat, clusters) {
    ind = (clusters == i)
    colMeans(dat[ind,])
  }
  
  palette.1 <- function(clastersNum){
    fit1 <- kmeans(colors, clastersNum)
    palette1 <-fit1$centers
    palette1M <- rgb(palette1[,1], palette1[,2], palette1[,3])
  }
  
  palette.2 <- function(clastersNum){
    d <- dist(colors, method = "euclidean")# 
    fit <- hclust(d, method="ward.D") 
    groups <- cutree(fit, k=clastersNum)
    palette <- sapply(unique(groups), clust.centroid, colors, groups)
    paletteM <- rgb(palette[1,], palette[2,], palette[3,])
  }
   
   
  palette.3 <- function(clastersNum){
    d <- dist(colors, method = "canberra")# 
    fit <- hclust(d, method="ward.D") 
    groups <- cutree(fit, k=clastersNum)
    palette <- sapply(unique(groups), clust.centroid, colors, groups)
    paletteM <- rgb(palette[1,], palette[2,], palette[3,])
  }
  
  palette.4 <- function(clastersNum){
    d <- dist(colors, method = "manhattan")
    fit <- hclust(d, method="ward.D") 
    groups <- cutree(fit, k=clastersNum)
    palette <- sapply(unique(groups), clust.centroid, colors, groups)
    paletteM <- rgb(palette[1,], palette[2,], palette[3,])
  }
  palette.5 <- function(clastersNum){
    d <- dist(colors, method = "maximum")
    fit <- hclust(d, method="ward.D") 
    groups <- cutree(fit, k=clastersNum)
    palette <- sapply(unique(groups), clust.centroid, colors, groups)
    paletteM <- rgb(palette[1,], palette[2,], palette[3,])
  }
  palette.6 <- function(clastersNum){
    d <- dist(colors, method = "minkowski")
    fit <- hclust(d, method="ward.D") 
    groups <- cutree(fit, k=clastersNum)
    palette <- sapply(unique(groups), clust.centroid, colors, groups)
    paletteM <- rgb(palette[1,], palette[2,], palette[3,])
  }
  

  output$image1 <- renderImage({
    
    image <- readJPEG(input$file1$datapath)
    cs<- data.frame()
    cs<- cbind(r = c(image[,,1]))
    cs<- cbind(cs, g = c(image[,,2]))
    cs<- cbind(cs, b = c(image[,,3]))
    colors <<- cs
    
    list(src = input$file1$datapath,
         contentType = 'image/jpeg',
         width = 50,
         height = 50,
         alt = "your image")
  })
  
  
  
  output$plot <- renderPlot({
    
    input$goButton 
    num <-0; 
    pp <- c();
    if(input$m1)
    {
      p1 <- palette.1(input$psize);
      pp <- c(pp, p1);
      num<-num +1;
    }
    if(input$m2)
    {
      p2 <- palette.2(input$psize);
      pp <- c(pp, p2);
      num<-num +1;
    }
    if(input$m3)
    {
      p3 <- palette.3(input$psize);
      pp <- c(pp, p3);
      num<-num +1;
    }
    if(input$m4)
    {
      p4 <- palette.4(input$psize);
      pp <- c(pp, p4);
      num<-num +1;
    }
    if(input$m5)
    {
      p5 <- palette.5(input$psize);
      pp <- c(pp, p5);
      num<-num +1;
    }
    if(input$m6)
    {
      p6 <- palette.6(input$psize);
      pp <- c(pp, p6);
      num<-num +1;
    }
    grid.raster (matrix( pp,nrow=input$psize, ncol=num)
                 , interpolate=FALSE)
    
    
  })
  
 
  
})
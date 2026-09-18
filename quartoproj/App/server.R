library(shiny)
#funcao densidade de uma mistura normal
dMisturaNorm <- function(x,mi,dp,probs){
  n <- length(mi)
  stopifnot("NA's presentes ou variância é negativa"=!any(sapply(c(mi,dp,probs),is.na)),
            "Comprimento dos parâmetros difere"=all.equal(n,length(dp),
                      length(probs),tolerance=0),
            "A soma das proporções não é 1"=(sum(probs)==1))
  if(length(x)==1)
    #caso especial, quando x não é vetor
    return(sum(probs*dnorm(x,mi,dp)))
  return(rowSums(sapply(1:n,function(k) probs[k]*dnorm(x,mi[k],dp[k]))))
}

server <- function(input, output,session) {
  #processa os dados
  processa <- eventReactive(input$draw_btn,{
             params <- list(input$mu,input$sig,input$p)
              params <- sapply(params,function(x) as.numeric(unlist(strsplit(x,","))),simplify=F)
              return(params)})
  #plota o grafico
  output$densidade <- renderPlot({
    params <- processa()
    par(mar=c(4.1,4.1,2,1))
    limites=c(min(params[[1]])-2.5*sqrt(max(params[[2]])),max(params[[1]])+2.5*sqrt(max(params[[2]])))
    x=seq(limites[1], limites[2], length.out = 250)
    y=dMisturaNorm(x,params[[1]],sqrt(params[[2]]),params[[3]])
      plot(x,y,type="l",
            ylab="Densidade")
      polygon(c(min(x),x,max(x)), c(0, y, 0), col = "skyblue2", border = NA)
      lines(x,y,type="l",
           ylab="Densidade")
  })
}

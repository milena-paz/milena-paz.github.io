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
      curve(dMisturaNorm(x,params[[1]],sqrt(params[[2]]),params[[3]]),from=min(params[[1]])-10,to=max(params[[1]])+10,
            ylab="Densidade")
  })
}

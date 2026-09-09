library(shiny)
library(shinythemes)
options(shiny.sanitize.errors = FALSE)
fluidPage(theme = shinytheme("readable"),
          titlePanel("Misturas Gaussianas: Ferramenta de visualização",
                     windowTitle = "Misturas Gaussianas"),
          withMathJax(),
          HTML("<script type='text/x-mathjax-config' >
                MathJax.Hub.Config({
                tex2jax: {inlineMath: [['$','$']]}
                });
                </script >
                "),
          ## TEXTO
          h3(style="text-indent: 14px","Modo de Uso")
          ,
          wellPanel(
            p(style="text-indent: 14px",
              "Para usar este app basta fixar uma quantidade k de componentes e definir os parâmetros para cada escrevendo k valores,
                                                  separados por vírgula e com casa decimal com ponto, para a média e variância de cada componente, assim como a proporção/peso das respectivas classes."
            )),
          ## SIMULACAO
          fluidRow(h3(style="text-indent: 14px","Visualização"),
                   sidebarLayout(
                     sidebarPanel(
                       numericInput("k",
                                    "Número de componentes:",
                                    value = 2, max=1E3),
                       #PAINEL MISTURA
                       inputPanel(textInput("p",
                                            "Proporções:",
                                            value = "0.7,0.3")),
                       inputPanel(textInput("mu",
                                                     "Médias:",
                                                     value = "20,50",
                                                  placeholder="")
                                  ,width=5),
                       inputPanel(textInput("sig",
                               "Variâncias:",
                               value = "25,64")),
                       actionButton("draw_btn", "Desenhar gráfico", class = "btn-primary")
                     ),
                     # Mostra o gráfico da distribuição definida
                      mainPanel(
                        plotOutput("densidade",width="600px")
                        # textOutput("densidade")
                      )
                   )
          )
)

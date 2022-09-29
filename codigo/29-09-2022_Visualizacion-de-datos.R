#Visualizacion con ggplot2

#paquetes
library(readr)
library(forcats) #para trabajar con variables de tipo factor (categoría)
library(dplyr)
library(ggplot2)

desarrollo <- read_csv("datos/datos-desarrollo.csv")

#Gráfico 1, PIB Chile

desarrollo |> #ctrl + shift + m el pip nativo de r, un pelin peor
  filter(pais == "Chile", anio >= 2000) |>
  ggplot(aes(x = anio, y = pib)) + #los elementos se agregan con un +, por ejemplo una linea, puntos, etc
  geom_line(color = "#2a39fd", size = 1) +
  geom_point(color = "#151c7e", size = 2) +
  scale_y_continuous(limits = c(0,14000), labels = scales::dollar) + #con scale, una familia de funciones ajustamos los ejes
  labs(title = "Producto Interno Bruto (PIB) de Chile",
       subtitle = "periodo entre 2000 y 2020",
       y = "PIB en dólares",
       x = NULL,
       caption = "Elaboración propia a partir de datos del Banco Mundial") +
  theme_bw() #forma rápida de borrar el fondo gris
  
#ggplot ejecuta por línea, da igual el orden mientras se ejecute lo que queremos, aunque una buena práctica es agrupar cosas

#Guardar el último gráfico ejecutado (plot)
ggsave("figuras/linea-pib-chile.png", width = 10, height = 7)


#Otro gráfico agregando más países

desarrollo |>
  filter(pais %in% c("Chile", "Argentina", "Uruguay")) |>
  ggplot(aes(x = anio, y = esperanza_vida, color = pais)) + #con color = pais definimos que las variables de pais se distingan por colores
  geom_line(size = 1) +
  scale_y_continuous(limits = c(0,85)) +
  scale_x_continuous(breaks = seq(1960,2020,10)) +
  labs(title = "Evolución de la esperanza de vida en Chile, Argentina y Uruguay",
       subtitle = "(1960-2020)",
       x = NULL, #se sobreentiende que el eje x es el año
       y = "esperanza de vida",
       color = "País" #para modificar el titulo de la leyenda
       ) 

#mejorando lo anterior, por ejemplo el orden de la leyenda de colores puede ser dependiendo del último valor tomado (es más fácil de leer) y no alfabético

colores_paises <- c("Chile" = "#d62d20", "Argentina" = "#ffa700", "Uruguay" = "#0057e7")

desarrollo |>
  filter(pais %in% c("Chile", "Argentina", "Uruguay")) |>
  ggplot(aes(x = anio, y = esperanza_vida, color = fct_reorder2(pais, anio, esperanza_vida))) + #se reordena según la mayor esperanza de vida en el mayor año
  geom_line(size = 1) +
  scale_y_continuous(limits = c(0,85)) +
  scale_x_continuous(breaks = seq(1960,2020,10)) +
  scale_color_manual(values = colores_paises) +
  labs(title = "Evolución de la esperanza de vida en Chile, Argentina y Uruguay",
       subtitle = "(1960-2020)",
       x = NULL, #se sobreentiende que el eje x es el año
       y = "esperanza de vida",
       color = NULL) + #para modificar el titulo de la leyenda, es obvio que son países
  theme_bw() +
  theme(legend.position = "bottom")

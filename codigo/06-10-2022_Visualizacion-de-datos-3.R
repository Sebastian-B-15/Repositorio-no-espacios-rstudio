#sesion 3

#paquetes

library(readr)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(showtext)

#Ejemplo 1: Facetas


desarrollo <- read_csv("datos/datos-desarrollo.csv")
cada_cinco <- desarrollo |>
  group_by(pais) |>
  filter(row_number() %% 5 == 1)

ggplot(cada_cinco, aes(pib, esperanza_vida, size = poblacion)) + #el tamaño de los futuros puntos estará ligado al tamaño de la población
  geom_point(alpha = 0.3) + #alpha es la transparencia de los puntos
  scale_x_log10(label = scales::dollar) + #escala del eje x está en logaritmo de base 10, para observar mejor los datos (no todos pegados)
  scale_y_continuous(limits = c(0,90), breaks = seq(0,80,20)) +
  facet_wrap(vars(continente)) + #Divide los graficos segun continentes
  theme_bw() #tema del gráfico (blanco y negro (bw))
  

# como definir la fuente tipografica (desde google)
font_add_google(name = "Lato", family = "Lato") #family es como se llama la fuente y name como nos referiremos a ella, la recomendación es que sean el mismo
showtext_auto()


grafico <- desarrollo |>
  filter(pais %in% c("Argentina", "Chile", "Uruguay")) |>
  ggplot(aes(anio, pib, color = pais)) +
  geom_line(size = 2) +
  scale_color_colorblind() + #paletas de colores para daltónicos
  labs(title = "Evolución del PIB en Argentina, Chile y Uruguay",
       x = NULL,
       y = "PIB en dolares",
       color = "país") #como diferenciamos por color, para editar la leyenda lo mencionamos como argumento

grafico +
  theme(text = element_text(family = "Lato"),
        plot.title = element_text(size = 24), #al referirnos a algo en "theme" y editarlo, debemos mencionar el tipo que es el elemento editado
        axis.text = element_text(size = 15),
        axis.title.y = element_text(size = 15),
        legend.position = "top",
        legend.justification = "left",
        legend.text = element_text(size = 14),
        panel.grid.major.y = element_line(color = "gray40"),
        panel.grid.minor.y = element_line(color = "gray30"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        plot.background = element_rect(fill = "gray80"),
        legend.background = element_blank(),
        panel.background = element_blank(), #con fill relleno una superficie y con color le doy color a un elemento como linea o punto, o el borde de una superficie, y se "elimina" la superficie con element blank
        #axis.licks
        )

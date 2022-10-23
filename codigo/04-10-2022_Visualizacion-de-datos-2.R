#04-10-2022 sesión 2 de visualización de datos

library(readxl)
library(readr)
library(dplyr)
library(ggplot2)
library(ggtext) #Para editar anotaciones y etiquetas
library(gghighlight) #Para destacar valores en un gráfico

#los datos ----

desarrollo <- read_csv("datos/datos-desarrollo.csv") #read.csv es lo mismo en terminos de la variable creada, pero para verlo hay ciertos cambios

sudamerica <- filter(desarrollo, pais %in% c("Chile", #En Rbase también existe esta función, así que hay que tener cuidado y se puede interpretar que la función que se ejecuta es la de Rbase, para salir de problemas se puede especificar el paquete
          "Argentina", "Uruguay", "Paraguay", "Bolivia", "Perú", "Ecuador", 
          "Colombia", "Venezuela", "Brasil", "Suriname", "Guyana"))

sudamerica |>
  filter(anio == 2020) |>
  ggplot(aes(reorder(pais, -esperanza_vida), esperanza_vida)) + #con reorder reordenamos las posiciones de país, ya no según orden alfabético, el orden por defecto es de menor a mayor. Agregando un - esto se puede invertir
  geom_col(fill = "turquoise4") +
  geom_text(aes(label = esperanza_vida), 
            vjust = 10, 
            col = "white",
            fontface = "bold" #negrita
  ) +
  labs(title = "Esperanza de vida en 2020",
       subtitle = "países en Sudamérica",
       x = NULL,
       y = "Esperanza de vida") +
  theme_bw()



#En caso de nombres muy largos en el eje x, es cosa de definir los ejes al revés para que aparezcan los nombres en el eje Y, es lo recomendado (y en vez de vjust usar una justificacion horizontal: hjust)

#Ejemplo 2: Destacar valores dentro de un gráfico

ggplot(sudamerica, aes(anio, pib, color = pais)) +
  geom_line(size = 1.7) +
  gghighlight(pais == "Chile", unhighlighted_params = aes(col = "#b2d3c9")) + #unhighlighted_params nos permite poner los parametros para las lineas u objetos no destacados
  scale_color_manual(values = "#006e4e") + #color destacado
  labs(title = "Comparación del PIB de Chile con el resto de Sudamérica") +
  theme_bw()

#unhighlighted_colour es un argumento -->deprecated, observar esto en los argumentos es importante pues significa que no está desarrollándose este argumento y en el futuro por tanto debería desaparecer

#Ejemplo3
desarrollo |>
  filter(pais == "Ruanda") |>
  ggplot(aes(anio, esperanza_vida)) + 
  geom_line(size = 1.8, color = "magenta4") + 
  geom_label(aes(x = 1995, y = 10, label = "1993: Año del genocidio \n de la población Tutsi"), #\n sirve como salto de línea, para que no ocupe todo el espacio de forma horizontal
             hjust = -0.01,
             fill = "magenta4",
             color = "white",
             fontface = "bold") +
  scale_y_continuous(limits = c(0,80)) +
  scale_x_continuous(breaks = seq(1960, 2020, 10)) + #mejor que se vea el año 90 pues se destaca un evento que empezó o es aprox. en dicha década/año
  labs(title = "Esperanza de vida en Ruanda",
       x = NULL,
       y = NULL) +
  theme_bw()

#Ejemplo 4: como indicar a que corresponde cada cosa del gráfico (alternativa a leyenda)

sudamerica |>
  filter(pais %in% c("Uruguay", "Argentina")) |>
  ggplot(aes(anio, pib, color = pais)) + 
  geom_line(size = 2, show.legend = F) + #no queremos usar leyenda
  scale_color_manual(values = c("Uruguay" = "#0081a7", "Argentina" = "#f07167")) +
  labs(title = "Evaluacion del PIB en <b style = color:'#f07167'>Argentina</b> 
       y <b style = color:'#0081a7'>Uruguay</b>") +
  theme_bw() + 
  theme(plot.title = element_markdown()) #el titulo esta en formato markdown, incluido html, gracias al paquete ggtext


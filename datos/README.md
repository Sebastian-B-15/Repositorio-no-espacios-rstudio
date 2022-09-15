# Datos

En esta carpeta van los datos, aparte que si una capeta vacia no es detectada por git (git solo lleva control de archivos, no carpetas vacias). Este es un archivo markdown.

## datos-desarrollo.csv

Este set de datos contiene siete variables

| Variable         | tipo     | descripción                                                                                              |
|------------------|----------|----------------------------------------------------------------------------------------------------------|
| `pais`           | caracter | Nombre del país                                                                                          |
| `anio`           | numérica | Año de la observación (1960 a 2020)                                                                      |
| `esperanza_vida` | numérica | Esperanza de vida al nacer en años                                                                       |
| `pib`            | numérica | PIB per cápita en dólares (ajstados a dólares de 2015)                                                   |
| `poblacion`      | numérica | Población observada                                                                                      |
| `iso3`           | caracter | Código ISO de tres caracteres                                                                            |
| `continente`     | caracter | El continente en que se encuentra el país ("Américas" hace referencia a América del norte, Centro y Sur) |

Los datos fueron obtenidos del sitio del Banco Mundial en el caso de la variable `pib` y de la página del proyecto Gapminder en el caso de las variables `esperanza_vida` y `poblacion`

El código utilizado para crear este set de datos se encuentra disponible en `/codigo/13-09-2022_Datos-sin-procesar.R`.

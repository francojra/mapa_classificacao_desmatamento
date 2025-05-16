
# Elaborando um Mapa de Áreas Desmatadas no R ----------------------------------------------------------------------------------------------
# Autoria do script: Jeanne Franco ---------------------------------------------------------------------------------------------------------
# Data: 02/05/2025 -------------------------------------------------------------------------------------------------------------------------

# Instalar e carregar os pacotes necessários -----------------------------------------------------------------------------------------------

# Instalar pacotes (se necessário)
install.packages(c("raster", "terra","tidyverse", 
                   "RStoolbox", "sf", "sp"))

# install.packages("rgdal")

# Carregar pacotes
library(raster)
library(terra)
library(tidyverse)
library(RStoolbox)
library(sf)
library(sp)

# Carregar os dados ------------------------------------------------------------------------------------------------------------------------

## Você precisará de:

## 1 - Imagem de satélite (por exemplo, Landsat ou Sentinel)
## 2 - Dados de referência (shapefiles ou outros dados vetoriais)

# Carregar imagem de satélite 
img <- stack("CAAT2021_21665_L8_041021_C_RED.tif")

## Podemos também carregar a imagem usando o pacote "terra":
img <- rast("CAAT2021_21665_L8_041021_C_RED.tif")

# Carregar shapefile de áreas desmatadas (se disponível)
desmatamento <- read_sf("EDITION_21665_21.shp")

# Visualizar os dados
raster::plotRGB(img, r = 1, g = 3, b = 2, stretch = "lin") # Para Landsat (bandas 4,3,2)

# Pré-processamento da imagem --------------------------------------------------------------------------------------------------------------

# Recortar para área de interesse (opcional)
extent_aoi <- extent(c(461685, 690015, -915915, -683385)) # Defina suas coordenadas
img_cropped <- crop(img, extent_aoi)

plot(img_cropped)

## Ou:
# extent_aoi_1 <- extent(c(-45.07807, -35.06698,
#                        -16.71256, -2.748381)) # Extensão do bioma Caatinga
# img_cropped <- crop(img, extent_aoi_1) # Associa a imagem satelite com a geometria do shapefile

### OBS.: os valores de extent estão disponíveis nas informações
### fornecidas no console após correr o nome "img" no R

# Calcular índices de vegetação (NDVI é comum para detecção de desmatamento)
ndvi <- (img_cropped[[3]] - img_cropped[[2]]) / (img_cropped[[3]] + img_cropped[[2]])
plot(ndvi, main = "NDVI")

### O NDVI é um Índice de Vegetação por Diferença Normalizada
### É uma medida da saúde das plantas com base em como uma planta.
### reflete a luz (geralmente luz solar) em frequências específicas.
### Quanto mais próximo o NDVI estiver de 1, mais saudável é a planta.

### O resultado do mapa mostra um índice na legenda que varia de -1 a
### 1, quanto mais próximo de 1, mais nítida ou densa é a vegetação.

### Índices mais próximos do verde escuro ou 1, representam vegetação
### com mais vigor.


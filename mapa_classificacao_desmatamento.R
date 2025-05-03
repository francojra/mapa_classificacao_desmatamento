
# Elaborando um Mapa de Classificação de Áreas Desmatadas com Corte Raso no R --------------------------------------------------------------
# Autoria do script: Jeanne Franco ---------------------------------------------------------------------------------------------------------
# Data: 02/05/2025 -------------------------------------------------------------------------------------------------------------------------

# Instalar e carregar os pacotes necessários -----------------------------------------------------------------------------------------------

# Instalar pacotes (se necessário)
install.packages(c("raster", "rgdal", "rgeos", "ggplot2", 
                   "RStoolbox", "sf", "sp", "viridis"))

# Carregar pacotes
library(raster)
library(rgdal)
library(ggplot2)
library(RStoolbox)
library(sf)
library(sp)
library(viridis)

# Carregar os dados ------------------------------------------------------------------------------------------------------------------------

## Você precisará de:

## 1 - Imagem de satélite (por exemplo, Landsat ou Sentinel)
## 2 - Dados de referência (shapefiles ou outros dados vetoriais)

# Carregar imagem de satélite (substitua pelo seu caminho)
img <- stack("imagem.tif")

# Carregar shapefile de áreas desmatadas (se disponível)
desmatamento <- readOGR("shapefile.shp")

# Visualizar os dados
plotRGB(img, r = 4, g = 3, b = 2, stretch = "lin") # Para Landsat (bandas 4,3,2)

# Pré-processamento da imagem --------------------------------------------------------------------------------------------------------------

# Recortar para área de interesse (opcional)
extent_aoi <- extent(c(xmin, xmax, ymin, ymax)) # Defina suas coordenadas
img_cropped <- crop(img, extent_aoi)

# Calcular índices de vegetação (NDVI é comum para detecção de desmatamento)
ndvi <- (img_cropped[[4]] - img_cropped[[3]]) / (img_cropped[[4]] + img_cropped[[3]])
plot(ndvi, main = "NDVI")

# Classificação supervisionada -------------------------------------------------------------------------------------------------------------

# Criar polígonos de treinamento (execute no console interativamente)
train_data <- readOGR("caminho/para/seus/dados_de_treinamento.shp")

# Se não tiver dados de treinamento, você pode criar manualmente:
# train_data <- drawPoly(img_cropped, n = 3, type = 'p', col = 'red') # Para cada classe

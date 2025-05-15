
# Elaborando um Mapa de Classificação de Áreas Desmatadas com Corte Raso no R --------------------------------------------------------------
# Autoria do script: Jeanne Franco ---------------------------------------------------------------------------------------------------------
# Data: 02/05/2025 -------------------------------------------------------------------------------------------------------------------------

# Instalar e carregar os pacotes necessários -----------------------------------------------------------------------------------------------

# Instalar pacotes (se necessário)
install.packages(c("raster", "terra","tidyverse", "frair",
                   "RStoolbox", "sf", "sp", "viridis"))

# install.packages("rgdal")

# Carregar pacotes
library(raster)
library(terra)
# library(rgdal)
library(tidyverse)
library(frair)
library(RStoolbox)
library(sf)
library(sp)
library(viridis)

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

library(geobr)

biomas <- geobr::read_biomes()
view(biomas)

class(biomas)
glimpse(biomas)

caatinga <- biomas |>
  filter(name_biome %in% c("Caatinga"))

## Mapa bioma Caatinga

ggplot() +
  geom_sf(data = caatinga, fill = "transparent") +
  theme_minimal()

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

# Classificação supervisionada -------------------------------------------------------------------------------------------------------------

## 1 - Criar áreas de treinamento (se não tiver shapefiles)

# Criar polígonos de treinamento (execute no console interativamente)
train_data <- readOGR("dados_de_treinamento.shp")

# Se não tiver dados de treinamento, você pode criar manualmente:
train_data <- drawPoly(img_cropped) # Para cada classe

## 2 - Extrair valores espectrais para treinamento

# Extrair valores das bandas para as áreas de treinamento
train_values <- extract(img_cropped, train_data)
train_values <- do.call(rbind, train_values)

# Criar vetor de classes (ajuste conforme suas classes)
classes <- rep(c("Floresta", "Corte_Raso", "Outros"), 
               sapply(train_data@polygons, function(x) nrow(x@coords)))

# Combinar em dataframe
training <- data.frame(class = as.factor(classes), train_values)

## 3 - Treinar o modelo de classificação

# Modelo Random Forest (pode usar outros como SVM)
library(randomForest)
model_rf <- randomForest(class ~ ., data = training)

# Classificar a imagem
classification <- predict(img_cropped, model_rf)
plot(classification, main = "Classificação Supervisionada")

# Visualização final -----------------------------------------------------------------------------------------------------------------------

# Mapa temático
ggplot() +
  geom_raster(data = as.data.frame(classification_fct, xy = TRUE), 
              aes(x = x, y = y, fill = as.factor(layer))) +
  scale_fill_manual(values = c("darkgreen", "brown", "gray"),
                    labels = c("Floresta", "Corte Raso", "Outros"),
                    name = "Classes") +
  ggtitle("Mapa de Classificação de Áreas Desmatadas") +
  coord_equal() +
  theme_minimal()

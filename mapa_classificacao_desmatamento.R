
# Elaborando um Mapa de Classificação de Áreas Desmatadas com Corte Raso no R --------------------------------------------------------------
# Autoria do script: Jeanne Franco ---------------------------------------------------------------------------------------------------------
# Data: 02/05/2025 -------------------------------------------------------------------------------------------------------------------------

# Instalar e carregar os pacotes necessários -----------------------------------------------------------------------------------------------

# Instalar pacotes (se necessário)
install.packages(c("raster", "rgeos", "ggplot2", 
                   "RStoolbox", "sf", "sp", "viridis"))

install.packages("rgdal", type = "source")

install.packages("devtools")
library(devtools)
install_url('https://cran.r-project.org/doc/manuals/r-patched/R-admin.html#Installing-packages')

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
desmatamento <- readOGR("yearly_deforestation.shp")

# Visualizar os dados
plotRGB(img, r = 4, g = 3, b = 2, stretch = "lin") # Para Landsat (bandas 4,3,2)

# Pré-processamento da imagem --------------------------------------------------------------------------------------------------------------

# Recortar para área de interesse (opcional)
extent_aoi <- extent(c(xmin, xmax, ymin, ymax)) # Defina suas coordenadas
img_cropped <- crop(img, extent_aoi) # Cortar a imagem "img" de acordo com as coordenadas definidas na função acima

# Calcular índices de vegetação (NDVI é comum para detecção de desmatamento)
ndvi <- (img_cropped[[4]] - img_cropped[[3]]) / (img_cropped[[4]] + img_cropped[[3]])
plot(ndvi, main = "NDVI")

# Classificação supervisionada -------------------------------------------------------------------------------------------------------------

## 1 - Criar áreas de treinamento (se não tiver shapefiles)

# Criar polígonos de treinamento (execute no console interativamente)
train_data <- readOGR("caminho/para/seus/dados_de_treinamento.shp")

# Se não tiver dados de treinamento, você pode criar manualmente:
# train_data <- drawPoly(img_cropped, n = 3, type = 'p', col = 'red') # Para cada classe

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

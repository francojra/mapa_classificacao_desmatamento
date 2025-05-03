
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

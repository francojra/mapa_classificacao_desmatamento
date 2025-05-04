# Mapa de classificacao no R - Dados de desmatamento

### Elaborando um Mapa de Classificação de Áreas Desmatadas com Corte Raso no R 
### Autoria do script: Jeanne Franco 
### Data: 02/05/2025 

#### Tópicos do script

1. Instalar e carregar os pacotes necessários;
2. Carregar os dados:
- Carregar imagem de satélite (substitua pelo seu caminho);
- Carregar shapefile de áreas desmatadas (se disponível);
- Visualizar os dados.
3. Pré-processamento da imagem:
- Recortar para área de interesse (opcional);
- Calcular índices de vegetação (NDVI é comum para detecção de desmatamento).
4. Classificação supervisionada:
- Criar polígonos de treinamento (execute no console interativamente);
- Extrair valores das bandas para as áreas de treinamento;
- Criar vetor de classes (ajuste conforme suas classes);
- Combinar em dataframe.
5. Treinar o modelo de classificação:
- Modelo Random Forest (pode usar outros como SVM);
- Classificar a imagem.
6. Visualização final do mapa temático.

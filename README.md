# Mapa de classificacao no R - Dados de desmatamento

### Elaborando um Mapa de Classificação de Áreas Desmatadas com Corte Raso no R 
### Autoria do script: Jeanne Franco 
### Data: 02/05/2025 

Um mapa de classificação, ou mapa temático, é um mapa que visa representar informações e fenômenos específicos em um determinado espaço geográfico, utilizando cores, símbolos e outros recursos visuais para facilitar a compreensão e análise. Essa classificação é feita para facilitar a compreensão e análise de fenômenos geográficos, permitindo identificar padrões e tendências com maior clareza. Em essência, é uma forma de organizar e apresentar informações geográficas de forma organizada e visualmente apelativa.

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

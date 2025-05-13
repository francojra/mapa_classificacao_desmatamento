# Mapa de classificacao no R - Dados de desmatamento

### Elaborando um Mapa de Classificação de Áreas Desmatadas com Corte Raso no R 
### Autoria do script: Jeanne Franco 
### Data: 02/05/2025 

Um mapa de classificação, ou mapa temático, é um mapa que visa representar informações e fenômenos específicos em um determinado espaço geográfico, utilizando cores, símbolos e outros recursos visuais para facilitar a compreensão e análise. Essa classificação é feita para facilitar a compreensão e análise de fenômenos geográficos, permitindo identificar padrões e tendências com maior clareza. Em essência, é uma forma de organizar e apresentar informações geográficas de forma organizada e visualmente apelativa.

Os satélites circulam em volta da Terra em diferentes intervalos de tempo, por exemplo, um satélite pode retornar ao mesmo ponto após 16 dias. Esses satélites capturam as imagens através da luz solar que é refletida no solo. Os principais satélites são: Landsat, Sentinel-2, CBERS. O Landsar é um satélite mais antigo, o Sentinel apresenta imagens em alta resolução.

A exploração dos dados de satélite serve para entender o arranjo de elementos nas imagens. Por exemplo, um ecólogo poderá entender o desmatamento e a mudança da paisagem ao longo do tempo. Também, é possível elaborar diversas classificações do uso do solo como água, vegetação, área urbana, agricultura, etc.

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

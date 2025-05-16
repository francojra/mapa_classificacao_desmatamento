# Mapa no R - Dados de desmatamento e Cálculo do NDVI

### Elaborando um Mapa de Áreas Desmatadas no R 
### Autoria do script: Jeanne Franco 
### Data: 02/05/2025 

#### Alguns conceitos de mapas com sensoriamento remoto

Um mapa de classificação, ou mapa temático, é um mapa que visa representar informações e fenômenos específicos em um determinado espaço geográfico, utilizando cores, símbolos e outros recursos visuais para facilitar a compreensão e análise. Essa classificação é feita para facilitar a compreensão e análise de fenômenos geográficos, permitindo identificar padrões e tendências com maior clareza. Em essência, é uma forma de organizar e apresentar informações geográficas de forma organizada e visualmente apelativa.

As imagens analisadas são processadas por satélites. Os satélites circulam em volta da Terra em diferentes intervalos de tempo, por exemplo, um satélite pode retornar ao mesmo ponto da Terra após 16 dias. Esses satélites capturam as imagens através da luz solar que é refletida no solo. Os principais satélites são: Landsat, Sentinel-2 e CBERS. O Landsat é um satélite mais antigo, já o Sentinel é mais atual e apresenta imagens em alta resolução.

A exploração dos dados de satélite serve para entender o arranjo de elementos nas imagens da Terra. Por exemplo, um ecólogo poderá entender o desmatamento e a mudança da paisagem ao longo do tempo. Também, é possível elaborar diversas classificações do uso do solo como água, vegetação, área urbana, agricultura, etc.

O INPE é responsável por dois principais sistemas de monitoramento das florestas tropicais, entre eles estão o PRODES e o DETER. Esses sistemas foram criados para apoiar políticas públicas da área ambiental. O PRODES foi criado em 1978 e é mais antigo. Com 229 cenas das imagens satélites geradas, é possível cobrir todo bioma da Amazônia, e assim realizar um monitoramento de toda a vegetação. O PRODES trabalha com desmatamento de corte raso onde ocorre toda a derrubada da floresta, ou seja, onde não existe nenhuma vegetação. Existe outros tipos de degradação que não são desmatamento, como queimadas e corte seletivo. O PRODES fornece uma taxa anual de mudança da cobertura vegetal, onde são apresentados mudanças de vegetação no espaço e no tempo. Em contrapartida, o DETER analisa tanto o desmatamento quanto a degradação em tempo real, ou seja, existe um menor intervalo de tempo entre as avaliações, como dias e semanas. Os dados de desmatamento são públicos e podem ser acessados gratuitamente por toda população brasileira.

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

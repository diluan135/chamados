# Usa a imagem oficial do Node.js
FROM node:18

# Define o diretório de trabalho
WORKDIR /app

# Copia apenas os arquivos necessários para instalar dependências
COPY package*.json ./

# Instala as dependências antes de copiar o restante do código
RUN npm install

# Agora copia o restante dos arquivos
COPY . .

# Expõe a porta 3000
EXPOSE 3000

# Comando para rodar o Next.js
CMD ["npm", "run", "dev"]

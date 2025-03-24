# Sistema de Chamados

Este é um sistema de gestão de chamados, desenvolvido utilizando **Laravel 10** e **Next.js**, com **Docker** para containerização. O sistema permite o cadastro, listagem, atendimento, e exclusão de chamados, além de exibir métricas e indicadores de desempenho, como o SLA de chamados resolvidos dentro do prazo.

#### Diagrama ER

![Modelo Entidade-Relacionamento](https://i.imgur.com/0NkDrJd.png)

### Tecnologias Utilizadas

- **Backend:** Laravel 10, PHP
- **Frontend:** Next.js, Tailwind CSS
- **Banco de Dados:** MySQL
- **Docker:** Para containerização do sistema
- **Pacotes:** Spatie, Sanctum

## Como Rodar o Sistema

### Pré-requisitos

Certifique-se de ter o **Docker** e o **Docker Compose** instalados em sua máquina. Caso não tenha, siga os passos abaixo para instalá-los:

- [Instalar Docker](https://docs.docker.com/get-docker/)
- [Instalar Docker Compose](https://docs.docker.com/compose/install/)

### Passo a Passo

1. Clone o repositório para sua máquina:
   ```bash
   git clone https://github.com/diluan135/chamados.git
   cd chamados

2. Utilize as seguintes configurações para o .env:

   ```bash
   DB_CONNECTION=mysql
   DB_HOST=db
   DB_PORT=3306
   DB_DATABASE=chamados
   DB_USERNAME=root
   DB_PASSWORD=root
   ```

3. Para iniciar o ambinete:

   ```bash
   docker-compose down --volumes
   docker-compose build --no-cache
   docker-compose up -d

4. Acesso ao sistema no navegador:

    Frontend: http://localhost:3000

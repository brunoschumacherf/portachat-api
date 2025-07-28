
# PortaChat API

Backend da aplicação de chat interno, construído com **Ruby on Rails 7**.  
Fornece uma **API RESTful** com autenticação via **JWT**, comunicação em tempo real com **WebSockets (Action Cable)** e processamento assíncrono com **Sidekiq**.

---

## 🚀 Tecnologias Principais

- **Ruby on Rails 7**
- **PostgreSQL**
- **Redis**
- **Docker & Docker Compose**
- **RSpec**

---

## 🛠️ Ambiente Local com Docker

O projeto é totalmente containerizado. Para rodá-lo localmente, basta ter o **Docker** e **Docker Compose** instalados.

### ⚙️ Configuração Inicial

1. Clone o repositório e aceda à pasta do projeto:

```bash
git clone https://github.com/brunoschumacherf/portachat-api.git
cd portachat-api
```

2. Verifique se o arquivo `config/master.key` existe. Caso contrário, solicite uma cópia segura.

3. Crie e migre o banco de dados (somente na primeira vez):

```bash
docker-compose exec api bundle exec bin/rails db:create db:migrate
```

---

## 💻 Comandos Essenciais

### Iniciar a aplicação (em background):

```bash
docker-compose up -d
```

### Reconstruir e iniciar (após mudanças no `Gemfile` ou `Dockerfile`):

```bash
docker-compose up --build
```

### Executar a suíte de testes:

```bash
docker-compose run --rm -e RAILS_ENV=test api bundle exec rspec
```

### Acessar o console Rails:

```bash
docker-compose exec api bin/rails c
```


### Iniciar a aplicação:

```bash
docker-compose up
```

### ❗ Conflito de porta com PostgreSQL local

Se necessário, pare o serviço local do PostgreSQL com:

```bash
sudo systemctl stop postgresql
```

---

## 🔗 Links e Deploy

* **📚 Documentação da API**: [https://bold-desert-925648.postman.co/workspace/Team-Workspace~b249a7be-7a79-4d98-8572-ef8362299a56/collection/24048916-faeca747-924c-428e-aa07-8fc6c8bb5389?action=share&creator=24048916]
* **🌐 Frontend**: [https://portachat-client.vercel.app/](https://portachat-client.vercel.app/)


## 📝 Licença

Este projeto está licenciado sob os termos da [MIT License](LICENSE).


# Uchiru Task API

API для работы со школами, классами и учениками на Ruby on Rails + PostgreSQL. 
Документация сгенерирована через `rswag` (OpenAPI 3.0.3).

## 🚀 Запуск проекта (Docker)

```bash
docker-compose build

docker-compose up -d

docker-compose exec app rails db:create db:migrate db:seed
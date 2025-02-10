# FIAP Hackathon - Monorepo

Repositório responsável por permitir o uso das duas aplicações (monólito e worker) em ambiente local de forma facilitada.
Também contém a arquitetura compartilhada por ambas as aplicações, como Pub/Sub, Cloud SQL, Cloud Storage e afins (para maiores informações, consultar a pasta [terraform](./terraform))

## Como utilizar

1. Clone o repositório com seus submodulos (flag `--recurse-submodules`)
2. Construa e suba os containeres (`docker compose up -d`)
3. O monólito estará disponível na porta 80

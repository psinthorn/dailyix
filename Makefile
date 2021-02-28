postgres: 
	docker run --name postgres13 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:13-alpine
createdb:
	docker exec -it postgres13 createdb --username=root --owner=root daily_ix
dropdb:
	docker exec -it postgres13 dropdb daily_ix

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/daily_ix?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/daily_ix?sslmode=disable" -verbose down

sqlc:
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown sqlc
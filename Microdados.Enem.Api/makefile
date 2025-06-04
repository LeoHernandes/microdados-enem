.PHONY:

api:
	cd Core && dotnet run

db-setup:
	cd DatabaseSetup && dotnet run

db-reset:
	./reset-database.sh

db-open:
	sqlite3 Core/Data/microdados.db

docker-build:
	cd Core && docker buildx build -t leohernandes/microdados-enem:latest -f Dockerfile .

docker-push:
	docker push leohernandes/microdados-enem:latest
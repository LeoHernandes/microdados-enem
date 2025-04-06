.PHONY:

api:
	cd Core && dotnet run

db-setup:
	cd DatabaseSetup && dotnet run

db-reset:
	./reset-database.sh

db-open:
	sqlite3 Core/Data/microdados.db
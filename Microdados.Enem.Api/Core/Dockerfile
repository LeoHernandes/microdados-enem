FROM mcr.microsoft.com/dotnet/sdk:8.0@sha256:bf08a06451dade362de02e9b520ff4cff67295a4c6730a262648da063c535fdc AS build
WORKDIR /Core
COPY . ./
RUN dotnet restore
RUN dotnet publish -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0@sha256:8757d38b7bef730a7723e28792b789c359fd24509a5cf6cb15143e4b44615fc0
WORKDIR /Core
COPY --from=build /Core/out .
EXPOSE 8080
ENTRYPOINT ["dotnet", "Core.dll"]
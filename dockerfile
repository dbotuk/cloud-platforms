FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

COPY . .
RUN dotnet restore ./SampleWebApiAspNetCore/SampleWebApiAspNetCore.csproj
RUN dotnet publish ./SampleWebApiAspNetCore/SampleWebApiAspNetCore.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app

COPY --from=build /app/publish .
ENV ASPNETCORE_URLS=http://+:8080
ENV ASPNETCORE_ENVIRONMENT=Development
EXPOSE 8080

ENTRYPOINT ["dotnet", "SampleWebApiAspNetCore.dll"]
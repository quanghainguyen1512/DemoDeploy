FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS builder
WORKDIR /usr/src/app

COPY . .
# COPY *.sln .
# COPY ./DemoDeploy.Api/*.csproj ./DemoDeploy.Api
# COPY ./DemoDeploy.Lib/*.csproj ./DemoDeploy.Lib
RUN dotnet restore

# COPY ./DemoDeploy.Api/* ./DemoDeploy.Api/
# COPY ./DemoDeploy.Lib/* ./DemoDeploy.Lib/
WORKDIR /usr/src/app/DemoDeploy.Api
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS runtime
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/DemoDeploy.Api/out .
ENTRYPOINT [ "dotnet", "DemoDeploy.Api.dll" ]
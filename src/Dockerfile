# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src

# Copy the project file and restore any dependencies
COPY ["src/SuperService.csproj", "./"]
RUN dotnet restore

# Copy the rest of the application code
COPY src/. .
RUN dotnet build -c Release -o /app/build
RUN dotnet publish -c Release -o /app/publish

# Stage 2: Use the official ASP.NET Core runtime image to run the application
FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 80
EXPOSE 443
ENTRYPOINT ["dotnet", "SuperService.dll"]

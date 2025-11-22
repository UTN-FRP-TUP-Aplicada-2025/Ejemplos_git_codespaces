# Build stage
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# Copy project files
COPY ["Ejemplos_codespaces/Ejemplo_API_Web/Ejemplo_API_Web.csproj", "Ejemplo_API_Web/"]
RUN dotnet restore "Ejemplo_API_Web/Ejemplo_API_Web.csproj"

# Copy source code
COPY . .
WORKDIR "/src/Ejemplo_API_Web"

# Build
RUN dotnet build "Ejemplo_API_Web.csproj" -c Release -o /app/build

# Publish stage
FROM build AS publish
RUN dotnet publish "Ejemplo_API_Web.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
EXPOSE 80
EXPOSE 443

# Copy published application
COPY --from=publish /app/publish .

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD dotnet-health-check || exit 1

ENTRYPOINT ["dotnet", "Ejemplo_API_Web.dll"]

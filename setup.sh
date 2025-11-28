#!/usr/bin/env bash

set -e  # Stop on error

DB_NAME="trajectory_doom"
DB_USER="postgres"
SCHEMA_FILE="./trajectory-doom.sql"
RESOURCES_DIR="./resources"
JAR="./resources/postgresql-42.7.8.jar"

echo "=== Checking Java installation ==="
if ! command -v java &> /dev/null; then
    echo "Java not found. Installing..."
    sudo apt update
    sudo apt install -y default-jdk
else
    echo "Java found: $(java -version 2>&1 | head -n 1)"
fi

echo "=== Checking PostgreSQL client ==="
if ! command -v psql &> /dev/null; then
    echo "ERROR: psql not installed. Install PostgreSQL client first."
    exit 1
fi

echo "=== Dropping database if it exists ==="
dropdb -U "$DB_USER" "$DB_NAME" 2>/dev/null || echo "Database did not exist."

echo "=== Creating fresh database ==="
createdb -U "$DB_USER" "$DB_NAME"

echo "=== Loading schema from $SCHEMA_FILE ==="
psql -U "$DB_USER" -d "$DB_NAME" -f "$SCHEMA_FILE"

echo "=== Compiling Java loader ==="
javac -cp ".:$JAR" LlenarDB.java
echo "Java compilation successful."

echo "=== Processing telemetry files in $RESOURCES_DIR ==="

for file in "$RESOURCES_DIR"/*.txt; do
    if [[ -f "$file" ]]; then
        echo "→ Loading $file"
        java -cp ".:$JAR" LlenarDB "$file"
    fi
done

echo "=== DONE! Fresh database loaded and populated successfully. ==="

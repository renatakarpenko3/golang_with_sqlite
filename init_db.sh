#!/bin/zsh

# Database file path
DB_PATH="/root/data/test.db"

# SQL commands to populate the database
SQLITE_COMMANDS=$(cat <<EOF
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

INSERT INTO users (name) VALUES ('Alice');
INSERT INTO users (name) VALUES ('Bob');
INSERT INTO users (name) VALUES ('Charlie');
EOF
)

# Ensure the database directory exists
mkdir -p $(dirname $DB_PATH)

# Initialize the database and populate it
sqlite3 $DB_PATH "$SQLITE_COMMANDS"

echo "Database initialized and populated successfully."

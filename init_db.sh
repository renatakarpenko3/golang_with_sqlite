#!/bin/zsh


DB_PATH="/root/data/test.db"

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

# make sure the database directory exists
mkdir -p $(dirname $DB_PATH)

# init the database and populate it
sqlite3 $DB_PATH "$SQLITE_COMMANDS"

echo "Database initialized and populated successfully."

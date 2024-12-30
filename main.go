package main

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/mattn/go-sqlite3"
)

func main() {
	// Connect to the SQLite database
	db, err := sql.Open("sqlite3", "./data/test.db")
	if err != nil {
		log.Fatal("Failed to connect to SQLite:", err)
	}
	defer db.Close()

	// Query the data
	rows, err := db.Query("SELECT id, name FROM users")
	if err != nil {
		log.Fatal("Failed to query data:", err)
	}
	defer rows.Close()

	// Print the data
	fmt.Println("Users in the database:")
	for rows.Next() {
		var id int
		var name string
		err = rows.Scan(&id, &name)
		if err != nil {
			log.Fatal(err)
		}
		fmt.Printf("ID: %d, Name: %s\n", id, name)
	}
}

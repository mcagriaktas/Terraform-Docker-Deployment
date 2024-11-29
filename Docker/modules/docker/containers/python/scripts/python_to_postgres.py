import psycopg2
import pandas as pd


class Postgres:
    def __init__(self, user="dev_user", password="dev_pass", host="postgres", port="5432", database="dev_db", schema="mysc"):
        self.user = user
        self.password = password
        self.host = host
        self.port = port
        self.database = database
        self.schema = schema
        self.connection = None
        self.cursor = None

    def connection_to_postgres(self):
        """Establish connection to the PostgreSQL database."""
        try:
            self.connection = psycopg2.connect(
                user=self.user,
                password=self.password,
                host=self.host,
                port=self.port,
                database=self.database
            )
            self.cursor = self.connection.cursor()
            print("Connection to PostgreSQL established successfully.")
        except (Exception, psycopg2.Error) as error:
            print(f"Failed to connect to PostgreSQL: {error}")
            self.connection, self.cursor = None, None

    def create_schema(self):
        """Create the schema if it doesn't exist."""
        if self.cursor:
            try:
                create_schema_query = f"CREATE SCHEMA IF NOT EXISTS {self.schema};"
                self.cursor.execute(create_schema_query)
                print(f"Schema {self.schema} created or already exists.")
            except (Exception, psycopg2.Error) as error:
                print(f"Failed to create schema: {error}")

    def create_table(self):
        """Create a table in the specified schema."""
        if self.cursor:
            try:
                create_table_query = f"""
                    CREATE TABLE IF NOT EXISTS {self.schema}.mobile (
                        id SERIAL PRIMARY KEY,
                        model VARCHAR(25),
                        price INT
                    );
                """
                self.cursor.execute(create_table_query)
                print(f"Table 'mobile' created or already exists in schema {self.schema}.")
            except (Exception, psycopg2.Error) as error:
                print(f"Failed to create table: {error}")

    def insert_data(self, model, price):
        """Insert data into the table."""
        if self.cursor:
            try:
                insert_query = f"INSERT INTO {self.schema}.mobile (model, price) VALUES (%s, %s)"
                self.cursor.execute(insert_query, (model, price))
                self.connection.commit()
                print(f"Record inserted successfully: ({model}, {price})")
            except (Exception, psycopg2.Error) as error:
                print(f"Failed to insert data: {error}")

    def close_connection(self):
        """Close the database connection."""
        if self.connection:
            self.cursor.close()
            self.connection.close()
            print("PostgreSQL connection is closed.")

    def main(self):
        """Main function to manage database operations."""
        self.connection_to_postgres()
        if self.cursor:
            self.create_schema()
            self.create_table()
            self.insert_data("One Plus 6", 950)
            self.close_connection()


if __name__ == "__main__":
    postgres = Postgres()
    postgres.main()

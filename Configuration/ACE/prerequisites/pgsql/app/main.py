import psycopg2
import sys
import os


def init():
    namespace = "integration-enablement"
    host_vars = (os.getenv("DB_HOST"), namespace, "svc", "cluster", "local")
    host = ".".join(host_vars)
    connection = psycopg2.connect(database=os.getenv("DB_DB"),
                                  user=os.getenv("DB_USERNAME"),
                                  password=os.getenv("DB_PASSWORD"),
                                  host=host,
                                  port=5432)
    cursor = connection.cursor()
    init_table_commands = (
        """
        CREATE TABLE TRANSFERS (
            TRANSFER_ID SERIAL PRIMARY KEY,
            FROM_ID SERIAL NOT NULL,
            TO_ID SERIAL NOT NULL,
            TRANSFER_AMOUNT INTEGER NOT NULL,
            TRANSFER_DATE VARCHAR(256)
        )
        """,
        """ 
        CREATE TABLE CUSTOMERS (
                CUSTOMER_ID SERIAL PRIMARY KEY,
                FIRST_NAME VARCHAR(255),
                LAST_NAME VARCHAR(255),
                FULL_NAME VARCHAR(255),
                BALANCE INTEGER NOT NULL
        )
        """,
        """
        INSERT INTO 
        CUSTOMERS(CUSTOMER_ID, FIRST_NAME, LAST_NAME, FULL_NAME, BALANCE) VALUES
          (001, 'Malicious', 'User', 'Malicious User', 100), 
          (123, 'Marwan', 'Attar', 'Marwan Attar', 100000),
          (456, 'Oliver', 'Medland', 'Oliver Medland', 200000),
          (789, 'Peter', 'Jessup', 'Peter Jessup', 500000),
          (234, 'Leonardo', 'Vidal', 'Leonardo Vidal', 8900000),
          (567, 'Sasha', 'Khalikov', 'Sasha Khalikov', 9003321),
          (890, 'Bernd', 'Beilke', 'Bernd Beilke', 5000021),
          (100, 'Mohak', 'Talreja', 'Mohak Talreja', 3455021);   
        """
    )

    for command in init_table_commands:
        cursor.execute(command)
    cursor.close()
    connection.commit()


if __name__ == "__main__":
    init()
    sys.exit()

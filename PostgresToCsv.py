import psycopg2
import pandas as pd
from sqlalchemy import create_engine
import csv
from env_init import *



def export_using_psycopg2(host,port,user,password,database,table_name,output):
    try:
        # Connect to PostgresSQL database
        conn = psycopg2.connect(
            host=host,
            port=port,
            user=user,
            password=password,
            database =db_name
        )
        cur = conn.cursor()
        # Execute SQL query to fetch data from table
        cur.execute(f"SELECT * FROM {TABLE_NAME}")
        # Fetch all results
        results = cur.fetchall()
        # Get column names for the  header
        column_names = [desc[0] for desc in cur.description]
        # Write data to CSV file
        with open(output,'w',newline='') as f:
            writer =csv.writer(f)
            writer.writerow(column_names)
            writer.writerows(results)

        print(f"Data from {table_name} exported to {output} successfully.")
    except psycopg2.Error as e:
        print(f"Error connecting to or querying the database : {e}.")


    finally:
        if cur:
            cur.close()
        if conn:
            conn.close()


def export_using_pandas(host,port,user,password,database,table_name,output):
    try:
        # Connect to PostgresSQL database
        conn = psycopg2.connect(
            host=host,
            port=port,
            user=user,
            password=password,
            database =db_name
        )
        print("[+] CONNECTION TO DATABASE SUCCESSFUL")
        sql_query = f"SELECT * FROM {table_name}"
        df = pd.read_sql_query(sql_query,conn)
        print("[+] SQL QUERY EXECUTED SUCCESSFULLY")
        df.to_csv(output,index=False)   
        print(f"[+] DATA EXPORTED TO {output} SUCCESSFULLY")
    except Exception as e:
        print(f"[-] ERROR EXPORTING DATA TO CSV: {e}")
    finally:
        if 'conn' in locals() and conn:
            conn.close()
            print("[+] DATABASE CONNECTION CLOSED")
        
        


if __name__ == "__main__":
    #export_using_psycopg2(host,port,user,password,db_name,TABLE_NAME,OUTPUT_CSV_FILE)
    export_using_pandas(host,port,user,password,db_name,TABLE_NAME,OUTPUT_CSV_FILE)
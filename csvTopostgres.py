from env_init import *
import psycopg2
import csv
import datetime





csv_filename = f'Data/processeced/Superstore-{datetime.now().strftime("%Y_%m_%d_%H_%M_%S")}.csv'
table_name = f'superstore_data-{datetime.now().strftime("%Y_%m_%d_%H_%M_%S")}'

def csv_to_postgres():
    try:
        conn=psycopg2.connect(
            dbname =db_name,user=user,password=password,host=host,port=port
        )
        cur = conn.cursor()
        with open(csv_filename,'r')as f:
            #next(f)
            cur.copy_from(f,table_name,sep=',')

        conn.commmit()
        print(f"DATA FROM {csv_filename} SUCCESSFULLYIMPORTED INTO {table_name} ." )
    except psycopg2.Error as e:
        print(f"ERROR IMPORTING DATA: {e}")
    finally:
        conn=psycopg2.connect(
            dbname =db_name,user=user,password=password,host=host,port=port
        )
        cur = conn.cursor()

        if cur:
            cur.close()
        if conn:
            conn.close()
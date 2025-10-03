from dotenv import load_dotenv
import os
from datetime import datetime

load_dotenv()
db_name = os.getenv("db_name")
user = os.getenv("user")
password = os.getenv("password")
host= os.getenv("host")
port = os.getenv("port")

time_date = datetime.now().strftime("%Y-%m-%d-%H-%M-%S")

TABLE_NAME = "superstore"
OUTPUT_CSV_FILE = f"Data/processed/Superstore-{time_date}.csv"
print("[+] ENVIRONMENT VARIABLES LOADED SUCCESSFULLY")
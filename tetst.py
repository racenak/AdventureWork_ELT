import pyodbc

try:
    conn = pyodbc.connect(
        "DRIVER={ODBC Driver 17 for SQL Server};"
        "SERVER=localhost,1433;"
        "DATABASE=AdventureWorks2022;"
        "UID=sa;"
        "PWD=YourStrong!Passw0rd;"
    )
    print("✅ Kết nối thành công!")
    conn.close()
except Exception as e:
    print("❌ Lỗi kết nối:", e)
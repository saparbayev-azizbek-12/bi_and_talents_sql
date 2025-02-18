import pyodbc

conn = pyodbc.connect(

    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=DESKTOP-L0MHKPI\SQLEXPRESS;"
    "DATABASE=lesson_2;"
    "Trusted_Connection=yes;"
)
cursor = conn.cursor()

cursor.execute("SELECT photo FROM photos WHERE id = 1")
row = cursor.fetchone()

if row and row[0]:
    with open("retrieved_image.jpg", "wb") as file:
        file.write(row[0])
    print("Image retrieved and saved as 'retrieved_image.jpg'")
else:
    print("No image found.")

cursor.close()
conn.close()
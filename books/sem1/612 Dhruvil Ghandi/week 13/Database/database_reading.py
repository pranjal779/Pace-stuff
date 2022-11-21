import sqlite3

connection = sqlite3.connect('chinook.db')
cursor = connection.cursor()
print(connection)
print(cursor)
cursor.execute('select FirstName from employees')
results = cursor.fetchall() # grabs all the results of execute
result = cursor.fetchone()
print(results)

#close connection after working
connection.close()

# connection = sqlite3.connect("survey.db")
# cursor = connection.cursor()
# cursor.execute("SELECT Site.lat, Site.long FROM Site;")
# results = cursor.fetchall()
# for r in results:
#     print(r)
# cursor.close()
# connection.close()
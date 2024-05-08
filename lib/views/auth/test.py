import requests
from icecream import ic

url = "http://127.0.0.1/backend/login.php"
email = "admin@admin.admin"  # Your email
password = "admin"  # Your password

# Sending POST request with email and password parameters
response = requests.post(url, data={"email": email, "password": password})

# Printing the response
ic(response.text)

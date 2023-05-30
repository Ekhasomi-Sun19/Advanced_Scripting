import socket
import json

Reciver_ip = input("Enter receiver ip address: ")
Reciver_port = int(input("Enter receiver port id: "))

data = {
    'name': 'John Doe',
    'age': 25,
    'city': 'New York'
}

json_data = json.dumps(data)

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

connect = 0

try:
    socket.connect((Reciver_ip, Reciver_port))

    sock.sendall(json_data.encode())

    response = sock.recv(1024)
    print('Received:', response.decode())

finally:
    sock.close()


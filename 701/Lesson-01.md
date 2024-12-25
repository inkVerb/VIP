# Linux 701
## Lesson 1: Web Hosting

Ready the CLI

```console
cd ~/School/VIP/701
```
___

### Python Server

| **1** :$

```console
cp hw1.py work/hw.py
code hw1.py
```

*Note:*
- *We use `BaseHTTPRequestHandler` and `HTTPServer` Python `http.server` classes*
- *`port` is assigned to `9001`*
- *`localhost` is defined by using `127.0.0.1`*
- *Loading `BaseHTTPRequestHandler` requires a little more custom code and takes less advantage of Python's built-in HTTP handling code*

| **hw1.py** : port `9001`

```py
from http.server import HTTPServer, BaseHTTPRequestHandler

PORT = 9001
HOST = "127.0.0.1"

class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
  def do_GET(self):
    self.send_response(200)
    self.send_header("Content-type", "text/html")
    self.end_headers()
    self.wfile.write(b"Ink is a verb. Ink!")

if __name__ == "__main__":
  server_address = (HOST, PORT)
  httpd = HTTPServer(server_address, SimpleHTTPRequestHandler)
  print(f"Starting Python server on port {PORT}...")
  try:
    httpd.serve_forever()
  except KeyboardInterrupt:
    print("Server stopped by user.")
```

| **2** :$

```console
python hw.py
```

| **B-2** ://

```console
localhost:9001
```

*Note how the terminal responds each time you access or refresh the webpage*

*You could merely change the `PORT` constant to `80` in the above code, but we will show a little more of Python's capability with a slightly different code...*

| **3** :$

```console
cp hw2.py work/hw.py
code hw2.py
```

*Note:*
- *`port` is assigned to `80` for normal browser use*
- *Using port `80` requires permissions, so `python` must be run with `sudo`*
  - *This is **dangerous** and can create **security vulnerabilityes** on a production server*
  - *Use for learning purposes only!*
- *Loading `socketserver` takes advantage of Python's built-in HTTP handling for the `with socketserver...` statement*

| **hw2.py** : port `80` for normal web browser

```py
import http.server
import socketserver

PORT = 80
HOST = "127.0.0.1"

class CustomHandler(http.server.SimpleHTTPRequestHandler):
  def do_GET(self):
    self.send_response(200)
    self.send_header("Content-type", "text/html")
    self.end_headers()
    self.wfile.write(b"Ink is a verb. Ink!")

with socketserver.TCPServer((HOST, PORT), CustomHandler) as httpd:
  print(f"Starting Python server on port {PORT}...")
  try:
    httpd.serve_forever()
  except KeyboardInterrupt:
    print("Server stopped by user.")
```

| **3** :$

```console
sudo python hw.py
```

*Note no port is specified because it uses the default port `80`*

| **B-3** ://

```console
localhost
```

*You could change the `PORT` constant to `9001` to use `localhost:9001` as in our first example from `hw1.py`*

*To use SSL, we need to do more than change `PORT` to `443`...*

| **4** :$

```console
cp hw3.py work/hw.py
code hw3.py
```

*Note:*
- *`port` is assigned to `443` for SSL*
- *Loading `ssl` allows us to use SSL features (noted with comments)*

| **hw3.py** : port `443` for SSL

```py
import http.server
import socketserver
import ssl

PORT = 443
HOST = "127.0.0.1"

class CustomHandler(http.server.SimpleHTTPRequestHandler):
  def do_GET(self):
    self.send_response(200)
    self.send_header("Content-type", "text/html")
    self.end_headers()
    self.wfile.write(b"Ink is a verb. Ink!")

# SSL certs
certfile = '/etc/ssl/desk/snakeoil.crt.pem'
keyfile  = '/etc/ssl/desk/snakeoil.key.pem'

# SSL context
context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
context.load_cert_chain(certfile=certfile, keyfile=keyfile)

with socketserver.TCPServer((HOST, PORT), CustomHandler) as httpd:
  httpd.socket = context.wrap_socket(httpd.socket, server_side=True) # Wrap the socket with the SSL context
  print(f"Starting Python server on port {PORT} with SSL...")
  try:
    httpd.serve_forever()
  except KeyboardInterrupt:
    print("Server stopped by user.")
```

| **5** :$

```console
sudo python hw.py
```

*Note no port is specified because it uses the default port `443`*

*With this address you will get an SSL security warning from your browser*
  - *You can view the certificate for `O=Snakeoil/OU=Learning/CN=myComputer` as we created in our [LENG Desktop](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/LENG-Desktop.md)*

| **B-5** ://

```console
https://localhost
```

*Changing the `PORT` constant to anything but `443` won't work because this uses SSL*

*Let's include our [Diffie-Hellman Group](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange) key file in this SSL config to see how that looks...*

| **6** :$

```console
cp hw4.py work/hw.py
code hw4.py
```

*Note everything is the same as `hw3.py` for SSL, except we have two `dhparams` statements (indicated with `DH` comments)*

| **hw4.py** : port `443` for SSL

```py
import http.server
import socketserver
import ssl

PORT = 443
HOST = "127.0.0.1"

class CustomHandler(http.server.SimpleHTTPRequestHandler):
  def do_GET(self):
    self.send_response(200)
    self.send_header("Content-type", "text/html")
    self.end_headers()
    self.wfile.write(b"Ink is a verb. Ink!")

# SSL certs
certfile = '/etc/ssl/desk/snakeoil.crt.pem'
keyfile  = '/etc/ssl/desk/snakeoil.key.pem'
dhparams = '/etc/ssl/desk/dhparams.pem'      # DH key

# SSL context
context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
context.load_cert_chain(certfile=certfile, keyfile=keyfile)
context.load_dh_params(dhparams)             # DH context

with socketserver.TCPServer((HOST, PORT), CustomHandler) as httpd:
  httpd.socket = context.wrap_socket(httpd.socket, server_side=True) # Wrap the socket with the SSL context
  print(f"Starting Python server on port {PORT} with SSL...")
  try:
    httpd.serve_forever()
  except KeyboardInterrupt:
    print("Server stopped by user.")
```

| **7** :$

```console
sudo python hw.py
```

*Note no port is specified because it uses the default port `443`*

*With this address you will get an SSL security warning from your browser*
  - *You can view the certificate for `O=Snakeoil/OU=Learning/CN=myComputer` as we created in our [LENG Desktop](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/LENG-Desktop.md)*

| **B-7** ://

```console
https://localhost
```

### Node Server



### Go Server
*Go is different from Python and Node*
  - *Go compiles as a stand-alone program and does not need Python or Node-V8 to be running in order for it to run*
  - *These commands will have the extra step of compiling our Go program each time before executing it*

___

# The Take

___

#### [Lesson 2: ](https://github.com/inkVerb/vip/blob/master/701/Lesson-02.md)
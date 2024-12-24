# Linux 701
## Lesson 1: 

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

| **hw1.py** : port `9001`

```py
from http.server import HTTPServer, BaseHTTPRequestHandler

class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
  def do_GET(self):
    self.send_response(200)
    self.send_header("Content-type", "text/html")
    self.end_headers()
    self.wfile.write(b"Ink is a verb. Ink!")

if __name__ == "__main__":
  server_address = ("127.0.0.1", 9001)
  httpd = HTTPServer(server_address, SimpleHTTPRequestHandler)
  print("Starting Python server on port 9001...")

  httpd.serve_forever()
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

| **hw2.py** : port `80` for normal web browser

```py
import http.server
import socketserver

PORT = 80

class MyHandler(http.server.SimpleHTTPRequestHandler):
  def do_GET(self):
    self.send_response(200)
    self.send_header("Content-type", "text/html")
    self.end_headers()
    self.wfile.write(b"Ink is a verb. Ink!")

with socketserver.TCPServer(("127.0.0.1", PORT), MyHandler) as httpd:
  print(f"Starting Python server on port {PORT}...")
  httpd.serve_forever()
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

___

# The Take

___

#### [Lesson 2: ](https://github.com/inkVerb/vip/blob/master/701/Lesson-02.md)
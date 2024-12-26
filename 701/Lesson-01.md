# Linux 701
## Lesson 1: Web Hosting

Ready the CLI

```console
cd ~/School/VIP/701
```
___

### Python Server
#### Port `9001`

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

| **`hw1.py`** : port `9001`

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

*Note that we don't use `sudo` to run this `.py` app because it uses a **non-privileged port** (above `1024`)*

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

#### Port `80` for HTTP

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

| **`hw2.py`** : port `80` for HTTP

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

#### Port `443` for HTTPS-SSL

| **4** :$

```console
cp hw3.py work/hw.py
code hw3.py
```

*Note:*
- *`port` is assigned to `443` for SSL*
- *Loading `ssl` allows us to use SSL features (noted with comments)*

| **`hw3.py`** : port `443` for HTTPS-SSL

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

#### SSL with DH

| **6** :$

```console
cp hw4.py work/hw.py
code hw4.py
```

*Note everything is the same as `hw3.py` for SSL, except we have two `dhparams` statements (noted with `DH` comments)*

| **`hw4.py`** : SSL with DH

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

| **B-7** ://

```console
https://localhost
```

### Node Server
#### Port `9001`

| **8** :$

```console
cp hw1.node work/hw.node
code hw1.node
```

*Note:*
- *We use `BaseHTTPRequestHandler` and `HTTPServer` Python `http.server` classes*
- *`port` is assigned to `9001`*
- *`localhost` is defined by using `127.0.0.1`*
- *Loading `http` brings native tools in Node for an HTTP server*

| **`hw1.node`** : port `9001`

```js
var http = require('http');

var PORT = 9001;
var HOST = '127.0.0.1';

http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.end('Ink is a verb. Ink!');
}).listen(PORT, HOST);
console.log('Server running at http://' + HOST + ':' + PORT + '/');

process.on('SIGINT', function () {
  console.log('Server stopped by user.');
  process.exit(0);
});
```

*Note that we don't use `sudo` to run this `.node` app because it uses a **non-privileged port** (above `1024`)*

| **9** :$

```console
node hw.node
```

| **B-9** ://

```console
localhost:9001
```

*Note how the terminal responds each time you access or refresh the webpage*

*You could merely change the `PORT` constant to `80` in the above code, but we will show a little more of Node's capability with a slightly different code...*

#### Port `80` for HTTP

| **10** :$

```console
cp hw2.node work/hw.node
code hw2.node
```

*Note:*
- *`port` is assigned to `80` for normal browser use*
- *Using port `80` requires permissions, so `node` must be run with `sudo`*
  - *This is **dangerous** and can create **security vulnerabilityes** on a production server*
  - *Use for learning purposes only!*
- *This implements arrow functions, which isn't quite so old-school Node*
- *Running `server.listen` organizes things a little better*
- *Running `server.close` makes for a more graceful shutdown of the server*

| **`hw2.node`** : port `80` for HTTP

```js
const http = require('http');

const PORT = 80;
const HOST = '127.0.0.1';

const server = http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.end('Ink is a verb. Ink!', 'utf8');
});

server.listen(PORT, HOST, () => {
  console.log(`Starting Node.js server on port ${PORT}...`);
});

process.on('SIGINT', () => {
  console.log('Server stopped by user.');
  server.close(() => {  // More graceful
    process.exit(0);
  });
});
```

| **11** :$

```console
sudo node hw.node
```

*Note no port is specified because it uses the default port `80`*

| **B-11** ://

```console
localhost
```

*You could change the `PORT` constant to `9001` to use `localhost:9001` as in our first example from `hw1.node`*

*To use SSL, we need to do more than change `PORT` to `443`...*

#### Port `443` for HTTPS-SSL

| **12** :$

```console
cp hw13.node work/hw.node
code hw3.node
```

*Note:*
- *`port` is assigned to `443` for SSL*
- *Loading `https` allows us to use SSL features (noted with comments)*

| **`hw3.node`** : port `443` for HTTPS-SSL

```js
const https = require('https');
const fs = require('fs');

const PORT = 443;
const HOST = '127.0.0.1';

// SSL certs
const options = {
  key: fs.readFileSync('/etc/ssl/desk/snakeoil.key.pem'),
  cert: fs.readFileSync('/etc/ssl/desk/snakeoil.crt.pem')
};

// HTTPS
const server = https.createServer(options, (req, res) => {
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.end('Ink is a verb. Ink!', 'utf8');
});

server.listen(PORT, HOST, () => {
  console.log(`Starting Node.js server on port ${PORT} with SSL...`);
});

process.on('SIGINT', () => {
  console.log('Server stopped by user.');
  server.close(() => {
    process.exit(0);
  });
});
```

| **13** :$

```console
sudo node hw.node
```

*Note no port is specified because it uses the default port `443`*

*With this address you will get an SSL security warning from your browser*
  - *You can view the certificate for `O=Snakeoil/OU=Learning/CN=myComputer` as we created in our [LENG Desktop](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/LENG-Desktop.md)*

| **B-13** ://

```console
https://localhost
```

*Changing the `PORT` constant to anything but `443` won't work because this uses SSL*

*Let's include our [Diffie-Hellman Group](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange) key file in this SSL config to see how that looks...*

#### SSL with DH

| **14** :$

```console
cp hw4.node work/hw.node
code hw4.node
```

*Note everything is the same as `hw3.node` for SSL, except we have one `dhparams` statement (noted with a DH comment)*

| **`hw4.node`** : SSL with DH

```js
const https = require('https');
const fs = require('fs');

const PORT = 443;
const HOST = '127.0.0.1';

// SSL certs
const options = {
  key: fs.readFileSync('/etc/ssl/desk/snakeoil.key.pem'),
  cert: fs.readFileSync('/etc/ssl/desk/snakeoil.crt.pem'),
  dhparam: fs.readFileSync('/etc/ssl/desk/dhparams.pem') // DH

// HTTPS
const server = https.createServer(options, (req, res) => {
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.end('Ink is a verb. Ink!', 'utf8');
});

server.listen(PORT, HOST, () => {
  console.log(`Starting Node.js server on port ${PORT} with SSL...`);
});

process.on('SIGINT', () => {
  console.log('Server stopped by user.');
  server.close(() => {
    process.exit(0);
  });
});
```

| **15** :$

```console
sudo node hw.node
```

| **B-15** ://

```console
https://localhost
```


### Go Server
*Go is different from Python and Node*
  - *Go compiles as a stand-alone program and does not need Python or Node-V8 to be running in order for it to execute*
  - *We will use a no-compile command (`go run somefile.go`) so Go will compile, store the compiled file in a temp directory, then execute it*
  - *Go should normally be compiled first for a production server (`go build somefile.go`)*

#### Port `9001`

| **16** :$

```console
cp hw1.go work/hw.go
code hw1.go
```

*Note:*
- *We use `BaseHTTPRequestHandler` and `HTTPServer` Python `http.server` classes*
- *`port` is assigned to `9001`*
- *`localhost` is defined by using `127.0.0.1`*
- *Loading `net` brings us tools in Go for an HTTP server*

| **`hw1.go`** : port `9001`

```go
package main

import (
  "fmt"
  "net"
)

func main() {
  PORT := 9001
  HOST := "127.0.0.1"

  listener, err := net.Listen("tcp", fmt.Sprintf("%s:%d", HOST, PORT))
  if err != nil {
    fmt.Println(err)
    return
  }
  defer listener.Close()

  fmt.Printf("Starting Go server on port %d...\n", PORT)

  for {
    conn, err := listener.Accept()
    if err != nil {
      fmt.Println(err)
      continue
    }
    go handleConnection(conn)
  }
}

func handleConnection(conn net.Conn) {
  defer conn.Close()
  conn.Write([]byte("HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\nInk is a verb. Ink!"))
}
```

*Note that we don't use `sudo` to run this `.go` app because it uses a **non-privileged port** (above `1024`)*

| **17** :$

```console
go run hw.go
```

| **B-17** ://

```console
localhost:9001
```

*Note how the terminal responds each time you access or refresh the webpage*

*You could merely change the `PORT` constant to `80` in the above code, but we will show a little more of Go's capability with a slightly different code...*

#### Port `80` for HTTP

| **18** :$

```console
cp hw2.go work/hw.go
code hw2.go
```

*Note:*
- *`port` is assigned to `80` for normal browser use*
- *Using port `80` requires permissions, so `node` must be run with `sudo`*
  - *This is **dangerous** and can create **security vulnerabilityes** on a production server*
  - *Use for learning purposes only!*
- *Loading `net/http` takes advantage of Go's built-in HTTP handling so we don't need to creat loops*
- *Loading `log` takes advantage of Go's built-in error logging so we don't need an `if` statement to trigger errors*

| **`hw2.go`** : port `80` for HTTP

```go
package main

import (
  "fmt"
  "log"
  "net/http"
)

func main() {
  const (
    PORT = 80
    HOST = "127.0.0.1"
  )

  http.HandleFunc("/", handler)

  fmt.Printf("Starting Go server on port %d...\n", PORT)
  log.Fatal(http.ListenAndServe(fmt.Sprintf("%s:%d", HOST, PORT), nil))
}

func handler(w http.ResponseWriter, r *http.Request) {
  w.Header().Set("Content-Type", "text/html; charset=utf-8")
  w.Write([]byte("Ink is a verb. Ink!"))
}
```

| **19** :$

```console
sudo go run hw.go
```

| **B-19** ://

```console
localhost
```

#### Port `443` for HTTPS-SSL

| **20** :$

```console
cp hw3.go work/hw.go
code hw3.go
```

*Note:*
- *`port` is assigned to `443` for SSL*
- *Loading `crypto/tls` allows us to use SSL features (noted with comments)*

| **`hw3.go`** : port `443` for HTTPS-SSL

```go
package main

import (
  "fmt"
  "log"
  "net/http"

  "crypto/tls"
)

func main() {
  const (
    PORT = 443
    HOST = "127.0.0.1"
  )

  // SSL certs
  cert, err := tls.LoadX509KeyPair("/etc/ssl/desk/snakeoil.crt.pem", "/etc/ssl/desk/snakeoil.key.pem")
  if err != nil {
    log.Fatal(err)
  }

  // SSL/TLS ciphers
  tlsConfig := &tls.Config{
    Certificates: []tls.Certificate{cert},
    CipherSuites: []uint16{
      tls.TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,
      tls.TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,
    },
    PreferServerCipherSuites: true,
  }
  tlsConfig.BuildNameToCertificate()

  server := &http.Server{
    Addr:      fmt.Sprintf("%s:%d", HOST, PORT),
    Handler:   http.HandlerFunc(handler),
    TLSConfig: tlsConfig,
  }

  fmt.Printf("Starting Go server on port %d with SSL...\n", PORT)
  log.Fatal(server.ListenAndServeTLS("", ""))
}

func handler(w http.ResponseWriter, r *http.Request) {
  w.Header().Set("Content-Type", "text/html; charset=utf-8")
  w.Write([]byte("Ink is a verb. Ink!"))
}
```

| **21** :$

```console
sudo go run hw.go
```

*Note no port is specified because it uses the default port `443`*

*With this address you will get an SSL security warning from your browser*
  - *You can view the certificate for `O=Snakeoil/OU=Learning/CN=myComputer` as we created in our [LENG Desktop](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/LENG-Desktop.md)*

| **B-21** ://

```console
https://localhost
```

*Changing the `PORT` constant to anything but `443` won't work because this uses SSL*

*Let's include our [Diffie-Hellman Group](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange) key file in this SSL config to see how that looks...*

#### SSL with DH

| **22** :$

```console
cp hw4.go work/hw.go
code hw4.go
```

*Note everything is the same as `hw3.go` for SSL, except we have a few `dhParams` statements (noted with `DH` comments)*
*Loading `io/ioutil` allowed us to use `dhParams`*

| **`hw4.go`** : SSL with DH

```go
package main

import (
  "fmt"
  "io/ioutil"
  "log"
  "net/http"

  "crypto/tls"
)

func main() {
  const (
    PORT = 443
    HOST = "127.0.0.1"
  )

  // SSL certs
  cert, err := tls.LoadX509KeyPair("/etc/ssl/desk/snakeoil.crt.pem", "/etc/ssl/desk/snakeoil.key.pem")
  if err != nil {
    log.Fatal(err)
  }

  // DH
  dhParams, err := ioutil.ReadFile("/etc/ssl/desk/dhparams.pem")
  if err != nil {
    log.Fatal(err)
  }

  // SSL/TLS ciphers
  tlsConfig := &tls.Config{
    Certificates: []tls.Certificate{cert},
    CipherSuites: []uint16{
      tls.TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,
      tls.TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,
    },
    PreferServerCipherSuites: true,
  }
  tlsConfig.BuildNameToCertificate()
  tlsConfig.SetSessionTicketKeys([][32]byte{{}})
  tlsConfig.DHParams, err = tls.X509KeyPair(dhParams, dhParams) // DH

  server := &http.Server{
    Addr:      fmt.Sprintf("%s:%d", HOST, PORT),
    Handler:   http.HandlerFunc(handler),
    TLSConfig: tlsConfig,
  }

  fmt.Printf("Starting Go server on port %d with SSL...\n", PORT)
  log.Fatal(server.ListenAndServeTLS("", ""))
}

func handler(w http.ResponseWriter, r *http.Request) {
  w.Header().Set("Content-Type", "text/html; charset=utf-8")
  w.Write([]byte("Ink is a verb. Ink!"))
}
```

| **23** :$

```console
sudo go run hw.go
```

| **B-23** ://

```console
https://localhost
```

### Nginx Reverse-Proxy Server
The more efficient web server

*While these three server-side languages are capable of handling their own web service for HTTP (`80`) and HTTPS (`443`), Nginx is much better equipped for a few reasons:*
- *Terminating SSL connections*
- *Handling high traffic from the web*
- *Serving more than one website or app*
  - *If on ports `80` or `443`, such a Python, Node.js, or Go app might be the only website allowed on the entire server*

*As a base of reference, this is what a basic reverse-proxy single-file config for Nginx could be...*

| **`nginx-reverse-proxy.conf`** :

```
http {
  # Global SSL
  ssl_protocols TLSv1.2 TLSv1.3;
  ssl_prefer_server_ciphers on;
  ssl_ciphers ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256;
  ssl_session_cache shared:SSL:10m;
  ssl_session_timeout 10m;

  # HTTPS port 443
  server {
    listen 443 ssl;
    listen [::]:443 ssl;
    http2 on;
    server_name localhost;  # Can replace with a domain

    ssl_certificate      /etc/ssl/desk/snakeoil.crt.pem;
    ssl_certificate_key  /etc/ssl/desk/snakeoil.key.pem;
    ssl_dhparam          /etc/ssl/desk/dhparams.pem;

    location / {
      proxy_pass http://127.0.0.1:9001;
      proxy_http_version 1.1;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection 'upgrade';
      proxy_set_header Host $host;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto $scheme;
      proxy_hide_header Upgrade;
    }
  }

  # Redirect HTTP port 80 to HTTPS port 443
  server {
    listen 80;
    server_name localhost;  # Can replace with a domain
    return 301 https://$host$request_uri;
  }
}
```

*...but we aren't actually using this Nginx config because we have the two-part configs from our [LENG Desktop](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/LENG-Desktop.md) configuration*

*This is the short version, only with the `server` blocks for port `443` and port `80` redirecting, and passing as a proxy to internal port `9001` for our Pythin/Node.js/Go app...*

| **`rphttps.conf`** :

```
# HTTPS port 443
server {
  listen 443 ssl;
  listen [::]:443 ssl;
  http2 on;
  server_name localhost;

  ssl_certificate      /etc/ssl/desk/snakeoil.crt.pem;
  ssl_certificate_key  /etc/ssl/desk/snakeoil.key.pem;

  location / {
    proxy_pass http://127.0.0.1:9001;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_hide_header Upgrade;
  }
}

# Redirect HTTP port 80 to HTTPS port 443
server {
  listen 80;
  listen [::]:80;
  server_name localhost;
  
  return 301 https://$host$request_uri;
}
```

*Assuming the [LENG Desktop](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/LENG-Desktop.md), we will move the reverse-proxy SSL Nginx config into place...*

| **24** :$

```console
sudo ln -sfn /etc/nginx/conf.d/rphttp.conf /etc/nginx/enabled.d/active.conf
```

*Start our Nginx server for this configuration*

| **25** :$

```console
sudo systemctl start nginx
```

### Proxied Services
Apps that run behind an Nginx reverse-proxy server

*Write our Python, Node.js, and Go web apps to run behind an Nginx reverse-proxy web server*
- *Note that when running behind an Nginx reverse-proxy server, these apps no longer need to address incoming traffic from the web*
- *These will be much like slimmed-down versions of the `hw1.*` and `hw2.*` examples above*
- *These basic "Hello World!" apps only run on the internal server, in these examples using port `9001`*
- *Developing our web apps as **proxied services** like these are what we will build on in the lessons ahead*

#### Python

| **26** :$

```console
code hwrp.py
```

| **`hwrp.py`** :

```py
import http.server

PORT = 9001
HOST = "127.0.0.1"

class CustomHandler(http.server.SimpleHTTPRequestHandler):
  def do_GET(self):
  self.send_response(200)
  self.send_header("Content-type", "text/html")
  self.end_headers()
  self.wfile.write(b"Ink is a verb. Ink!")

if __name__ == "__main__":
  with http.server.HTTPServer((HOST, PORT), CustomHandler) as httpd:
    print(f"Starting Python server on port {PORT}...")
    try:
    httpd.serve_forever()
    except KeyboardInterrupt:
    print("Server stopped by user.")
```

| **27** :$

```console
sudo python hw.py
```

| **B-27** ://

```console
https://localhost
```

#### Node.js

| **28** :$

```console
code hwrp.node
```

| **`hwrp.node`** :

```js
const http = require('http');

const PORT = 9001;
const HOST = '127.0.0.1';

const server = http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.end('Ink is a verb. Ink!', 'utf8');
});

server.listen(PORT, HOST, () => {
  console.log(`Starting Node.js server on port ${PORT}...`);
});

process.on('SIGINT', () => {
  console.log('Server stopped by user.');
  server.close(() => {
  process.exit(0);
  });
});
```

| **29** :$

```console
sudo node hw.node
```

| **B-29** ://

```console
https://localhost
```

#### Go

| **30** :$

```console
code hwrp.go
```

| **`hwrp.go`** :

```go
package main

import (
  "fmt"
  "net/http"
)

func main() {
  const (
    PORT = 9001
    HOST = "127.0.0.1"
  )

  http.HandleFunc("/", handler)

  fmt.Printf("Starting Go server on port %d...\n", PORT)
  err := http.ListenAndServe(fmt.Sprintf("%s:%d", HOST, PORT), nil)
  if err != nil {
    fmt.Printf("Server error: %v\n", err)
  }
}

func handler(w http.ResponseWriter, r *http.Request) {
  w.Header().Set("Content-Type", "text/html; charset=utf-8")
  w.Write([]byte("Ink is a verb. Ink!"))
}
```

| **31** :$

```console
sudo go run hw.go
```

| **B-31** ://

```console
https://localhost
```

___

# The Take
- Python, Node.js, and Go support their own web servers
  - Serving web apps
  - SSL/TLS
  - [Diffie-Hellman](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange) keys
- Nginx is still more efficient
  - High-traffic
  - More than one web app on the same server
- Go scripts compile into their own binaries that need no additional installation on the server
  - There is a way to run Go apps with a single command, but this still compiles the script before running
  - Developing or compiling Go apps requires the Go package to be installed for compiling purposes
- Python and Node.js require their own packages to run scripts
- Nginx can serve statick Text/HTML files
- Nginx can proxy web traffic to internal "**proxied services**"
- Python, Node.js, and Go can be used to write **proxied services**, even to be served on the web through Nginx

___

#### [Lesson 2: Database Connections](https://github.com/inkVerb/vip/blob/master/701/Lesson-02.md)
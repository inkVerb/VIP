# Linux 701
## Lesson 2: Method & RegEx Handling

Ready the CLI

```console
cd ~/School/VIP/701
```

Ready services

```console
sudo systemctl start nginx
```

___

*Before `<form>` handling, let's have a look at what our three server languages see...*

### Basic `GET` dump
*These three backend programs will dump all GET values based on the URL you use*

*These use `:9001` in the URL, so Nginx won't matter*

#### Python

| **1** :$

```console
code dump-get.py
```

| **`dump-get.py`** :

```py
import http.server
import urllib.parse

PORT = 9001
HOST = "127.0.0.1"

class CustomHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):

        # Parse the URL for GET entries
        parsed_path = urllib.parse.urlparse(self.path)
        query_components = urllib.parse.parse_qs(parsed_path.query)

        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        
        # Construct the $response wrapped in HTML page tags
        response = '<!DOCTYPE html>'
        response += '<html><body>'

        # Loop through each GET entry
        for key, values in query_components.items():
            response += f'{key}: {", ".join(values)}<br>'
        
        # Finish the $response HTML
        response += '</body></html>'
        
        # write the $response as output
        self.wfile.write(response.encode())

if __name__ == "__main__":
    with http.server.HTTPServer((HOST, PORT), CustomHandler) as httpd:
        print(f"Starting Python method-handler server on port {PORT}...")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("Server stopped by user.")
```

| **2** :$

```console
python dump-get.py
```

| **B-3** ://

```console
localhost:9001?ONE=one&TWO=two&THREE=three
```

*Feel free to hack the GET line `ONE=one&TWO=two&THREE=three` to make modifications*

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

#### Node.js

| **4** :$

```console
code dump-get.node
```

| **`dump-get.node`** :

```js
const http = require('http');
const url = require('url');

const PORT = 9001;
const HOST = '127.0.0.1';

const server = http.createServer((req, res) => {

  // Parse the URL for GET entries
  const queryObject = url.parse(req.url, true).query;

  res.writeHead(200, {'Content-Type': 'text/html'});

  // Construct the $response wrapped in HTML page tags
  let response = '<!DOCTYPE html>';
  response += '<html><body>';

  // Loop through each GET entry
  for (const [key, value] of Object.entries(queryObject)) {
    response += `${key}: ${value}<br>`;
  }

  // Finish the $response HTML
  response += '</body></html>';

  // res.end the $response as output
  res.end(response);
});

server.listen(PORT, HOST, () => {
  console.log(`Starting Node.js method-handler server on port ${PORT}...`);
});

process.on('SIGINT', () => {
  console.log('Server stopped by user.');
  server.close(() => {
    process.exit(0);
  });
});
```

| **5** :$

```console
node dump-get.node
```

| **B-5** ://

```console
localhost:9001?ONE=one&TWO=two&THREE=three
```

*Feel free to hack the GET line `ONE=one&TWO=two&THREE=three` to make modifications*

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

#### Go

| **6** :$

```console
code dump-get.go
```

| **`dump-get.go`** :

```go
package main

import (
    "fmt"
    "net/http"
    "net/url"
)

func main() {
    const (
        PORT = 9001
        HOST = "127.0.0.1"
    )

    http.HandleFunc("/", handler)

    fmt.Printf("Starting Go method-handler server on port %d...\n", PORT)
    err := http.ListenAndServe(fmt.Sprintf("%s:%d", HOST, PORT), nil)
    if err != nil {
        fmt.Printf("Server error: %v\n", err)
    }
}

func handler(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "text/html; charset=utf-8")
    
    // Parse the URL for GET entries
    values, err := url.ParseQuery(r.URL.RawQuery)
    if err != nil {
        http.Error(w, "Error parsing query", http.StatusBadRequest)
        return
    }
    
    // Construct the $response wrapped in HTML page tags
    response := "<!DOCTYPE html>"
    response += "<html><body>"

    // Loop through each GET entry
    for key, value := range values {
        response += fmt.Sprintf("%s: %s<br>", key, value)
    }

    // Finish the $response HTML
    response += "</body></html>"
    
    // res.end the $response as output
    fmt.Fprintf(w, response)
}
```

| **7** :$

```console
go run dump-get.go
```

| **B-7** ://

```console
localhost:9001?ONE=one&TWO=two&THREE=three
```

*Feel free to hack the GET line `ONE=one&TWO=two&THREE=three` to make modifications*

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

### Port vs Proxy

*Each of the browser URLs above denoted the port with `:9001`*

*Because we are using Nginx to redirect web traffic to port `9001`, we actually don't need this in our URL*

*Note that Nginx is running...*

| **8** :$

```console
sudo systemctl status nginx
```

*Stop Nginx...*

| **9** :$

```console
sudo systemctl stop nginx
```

*Start any **one** of the backend scripts... (choose one)*

| **10-p** :$

```console
python dump-get.py
```

| **10-n** :$

```console
node dump-get.node
```

| **10-g** :$

```console
go run dump-get.go
```

*Now try any of the backend scripts with a `:9001`-GET URL again...*

| **B-10** ://

```console
localhost:9001?ONE=one&TWO=two&THREE=three
```

*They should work because the backend serviec is running on port `9001` and we specified that in our URL with `:9001`*

*Now try any of the backend scripts with only `localhost`-GET URL...*

| **B-11** ://

```console
localhost/?ONE=one&TWO=two&THREE=three
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

*They shouldn't work because browsers listen on ports `80` and `443`, but nothing is running that listens to those ports (since Nginx is turned off)*

*Turn on Nginx to listen to port `443` and to port `80` that redirects to port `443`...*

| **12** :$

```console
sudo systemctl start nginx
```

*Again, try any of the backend scripts with only `localhost`-GET URL...*

| **B-12** ://

```console
localhost/?ONE=one&TWO=two&THREE=three
```

*Note that the Nginx reverse proxy handles the normal browser traffic, then passes it to port `9001` so that the URL doesn't need to include `:9001`*

*Any time you have a backend service running on a port, Nginx can probably just pass web traffic to it*

*From here on out, we will use Nginx for our proxy pass*

### Handling specific GET `<form>` items
*Basic HTML `<form>` backend services that handle GET requests*

#### Python

| **13** :$

```console
code form-get.py
```

| **`form-get.py`** :

```py
import http.server
import urllib.parse

PORT = 9001
HOST = "127.0.0.1"

# HTML blocks as docstring constants
html_doc_start = """
<!DOCTYPE html>
<html>
<body>
"""

html_form = """
<form action="localhost" method="get">
  One: <input type="text" name="one"><br><br>
  Two: <input type="text" name="two"><br><br>
  Three: <input type="text" name="three"><br><br>
  <input type="submit" value="Submit Button">
</form>
"""

html_doc_end = """
</body>
</html>
"""

# Handle HTTP requests
class CustomHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):

        # Parse the URL for GET entries
        parsed_path = urllib.parse.urlparse(self.path)
        query_components = urllib.parse.parse_qs(parsed_path.query)

        # Start the document
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()

        # Construct the $response variable inside its function
        response = html_doc_start

        # Append the $response
        ## If no GET entries, say so
        if not query_components:
            response += '<pre>No form yet.</pre>'
        
        ## If GET entries, show them
        else:
            response += '<code>'

            ### Process only specified GET items
            if 'one' in query_components:
                response += f'one: {query_components["one"][0]}<br>'
            if 'two' in query_components:
                response += f'two: {query_components["two"][0]}<br>'
            if 'three' in query_components:
                response += f'three: {query_components["three"][0]}<br>'

            response += '</code><br>'

        # Finish the $response
        response += html_form
        response += html_doc_end

        # write the constructed $response 
        self.wfile.write(response.encode())

# Backend processing
if __name__ == "__main__":
    with http.server.HTTPServer((HOST, PORT), CustomHandler) as httpd:
        print(f"Starting Python server on port {PORT}...")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("Server stopped by user.")
```

| **14** :$

```console
python form-get.py
```

| **B-14** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

#### Node.js

| **15** :$

```console
code form-get.node
```

| **`form-get.node`** :

```js
const http = require('http');
const url = require('url');

const PORT = 9001;
const HOST = '127.0.0.1';

// HTML blocks as template literal constants
const htmlDocStart = `
<!DOCTYPE html>
<html>
<body>
`;

const htmlForm = `
<form action="localhost" method="get">
  One: <input type="text" name="one"><br><br>
  Two: <input type="text" name="two"><br><br>
  Three: <input type="text" name="three"><br><br>
  <input type="submit" value="Submit Button">
</form>
`;

const htmlDocEnd = `
</body>
</html>
`;

// Handle HTTP requests
const server = http.createServer((req, res) => {

    // Start the document
    res.writeHead(200, {'Content-Type': 'text/html'});

    // Parse the URL for GET entries
    const queryObject = url.parse(req.url, true).query;

    // Construct the $response variable inside its function
    let response = htmlDocStart;

    // Append the $response
    /// If no GET entries, say so
    if (Object.keys(queryObject).length === 0) {
        response += `<pre>No form yet.</pre>`;

    /// If GET entries, show them
    } else {
        response += `<code>`;

        //// Process only specified GET items
        if ('one' in queryObject) response += `one: ${queryObject.one}<br>`;
        if ('two' in queryObject) response += `two: ${queryObject.two}<br>`;
        if ('three' in queryObject) response += `three: ${queryObject.three}<br>`;

        response += `</code><br>`;
    }

    // Finish the $response
    response += htmlForm;
    response += htmlDocEnd;

    // res.end the $response
    res.end(response);

});

// Backend processing
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

| **16** :$

```console
node form-get.node
```

| **B-16** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

#### Go

| **17** :$

```console
code form-get.go
```

| **`form-get.go`** :

```go
package main

import (
    "fmt"
    "net/http"
    "net/url"
)

// HTML blocks as raw string literal constants
const htmlDocStart = `
<!DOCTYPE html>
<html>
<body>
`

const htmlForm = `
<form action="localhost" method="get">
  One: <input type="text" name="one"><br><br>
  Two: <input type="text" name="two"><br><br>
  Three: <input type="text" name="three"><br><br>
  <input type="submit" value="Submit Button">
</form>
`

const htmlDocEnd = `
</body>
</html>
`

func main() {
    const (
        PORT = 9001
        HOST = "127.0.0.1"
    )

    http.HandleFunc("/", handler)

    // Backend processing
    fmt.Printf("Starting Go server on port %d...\n", PORT)
    err := http.ListenAndServe(fmt.Sprintf("%s:%d", HOST, PORT), nil)
    if err != nil {
        fmt.Printf("Server error: %v\n", err)
    }
}

// Handle HTTP requests
func handler(w http.ResponseWriter, r *http.Request) {

    // Start the document
    w.Header().Set("Content-Type", "text/html; charset=utf-8")
    
    // Parse the URL for GET entries
    values, err := url.ParseQuery(r.URL.RawQuery)
    if err != nil {
        http.Error(w, "Error parsing query", http.StatusBadRequest)
        return
    }

    // Construct the $response variable inside its function
    response := htmlDocStart

    // Append the $response
    /// If no GET entries, say so
    if len(values) == 0 {
        response += `<pre>No form yet.</pre>`
    
    /// If GET entries, show them
    } else {
        response += `<code>`
        
        //// Process only specified GET items
        if one, ok := values["one"]; ok {
            response += fmt.Sprintf("one: %s<br>", one[0])
        }
        if two, ok := values["two"]; ok {
            response += fmt.Sprintf("two: %s<br>", two[0])
        }
        if three, ok := values["three"]; ok {
            response += fmt.Sprintf("three: %s<br>", three[0])
        }
        
        response += `</code><br>`
    }

    // Finish the $response
    response += htmlForm
    response += htmlDocEnd

    // fmt.Fprint the $response
    fmt.Fprint(w, response)
}
```

| **18** :$

```console
go run form-get.go
```

| **B-18** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

### Handling specific POST `<form>` items
*Basic HTML `<form>` backend services that handle POST requests*

*Note in all three examples, when we POST, we don't want the `<form action=` to be `localhost` because that would result in `localhost/localhost`*

*In GET, we would receive the full and proper URL with `<form action="localhost"`*

*In POST, we need `<form action="/"`*

#### Python

| **19** :$

```console
code form-post.py
```

| **`form-post.py`** :

```py
import http.server
import urllib.parse

PORT = 9001
HOST = "127.0.0.1"

# HTML blocks as docstring constants
html_doc_start = """
<!DOCTYPE html>
<html>
<body>
"""

html_form = """
<form action="/" method="post">
  One: <input type="text" name="one"><br><br>
  Two: <input type="text" name="two"><br><br>
  Three: <input type="text" name="three"><br><br>
  <input type="submit" value="Submit Button">
</form>
"""

html_doc_end = """
</body>
</html>
"""

# Handle HTTP requests
class CustomHandler(http.server.SimpleHTTPRequestHandler):
    def do_POST(self):

        # Parse the header for POST entries
        content_length = self.headers.get('Content-Length')

        # Start the document
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()

        # Construct the $response variable inside its function
        response = html_doc_start

        # Append the $response
        if content_length:
            post_data = self.rfile.read(int(content_length))
            query_components = urllib.parse.parse_qs(post_data.decode())
            
            ## If POST, but no entries, say so
            if not query_components:
                response += '<pre>No POST entries.</pre>'
            
            ## If POST entries, show them
            else:

                response += '<code>'
                
                ### Process only specified POST items
                if 'one' in query_components:
                    response += f'one: {query_components["one"][0]}<br>'
                if 'two' in query_components:
                    response += f'two: {query_components["two"][0]}<br>'
                if 'three' in query_components:
                    response += f'three: {query_components["three"][0]}<br>'
                    
                response += '</code><br>'
            
        ## If no POST, leave empty
        else:
            query_components = {}
        
        # Finish the $response
        response += html_form
        response += html_doc_end

        # write the constructed $response 
        self.wfile.write(response.encode())

    # Create an empty do_GET to prevent serving the filesystem
    def do_GET(self):
        
        # Start the document
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        
        # Construct the $response variable inside its function
        response = html_doc_start

        # With no form, say so
        response += '<pre>No form yet.</pre>'
            
        # Finish the $response
        response += html_form
        response += html_doc_end

        # write the constructed $response 
        self.wfile.write(response.encode())

# Backend processing
if __name__ == "__main__":
    with http.server.HTTPServer((HOST, PORT), CustomHandler) as httpd:
        print(f"Starting Python server on port {PORT}...")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("Server stopped by user.")
```

| **20** :$

```console
python form-post.py
```

| **B-20** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

*Note that the Python code only identifies POST entries that have values*

*Node.js and Go will see the POST entry from the `<form>` even if the `<input>` is empty*

*Because of this, Python needed some more logic to handle various scenarios; look for comments:*
- *`## If POST, but no entries, say so`*
- *`## If no POST, leave empty`*
- *`# With no form, say so`*

*Python also needs to process a no-POST (AKA GET) scenario, without that `def do_GET(self)` block, Python could serve the filesystem of the PWD where the `.py` file was running*

*This serves as an example of how complex it can be for Python to handle POST vs GET requests*

#### Node.js

| **21** :$

```console
code form-post.node
```

| **`form-post.node`** :

```js
const http = require('http');
const querystring = require('querystring');

const PORT = 9001;
const HOST = '127.0.0.1';

// HTML blocks as template literal constants
const htmlDocStart = `
<!DOCTYPE html>
<html>
<body>
`;

const htmlForm = `
<form action="/" method="post">
  One: <input type="text" name="one"><br><br>
  Two: <input type="text" name="two"><br><br>
  Three: <input type="text" name="three"><br><br>
  <input type="submit" value="Submit Button">
</form>
`;

const htmlDocEnd = `
</body>
</html>
`;

// Handle HTTP requests
const server = http.createServer((req, res) => {

    // Start the document
    res.writeHead(200, {'Content-Type': 'text/html'});

    // Parse the URL for POST entries
    let body = '';
    req.on('data', chunk => {
        body += chunk.toString(); // convert Buffer to string
    });
    req.on('end', () => {
        const queryObject = querystring.parse(body);

        // Construct the $response variable inside its function
        let response = htmlDocStart;

        // Append the $response
        /// If no POST entries, say so
        if (Object.keys(queryObject).length === 0) {
            response += `<pre>No form yet.</pre>`;

        /// If POST entries, show them
        } else {
            response += `<code>`;

            //// Process only specified POST items
            if ('one' in queryObject) response += `one: ${queryObject.one}<br>`;
            if ('two' in queryObject) response += `two: ${queryObject.two}<br>`;
            if ('three' in queryObject) response += `three: ${queryObject.three}<br>`;

            response += `</code><br>`;
        }

        // Finish the $response
        response += htmlForm;
        response += htmlDocEnd;

        // res.end the $response
        res.end(response);
    });
});

// Backend processing
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

| **22** :$

```console
node form-post.node
```

| **B-22** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

#### Go

| **23** :$

```console
code form-post.go
```

| **`form-post.go`** :

```go
package main

import (
    "fmt"
    "net/http"
)

// HTML blocks as raw string literal constants
const htmlDocStart = `
<!DOCTYPE html>
<html>
<body>
`

const htmlForm = `
<form action="/" method="post">
  One: <input type="text" name="one"><br><br>
  Two: <input type="text" name="two"><br><br>
  Three: <input type="text" name="three"><br><br>
  <input type="submit" value="Submit Button">
</form>
`

const htmlDocEnd = `
</body>
</html>
`

func main() {
    const (
        PORT = 9001
        HOST = "127.0.0.1"
    )

    http.HandleFunc("/", handler)

    // Backend processing
    fmt.Printf("Starting Go server on port %d...\n", PORT)
    err := http.ListenAndServe(fmt.Sprintf("%s:%d", HOST, PORT), nil)
    if err != nil {
        fmt.Printf("Server error: %v\n", err)
    }
}

// Handle HTTP requests
func handler(w http.ResponseWriter, r *http.Request) {

    // Start the document
    w.Header().Set("Content-Type", "text/html; charset=utf-8")
    
    // Parse the URL for POST entries
    err := r.ParseForm()
    if err != nil {
        http.Error(w, "Error parsing form", http.StatusBadRequest)
        return
    }
    values := r.PostForm

    // Construct the $response variable inside its function
    response := htmlDocStart

    // Append the $response
    /// If no POST entries, say so
    if len(values) == 0 {
        response += `<pre>No form yet.</pre>`
    
    /// If POST entries, show them
    } else {
        response += `<code>`
        
        //// Process only specified POST items
        if one, ok := values["one"]; ok {
            response += fmt.Sprintf("one: %s<br>", one[0])
        }
        if two, ok := values["two"]; ok {
            response += fmt.Sprintf("two: %s<br>", two[0])
        }
        if three, ok := values["three"]; ok {
            response += fmt.Sprintf("three: %s<br>", three[0])
        }
        
        response += `</code><br>`
    }

    // Finish the $response
    response += htmlForm
    response += htmlDocEnd

    // fmt.Fprint the $response
    fmt.Fprint(w, response)
}
```

| **24** :$

```console
go run form-post.go
```

| **B-24** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

<!-- DEV these need to be reviewed for workflow. Eg sometimes a suggess message will appear only with a GET request -->
### Validate & Sanitize with RegEx
*Basic RegEx checks for POST submissions*

#### Python

| **25** :$

```console
code regex-post.py
```

| **`regex-post.py`** :

```py
import http.server
import urllib.parse
import re

PORT = 9001
HOST = "127.0.0.1"

html_doc_start = """
<!DOCTYPE html>
<html>
<body>
"""

html_form = """
<form action="/" method="post">
  Full name: <input type="text" name="fullname"><br><br>
  Username: <input type="text" name="username"><br><br>
  Email: <input type="text" name="email"><br><br>
  Webpage: <input type="text" name="webpage"><br><br>
  Favorite number: <input type="text" name="number"><br><br>
  Password: <input type="password" name="password"><br><br>
  Password again: <input type="password" name="password2"><br><br>
  <input type="submit" value="Submit Button">
</form>
"""

html_doc_end = """
</body>
</html>
"""

class CustomHandler(http.server.SimpleHTTPRequestHandler):
    def do_POST(self):
        content_length = self.headers.get('Content-Length')
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        
        response = html_doc_start
        errors = []

        if content_length:
            post_data = self.rfile.read(int(content_length))
            query_components = urllib.parse.parse_qs(post_data.decode())

            # Validate & sanitize
            if 'fullname' in query_components:
                fullname = query_components['fullname'][0]
                if not re.match(r'^[a-zA-Z ]{6,32}$', fullname, re.IGNORECASE):
                    errors.append("Full name must be 6-32 characters long, containing only letters and spaces.")

            if 'username' in query_components:
                username = query_components['username'][0]
                if not re.match(r'^[a-zA-Z0-9_]{6,32}$', username, re.IGNORECASE):
                    errors.append("Username must be 6-32 characters long, containing only letters, numbers, and underscores.")

            if 'email' in query_components:
                email = query_components['email'][0]
                if not re.match(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', email):
                    errors.append("Invalid email format.")

            if 'webpage' in query_components:
                webpage = query_components['webpage'][0]
                if not re.match(r'^https?://(?:[a-zA-Z0-9.-]+(?:\.[a-zA-Z]{2,6})|[0-9]{1,3}(?:\.[0-9]{1,3}){3})(?:/.*)?$', webpage):
                    errors.append("Invalid URL format.")

            if 'number' in query_components:
                number = query_components['number'][0]
                try:
                    number = int(number)
                    if not (0 <= number <= 100):
                        errors.append("Favorite number must be between 0 and 100.")
                except ValueError:
                    errors.append("Favorite number must be an integer.")

            if 'password' in query_components and 'password2' in query_components:
                password = query_components['password'][0]
                password2 = query_components['password2'][0]
                if password != password2:
                    errors.append("Passwords do not match.")
                elif not re.match(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%]{6,32}$', password):
                    errors.append("Password must be 6-32 characters long, including at least one number, one lowercase letter, one uppercase letter, and one special character.")

            if errors:
                response += '<pre>' + '\n'.join(errors) + '</pre>'
            else:
                response += '<code>Form submitted successfully!</code><br>'

        else:
            response += '<pre>No POST entries.</pre>'

        response += html_form
        response += html_doc_end
        self.wfile.write(response.encode())

    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        response = html_doc_start + '<pre>No form yet.</pre>' + html_form + html_doc_end
        self.wfile.write(response.encode())

if __name__ == "__main__":
    with http.server.HTTPServer((HOST, PORT), CustomHandler) as httpd:
        print(f"Starting Python server on port {PORT}...")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("Server stopped by user.")
```

| **26** :$

```console
python regex-post.py
```

| **B-26** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

#### Node.js

| **27** :$

```console
code regex-post.node
```

| **`regex-post.node`** :

```js
const http = require('http');
const querystring = require('querystring');

const PORT = 9001;
const HOST = '127.0.0.1';

const htmlDocStart = `
<!DOCTYPE html>
<html>
<body>
`;

const htmlForm = `
<form action="/" method="post">
  Full name: <input type="text" name="fullname"><br><br>
  Username: <input type="text" name="username"><br><br>
  Email: <input type="text" name="email"><br><br>
  Webpage: <input type="text" name="webpage"><br><br>
  Favorite number: <input type="text" name="number"><br><br>
  Password: <input type="password" name="password"><br><br>
  Password again: <input type="password" name="password2"><br><br>
  <input type="submit" value="Submit Button">
</form>
`;

const htmlDocEnd = `
</body>
</html>
`;

const server = http.createServer((req, res) => {
    res.writeHead(200, {'Content-Type': 'text/html'});

    let body = '';
    req.on('data', chunk => {
        body += chunk.toString();
    });
    req.on('end', () => {
        const queryObject = querystring.parse(body);
        let response = htmlDocStart;
        let errors = [];

        // Validate & sanitize
        if ('fullname' in queryObject) {
            if (!/^[a-zA-Z ]{6,32}$/i.test(queryObject.fullname)) {
                errors.push("Full name must be 6-32 characters long, containing only letters and spaces.");
            }
        }

        if ('username' in queryObject) {
            if (!/^[a-zA-Z0-9_]{6,32}$/i.test(queryObject.username)) {
                errors.push("Username must be 6-32 characters long, containing only letters, numbers, and underscores.");
            }
        }

        if ('email' in queryObject) {
            if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(queryObject.email)) {
                errors.push("Invalid email format.");
            }
        }

        if ('webpage' in queryObject) {
            if (!/^https?:\/\/(?:[a-zA-Z0-9.-]+(?:\.[a-zA-Z]{2,6})|[0-9]{1,3}(?:\.[0-9]{1,3}){3})(?:\/.*)?$/.test(queryObject.webpage)) {
                errors.push("Invalid URL format.");
            }
        }

        if ('number' in queryObject) {
            let number = parseInt(queryObject.number, 10);
            if (isNaN(number) || number < 0 || number > 100) {
                errors.push("Favorite number must be between 0 and 100.");
            }
        }

        if ('password' in queryObject && 'password2' in queryObject) {
            if (queryObject.password !== queryObject.password2) {
                errors.push("Passwords do not match.");
            } else if (!/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%]{6,32}$/.test(queryObject.password)) {
                errors.push("Password must be 6-32 characters long, including at least one number, one lowercase letter, one uppercase letter, and one special character.");
            }
        }

        if (errors.length) {
            response += `<pre>${errors.join('\n')}</pre>`;
        } else {
            response += `<code>Form submitted successfully!</code><br>`;
        }

        response += htmlForm + htmlDocEnd;
        res.end(response);
    });
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

| **28** :$

```console
node regex-post.node
```

| **B-28** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

#### Go

| **29** :$

```console
code regex-post.go
```

| **`regex-post.go`** :

```go
package main

import (
    "fmt"
    "net/http"
    "regexp"
    "strconv"
    "strings"
    "unicode"
)

const htmlDocStart = `
<!DOCTYPE html>
<html>
<body>
`

const htmlForm = `
<form action="/" method="post">
  Full name: <input type="text" name="fullname"><br><br>
  Username: <input type="text" name="username"><br><br>
  Email: <input type="text" name="email"><br><br>
  Webpage: <input type="text" name="webpage"><br><br>
  Favorite number: <input type="text" name="number"><br><br>
  Password: <input type="password" name="password"><br><br>
  Password again: <input type="password" name="password2"><br><br>
  <input type="submit" value="Submit Button">
</form>
`

const htmlDocEnd = `
</body>
</html>
`

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
    err := r.ParseForm()
    if err != nil {
        http.Error(w, "Error parsing form", http.StatusBadRequest)
        return
    }

    response := htmlDocStart
    var errors []string

    // Validate & sanitize
    if fullname, ok := r.PostForm["fullname"]; ok {
        if !regexp.MustCompile(`^[a-zA-Z ]{6,32}$`).MatchString(fullname[0]) {
            errors = append(errors, "Full name must be 6-32 characters long, containing only letters and spaces.")
        }
    }

    if username, ok := r.PostForm["username"]; ok {
        if !regexp.MustCompile(`^[a-zA-Z0-9_]{6,32}$`).MatchString(username[0]) {
            errors = append(errors, "Username must be 6-32 characters long, containing only letters, numbers, and underscores.")
        }
    }

    if email, ok := r.PostForm["email"]; ok {
        if !regexp.MustCompile(`^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`).MatchString(email[0]) {
            errors = append(errors, "Invalid email format.")
        }
    }

    if webpage, ok := r.PostForm["webpage"]; ok {
        webpageRegex := regexp.MustCompile(`^https?:\/\/(?:[a-zA-Z0-9.-]+(?:\.[a-zA-Z]{2,6})|[0-9]{1,3}(?:\.[0-9]{1,3}){3})(?:\/.*)?$`)
        if !webpageRegex.MatchString(webpage[0]) {
            errors = append(errors, "Invalid URL format.")
        }
    }

    if number, ok := r.PostForm["number"]; ok {
        num, err := strconv.Atoi(number[0])
        if err != nil || num < 0 || num > 100 {
            errors = append(errors, "Favorite number must be between 0 and 100.")
        }
    }

    if password, ok := r.PostForm["password"]; ok {
        if password2, ok := r.PostForm["password2"]; ok {
            if password[0] != password2[0] {
                errors = append(errors, "Passwords do not match.")
            } else {
                // Password validation without lookahead
                if len(password[0]) < 6 || len(password[0]) > 32 {
                    errors = append(errors, "Password must be 6-32 characters long.")
                } else {
                    hasNumber := false
                    hasLower := false
                    hasUpper := false
                    hasSpecial := false
                    for _, char := range password[0] {
                        if unicode.IsDigit(char) {
                            hasNumber = true
                        } else if unicode.IsLower(char) {
                            hasLower = true
                        } else if unicode.IsUpper(char) {
                            hasUpper = true
                        } else if strings.ContainsRune("!@#$%", char) {
                            hasSpecial = true
                        }
                    }
                    if !hasNumber || !hasLower || !hasUpper || !hasSpecial {
                        errors = append(errors, "Password must include at least one number, one lowercase letter, one uppercase letter, and one special character (!@#$%).")
                    }
                }
            }
        }
    }

    if len(errors) > 0 {
        response += `<pre>` + strings.Join(errors, "\n") + `</pre>`
    } else {
        response += `<code>Form submitted successfully!</code><br>`
    }

    response += htmlForm + htmlDocEnd
    fmt.Fprint(w, response)
}
```

| **30** :$

```console
go run regex-post.go
```

| **B-30** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

#### With `.error` styling
*Basic CSS styling for success messages and errors*

| **31** :$

```console
code style.css
```

| **`style.css`** :

```css
form input.error {
    border: 2px solid #cc3333;
}

.error {
    color: #cc3333;
}

.green {
    color: #33cc33;
}
```

##### Python

| **32** :$

```console
code regex-post-css.py
```

| **`regex-post-css.py`** :

```py
import http.server
import urllib.parse
import re

PORT = 9001
HOST = "127.0.0.1"

html_doc_start = """
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="style.css">
</head>
<body>
"""

html_form = """
<form action="/" method="post">
  Full name: <input type="text" name="fullname"><br><br>
  Username: <input type="text" name="username"><br><br>
  Email: <input type="text" name="email"><br><br>
  Webpage: <input type="text" name="webpage"><br><br>
  Favorite number: <input type="text" name="number"><br><br>
  Password: <input type="password" name="password"><br><br>
  Password again: <input type="password" name="password2"><br><br>
  <input type="submit" value="Submit Button">
</form>
"""

html_doc_end = """
</body>
</html>
"""

class CustomHandler(http.server.SimpleHTTPRequestHandler):
    def do_POST(self):
        content_length = self.headers.get('Content-Length')
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        
        response = html_doc_start
        errors = []

        if content_length:
            post_data = self.rfile.read(int(content_length))
            query_components = urllib.parse.parse_qs(post_data.decode())

            # Validate & sanitize
            if 'fullname' in query_components:
                fullname = query_components['fullname'][0]
                if not re.match(r'^[a-zA-Z ]{6,32}$', fullname, re.IGNORECASE):
                    errors.append("Full name must be 6-32 characters long, containing only letters and spaces.")

            if 'username' in query_components:
                username = query_components['username'][0]
                if not re.match(r'^[a-zA-Z0-9_]{6,32}$', username, re.IGNORECASE):
                    errors.append("Username must be 6-32 characters long, containing only letters, numbers, and underscores.")

            if 'email' in query_components:
                email = query_components['email'][0]
                if not re.match(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', email):
                    errors.append("Invalid email format.")

            if 'webpage' in query_components:
                webpage = query_components['webpage'][0]
                if not re.match(r'^https?://(?:[a-zA-Z0-9.-]+(?:\.[a-zA-Z]{2,6})|[0-9]{1,3}(?:\.[0-9]{1,3}){3})(?:/.*)?$', webpage):
                    errors.append("Invalid URL format.")

            if 'number' in query_components:
                number = query_components['number'][0]
                try:
                    number = int(number)
                    if not (0 <= number <= 100):
                        errors.append("Favorite number must be between 0 and 100.")
                except ValueError:
                    errors.append("Favorite number must be an integer.")

            if 'password' in query_components and 'password2' in query_components:
                password = query_components['password'][0]
                password2 = query_components['password2'][0]
                if password != password2:
                    errors.append("Passwords do not match.")
                elif not re.match(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%]{6,32}$', password):
                    errors.append("Password must be 6-32 characters long, including at least one number, one lowercase letter, one uppercase letter, and one special character.")

            if errors:
                response += '<div class="error">' + '<br>'.join(errors) + '</div>'
                for field in ["fullname", "username", "email", "webpage", "number", "password", "password2"]:
                    if field in query_components and any(err.lower().startswith(field) for err in errors):
                        response = response.replace(f'name="{field}"', f'name="{field}" class="error"')
            else:
                response += '<div class="green">Form submitted successfully!</div>'

        else:
            response += '<div class="error">No POST entries.</div>'

        response += html_form
        response += html_doc_end
        self.wfile.write(response.encode())

    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        response = html_doc_start + '<div class="error">No form yet.</div>' + html_form + html_doc_end
        self.wfile.write(response.encode())

if __name__ == "__main__":
    with http.server.HTTPServer((HOST, PORT), CustomHandler) as httpd:
        print(f"Starting Python server on port {PORT}...")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("Server stopped by user.")
```

| **33** :$

```console
python regex-post-css.py
```

| **B-33** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

##### Node.js

| **34** :$

```console
code regex-post-css.node
```

| **`regex-post-css.node`** :

```js
const http = require('http');
const querystring = require('querystring');
const fs = require('fs');

const PORT = 9001;
const HOST = '127.0.0.1';

const htmlDocStart = `
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="style.css">
</head>
<body>
`;

const htmlForm = `
<form action="/" method="post">
  Full name: <input type="text" name="fullname"><br><br>
  Username: <input type="text" name="username"><br><br>
  Email: <input type="text" name="email"><br><br>
  Webpage: <input type="text" name="webpage"><br><br>
  Favorite number: <input type="text" name="number"><br><br>
  Password: <input type="password" name="password"><br><br>
  Password again: <input type="password" name="password2"><br><br>
  <input type="submit" value="Submit Button">
</form>
`;

const htmlDocEnd = `
</body>
</html>
`;

const server = http.createServer((req, res) => {
    res.writeHead(200, {'Content-Type': 'text/html'});

    let body = '';
    req.on('data', chunk => {
        body += chunk.toString();
    });
    req.on('end', () => {
        const queryObject = querystring.parse(body);
        let response = htmlDocStart;
        let errors = [];

        // Validate & sanitize
        if ('fullname' in queryObject) {
            if (!/^[a-zA-Z ]{6,32}$/i.test(queryObject.fullname)) {
                errors.push("Full name must be 6-32 characters long, containing only letters and spaces.");
            }
        }

        if ('username' in queryObject) {
            if (!/^[a-zA-Z0-9_]{6,32}$/i.test(queryObject.username)) {
                errors.push("Username must be 6-32 characters long, containing only letters, numbers, and underscores.");
            }
        }

        if ('email' in queryObject) {
            if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(queryObject.email)) {
                errors.push("Invalid email format.");
            }
        }

        if ('webpage' in queryObject) {
            if (!/^https?:\/\/(?:[a-zA-Z0-9.-]+(?:\.[a-zA-Z]{2,6})|[0-9]{1,3}(?:\.[0-9]{1,3}){3})(?:\/.*)?$/.test(queryObject.webpage)) {
                errors.push("Invalid URL format.");
            }
        }

        if ('number' in queryObject) {
            let number = parseInt(queryObject.number, 10);
            if (isNaN(number) || number < 0 || number > 100) {
                errors.push("Favorite number must be between 0 and 100.");
            }
        }

        if ('password' in queryObject && 'password2' in queryObject) {
            if (queryObject.password !== queryObject.password2) {
                errors.push("Passwords do not match.");
            } else if (!/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%]{6,32}$/.test(queryObject.password)) {
                errors.push("Password must be 6-32 characters long, including at least one number, one lowercase letter, one uppercase letter, and one special character.");
            }
        }

        if (errors.length) {
            response += `<div class="error">${errors.join('<br>')}</div>`;
            Object.keys(queryObject).forEach(field => {
                if (errors.some(err => err.toLowerCase().startsWith(field))) {
                    response = response.replace(`name="${field}"`, `name="${field}" class="error"`);
                }
            });
        } else {
            response += `<div class="green">Form submitted successfully!</div>`;
        }

        response += htmlForm + htmlDocEnd;
        res.end(response);
    });
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

| **35** :$

```console
node regex-post-css.node
```

| **B-35** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

##### Go

| **36** :$

```console
code regex-post-css.go
```

| **`regex-post-css.go`** :

```go
package main

import (
    "fmt"
    "net/http"
    "regexp"
    "strconv"
    "strings"
    "unicode"
)

const htmlDocStart = `
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="style.css">
</head>
<body>
`

const htmlForm = `
<form action="/" method="post">
  Full name: <input type="text" name="fullname"><br><br>
  Username: <input type="text" name="username"><br><br>
  Email: <input type="text" name="email"><br><br>
  Webpage: <input type="text" name="webpage"><br><br>
  Favorite number: <input type="text" name="number"><br><br>
  Password: <input type="password" name="password"><br><br>
  Password again: <input type="password" name="password2"><br><br>
  <input type="submit" value="Submit Button">
</form>
`

const htmlDocEnd = `
</body>
</html>
`

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
    err := r.ParseForm()
    if err != nil {
        http.Error(w, "Error parsing form", http.StatusBadRequest)
        return
    }

    response := htmlDocStart
    var errors []string

    // Validate & sanitize
    if fullname, ok := r.PostForm["fullname"]; ok {
        if !regexp.MustCompile(`^[a-zA-Z ]{6,32}$`).MatchString(fullname[0]) {
            errors = append(errors, "Full name must be 6-32 characters long, containing only letters and spaces.")
        }
    }

    if username, ok := r.PostForm["username"]; ok {
        if !regexp.MustCompile(`^[a-zA-Z0-9_]{6,32}$`).MatchString(username[0]) {
            errors = append(errors, "Username must be 6-32 characters long, containing only letters, numbers, and underscores.")
        }
    }

    if email, ok := r.PostForm["email"]; ok {
        if !regexp.MustCompile(`^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`).MatchString(email[0]) {
            errors = append(errors, "Invalid email format.")
        }
    }

    if webpage, ok := r.PostForm["webpage"]; ok {
        webpageRegex := regexp.MustCompile(`^https?:\/\/(?:[a-zA-Z0-9.-]+(?:\.[a-zA-Z]{2,6})|[0-9]{1,3}(?:\.[0-9]{1,3}){3})(?:\/.*)?$`)
        if !webpageRegex.MatchString(webpage[0]) {
            errors = append(errors, "Invalid URL format.")
        }
    }

    if number, ok := r.PostForm["number"]; ok {
        num, err := strconv.Atoi(number[0])
        if err != nil || num < 0 || num > 100 {
            errors = append(errors, "Favorite number must be between 0 and 100.")
        }
    }

    if password, ok := r.PostForm["password"]; ok {
        if password2, ok := r.PostForm["password2"]; ok {
            if password[0] != password2[0] {
                errors = append(errors, "Passwords do not match.")
            } else {
                // Password validation without lookahead
                if len(password[0]) < 6 || len(password[0]) > 32 {
                    errors = append(errors, "Password must be 6-32 characters long.")
                } else {
                    hasNumber := false
                    hasLower := false
                    hasUpper := false
                    hasSpecial := false
                    for _, char := range password[0] {
                        if unicode.IsDigit(char) {
                            hasNumber = true
                        } else if unicode.IsLower(char) {
                            hasLower = true
                        } else if unicode.IsUpper(char) {
                            hasUpper = true
                        } else if strings.ContainsRune("!@#$%", char) {
                            hasSpecial = true
                        }
                    }
                    if !hasNumber || !hasLower || !hasUpper || !hasSpecial {
                        errors = append(errors, "Password must include at least one number, one lowercase letter, one uppercase letter, and one special character (!@#$%).")
                    }
                }
            }
        }
    }

    if len(errors) > 0 {
        response += `<div class="error">` + strings.Join(errors, "<br>") + `</div>`
        for field := range r.PostForm {
            if strings.Contains(strings.Join(errors, ""), field) {
                htmlForm = strings.ReplaceAll(htmlForm, `name="`+field+`"`, `name="`+field+`" class="error"`)
            }
        }
    } else {
        response += `<div class="green">Form submitted successfully!</div>`
    }

    response += htmlForm + htmlDocEnd
    fmt.Fprint(w, response)
}
```

| **37** :$

```console
go run regex-post-css.go
```

| **B-37** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

___

# The Take

___

#### [Lesson 3: Database Connections](https://github.com/inkVerb/vip/blob/master/701/Lesson-03.md)
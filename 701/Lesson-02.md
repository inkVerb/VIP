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
    
    // Parse the URL for GET entries, no FORM needed for URL-GET
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
    
    // Parse the URL for FORM entries
    err := r.ParseForm()
    if err != nil {
        http.Error(w, "Error parsing form", http.StatusBadRequest)
        return
    }

    // Construct the $response variable inside its function
    response := htmlDocStart

    // Append the $response
    /// If no POST entries, say so
    if len(r.PostForm) == 0 {
    // if len(r.Form) == 0 { // Could also work for FORM, whether GET or POST
        response += `<pre>No form yet.</pre>`
    
    /// If POST entries, show them
    } else {
        response += `<code>`
        
        //// Process only specified POST items
        if one, ok := r.PostForm["one"]; ok {
            response += fmt.Sprintf("one: %s<br>", one[0])
        }
        // Could also work for FORM, whether GET or POST
        // if one := r.FormValue("one"); one != "" {
        //     response += fmt.Sprintf("one: %s<br>", one)
        // }
        if two, ok := r.PostForm["two"]; ok {
            response += fmt.Sprintf("two: %s<br>", two[0])
        }
        // Could also work for FORM, whether GET or POST
        // if two := r.FormValue("two"); two != "" {
        //     response += fmt.Sprintf("two: %s<br>", two)
        // }
        if three, ok := r.PostForm["three"]; ok {
            response += fmt.Sprintf("three: %s<br>", three[0])
        }
        // Could also work for FORM, whether GET or POST
        // if three := r.FormValue("three"); three != "" {
        //     response += fmt.Sprintf("three: %s<br>", three)
        // }
        
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

#### Basic valida-sanitize-quote
##### Python

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
            ## Name
            if 'fullname' in query_components:
                fullname = query_components['fullname'][0]
                if not re.match(r'^[a-zA-Z ]{6,32}$', fullname, re.IGNORECASE):
                    errors.append("Full name must be 6-32 characters long, containing only letters and spaces.")
                else:
                    fullname_s = re.sub(r'[^a-zA-Z ]', '', fullname)[:32]
            else:
                errors.append("No name entered.")
            
            ## Username
            if 'username' in query_components:
                username = query_components['username'][0]
                if not re.match(r'^[a-zA-Z0-9_]{6,32}$', username, re.IGNORECASE):
                    errors.append("Username must be 6-32 characters long, containing only letters, numbers, and underscores.")
                else:
                    username_s = re.sub(r'[^a-zA-Z0-9_]', '', username)[:32]
            else:
                errors.append("No username entered.")
            
            ## Email
            if 'email' in query_components:
                email = query_components['email'][0]
                if not re.match(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', email):
                    errors.append("Invalid email format.")
                else:
                    email_s = re.sub(r'[^a-zA-Z0-9._-@]', '', email)
            else:
                errors.append("No email entered.")
            
            ## Webpage
            if 'webpage' in query_components:
                webpage = query_components['webpage'][0]
                if not re.match(r'^https?://(?:[a-zA-Z0-9.-]+(?:\.[a-zA-Z]{2,6})|[0-9]{1,3}(?:\.[0-9]{1,3}){3})(?:/[^\s]*)?(?:\?[^#\s]*)?$', webpage):
                    errors.append("Invalid URL format.")
                else:
                    webpage_s = re.sub(r'[^a-zA-Z0-9.-:/?=&%]', '', webpage)
            else:
                errors.append("No webpage entered.")
            
            ## Favorite number
            if 'number' in query_components:
                number = query_components['number'][0]
                try:
                    number = int(number)
                    if not (0 <= number <= 100):
                        errors.append("Favorite number must be between 0 and 100.")
                    else:
                        number_s = number
                except ValueError:
                    errors.append("Favorite number must be an integer.")
            else:
                errors.append("No favorite number entered.")
            
            ## Password
            if 'password' in query_components:
                password = query_components['password'][0]
                if not re.match(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9!@#$%]{6,32}$', password):
                    errors.append("Password must be 6-32 characters long, including at least one number, one lowercase letter, one uppercase letter, and one special character.")
                else:
                    password_s = re.sub(r'[^a-zA-Z0-9!@#$%]', '', password)
            else:
                errors.append("No password entered.")

            ## Password match
            if 'password' in query_components and 'password2' in query_components:
                password2 = query_components['password2'][0]
                if password != password2:
                    errors.append("Passwords do not match.")
            else:
                errors.append("Password must be entered twice.")

            # Error/success message
            if errors:
                response += '<pre>' + '\n'.join(errors) + '</pre>'
            else:
                response += '<code>Form submitted successfully!</code><br>'
            
        else:
            response += '<pre>No POST entries.</pre>'
        
        ## Quote for HTML rendering
        fullname_s_h = html.escape(fullname_s)
        username_s_h = html.escape(username_s)
        email_s_h = html.escape(email_s)
        webpage_s_h = html.escape(webpage_s)
        number_s_h = html.escape(fullname_s)
        password_s_h = html.escape(number_s)

        ## Build and display the response
        response += '<p>Name: ' + password_s_h + '</p>'
        response += '<p>Username: ' + username_s_h + '</p>'
        response += '<p>Email: ' + email_s_h + '</p>'
        response += '<p>Webpage: ' + webpage_s_h + '</p>'
        response += '<p>Favorite number: ' + number_s_h + '</p>'
        response += '<p>Password: ' + password_s_h + '</p>'
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

##### Node.js

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
        /// Name
        if ('fullname' in queryObject) {
            if (!/^[a-zA-Z ]{6,32}$/i.test(queryObject.fullname)) {
                errors.push("Full name must be 6-32 characters long, containing only letters and spaces.");
            } else {
                let fullname_s = queryObject.fullname.replace(/[^a-zA-Z ]/g, '').slice(0, 32);
            }
        } else {
            errors.push("No name entered.");
        }
        
        /// Username
        if ('username' in queryObject) {
            if (!/^[a-zA-Z0-9_]{6,32}$/i.test(queryObject.username)) {
                errors.push("Username must be 6-32 characters long, containing only letters, numbers, and underscores.");
            } else {
                let username_s = queryObject.username.replace(/[^a-zA-Z0-9_]/g, '').slice(0, 32);
            }
        } else {
            errors.push("No email entered.");
        }
        
        /// Email
        if ('email' in queryObject) {
            if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(queryObject.email)) {
                errors.push("Invalid email format.");
            } else {
                let email_s = queryObject.email.replace(/[^a-zA-Z0-9._-@]/g, '');
            }
        } else {
            errors.push("No email entered.");
        }
        
        /// Webpage
        if ('webpage' in queryObject) {
            if (!/^https?:\/\/(?:[a-zA-Z0-9.-]+(?:\.[a-zA-Z]{2,6})|[0-9]{1,3}(?:\.[0-9]{1,3}){3})(?:\/[^\s]*)?(?:\?[^#\s]*)?$/.test(queryObject.webpage)) {
                errors.push("Invalid URL format.");
            } else {
                let webpage_s = queryObject.webpage.replace(/[^a-zA-Z0-9.-:/?]/g, '');
            }
        } else {
            errors.push("No webpage entered.");
        }
        
        /// Favorite number
        if ('number' in queryObject) {
            let number = parseInt(queryObject.number, 10);
            if (isNaN(number) || number < 0 || number > 100) {
                errors.push("Favorite number must be between 0 and 100.");
            } else {
                let number_s += number;
            }
        } else {
            errors.push("No favorite number entered.");
        }
        
        /// Password
        if ('password' in queryObject) {
            if (!/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9!@#$%]{6,32}$/.test(queryObject.password)) {
                errors.push("Password must be 6-32 characters long, including at least one number, one lowercase letter, one uppercase letter, and one special character.");
            } else {
                let password_s = queryObject.password.replace(/[^a-zA-Z0-9!@#$%]/g, '');
            }
        } else {
            errors.push("No password entered.");
        }

        /// Password match
        if ('password' in queryObject && 'password2' in queryObject) {
            if (queryObject.password !== queryObject.password2) {
                errors.push("Passwords do not match.");
            } else {
            errors.push("Password must be entered twice.");
            }
        }
        
        // Error/success message
        if (errors.length) {
            response += `<pre>${errors.join('\n')}</pre>`;
        } else {
            response += `<code>Form submitted successfully!</code><br>`;
        }

        /// Create a function to quote HTML special characters
        const escapeHtml = (unsafe) => {
            return unsafe
                .replace(/&/g, "&amp;")
                .replace(/</g, "&lt;")
                .replace(/>/g, "&gt;")
                .replace(/"/g, "&quot;")
                .replace(/'/g, "&#039;");
        };

        /// Quote for HTML rendering
        let fullname_s_h = escapeHtml(fullname_s);
        let username_s_h = escapeHtml(username_s);
        let email_s_h = escapeHtml(email_s);
        let webpage_s_h = escapeHtml(webpage_s);
        let number_s_h = escapeHtml(fullname_s);
        let password_s_h = escapeHtml(number_s);

        /// Build and display the response
        response += '<p>Name: ' + fullname_s + '</p>';
        response += '<p>Username: ' + username_s + '</p>';
        response += '<p>Email: ' + email_s + '</p>';
        response += '<p>Webpage: ' + webpage_s + '</p>';
        response += '<p>Favorite number: ' + number_s + '</p>';
        response += '<p>Password: ' + password_s + '</p>';
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

##### Go

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
    "html"    // for html.EscapeString
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
    /// Name
    if fullname, ok := r.PostForm["fullname"]; ok {
        if !regexp.MustCompile(`^[a-zA-Z ]{6,32}$`).MatchString(fullname[0]) {
            errors = append(errors, "Full name must be 6-32 characters long, containing only letters and spaces.")
        } else {
            sanitized := regexp.MustCompile(`[^a-zA-Z ]`).ReplaceAllString(fullname[0], "")
            if len(sanitized) > 32 {
                sanitized = sanitized[:32]
            }
            var fullname_s = sanitized
        }
    } else {
        errors = append(errors, "No name entered.")
    }
    
    /// Username
    if username, ok := r.PostForm["username"]; ok {
        if !regexp.MustCompile(`^[a-zA-Z0-9_]{6,32}$`).MatchString(username[0]) {
            errors = append(errors, "Username must be 6-32 characters long, containing only letters, numbers, and underscores.")
        } else {
            sanitized := regexp.MustCompile(`[^a-zA-Z0-9_]`).ReplaceAllString(username[0], "")
            if len(sanitized) > 32 {
                sanitized = sanitized[:32]
            }
            var username_s = sanitized
        }
    } else {
        errors = append(errors, "No username entered.")
    }
    
    /// Email
    if email, ok := r.PostForm["email"]; ok {
        if !regexp.MustCompile(`^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`).MatchString(email[0]) {
            errors = append(errors, "Invalid email format.")
        } else {
            var email_s = regexp.MustCompile(`[^a-zA-Z0-9._-@]`).ReplaceAllString(email[0], "")
        }
    } else {
        errors = append(errors, "No email entered.")
    }
    
    /// Webpage
    if webpage, ok := r.PostForm["webpage"]; ok {
        webpageRegex := regexp.MustCompile(`^https?:\/\/(?:[a-zA-Z0-9.-]+(?:\.[a-zA-Z]{2,6})|[0-9]{1,3}(?:\.[0-9]{1,3}){3})(?:\/[^\s]*)?(?:\?[^#\s]*)?$`)
        if !webpageRegex.MatchString(webpage[0]) {
            errors = append(errors, "Invalid URL format.")
        } else {
            var webpage_s = regexp.MustCompile(`[^a-zA-Z0-9.-:/?]`).ReplaceAllString(webpage[0], "")
        }
    }
    
    /// Favorite number
    if number, ok := r.PostForm["number"]; ok {
        num, err := strconv.Atoi(number[0])
        if err != nil || num < 0 || num > 100 {
            errors = append(errors, "Favorite number must be between 0 and 100.")
        } else {
            var number_s = number
        }
    } else {
        errors = append(errors, "No favorite number entered.")
    }
    
    // Password
    if password, ok := r.PostForm["password"]; ok {
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
            } else {
                var password_s = regexp.MustCompile(`[^a-zA-Z0-9!@#$%]`).ReplaceAllString(password[0], "")
            }
        }
    } else {
        errors = append(errors, "No password entered.")
    }

    /// Password match
    if password, ok := r.PostForm["password"]; ok {
        if password2, ok := r.PostForm["password2"]; ok {
            if password[0] != password2[0] {
                errors = append(errors, "Passwords do not match.")
            }
        } else {
            errors = append(errors, "Passwords must be entered twice.")
        }
    }

    // Error/success message
    if len(errors) > 0 {
        response += `<pre>` + strings.Join(errors, "\n") + `</pre>`
    } else if len(errors) <= 0 {
        response += `<code>Form submitted successfully!</code><br>`
    }

    /// Quote for HTML rendering
    var fullname_s_h = html.EscapeString(fullname_s)
    var username_s_h = html.EscapeString(username_s)
    var email_s_h = html.EscapeString(email_s)
    var webpage_s_h = html.EscapeString(webpage_s)
    var number_s_h = html.EscapeString(number_s)
    var password_s_h = html.EscapeString(password_s)

    /// Build and display the response
    response += '<p>Name: ' + fullname_s_h + '</p>'
    response += '<p>Username: ' + username_s_h + '</p>'
    response += '<p>Email: ' + email_s_h + '</p>'
    response += '<p>Webpage: ' + webpage_s_h + '</p>'
    response += '<p>Favorite number: ' + number_s_h + '</p>'
    response += '<p>Password: ' + password_s_h + '</p>'
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

*...That gets included by simply making our HTML document start with this:*

```html
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="style.css">
</head>
<body>
```

*Also, these three examples will dynamically add `class="error"` to the `<form>` through a replace function*

| **Python** :

```py
for key in errors.keys():
    html_form = html_form.replace(f'name="{key}"', f'name="{key}" class="error"')
```

| **Node.js** :

```js
for (let key in errors) {
    htmlForm = htmlForm.replace(new RegExp(`name="${key}"`, 'g'), `name="${key}" class="error"`);
}
```

| **Go** :

```go
for key := range errors {
    htmlForm = strings.Replace(htmlForm, fmt.Sprintf(`name="%s"`, key), fmt.Sprintf(`name="%s" class="error"`, key), -1)
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
        errors = {}

        if content_length:
            post_data = self.rfile.read(int(content_length))
            query_components = urllib.parse.parse_qs(post_data.decode())

            # Validate & sanitize
            ## Name
            if 'fullname' in query_components:
                fullname = query_components['fullname'][0]
                if not re.match(r'^[a-zA-Z ]{6,32}$', fullname, re.IGNORECASE):
                    errors['fullname'] = "Full name must be 6-32 characters long, containing only letters and spaces."
                else:
                    fullname_s = re.sub(r'[^a-zA-Z ]', '', fullname)[:32]
            else:
                errors['fullname'] = "No name entered."
            
            ## Username
            if 'username' in query_components:
                username = query_components['username'][0]
                if not re.match(r'^[a-zA-Z0-9_]{6,32}$', username, re.IGNORECASE):
                    errors['username'] = "Username must be 6-32 characters long, containing only letters, numbers, and underscores."
                else:
                    username_s = re.sub(r'[^a-zA-Z0-9_]', '', username)[:32]
            else:
                errors['username'] = "No username entered."
            
            ## Email
            if 'email' in query_components:
                email = query_components['email'][0]
                if not re.match(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', email):
                    errors['email'] = "Invalid email format."
                else:
                    email_s = re.sub(r'[^a-zA-Z0-9._-@]', '', email)
            else:
                errors['email'] = "No email entered."
            
            ## Webpage
            if 'webpage' in query_components:
                webpage = query_components['webpage'][0]
                if not re.match(r'^https?://(?:[a-zA-Z0-9.-]+(?:\.[a-zA-Z]{2,6})|[0-9]{1,3}(?:\.[0-9]{1,3}){3})(?:/[^\s]*)?(?:\?[^#\s]*)?$', webpage):
                    errors['webpage'] = "Invalid URL format."
                else:
                    webpage_s = re.sub(r'[^a-zA-Z0-9.-:/?=&%]', '', webpage)
            else:
                errors['webpage'] = "No webpage entered."
            
            ## Favorite number
            if 'number' in query_components:
                number = query_components['number'][0]
                try:
                    number = int(number)
                    if not (0 <= number <= 100):
                        errors['number'] = "Favorite number must be between 0 and 100."
                    else:
                        number_s = number
                except ValueError:
                    errors['number'] = "Favorite number must be an integer."
            else:
                errors['number'] = "No favorite number entered."
            
            ## Password
            if 'password' in query_components:
                password = query_components['password'][0]
                if not re.match(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9!@#$%]{6,32}$', password):
                    errors['password'] = "Password must be 6-32 characters long, including at least one number, one lowercase letter, one uppercase letter, and one special character."
                else:
                    password_s = re.sub(r'[^a-zA-Z0-9!@#$%]', '', password)
            else:
                errors['password'] = "No password entered."

            ## Password match
            if 'password' in query_components and 'password2' in query_components:
                password2 = query_components['password2'][0]
                if password != password2:
                    errors['password2'] = "Passwords do not match."
            else:
                errors['password2'] = "Password must be entered twice."

            # Error/success message
            if errors:
                response += '<code class="error">'
                for key, value in errors.items():
                    response += f'Error in {key}: {value}<br>'
                response += '</code>'
                
                # Dynamically add error class to inputs
                for key in errors.keys():
                    html_form = html_form.replace(f'name="{key}"', f'name="{key}" class="error"')
            else:
                response += '<code class="green">Form submitted successfully!</code><br>'
            
        else:
            response += '<pre>No POST entries.</pre>'
        
        ## Quote for HTML rendering
        fullname_s_h = html.escape(fullname_s)
        username_s_h = html.escape(username_s)
        email_s_h = html.escape(email_s)
        webpage_s_h = html.escape(webpage_s)
        number_s_h = html.escape(number_s)
        password_s_h = html.escape(password_s)

        ## Build and display the response
        response += '<p>Name: ' + fullname_s_h + '</p>'
        response += '<p>Username: ' + username_s_h + '</p>'
        response += '<p>Email: ' + email_s_h + '</p>'
        response += '<p>Webpage: ' + webpage_s_h + '</p>'
        response += '<p>Favorite number: ' + number_s_h + '</p>'
        response += '<p>Password: ' + password_s_h + '</p>'
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
        let errors = {};

        // Validate & sanitize
        /// Name
        if ('fullname' in queryObject) {
            if (!/^[a-zA-Z ]{6,32}$/i.test(queryObject.fullname)) {
                errors['fullname'] = "Full name must be 6-32 characters long, containing only letters and spaces.";
            } else {
                let fullname_s = queryObject.fullname.replace(/[^a-zA-Z ]/g, '').slice(0, 32);
            }
        } else {
            errors['fullname'] = "No name entered.";
        }
        
        /// Username
        if ('username' in queryObject) {
            if (!/^[a-zA-Z0-9_]{6,32}$/i.test(queryObject.username)) {
                errors['username'] = "Username must be 6-32 characters long, containing only letters, numbers, and underscores.";
            } else {
                let username_s = queryObject.username.replace(/[^a-zA-Z0-9_]/g, '').slice(0, 32);
            }
        } else {
            errors['username'] = "No username entered.";
        }
        
        /// Email
        if ('email' in queryObject) {
            if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(queryObject.email)) {
                errors['email'] = "Invalid email format.";
            } else {
                let email_s = queryObject.email.replace(/[^a-zA-Z0-9._-@]/g, '');
            }
        } else {
            errors['email'] = "No email entered.";
        }
        
        /// Webpage
        if ('webpage' in queryObject) {
            if (!/^https?:\/\/(?:[a-zA-Z0-9.-]+(?:\.[a-zA-Z]{2,6})|[0-9]{1,3}(?:\.[0-9]{1,3}){3})(?:\/[^\s]*)?(?:\?[^#\s]*)?$/.test(queryObject.webpage)) {
                errors['webpage'] = "Invalid URL format.";
            } else {
                let webpage_s = queryObject.webpage.replace(/[^a-zA-Z0-9.-:/?]/g, '');
            }
        } else {
            errors['webpage'] = "No webpage entered.";
        }
        
        /// Favorite number
        if ('number' in queryObject) {
            let number = parseInt(queryObject.number, 10);
            if (isNaN(number) || number < 0 || number > 100) {
                errors['number'] = "Favorite number must be between 0 and 100.";
            } else {
                let number_s = number;
            }
        } else {
            errors['number'] = "No favorite number entered.";
        }
        
        /// Password
        if ('password' in queryObject) {
            if (!/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9!@#$%]{6,32}$/.test(queryObject.password)) {
                errors['password'] = "Password must be 6-32 characters long, including at least one number, one lowercase letter, one uppercase letter, and one special character.";
            } else {
                let password_s = queryObject.password.replace(/[^a-zA-Z0-9!@#$%]/g, '');
            }
        } else {
            errors['password'] = "No password entered.";
        }

        /// Password match
        if ('password' in queryObject && 'password2' in queryObject) {
            if (queryObject.password !== queryObject.password2) {
                errors['password2'] = "Passwords do not match.";
            }
        } else {
            errors['password2'] = "Password must be entered twice.";
        }
        
        // Error/success message
        if (Object.keys(errors).length > 0) {
            response += '<code class="error">';
            for (let key in errors) {
                if (errors.hasOwnProperty(key)) {
                    response += `Error in ${key}: ${errors[key]}<br>`;
                }
            }
            response += '</code>';
            
            // Dynamically add error class to inputs
            for (let key in errors) {
                htmlForm = htmlForm.replace(new RegExp(`name="${key}"`, 'g'), `name="${key}" class="error"`);
            }
        } else {
            response += '<code class="green">Form submitted successfully!</code><br>';
        }

        /// Create a function to quote HTML special characters
        const escapeHtml = (unsafe) => {
            return unsafe
                .replace(/&/g, "&amp;")
                .replace(/</g, "&lt;")
                .replace(/>/g, "&gt;")
                .replace(/"/g, "&quot;")
                .replace(/'/g, "&#039;");
        };

        /// Quote for HTML rendering
        let fullname_s_h = escapeHtml(fullname_s);
        let username_s_h = escapeHtml(username_s);
        let email_s_h = escapeHtml(email_s);
        let webpage_s_h = escapeHtml(webpage_s);
        let number_s_h = escapeHtml(fullname_s);
        let password_s_h = escapeHtml(number_s);

        /// Build and display the response
        response += '<p>Name: ' + fullname_s + '</p>';
        response += '<p>Username: ' + username_s + '</p>';
        response += '<p>Email: ' + email_s + '</p>';
        response += '<p>Webpage: ' + webpage_s + '</p>';
        response += '<p>Favorite number: ' + number_s + '</p>';
        response += '<p>Password: ' + password_s + '</p>';
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
    "html"    // for html.EscapeString
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
    errors := make(map[string]string)

    // Validate & sanitize
    /// Name
    if fullname, ok := r.PostForm["fullname"]; ok {
        if !regexp.MustCompile(`^[a-zA-Z ]{6,32}$`).MatchString(fullname[0]) {
            errors["fullname"] = "Full name must be 6-32 characters long, containing only letters and spaces."
        } else {
            sanitized := regexp.MustCompile(`[^a-zA-Z ]`).ReplaceAllString(fullname[0], "")
            if len(sanitized) > 32 {
                sanitized = sanitized[:32]
            }
            var fullname_s = sanitized
        }
    } else {
        errors["fullname"] = "No name entered."
    }
    
    /// Username
    if username, ok := r.PostForm["username"]; ok {
        if !regexp.MustCompile(`^[a-zA-Z0-9_]{6,32}$`).MatchString(username[0]) {
            errors["username"] = "Username must be 6-32 characters long, containing only letters, numbers, and underscores."
        } else {
            sanitized := regexp.MustCompile(`[^a-zA-Z0-9_]`).ReplaceAllString(username[0], "")
            if len(sanitized) > 32 {
                sanitized = sanitized[:32]
            }
            var username_s = sanitized
        }
    } else {
        errors["username"] = "No username entered."
    }
    
    /// Email
    if email, ok := r.PostForm["email"]; ok {
        if !regexp.MustCompile(`^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`).MatchString(email[0]) {
            errors["email"] = "Invalid email format."
        } else {
            var email_s = regexp.MustCompile(`[^a-zA-Z0-9._-@]`).ReplaceAllString(email[0], "")
        }
    } else {
        errors["email"] = "No email entered."
    }
    
    /// Webpage
    if webpage, ok := r.PostForm["webpage"]; ok {
        webpageRegex := regexp.MustCompile(`^https?:\/\/(?:[a-zA-Z0-9.-]+(?:\.[a-zA-Z]{2,6})|[0-9]{1,3}(?:\.[0-9]{1,3}){3})(?:\/[^\s]*)?(?:\?[^#\s]*)?$`)
        if !webpageRegex.MatchString(webpage[0]) {
            errors["webpage"] = "Invalid URL format."
        } else {
            var webpage_s = regexp.MustCompile(`[^a-zA-Z0-9.-:/?]`).ReplaceAllString(webpage[0], "")
        }
    } else {
        errors["webpage"] = "No webpage entered."
    }
    
    /// Favorite number
    if number, ok := r.PostForm["number"]; ok {
        num, err := strconv.Atoi(number[0])
        if err != nil || num < 0 || num > 100 {
            errors["number"] = "Favorite number must be between 0 and 100."
        } else {
            var number_s = number
        }
    } else {
        errors["number"] = "No favorite number entered."
    }
    
    // Password
    if password, ok := r.PostForm["password"]; ok {
        if len(password[0]) < 6 || len(password[0]) > 32 {
            errors["password"] = "Password must be 6-32 characters long."
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
                errors["password"] = "Password must include at least one number, one lowercase letter, one uppercase letter, and one special character (!@#$%)."
            } else {
                var password_s = regexp.MustCompile(`[^a-zA-Z0-9!@#$%]`).ReplaceAllString(password[0], "")
            }
        }
    } else {
        errors["password"] = "No password entered."
    }

    /// Password match
    if password, ok := r.PostForm["password"]; ok {
        if password2, ok := r.PostForm["password2"]; ok {
            if password[0] != password2[0] {
                errors["password2"] = "Passwords do not match."
            }
        } else {
            errors["password2"] = "Passwords must be entered twice."
        }
    }

    // Error/success message
    if len(errors) > 0 {
        response += '<code class="error">'
        for key, value := range errors {
            response += fmt.Sprintf("Error in %s: %s<br>", key, value)
        }
        response += '</code>'
        
        // Dynamically add error class to inputs
        for key := range errors {
            htmlForm = strings.Replace(htmlForm, fmt.Sprintf(`name="%s"`, key), fmt.Sprintf(`name="%s" class="error"`, key), -1)
        }
    } else {
        response += '<code class="green">Form submitted successfully!</code><br>'
    }

    /// Quote for HTML rendering
    var fullname_s_h = html.EscapeString(fullname_s)
    var username_s_h = html.EscapeString(username_s)
    var email_s_h = html.EscapeString(email_s)
    var webpage_s_h = html.EscapeString(webpage_s)
    var number_s_h = html.EscapeString(number_s)
    var password_s_h = html.EscapeString(password_s)

    /// Build and display the response
    response += '<p>Name: ' + fullname_s_h + '</p>'
    response += '<p>Username: ' + username_s_h + '</p>'
    response += '<p>Email: ' + email_s_h + '</p>'
    response += '<p>Webpage: ' + webpage_s_h + '</p>'
    response += '<p>Favorite number: ' + number_s_h + '</p>'
    response += '<p>Password: ' + password_s_h + '</p>'
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

#### With `<form>` & function building
*Replacing to add a `class="error"` attribute in a static `<form>` is fun, but it would be better to build each `<input>` with a function that takes errors into consideration*

*Each example will use a `functions.*` file to check POST content and to render a `<form>`. This will generate `<form> <input>` with both `vlaue=` content and any errors*

*The overall file for the rendered page will be smaller so you can see more of the backend language doing the lifting of running a backend web app*

##### Python

| **38** :$

```console
code functions.py regex-post-function.py
```

| **`functions.py`** :

```py
import re

errors = {}

def check_post(name, value):
    global errors
    
    if name == 'fullname':
        if not re.match(r'^[a-zA-Z ]{6,32}$', value, re.IGNORECASE):
            errors[name] = "Full name must be 6-32 characters long, containing only letters and spaces."
            return re.sub(r'[^a-zA-Z ]', '', value)[:32]
    elif name == 'username':
        if not re.match(r'^[a-zA-Z0-9_]{6,32}$', value, re.IGNORECASE):
            errors[name] = "Username must be 6-32 characters long, containing only letters, numbers, and underscores."
            return re.sub(r'[^a-zA-Z0-9_]', '', value)[:32]
    elif name == 'email':
        if not re.match(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', value):
            errors[name] = "Invalid email format."
            return re.sub(r'[^a-zA-Z0-9._-@]', '', value)
    elif name == 'webpage':
        if not re.match(r'^https?://(?:[a-zA-Z0-9.-]+(?:\.[a-zA-Z]{2,6})|[0-9]{1,3}(?:\.[0-9]{1,3}){3})(?:/[^\s]*)?(?:\?[^#\s]*)?$', value):
            errors[name] = "Invalid URL format."
            return re.sub(r'[^a-zA-Z0-9.-:/?=&%]', '', value)
    elif name == 'number':
        try:
            num = int(value)
            if not (0 <= num <= 100):
                errors[name] = "Favorite number must be between 0 and 100."
                return ''
            return num
        except ValueError:
            errors[name] = "Favorite number must be an integer."
            return ''
    elif name == 'password':
        if not re.match(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9!@#$%]{6,32}$', value):
            errors[name] = "Password must be 6-32 characters long, including at least one number, one lowercase letter, one uppercase letter, and one special character."
            return re.sub(r'[^a-zA-Z0-9!@#$%]', '', value)
    return value

def form_input(name, value):
    input_type = 'text' if name not in ['password', 'password2'] else 'password'
    error_class = ' class="error"' if name in errors else ''
    return f'<input type="{input_type}" name="{name}" value="{value}"{error_class}>'
```

| **`regex-post-function.py`** :

```py
from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import parse_qs
import html
import functions # Import our functions file, no file extension needed for .py names in PWD

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

html_doc_end = """
</body>
</html>
"""

class CustomHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        content_length = int(self.headers.get('Content-Length', 0))
        post_data = self.rfile.read(content_length).decode()
        query_components = parse_qs(post_data)
        
        # Validate & Sanitize
        fullname = functions.check_post('fullname', query_components.get('fullname', [''])[0])
        username = functions.check_post('username', query_components.get('username', [''])[0])
        email = functions.check_post('email', query_components.get('email', [''])[0])
        webpage = functions.check_post('webpage', query_components.get('webpage', [''])[0])
        number = functions.check_post('number', query_components.get('number', [''])[0])
        password = functions.check_post('password', query_components.get('password', [''])[0])
        
        if 'password2' in query_components and password != query_components.get('password2', [''])[0]:
            functions.errors['password2'] = "Passwords do not match."

        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        
        response = html_doc_start
        if functions.errors:
            response += '<code class="error">'
            for key, value in functions.errors.items():
                response += f'Error in {key}: {value}<br>'
            response += '</code>'
        else:
            response += '<code class="green">Form submitted successfully!</code><br>'
        
        # Quote for HTML rendering
        fullname_h = html.escape(fullname)
        username_h = html.escape(username)
        email_h = html.escape(email)
        webpage_h = html.escape(webpage)
        number_h = html.escape(str(number))
        password_h = html.escape(password)
        
        # Build and display the response
        response += f'<p>Name: {fullname_h}</p>'
        response += f'<p>Username: {username_h}</p>'
        response += f'<p>Email: {email_h}</p>'
        response += f'<p>Webpage: {webpage_h}</p>'
        response += f'<p>Favorite number: {number_h}</p>'
        response += f'<p>Password: {password_h}</p>'

        # Construct the form
        response += f'<form action="/" method="post">'
        response += f'Full name: {functions.form_input("fullname", fullname)}<br><br>'
        response += f'Username: {functions.form_input("username", username)}<br><br>'
        response += f'Email: {functions.form_input("email", email)}<br><br>'
        response += f'Webpage: {functions.form_input("webpage", webpage)}<br><br>'
        response += f'Favorite number: {functions.form_input("number", number)}<br><br>'
        response += f'Password: {functions.form_input("password", "")}<br><br>'
        response += f'Password again: {functions.form_input("password2", "")}<br><br>'
        response += '<input type="submit" value="Submit Button">'
        response += '</form>'
    
        # Finish & display the document
        response += html_doc_end
        self.wfile.write(response.encode())
        
    # No POST, Python still needs to do this again to return something because of how it handles request methods and variable scope
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        
        # Create empty variables
        fullname = ""
        username = ""
        email = ""
        webpage = ""
        number = ""

        # Construct the form
        response += f'<form action="/" method="post">'
        response += f'Full name: {functions.form_input("fullname", fullname)}<br><br>'
        response += f'Username: {functions.form_input("username", username)}<br><br>'
        response += f'Email: {functions.form_input("email", email)}<br><br>'
        response += f'Webpage: {functions.form_input("webpage", webpage)}<br><br>'
        response += f'Favorite number: {functions.form_input("number", number)}<br><br>'
        response += f'Password: {functions.form_input("password", "")}<br><br>'
        response += f'Password again: {functions.form_input("password2", "")}<br><br>'
        response += '<input type="submit" value="Submit Button">'
        response += '</form>'
    
        # Finish & display the document
        response += html_doc_end
        self.wfile.write(response.encode())

if __name__ == "__main__":
    with HTTPServer((HOST, PORT), CustomHandler) as httpd:
        print(f"Starting Python server on port {PORT}...")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("Server stopped by user.")
```

| **39** :$

```console
python regex-post-function.py
```

| **B-39** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

##### Node.js

| **40** :$

```console
code functions.node regex-post-function.node
```

*Note we use `.js` as the extension for the `functions.*` file so we don't need to specify the file extension in the main Node script*

| **`functions.js`** :

```js
let errors = {};

function checkPost(name, value) {
    switch (name) {
        case 'fullname':
            if (!/^[a-zA-Z ]{6,32}$/i.test(value)) {
                errors[name] = "Full name must be 6-32 characters long, containing only letters and spaces.";
                return value.replace(/[^a-zA-Z ]/g, '').slice(0, 32);
            }
            break;
        case 'username':
            if (!/^[a-zA-Z0-9_]{6,32}$/i.test(value)) {
                errors[name] = "Username must be 6-32 characters long, containing only letters, numbers, and underscores.";
                return value.replace(/[^a-zA-Z0-9_]/g, '').slice(0, 32);
            }
            break;
        case 'email':
            if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(value)) {
                errors[name] = "Invalid email format.";
                return value.replace(/[^a-zA-Z0-9._-@]/g, '');
            }
            break;
        case 'webpage':
            if (!/^https?:\/\/(?:[a-zA-Z0-9.-]+(?:\.[a-zA-Z]{2,6})|[0-9]{1,3}(?:\.[0-9]{1,3}){3})(?:\/[^\s]*)?(?:\?[^#\s]*)?$/.test(value)) {
                errors[name] = "Invalid URL format.";
                return value.replace(/[^a-zA-Z0-9.-:/?]/g, '');
            }
            break;
        case 'number':
            let num = parseInt(value, 10);
            if (isNaN(num) || num < 0 || num > 100) {
                errors[name] = "Favorite number must be between 0 and 100.";
                return '';
            }
            return num;
        case 'password':
            if (!/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9!@#$%]{6,32}$/.test(value)) {
                errors[name] = "Password must be 6-32 characters long, including at least one number, one lowercase letter, one uppercase letter, and one special character.";
                return value.replace(/[^a-zA-Z0-9!@#$%]/g, '');
            }
            break;
    }
    return value;
}

function formInput(name, value) {
    let inputType = name === 'password' ? 'password' : 'text';
    let errorClass = errors[name] ? ' class="error"' : '';
    return `<input type="${inputType}" name="${name}" value="${value ? value : ''}"${errorClass}>`;
}

module.exports = { checkPost, formInput, errors };
```

| **`regex-post-function.node`** :

```js
const http = require('http');
const querystring = require('querystring');
const functions = require('./functions'); // Import our functions file, no file extension needed for .js names

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

const htmlDocEnd = `
</body>
</html>
`;

const server = http.createServer((req, res) => {
    res.writeHead(200, {'Content-Type': 'text/html'});

    let response = htmlDocStart;

    if (req.method === 'POST') {
        let body = '';
        req.on('data', chunk => {
            body += chunk.toString();
        });
        req.on('end', () => {
            const queryObject = querystring.parse(body);

            // Validate & Sanitize
            let fullname = functions.checkPost('fullname', queryObject.fullname || '');
            let username = functions.checkPost('username', queryObject.username || '');
            let email = functions.checkPost('email', queryObject.email || '');
            let webpage = functions.checkPost('webpage', queryObject.webpage || '');
            let number = functions.checkPost('number', queryObject.number || '');
            let password = functions.checkPost('password', queryObject.password || '');
            
            if ('password2' in queryObject && password !== queryObject.password2) {
                functions.errors['password2'] = "Passwords do not match.";
            }

            if (Object.keys(functions.errors).length > 0) {
                response += '<code class="error">';
                for (let key in functions.errors) {
                    if (functions.errors.hasOwnProperty(key)) {
                        response += `Error in ${key}: ${functions.errors[key]}<br>`;
                    }
                }
                response += '</code>';
            } else {
                response += '<code class="green">Form submitted successfully!</code><br>';
            }

            // Quote for HTML rendering
            const escapeHtml = (unsafe) => {
                return unsafe
                    .replace(/&/g, "&")
                    .replace(/</g, "<")
                    .replace(/>/g, ">")
                    .replace(/"/g, """)
                    .replace(/'/g, "'");
            };
            let fullname_h = escapeHtml(fullname);
            let username_h = escapeHtml(username);
            let email_h = escapeHtml(email);
            let webpage_h = escapeHtml(webpage);
            let number_h = escapeHtml(number);
            let password_h = escapeHtml(password);

            // Build and display the response
            response += '<p>Name: ' + fullname_h + '</p>';
            response += '<p>Username: ' + username_h + '</p>';
            response += '<p>Email: ' + email_h + '</p>';
            response += '<p>Webpage: ' + webpage_h + '</p>';
            response += '<p>Favorite number: ' + number_h + '</p>';
            response += '<p>Password: ' + password_h + '</p>';

            // Construct the form
            response += '<form action="/" method="post">';
            response += `Full name: ${functions.formInput("fullname", fullname)}<br><br>`;
            response += `Username: ${functions.formInput("username", username)}<br><br>`;
            response += `Email: ${functions.formInput("email", email)}<br><br>`;
            response += `Webpage: ${functions.formInput("webpage", webpage)}<br><br>`;
            response += `Favorite number: ${functions.formInput("number", number)}<br><br>`;
            response += `Password: ${functions.formInput("password", "")}<br><br>`;
            response += `Password again: ${functions.formInput("password2", "")}<br><br>`;
            response += '<input type="submit" value="Submit Button">';
            response += '</form>';
    
            // Finish & display the document
            response += htmlDocEnd;
            res.end(response);

        });

    // No POST, still needs to do this again because of variable scope
    } else {

        // Create empty variables
        let fullname = "";
        let username = "";
        let email = "";
        let webpage = "";
        let number = "";

        // Construct the form
        response += '<form action="/" method="post">';
        response += `Full name: ${functions.formInput("fullname", fullname)}<br><br>`;
        response += `Username: ${functions.formInput("username", username)}<br><br>`;
        response += `Email: ${functions.formInput("email", email)}<br><br>`;
        response += `Webpage: ${functions.formInput("webpage", webpage)}<br><br>`;
        response += `Favorite number: ${functions.formInput("number", number)}<br><br>`;
        response += `Password: ${functions.formInput("password", "")}<br><br>`;
        response += `Password again: ${functions.formInput("password2", "")}<br><br>`;
        response += '<input type="submit" value="Submit Button">';
        response += '</form>';

        // Finish & display the document
        response += htmlDocEnd;
        res.end(response);
    }

    
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

| **41** :$

```console
node regex-post-function.node
```

| **B-41** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

##### Go

| **42** :$

```console
code functions.go regex-post-function.go
```

| **`functions.go`** :

```go
package main // With this, we don't need any include or require statement in the main .go script file

import (
    "net/url"
    "regexp"
    "strconv"
)

var errors map[string]string

func init() {
    errors = make(map[string]string)
}

func checkPost(name, value string) string {
    switch name {
    case "fullname":
        if !regexp.MustCompile(`^[a-zA-Z ]{6,32}$`).MatchString(value) {
            errors[name] = "Full name must be 6-32 characters long, containing only letters and spaces."
            return regexp.MustCompile(`[^a-zA-Z ]`).ReplaceAllString(value, "")[:32]
        }
    case "username":
        if !regexp.MustCompile(`^[a-zA-Z0-9_]{6,32}$`).MatchString(value) {
            errors[name] = "Username must be 6-32 characters long, containing only letters, numbers, and underscores."
            return regexp.MustCompile(`[^a-zA-Z0-9_]`).ReplaceAllString(value, "")[:32]
        }
    case "email":
        if !regexp.MustCompile(`^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`).MatchString(value) {
            errors[name] = "Invalid email format."
            return regexp.MustCompile(`[^a-zA-Z0-9._-@]`).ReplaceAllString(value, "")
        }
    case "webpage":
        webpageRegex := regexp.MustCompile(`^https?:\/\/(?:[a-zA-Z0-9.-]+(?:\.[a-zA-Z]{2,6})|[0-9]{1,3}(?:\.[0-9]{1,3}){3})(?:\/[^\s]*)?(?:\?[^#\s]*)?$`)
        if !webpageRegex.MatchString(value) {
            errors[name] = "Invalid URL format."
            return regexp.MustCompile(`[^a-zA-Z0-9.-:/?]`).ReplaceAllString(value, "")
        }
    case "number":
        num, err := strconv.Atoi(value)
        if err != nil || num < 0 || num > 100 {
            errors[name] = "Favorite number must be between 0 and 100."
            return ""
        }
        return value
    case "password":
        if !regexp.MustCompile(`^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9!@#$%]{6,32}$`).MatchString(value) {
            errors[name] = "Password must be 6-32 characters long, including at least one number, one lowercase letter, one uppercase letter, and one special character."
            return regexp.MustCompile(`[^a-zA-Z0-9!@#$%]`).ReplaceAllString(value, "")
        }
    }
    return value
}

func formInput(name, value string) string {
    inputType := "text"
    if name == "password" {
        inputType = "password"
    }
    errorClass := ""
    if _, ok := errors[name]; ok {
        errorClass = ` class="error"`
    }
    return `<input type="` + inputType + `" name="` + name + `" value="` + value + `" ` + errorClass + `>`
}
```

| **`regex-post-function.go`** :

```go
package main

import (
    "fmt"
    "net/http"
    "html"
)

const htmlDocStart = `
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="style.css">
</head>
<body>
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
    
    var response = htmlDocStart

    if r.Method == "POST" {
    // if r.Method == "GET" { // If you want to test for GET and use the same code below with <form method="post">
        err := r.ParseForm()
        if err != nil {
            http.Error(w, "Error parsing form", http.StatusBadRequest)
            return
        }

        // Validate & Sanitize
        //// POST or GET
        fullname := checkPost("fullname", r.FormValue("fullname"))
        username := checkPost("username", r.FormValue("username"))
        email := checkPost("email", r.FormValue("email"))
        webpage := checkPost("webpage", r.FormValue("webpage"))
        number := checkPost("number", r.FormValue("number"))
        password := checkPost("password", r.FormValue("password"))
        //// Only POST, but would need testing for nil[0] to avoid a runtime panic if any iterm were empty
        // fullname := checkPost("fullname", r.PostForm["fullname"][0])
        // username := checkPost("username", r.PostForm["username"][0])
        // email := checkPost("email", r.PostForm["email"][0])
        // webpage := checkPost("webpage", r.PostForm["webpage"][0])
        // number := checkPost("number", r.PostForm["number"][0])
        // password := checkPost("password", r.PostForm["password"][0])

        if r.FormValue("password2") != password {
            errors["password2"] = "Passwords do not match."
        }

        if len(errors) > 0 {
            response += `<code class="error">`
            for key, value := range errors {
                response += fmt.Sprintf("Error in %s: %s<br>", key, value)
            }
            response += `</code>`
        } else {
            response += `<code class="green">Form submitted successfully!</code><br>`
        }

        // Quote for HTML rendering
        fullname_h := html.EscapeString(fullname)
        username_h := html.EscapeString(username)
        email_h := html.EscapeString(email)
        webpage_h := html.EscapeString(webpage)
        number_h := html.EscapeString(number)
        password_h := html.EscapeString(password)

        // Build and display the response
        response += fmt.Sprintf("<p>Name: %s</p>", fullname_h)
        response += fmt.Sprintf("<p>Username: %s</p>", username_h)
        response += fmt.Sprintf("<p>Email: %s</p>", email_h)
        response += fmt.Sprintf("<p>Webpage: %s</p>", webpage_h)
        response += fmt.Sprintf("<p>Favorite number: %s</p>", number_h)
        response += fmt.Sprintf("<p>Password: %s</p>", password_h)

        // Construct the form
        response += `<form action="/" method="post">`
        response += `Full name: ` + formInput("fullname", fullname) + `<br><br>`
        response += `Username: ` + formInput("username", username) + `<br><br>`
        response += `Email: ` + formInput("email", email) + `<br><br>`
        response += `Webpage: ` + formInput("webpage", webpage) + `<br><br>`
        response += `Favorite number: ` + formInput("number", number) + `<br><br>`
        response += `Password: ` + formInput("password", "") + `<br><br>`
        response += `Password again: ` + formInput("password2", "") + `<br><br>`
        response += `<input type="submit" value="Submit Button">`
        response += `</form>`
        
        // Finish & display the document
        response += htmlDocEnd
        fmt.Fprint(w, response)

    // No POST, still needs to do this again because of variable scope
    } else {

        // Create empty variables
        fullname := ""
        username := ""
        email := ""
        webpage := ""
        number := ""

        // Construct the form
        response += `<form action="/" method="post">`
        response += `Full name: ` + formInput("fullname", fullname) + `<br><br>`
        response += `Username: ` + formInput("username", username) + `<br><br>`
        response += `Email: ` + formInput("email", email) + `<br><br>`
        response += `Webpage: ` + formInput("webpage", webpage) + `<br><br>`
        response += `Favorite number: ` + formInput("number", number) + `<br><br>`
        response += `Password: ` + formInput("password", "") + `<br><br>`
        response += `Password again: ` + formInput("password2", "") + `<br><br>`
        response += `<input type="submit" value="Submit Button">`
        response += `</form>`
    
        // Finish & display the document
        response += htmlDocEnd
        fmt.Fprint(w, response)
    }
}
```

| **43** :$

```console
go run regex-post-function.go
```

| **B-43** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

___

# The Take
- Go does not need to specify importing other files in the same directory that use `package main`, unlike Python and Node.js
- Nginx can forward an app (Go, Node, Python, etc) running on a port to the standard domain
  - Running on port `9001` normally needs `domain.tld:9001`
  - Nginx uses `proxy_pass http://127.0.0.1:9001;` so `domain.tld` works just the same
- Go, Python, and Node.js can parse GET and POST methods
  - They all need to be prepared before use, unlike PHP
  - Python:
    - Parse the HTTP request:
      - `post_data = self.rfile.read(int(content_length))`
      - `query_components = urllib.parse.parse_qs(post_data.decode())`
    - `<input name="input_name"` = `query_components['fullname'][0]`
  - Node.js:
    - Parse the HTTP request:
      - `req.on('data', chunk => { body += chunk.toString(); });`
      - `const queryObject = querystring.parse(body);`
    - `<input name="input_name"` = `queryObject.input_name`
  - Go:
    - Parse the HTTP request: `func handler(w http.ResponseWriter, r *http.Request)`
    - `values, err := url.ParseQuery(r.URL.RawQuery)` (parse GET from URL)
    - `values := r.PostForm` (parse POST, safe)
      - Both `values` above: `<input name="input_name"` = `values["input_name"]`
    - `if len(r.PostForm) == 0 {` (test for FORM POST presence)
    - `if len(r.Form) == 0 {` (test for FORM presence, whether POST or GET)
    - `if r.Method == "POST" { ... }` (test for POST request method)
    - `if r.Method == "GET" { ... }` (test for GET request method)
      - All `if` above: `<input name="input_name"` = `r.FormValue("input_name")` only from FORM, whether POST or GET
      - Unsafe direct use of `PostForm`: `<input name="input_name"` = `r.PostForm["input_name"][0]` only from POST
        - That `[0]` key on the end is necessary because of how `PostForm` works, not with `FormValue`
        - This could cause a runtime panic in Go if not properly tested for `nil[0]`
___

#### [Lesson 3: Database Connections](https://github.com/inkVerb/vip/blob/master/701/Lesson-03.md)
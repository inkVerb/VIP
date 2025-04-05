# Linux 701
## Lesson 4: URL Rewrite & Parsing

Ready the CLI

```console
cd ~/School/VIP/701
```

Ready services

```console
sudo systemctl start nginx mariadb postgresql
```

___

### Rewrite GET URL
*Make pretty URLs converted to GET values*

*Previously, in [Lesson 5: RewriteMod (Pretty Permalinks)](https://github.com/inkVerb/vip/blob/master/501/Lesson-05.md), we re-wrote URLs using Apache settings in `.htaccess` inside the web folder*

*Python, Node.js, and Go can rewrite URLs as GET values from inside the app itself, meaning that no `.htaccess` `RewriteMod` settings are needed outside of the actual app*

### Single GET URL Value
*First, we will rewrite one, single GET value in the URL*

#### Python
*Create the Python app*

| **1** :$

```console
code rewrite-get.py
```

| **`rewrite-get.py`** :

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
<form action="/" method="get">
  One: <input type="text" name="one"><br><br>
  <input type="submit" value="Submit Button">
</form>
"""

html_doc_end = """
</body>
</html>
"""

class CustomHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        # Parse the path for URL rewrite
        path = self.path
        query_components = {}
        
        # Rewrite rule: /GET-one-here → ?one=GET-one-here
        match = re.match(r'^/([^/]+)$', path)
        if match:
            query_components['one'] = [match.group(1)]
        else:
            # Fallback to standard query string parsing
            parsed_path = urllib.parse.urlparse(path)
            query_components = urllib.parse.parse_qs(parsed_path.query)

        # Start the document
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()

        # Construct the response
        response = html_doc_start

        # Append the response
        if not query_components:
            response += '<pre>No form yet.</pre>'
        else:
            response += '<code>'
            if 'one' in query_components:
                response += f'one: {query_components["one"][0]}<br>'
            response += '</code><br>'

        # Finish the response
        response += html_form
        response += html_doc_end

        # Write the response
        self.wfile.write(response.encode())

if __name__ == "__main__":
    with http.server.HTTPServer((HOST, PORT), CustomHandler) as httpd:
        print(f"Starting Python server on port {PORT}...")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("Server stopped by user.")
```

#### Node.js
*Create the Node.js app*

| **2** :$

```console
code rewrite-get.js
```

| **`rewrite-get.js`** :

```js
const http = require('http');
const url = require('url');

const PORT = 9001;
const HOST = '127.0.0.1';

const htmlDocStart = `
<!DOCTYPE html>
<html>
<body>
`;

const htmlForm = `
<form action="/" method="get">
  One: <input type="text" name="one"><br><br>
  <input type="submit" value="Submit Button">
</form>
`;

const htmlDocEnd = `
</body>
</html>
`;

const server = http.createServer((req, res) => {
    // Parse the path for URL rewrite
    const path = req.url;
    let queryObject = {};

    // Rewrite rule: /GET-one-here → ?one=GET-one-here
    const match = path.match(/^\/([^/]+)$/);
    if (match) {
        queryObject['one'] = match[1];
    } else {
        // Fallback to standard query string parsing
        queryObject = url.parse(req.url, true).query;
    }

    // Start the document
    res.writeHead(200, {'Content-Type': 'text/html'});

    // Construct the response
    let response = htmlDocStart;

    // Append the response
    if (Object.keys(queryObject).length === 0) {
        response += `<pre>No form yet.</pre>`;
    } else {
        response += `<code>`;
        if ('one' in queryObject) response += `one: ${queryObject.one}<br>`;
        response += `</code><br>`;
    }

    // Finish the response
    response += htmlForm;
    response += htmlDocEnd;

    // Send the response
    res.end(response);
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

#### Go
*Create the Go app*

| **3** :$

```console
code rewrite-get.go
```

| **`rewrite-get.go`** :

```go
package main

import (
    "fmt"
    "net/http"
    "net/url"
    "regexp"
)

const htmlDocStart = `
<!DOCTYPE html>
<html>
<body>
`

const htmlForm = `
<form action="/" method="get">
  One: <input type="text" name="one"><br><br>
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
    // Parse the path for URL rewrite
    path := r.URL.Path
    values := url.Values{}

    // Rewrite rule: /GET-one-here → ?one=GET-one-here
    re := regexp.MustCompile(`^/([^/]+)$`)
    if matches := re.FindStringSubmatch(path); len(matches) > 1 {
        values.Set("one", matches[1])
    } else {
        // Fallback to standard query string parsing
        var err error
        values, err = url.ParseQuery(r.URL.RawQuery)
        if err != nil {
            http.Error(w, "Error parsing query", http.StatusBadRequest)
            return
        }
    }

    // Start the document
    w.Header().Set("Content-Type", "text/html; charset=utf-8")

    // Construct the response
    response := htmlDocStart

    // Append the response
    if len(values) == 0 {
        response += `<pre>No form yet.</pre>`
    } else {
        response += `<code>`
        if one, ok := values["one"]; ok {
            response += fmt.Sprintf("one: %s<br>", one[0])
        }
        response += `</code><br>`
    }

    // Finish the response
    response += htmlForm
    response += htmlDocEnd

    // Write the response
    fmt.Fprint(w, response)
}
```

#### Implementation
*Now, see it in action...*

##### Python

| **4** :$

```console
python rewrite-get.py
```

| **B-4** ://

```console
localhost/first-get-arg
```

Operative Python code:

```py
        # Rewrite rule: /GET-one-here → ?one=GET-one-here
        match = re.match(r'^/([^/]+)$', path)
        if match:
            query_components['one'] = [match.group(1)]
        else:
            # Fallback to standard query string parsing
            parsed_path = urllib.parse.urlparse(path)
            query_components = urllib.parse.parse_qs(parsed_path.query)
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

##### Node.js

| **5** :$

```console
node rewrite-get.js
```

| **B-5** ://

```console
localhost/first-get-arg
```

Operative Node.js code:

```js
    // Rewrite rule: /GET-one-here → ?one=GET-one-here
    const match = path.match(/^\/([^/]+)$/);
    if (match) {
        queryObject['one'] = match[1];
    } else {
        // Fallback to standard query string parsing
        queryObject = url.parse(req.url, true).query;
    }
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

##### Go

| **6** :$

```console
go run rewrite-get.go
```

| **B-6** ://

```console
localhost/first-get-arg
```

Operative Go code:

```go
    // Parse the path for URL rewrite
    path := r.URL.Path
    values := url.Values{}

    // Rewrite rule: /GET-one-here → ?one=GET-one-here
    re := regexp.MustCompile(`^/([^/]+)$`)
    if matches := re.FindStringSubmatch(path); len(matches) > 1 {
        values.Set("one", matches[1])
    } else {
        // Fallback to standard query string parsing
        var err error
        values, err = url.ParseQuery(r.URL.RawQuery)
        if err != nil {
            http.Error(w, "Error parsing query", http.StatusBadRequest)
            return
        }
    }

```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

### Multiple GET URL Values
*Now, we will rewrite three GET values in the URL*

#### Python
*Create the Python app*

| **7** :$

```console
code rewrite-multi-get.py
```

| **`rewrite-multi-get.py`** :

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
<form action="/" method="get">
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

class CustomHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        # Parse the path for URL rewrite
        path = self.path
        query_components = {}
        
        # Rewrite rule: /GET-one-here/GET-two-here/GET-three-here → ?one=GET-one-here&two=GET-two-here&three=GET-three-here
        match = re.match(r'^/([^/]+)/([^/]+)/([^/]+)$', path)
        if match:
            query_components['one'] = [match.group(1)]
            query_components['two'] = [match.group(2)]
            query_components['three'] = [match.group(3)]
        else:
            # Fallback to standard query string parsing
            parsed_path = urllib.parse.urlparse(path)
            query_components = urllib.parse.parse_qs(parsed_path.query)

        # Start the document
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()

        # Construct the response
        response = html_doc_start

        # Append the response
        if not query_components:
            response += '<pre>No form yet.</pre>'
        else:
            response += '<code>'
            if 'one' in query_components:
                response += f'one: {query_components["one"][0]}<br>'
            if 'two' in query_components:
                response += f'two: {query_components["two"][0]}<br>'
            if 'three' in query_components:
                response += f'three: {query_components["three"][0]}<br>'
            response += '</code><br>'

        # Finish the response
        response += html_form
        response += html_doc_end

        # Write the response
        self.wfile.write(response.encode())

if __name__ == "__main__":
    with http.server.HTTPServer((HOST, PORT), CustomHandler) as httpd:
        print(f"Starting Python server on port {PORT}...")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("Server stopped by user.")
```

#### Node.js
*Create the Node.js app*

| **8** :$

```console
code rewrite-multi-get.js
```

| **`rewrite-multi-get.js`** :

```js
const http = require('http');
const url = require('url');

const PORT = 9001;
const HOST = '127.0.0.1';

const htmlDocStart = `
<!DOCTYPE html>
<html>
<body>
`;

const htmlForm = `
<form action="/" method="get">
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

const server = http.createServer((req, res) => {
    // Parse the path for URL rewrite
    const path = req.url;
    let queryObject = {};

    // Rewrite rule: /GET-one-here/GET-two-here/GET-three-here → ?one=GET-one-here&two=GET-two-here&three=GET-three-here
    const match = path.match(/^\/([^/]+)\/([^/]+)\/([^/]+)$/);
    if (match) {
        queryObject['one'] = match[1];
        queryObject['two'] = match[2];
        queryObject['three'] = match[3];
    } else {
        // Fallback to standard query string parsing
        queryObject = url.parse(req.url, true).query;
    }

    // Start the document
    res.writeHead(200, {'Content-Type': 'text/html'});

    // Construct the response
    let response = htmlDocStart;

    // Append the response
    if (Object.keys(queryObject).length === 0) {
        response += `<pre>No form yet.</pre>`;
    } else {
        response += `<code>`;
        if ('one' in queryObject) response += `one: ${queryObject.one}<br>`;
        if ('two' in queryObject) response += `two: ${queryObject.two}<br>`;
        if ('three' in queryObject) response += `three: ${queryObject.three}<br>`;
        response += `</code><br>`;
    }

    // Finish the response
    response += htmlForm;
    response += htmlDocEnd;

    // Send the response
    res.end(response);
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

#### Go
*Create the Go app*

| **9** :$

```console
code rewrite-multi-get.go
```

| **`rewrite-multi-get.go`** :

```go
package main

import (
    "fmt"
    "net/http"
    "net/url"
    "regexp"
)

const htmlDocStart = `
<!DOCTYPE html>
<html>
<body>
`

const htmlForm = `
<form action="/" method="get">
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

    fmt.Printf("Starting Go server on port %d...\n", PORT)
    err := http.ListenAndServe(fmt.Sprintf("%s:%d", HOST, PORT), nil)
    if err != nil {
        fmt.Printf("Server error: %v\n", err)
    }
}

func handler(w http.ResponseWriter, r *http.Request) {
    // Parse the path for URL rewrite
    path := r.URL.Path
    values := url.Values{}

    // Rewrite rule: /GET-one-here/GET-two-here/GET-three-here → ?one=GET-one-here&two=GET-two-here&three=GET-three-here
    re := regexp.MustCompile(`^/([^/]+)/([^/]+)/([^/]+)$`)
    if matches := re.FindStringSubmatch(path); len(matches) > 3 {
        values.Set("one", matches[1])
        values.Set("two", matches[2])
        values.Set("three", matches[3])
    } else {
        // Fallback to standard query string parsing
        var err error
        values, err = url.ParseQuery(r.URL.RawQuery)
        if err != nil {
            http.Error(w, "Error parsing query", http.StatusBadRequest)
            return
        }
    }

    // Start the document
    w.Header().Set("Content-Type", "text/html; charset=utf-8")

    // Construct the response
    response := htmlDocStart

    // Append the response
    if len(values) == 0 {
        response += `<pre>No form yet.</pre>`
    } else {
        response += `<code>`
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

    // Finish the response
    response += htmlForm
    response += htmlDocEnd

    // Write the response
    fmt.Fprint(w, response)
}
```

#### Implementation
*Now, see it in action...*

##### Python

| **10** :$

```console
python rewrite-multi-get.py
```

| **B-10** ://

```console
localhost/first-get-arg
```

Operative Python code:

```py
        # Rewrite rule: /GET-one-here/GET-two-here/GET-three-here → ?one=GET-one-here&two=GET-two-here&three=GET-three-here
        match = re.match(r'^/([^/]+)/([^/]+)/([^/]+)$', path)
        if match:
            query_components['one'] = [match.group(1)]
            query_components['two'] = [match.group(2)]
            query_components['three'] = [match.group(3)]
        else:
            # Fallback to standard query string parsing
            parsed_path = urllib.parse.urlparse(path)
            query_components = urllib.parse.parse_qs(parsed_path.query)
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

##### Node.js

| **11** :$

```console
node rewrite-multi-get.js
```

| **B-11** ://

```console
localhost/first-get-arg
```

Operative Node.js code:

```js
    // Rewrite rule: /GET-one-here/GET-two-here/GET-three-here → ?one=GET-one-here&two=GET-two-here&three=GET-three-here
    const match = path.match(/^\/([^/]+)\/([^/]+)\/([^/]+)$/);
    if (match) {
        queryObject['one'] = match[1];
        queryObject['two'] = match[2];
        queryObject['three'] = match[3];
    } else {
        // Fallback to standard query string parsing
        queryObject = url.parse(req.url, true).query;
    }
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

##### Go

| **12** :$

```console
go run rewrite-multi-get.go
```

| **B-12** ://

```console
localhost/first-get-arg
```

Operative Go code:

```go
    // Rewrite rule: /GET-one-here/GET-two-here/GET-three-here → ?one=GET-one-here&two=GET-two-here&three=GET-three-here
    re := regexp.MustCompile(`^/([^/]+)/([^/]+)/([^/]+)$`)
    if matches := re.FindStringSubmatch(path); len(matches) > 3 {
        values.Set("one", matches[1])
        values.Set("two", matches[2])
        values.Set("three", matches[3])
    } else {
        // Fallback to standard query string parsing
        var err error
        values, err = url.ParseQuery(r.URL.RawQuery)
        if err != nil {
            http.Error(w, "Error parsing query", http.StatusBadRequest)
            return
        }
    }
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

### User Profile with Pretty URL Rewrite
*Display user profile based on database entries from our backend app in [Lesson 3](https://github.com/inkVerb/vip/blob/master/701/Lesson-03.md)*

#### CSS Additions

| **13** :$

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

/* Table styling */

table {
    border-collapse: collapse;
    margin: 0.625em 0;
}

th, td {
    padding: 0.5em;
    text-align: left;
}

/* Automatically alternate table row colors without needing server-side logic */
tr:nth-child(even) {
    background-color: #DDD;
}

tr:nth-child(odd) {
    background-color: #FFF;
}

/* Class for Profile view*/
.profile {
    margin: 1em 0;
    padding: 1em;
    border: 1px solid #CCC;
    background-color: #F9F9F9;
}
```

#### Update Backend App for Public Profile Link
##### Python

| **14** :$

```console
code backend-users-app.py profile.py
```

| **`backend-users-app.py`** :

```py
from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import parse_qs, urlparse
import html
import functions
import db_process
import profile  # Import profile module

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
        # [Unchanged POST logic from your version]
        content_length = int(self.headers.get('Content-Length', 0))
        post_data = self.rfile.read(content_length).decode()
        query_components = parse_qs(post_data)
        # ... [rest of POST logic]
        self.wfile.write(response.encode())

    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        
        response = html_doc_start
        path = self.path
        parsed_url = urlparse(path)
        query = parse_qs(parsed_url.query)
        
        # Use profile module for /profile/<username>
        if path.startswith('/profile/'):
            response += profile.handle_profile_request(path)
        elif parsed_url.path == "/edit" and 'username' in query:
            # [Unchanged edit logic]
            username = query['username'][0]
            user = db_process.get_user(username)
            # ... [rest of edit logic]
        else:
            # [Unchanged user list logic]
            response += '<a href="/"><input type="submit" name="process" value="Create"></a><br><br>'
            users = db_process.get_all_users()
            # ... [rest of list logic]
        
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

| **`profile.py`** :

```py
import re
import html
import db_process

def handle_profile_request(path):
    match = re.match(r'^/profile/([^/]+)$', path)
    if match:
        username = match.group(1)
        user = db_process.get_user(username)
        if user:
            return f'<div class="profile"><h2>Profile: {html.escape(user["username"])}</h2><p>Full Name: {html.escape(user["fullname"])}</p><p>Email: {html.escape(user["email"])}</p><p>Webpage: {html.escape(user["webpage"])}</p><p>Favorite Number: {html.escape(str(user["number"]))}</p></div>'
        return '<code class="error">User not found</code>'
    return '<code class="error">Invalid profile URL</code>'
```

##### Node.js

| **15** :$

```console
code backend-users-app.js profile.js
```

| **`backend-users-app.js`** :

```js
const http = require('http');
const querystring = require('querystring');
const url = require('url');
const functions = require('./functions');
const dbProcess = require('./db-process');
const profile = require('./profile');  // Require profile module

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

const server = http.createServer(async (req, res) => {
    res.writeHead(200, {'Content-Type': 'text/html'});
    let response = htmlDocStart;

    const parsedUrl = url.parse(req.url, true);
    const path = parsedUrl.pathname;

    if (req.method === 'GET' && path.startsWith('/profile/')) {
        response += await profile.handleProfileRequest(path);
    } else if (req.method === 'POST') {
        // [Unchanged POST logic from your version]
        let body = await new Promise(resolve => {
            let data = '';
            req.on('data', chunk => data += chunk);
            req.on('end', () => resolve(data));
        });
        const queryObject = querystring.parse(body);
        // ... [rest of POST logic]
    } else if (req.method === 'GET') {
        if (parsedUrl.pathname === '/edit' && parsedUrl.query.username) {
            // [Unchanged edit logic]
            const username = parsedUrl.query.username;
            const user = await dbProcess.getUser(username);
            // ... [rest of edit logic]
        } else {
            // [Unchanged user list logic]
            response += '<a href="/"><input type="submit" name="process" value="Create"></a><br><br>';
            const users = await dbProcess.getAllUsers();
            // ... [rest of list logic]
        }
    }
    
    response += htmlDocEnd;
    res.end(response);
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

| **`profile.js`** :

```js
const dbProcess = require('./db-process');

async function handleProfileRequest(path) {
    const match = path.match(/^\/profile\/([^/]+)$/);
    if (match) {
        const username = match[1];
        const user = await dbProcess.getUser(username);
        if (user) {
            const escapeHtml = unsafe => unsafe
                .replace(/&/g, "&")
                .replace(/</g, "<")
                .replace(/>/g, ">")
                .replace(/"/g, """)
                .replace(/'/g, "'");
            return `<div class="profile"><h2>Profile: ${escapeHtml(user.username)}</h2><p>Full Name: ${escapeHtml(user.fullname)}</p><p>Email: ${escapeHtml(user.email)}</p><p>Webpage: ${escapeHtml(user.webpage)}</p><p>Favorite Number: ${escapeHtml(String(user.number))}</p></div>`;
        }
        return '<code class="error">User not found</code>';
    }
    return '<code class="error">Invalid profile URL</code>';
}

module.exports = { handleProfileRequest };
```

##### Go

| **16** :$

```console
code backend-users-app.go profile.go
```

| **`backend-users-app.go`** :

```go
package main

import (
    "fmt"
    "net/http"
    "html"
    "net/url"
    "db_process"
    "functions"
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
    http.HandleFunc("/profile/", profileHandler) // Use profile.go's handler

    fmt.Printf("Starting Go server on port %d...\n", PORT)
    err := http.ListenAndServe(fmt.Sprintf("%s:%d", HOST, PORT), nil)
    if err != nil {
        fmt.Printf("Server error: %v\n", err)
    }
}

func handler(w http.ResponseWriter, r *http.Request) {
    // [Unchanged handler logic from your version]
    w.Header().Set("Content-Type", "text/html; charset=utf-8")
    var response = htmlDocStart
    if r.Method == "POST" {
        // ... [POST logic]
    } else {
        // ... [GET logic for /edit and user list]
    }
    response += htmlDocEnd
    fmt.Fprint(w, response)
}
```

| **`profile.go`** :

```go
package main

import (
    "fmt"
    "net/http"
    "html"
    "regexp"
    "db_process"
)

func profileHandler(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "text/html; charset=utf-8")
    var response = htmlDocStart

    re := regexp.MustCompile(`^/profile/([^/]+)$`)
    if matches := re.FindStringSubmatch(r.URL.Path); len(matches) > 1 {
        username := matches[1]
        user, err := db_process.GetUser(username)
        if err == nil {
            response += `<div class="profile">`
            response += fmt.Sprintf(`<h2>Profile: %s</h2>`, html.EscapeString(user["username"]))
            response += fmt.Sprintf(`<p>Full Name: %s</p>`, html.EscapeString(user["fullname"]))
            response += fmt.Sprintf(`<p>Email: %s</p>`, html.EscapeString(user["email"]))
            response += fmt.Sprintf(`<p>Webpage: %s</p>`, html.EscapeString(user["webpage"]))
            response += fmt.Sprintf(`<p>Favorite Number: %s</p>`, html.EscapeString(user["number"]))
            response += `</div>`
        } else {
            response += `<code class="error">User not found</code>`
        }
    } else {
        response += `<code class="error">Invalid profile URL</code>`
    }

    response += htmlDocEnd
    fmt.Fprint(w, response)
}
```

#### Expanded Database Implementations for Public Profile `SELECT`
##### DB Process

| **17** :$

```console
code db-process.py db-process.js db-process.go
```

| **`db-process.py`** :

```py
import sqlite3
import mysql.connector
import psycopg2
import db

def get_db_connection():
    if db.db_type == 'sqlite':
        return sqlite3.connect(db.db_name, check_same_thread=False)
    elif db.db_type == 'mysql':
        return mysql.connector.connect(
            database=db.db_name,
            user=db.db_user,
            password=db.db_pass,
            host=db.db_host
        )
    elif db.db_type == 'postgresql':
        return psycopg2.connect(
            database=db.db_name,
            user=db.db_user,
            password=db.db_pass,
            host=db.db_host
        )
    else:
        raise ValueError(f"Unsupported db_type: {db.db_type}")

def handle_form_submission(process_type, fullname, username, email, webpage, number, password):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        if process_type == "Create":
            if db.db_type == 'sqlite':
                cursor.execute("""
                    INSERT INTO users (fullname, username, email, webpage, number, password, date_created, date_updated)
                    VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
                """, (fullname, username, email, webpage, number, password))
            elif db.db_type in ['mysql', 'postgresql']:
                cursor.execute("""
                    INSERT INTO users (fullname, username, email, webpage, number, password, date_created, date_updated)
                    VALUES (%s, %s, %s, %s, %s, %s, NOW(), NOW())
                """, (fullname, username, email, webpage, number, password))
        elif process_type == "Update":
            if db.db_type == 'sqlite':
                cursor.execute("""
                    UPDATE users SET fullname = ?, email = ?, webpage = ?, number = ?, password = ?, date_updated = CURRENT_TIMESTAMP
                    WHERE username = ?
                """, (fullname, email, webpage, number, password, username))
            elif db.db_type in ['mysql', 'postgresql']:
                cursor.execute("""
                    UPDATE users SET fullname = %s, email = %s, webpage = %s, number = %s, password = %s, date_updated = NOW()
                    WHERE username = %s
                """, (fullname, email, webpage, number, password, username))
        
        conn.commit()
        conn.close()
        return True, ""
    except Exception as e:
        if conn:
            conn.close()
        return False, str(e)

def get_all_users():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT username, fullname, email, webpage, number FROM users")
        if db.db_type == 'sqlite':
            users = [dict(zip(['username', 'fullname', 'email', 'webpage', 'number'], row)) for row in cursor.fetchall()]
        else:
            users = [dict(zip([desc[0] for desc in cursor.description], row)) for row in cursor.fetchall()]
        conn.close()
        return users
    except Exception as e:
        if conn:
            conn.close()
        return []

def get_user(username):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        if db.db_type == 'sqlite':
            cursor.execute("SELECT username, fullname, email, webpage, number, password FROM users WHERE username = ?", (username,))
        elif db.db_type in ['mysql', 'postgresql']:
            cursor.execute("SELECT username, fullname, email, webpage, number, password FROM users WHERE username = %s", (username,))
        user = cursor.fetchone()
        conn.close()
        return dict(zip(['username', 'fullname', 'email', 'webpage', 'number', 'password'], user)) if user else None
    except Exception as e:
        if conn:
            conn.close()
        return None
```

| **`db-process.js`** :

```js
const sqlite3 = require('sqlite3').verbose();
const mysql = require('mysql');
const { Pool } = require('pg');
const db = require('./db');

function getDbConnection() {
    if (db.dbType === 'sqlite') {
        return new sqlite3.Database(db.dbName, sqlite3.OPEN_READWRITE | sqlite3.OPEN_CREATE);
    } else if (db.dbType === 'mysql') {
        return mysql.createConnection({
            database: db.dbName,
            user: db.dbUser,
            password: db.dbPass,
            host: db.dbHost
        });
    } else if (db.dbType === 'postgresql') {
        return new Pool({
            database: db.dbName,
            user: db.dbUser,
            password: db.dbPass,
            host: db.dbHost
        });
    } else {
        throw new Error(`Unsupported dbType: ${db.dbType}`);
    }
}

function handleFormSubmission(processType, fullname, username, email, webpage, number, password) {
    return new Promise((resolve) => {
        const dbConn = getDbConnection();
        
        let query;
        const params = processType === 'Create' ?
            [fullname, username, email, webpage, number, password] :
            [fullname, email, webpage, number, password, username];
        
        if (db.dbType === 'sqlite' || db.dbType === 'mysql') {
            query = processType === 'Create' ?
                `INSERT INTO users (fullname, username, email, webpage, number, password, date_created, date_updated) 
                 VALUES (?, ?, ?, ?, ?, ?, ${db.dbType === 'sqlite' ? 'CURRENT_TIMESTAMP' : 'NOW()'}, ${db.dbType === 'sqlite' ? 'CURRENT_TIMESTAMP' : 'NOW()'})` :
                `UPDATE users SET fullname = ?, email = ?, webpage = ?, number = ?, password = ?, date_updated = ${db.dbType === 'sqlite' ? 'CURRENT_TIMESTAMP' : 'NOW()'} 
                 WHERE username = ?`;
            if (db.dbType === 'sqlite') {
                dbConn.run(query, params, function (err) {
                    dbConn.close();
                    resolve(err ? { success: false, error: err.message } : { success: true, error: '' });
                });
            } else {
                dbConn.query(query, params, (err) => {
                    dbConn.end();
                    resolve(err ? { success: false, error: err.message } : { success: true, error: '' });
                });
            }
        } else if (db.dbType === 'postgresql') {
            query = processType === 'Create' ?
                `INSERT INTO users (fullname, username, email, webpage, number, password, date_created, date_updated) 
                 VALUES ($1, $2, $3, $4, $5, $6, NOW(), NOW())` :
                `UPDATE users SET fullname = $1, email = $2, webpage = $3, number = $4, password = $5, date_updated = NOW() 
                 WHERE username = $6`;
            dbConn.query(query, params, (err) => {
                dbConn.end();
                resolve(err ? { success: false, error: err.message } : { success: true, error: '' });
            });
        }
    });
}

function getAllUsers() {
    return new Promise((resolve) => {
        const dbConn = getDbConnection();
        if (db.dbType === 'postgresql') {
            dbConn.query("SELECT username, fullname, email, webpage, number FROM users", [], (err, result) => {
                dbConn.end();
                resolve(err ? [] : result.rows);
            });
        } else {
            dbConn.all("SELECT username, fullname, email, webpage, number FROM users", [], (err, rows) => {
                dbConn.close();
                resolve(err ? [] : rows);
            });
        }
    });
}

function getUser(username) {
    return new Promise((resolve) => {
        const dbConn = getDbConnection();
        const query = db.dbType === 'sqlite' || db.dbType === 'mysql' ? 
            "SELECT username, fullname, email, webpage, number, password FROM users WHERE username = ?" :
            "SELECT username, fullname, email, webpage, number, password FROM users WHERE username = $1";
        const params = [username];
        
        if (db.dbType === 'postgresql') {
            dbConn.query(query, params, (err, result) => {
                dbConn.end();
                resolve(err || !result.rows[0] ? null : result.rows[0]);
            });
        } else if (db.dbType === 'mysql') {
            dbConn.query(query, params, (err, rows) => {
                dbConn.end();
                resolve(err || rows.length === 0 ? null : rows[0]);
            });
        } else {
            dbConn.get(query, params, (err, row) => {
                dbConn.close();
                resolve(err || !row ? null : row);
            });
        }
    });
}

module.exports = { handleFormSubmission, getAllUsers, getUser };
```

| **`db-process.go`** :

```go
package db_process

import (
    "database/sql"
    "os"
    "strings"
    _ "github.com/go-sql-driver/mysql"
    _ "github.com/lib/pq"
    _ "github.com/mattn/go-sqlite3"
)

var dbType, dbName, dbUser, dbPass, dbHost string

func init() {
    data, _ := os.ReadFile("db.conf")
    lines := strings.Split(string(data), "\n")
    for _, line := range lines {
        if strings.HasPrefix(line, "db_type=") { dbType = strings.TrimPrefix(line, "db_type=") }
        if strings.HasPrefix(line, "db_name=") { dbName = strings.TrimPrefix(line, "db_name=") }
        if strings.HasPrefix(line, "db_user=") { dbUser = strings.TrimPrefix(line, "db_user=") }
        if strings.HasPrefix(line, "db_pass=") { dbPass = strings.TrimPrefix(line, "db_pass=") }
        if strings.HasPrefix(line, "db_host=") { dbHost = strings.TrimPrefix(line, "db_host=") }
    }
}

func getDbConnection() (*sql.DB, error) {
    switch dbType {
    case "sqlite":
        return sql.Open("sqlite3", dbName)
    case "mysql":
        return sql.Open("mysql", dbUser+":"+dbPass+"@tcp("+dbHost+":3306)/"+dbName)
    case "postgresql":
        return sql.Open("postgres", "user="+dbUser+" password="+dbPass+" host="+dbHost+" port=5432 dbname="+dbName+" sslmode=disable")
    default:
        return nil, fmt.Errorf("unsupported db_type: %s", dbType)
    }
}

func HandleFormSubmission(processType, fullname, username, email, webpage, number, password string) (bool, string) {
    dbConn, err := getDbConnection()
    if err != nil {
        return false, err.Error()
    }
    defer dbConn.Close()

    if processType == "Create" {
        if dbType == "sqlite" {
            _, err = dbConn.Exec(`INSERT INTO users (fullname, username, email, webpage, number, password, date_created, date_updated) VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)`, fullname, username, email, webpage, number, password)
        } else {
            _, err = dbConn.Exec(`INSERT INTO users (fullname, username, email, webpage, number, password, date_created, date_updated) VALUES (?, ?, ?, ?, ?, ?, NOW(), NOW())`, fullname, username, email, webpage, number, password)
        }
    } else if processType == "Update" {
        if dbType == "sqlite" {
            _, err = dbConn.Exec(`UPDATE users SET fullname = ?, email = ?, webpage = ?, number = ?, password = ?, date_updated = CURRENT_TIMESTAMP WHERE username = ?`, fullname, email, webpage, number, password, username)
        } else {
            _, err = dbConn.Exec(`UPDATE users SET fullname = ?, email = ?, webpage = ?, number = ?, password = ?, date_updated = NOW() WHERE username = ?`, fullname, email, webpage, number, password, username)
        }
    }
    if err != nil {
        return false, err.Error()
    }
    return true, ""
}

func GetAllUsers() ([]map[string]string, error) {
    dbConn, err := getDbConnection()
    if err != nil {
        return nil, err
    }
    defer dbConn.Close()

    rows, err := dbConn.Query("SELECT username, fullname, email, webpage, number FROM users")
    if err != nil {
        return nil, err
    }
    defer rows.Close()

    var users []map[string]string
    for rows.Next() {
        var username, fullname, email, webpage, number string
        if err := rows.Scan(&username, &fullname, &email, &webpage, &number); err != nil {
            return nil, err
        }
        users = append(users, map[string]string{
            "username": username,
            "fullname": fullname,
            "email": email,
            "webpage": webpage,
            "number": number,
        })
    }
    return users, nil
}

func GetUser(username string) (map[string]string, error) {
    dbConn, err := getDbConnection()
    if err != nil {
        return nil, err
    }
    defer dbConn.Close()

    row := dbConn.QueryRow("SELECT username, fullname, email, webpage, number, password FROM users WHERE username = ?", username)
    var u, f, e, w, n, p string
    if err := row.Scan(&u, &f, &e, &w, &n, &p); err != nil {
        return nil, err
    }
    return map[string]string{
        "username": u,
        "fullname": f,
        "email": e,
        "webpage": w,
        "number": n,
        "password": p,
    }, nil
}
```

*Now, see it in action...*

##### Backend Users App
###### Python

| **18** :$

```console
cp sqlite-db.py db.py
cp backend-users-app.py backend.py
python backend.py
```

| **B-18** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

**Per Database**

*You may want to test the other databases, but we will assume SQLite going forward after this lesson:*

| **SQLite Python** :$

```console
cp sqlite-db.py db.py
python backend.py
```

| **MySQL/MariaDB Python** :$

```console
cp mysql-db.py db.py
python backend.py
```

| **PostgreSQL Python** :$

```console
cp postgres-db.py db.py
python backend.py
```

###### Node.js

| **19** :$

```console
cp sqlite-db.js db.js
cp backend-users-app.js backend.js
node backend.js
```

| **B-19** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

**Per Database**

*We've made the point about integrating other databases, and may continue to update those database files in the future*

*MySQL/MariaDB and PostgreSQL need to be running as services via `systemctl start` in order to be accessed; not so with SQLite*

*So, future lessons will not test MySQL/MariaDB and PostgreSQL explicitly; we will assume SQLite going forward after this lesson*

*If you want to test the other databases, use this reference below after running the first `backend.*` test for any language:*

| **Start the services** :$

```console
sudo systemctl start mariadb postgresql
```

| **SQLite Node.js** :$

```console
cp sqlite-db.js db.js
node backend.js
```

| **MySQL/MariaDB Node.js** :$

```console
cp mysql-db.js db.js
node backend.js
```

| **PostgreSQL Node.js** :$

```console
cp postgres-db.js db.js
node backend.js
```

###### Go

| **20** :$

```console
cp sqlite-db.conf db.conf
cp backend-users-app.go backend.go
go run backend.go profile.go
```

*Note we needed to run both `backend.go` and `profile.go` because they are implied via `package main` in both, but that doesn't kick in until compiled; by arguing both in the `go run` command, they both are included by the `run` interpreter*

| **B-20** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

**Per Database**

*You may want to test the other databases, but we will assume SQLite going forward after this lesson:*

| **SQLite Go** :$

```console
cp sqlite-db.conf db.conf
go run backend.go profile.go
```

| **MySQL/MariaDB Go** :$

```console
cp mysql-db.conf db.conf
go run backend.go profile.go
```

| **PostgreSQL Go** :$

```console
cp postgres-db.conf db.conf
go run backend.go profile.go
```

___

# The Take
## URL Rewrites
- Python, Node.js, and Go handle URL rewrites internally
  - No server modifications are needed as PHP needs in Apache's `.conf` site files, or more commonly `.htaccess`
  - These URL rewrites easily convert to GET arguments that can direct where we need to be within our webapp
  - URL rewrites are often called "pretty URLs"
## Separate Files for Same App
- We can create a separate web product (ie: Profile view page as `profile.*`) in a separate file, but incorporate it into the same deployment
  - Python and Node.js need a kind of statement to include the other file, perhaps as a module
  - Go does not `include` the other file, but implies it through the same package, ie `main` in `package main` for any `.go` files in the same directory at run time or compile time
    - Go will need to `go run` both files if not compiled first
  - This is useful so that each different file could be treated as a different web product, such as for different Product Managers or different Products, etc
    - Specializing the organization also prevents different teams from creating complex conflicts for `git` versioning
## Databases
- MySQL/MariaDB and PostgreSQL need to run as services (via `systemctl start ...`)
  - This takes up system resources
- SQLite is simpler for many reasons:
  - It does not need to run as a service, lightening load on the system and creates less work for the SysAdmin
  - It does not need user or password settings, so config files are simpler
- The database processes are also in a separate file for the same reasons as the `profile.*` file
  - This way, a team or developer focused on SQL calls can maintain that file separately from the overall product roadmap
___

#### [Lesson 5: Async and AJAX](https://github.com/inkVerb/vip/blob/master/701/Lesson-05.md)
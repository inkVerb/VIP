# Linux 701
## Lesson 3: Database Connections

Ready the CLI

```console
cd ~/School/VIP/701
```

Ready services

```console
sudo systemctl start nginx mariadb postgresql
```

___

### Databases
*This lesson will implement four databases into the backend web app we wrote in the previous lesson*

- SQLite
- MySQL/MariaDB
- PostgreSQL

### Basic Backend Structure for `INSERT` and `UPDATE`
*We will use the same three backend files for each of our databases; these files will remain unchanged*

*The database configs and access will be included in separate files*

*Note the filenames will be the same in these scripts, regardless of which database we use:*

- `db.*` for the database config
- `process-db.*` for the implemenation that processes database calls

*Note that we have new "Create" & "Update" `type="submit"` buttons*

*These are the `functions.*` and `backend-app.*` files that will use the database includes...*

#### Python

| **1** :$

```console
code functions.py backend-app.py
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
    elif name == 'password' or name == 'oldpassword':
        if not re.match(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9!@#$%]{6,32}$', value):
            errors[name] = "Password must be 6-32 characters long, including at least one number, one lowercase letter, one uppercase letter, and one special character."
            return re.sub(r'[^a-zA-Z0-9!@#$%]', '', value)
    return value

def form_input(name, value):
    input_type = 'text' if name not in ['password', 'oldpassword', 'password2'] else 'password'
    error_class = ' class="error"' if name in errors else ''
    return f'<input type="{input_type}" name="{name}" value="{value}"{error_class}>'
```

| **`backend-app.py`** :

```py
from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import parse_qs
import html
import functions
import db_process  # Python database module

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
            # Database query
            process_type = query_components.get('process', [''])[0]
            success, db_error = db_process.handle_form_submission(process_type, fullname, username, email, webpage, number, password)
            if success:
                response += '<code class="green">Form submitted successfully!</code><br>'
            else:
                response += f'<code class="error">Database error occurred: {db_error}</code><br>'
        
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
        response += '<input type="submit" name="process" value="Create">'
        if username != "":
            response += '<input type="submit" name="process" value="Update">'
        response += '</form>'
    
        # Finish & display the document
        response += html_doc_end
        self.wfile.write(response.encode())

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
        response = html_doc_start
        response += f'<form action="/" method="post">'
        response += f'Full name: {functions.form_input("fullname", fullname)}<br><br>'
        response += f'Username: {functions.form_input("username", username)}<br><br>'
        response += f'Email: {functions.form_input("email", email)}<br><br>'
        response += f'Webpage: {functions.form_input("webpage", webpage)}<br><br>'
        response += f'Favorite number: {functions.form_input("number", number)}<br><br>'
        response += f'Password: {functions.form_input("password", "")}<br><br>'
        response += f'Password again: {functions.form_input("password2", "")}<br><br>'
        response += '<input type="submit" name="process" value="Create">'
        if username != "":
            response += '<input type="submit" name="process" value="Update">'
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

#### Node.js
- *Node.js broke during course development with a [remarkably common yet unfixed error](https://stackoverflow.com/questions/68441706)*
- *Node.js is untested for this lesson*

| **2** :$

```console
code functions.node backend-app.node
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
        case 'oldpassword':
            if (!/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9!@#$%]{6,32}$/.test(value)) {
                errors[name] = "Password must be 6-32 characters long, including at least one number, one lowercase letter, one uppercase letter, and one special character.";
                return value.replace(/[^a-zA-Z0-9!@#$%]/g, '');
            }
            break;
    }
    return value;
}

function formInput(name, value) {
    let inputType = name === 'password' || name === 'oldpassword' || name === 'password2' ? 'password' : 'text';
    let errorClass = errors[name] ? ' class="error"' : '';
    return `<input type="${inputType}" name="${name}" value="${value ? value : ''}"${errorClass}>`;
}

module.exports = { checkPost, formInput, errors };
```

| **`backend-app.node`** :

```js
const http = require('http');
const querystring = require('querystring');
const functions = require('./functions');

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

    if (req.method === 'POST') {
        let body = await new Promise(resolve => {
            let data = '';
            req.on('data', chunk => data += chunk);
            req.on('end', () => resolve(data));
        });
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
            // Database query
            const processType = queryObject.process || '';
            const result = await dbProcess.handleFormSubmission(processType, fullname, username, email, webpage, number, password);
            if (result.success) {
                response += '<code class="green">Form submitted successfully!</code><br>';
            } else {
                response += `<code class="error">Database error occurred: ${result.error}</code><br>`;
            }
        }

        // Quote for HTML rendering
        const escapeHtml = unsafe => unsafe
            .replace(/&/g, "&")
            .replace(/</g, "<")
            .replace(/>/g, ">")
            .replace(/"/g, """)
            .replace(/'/g, "'");
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
        response += '<input type="submit" name="process" value="Create">';
        if (username !== "") {
            response += '<input type="submit" name="process" value="Update">';
        }
        response += '</form>';
        
        // Finish & display the document
        response += htmlDocEnd;
        res.end(response);

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
        response += '<input type="submit" name="process" value="Create">';
        if (username !== "") {
            response += '<input type="submit" name="process" value="Update">';
        }
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

#### Go

| **3** :$

```console
code functions.go backend-app.go
```

| **`functions.go`** :

```go
package main

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
            // Don't slice unless it is actually longer!
            sanitized := regexp.MustCompile(`[^a-zA-Z ]`).ReplaceAllString(value, "")
            if len(sanitized) > 32 {
                return sanitized[:32]
            }
            return sanitized
        }
    case "username":
        if !regexp.MustCompile(`^[a-zA-Z0-9_]{6,32}$`).MatchString(value) {
            errors[name] = "Username must be 6-32 characters long, containing only letters, numbers, and underscores."
            // Don't slice unless it is actually longer!
            sanitized := regexp.MustCompile(`[^a-zA-Z0-9_]`).ReplaceAllString(value, "")
            if len(sanitized) > 32 {
                return sanitized[:32]
            }
            return sanitized
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
    case "password", "oldpassword":
        if !regexp.MustCompile(`^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9!@#$%]{6,32}$`).MatchString(value) {
            errors[name] = "Password must be 6-32 characters long, including at least one number, one lowercase letter, one uppercase letter, and one special character."
            return regexp.MustCompile(`[^a-zA-Z0-9!@#$%]`).ReplaceAllString(value, "")
        }
    }
    return value
}

func formInput(name, value string) string {
    inputType := "text"
    if name == "password" || name == "oldpassword" {
        inputType = "password"
    }
    errorClass := ""
    if _, ok := errors[name]; ok {
        errorClass = ` class="error"`
    }
    return `<input type="` + inputType + `" name="` + name + `" value="` + value + `" ` + errorClass + `>`
}
```

| **`backend-app.go`** :

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
        err := r.ParseForm()
        if err != nil {
            http.Error(w, "Error parsing form", http.StatusBadRequest)
            return
        }

        // Validate & Sanitize
        fullname := checkPost("fullname", r.FormValue("fullname"))
        username := checkPost("username", r.FormValue("username"))
        email := checkPost("email", r.FormValue("email"))
        webpage := checkPost("webpage", r.FormValue("webpage"))
        number := checkPost("number", r.FormValue("number"))
        password := checkPost("password", r.FormValue("password"))

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
            // Database query
            processType := r.FormValue("process")
            success, dbErr := db_process.HandleFormSubmission(processType, fullname, username, email, webpage, number, password)
            if success {
                response += `<code class="green">Form submitted successfully!</code><br>`
            } else {
                response += fmt.Sprintf(`<code class="error">Database error occurred: %s</code><br>`, dbErr)
            }
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
        response += `<input type="submit" name="process" value="Create">`
        if username != "" { 
            response += `<input type="submit" name="process" value="Update">`
        }
        response += `</form>`
        
        // Finish & display the document
        response += htmlDocEnd
        fmt.Fprint(w, response)

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
        response += `<input type="submit" name="process" value="Create">`
        response += `</form>`
        
        // Finish & display the document
        response += htmlDocEnd
        fmt.Fprint(w, response)
    }
}
```

### Basic Database Implementations for `INSERT` and `UPDATE`
#### SQLite

*Access the SQLite terminal*

| **4** :$

```console
sudo -u www sqlite3 /srv/www/backendapp.db
```

*Create the database and table we need*

```
Database: backendapp.db
```

*Note the database is created when opened, no user or password with SQLite*

| **5** :>

```sql
CREATE TABLE users (
    fullname TEXT NOT NULL,
    username TEXT PRIMARY KEY,
    email TEXT NOT NULL,
    webpage TEXT,
    number INTEGER CHECK (number >= 0 AND number <= 100),
    password TEXT NOT NULL
);
.quit
```

*Note our databse configs (for each backend language)*

| **6** :$

```console
code sqlite-db.py sqlite-db.js sqlite-db.go
```

| **`sqlite-db.py`** :

```py
import sqlite3

def get_db_connection():
    conn = sqlite3.connect('backendapp.db')
    conn.row_factory = sqlite3.Row
    return conn
```

| **`sqlite-db.js`** :

```js
const sqlite3 = require('sqlite3').verbose();

function getDbConnection() {
    return new sqlite3.Database('backendapp.db', (err) => {
        if (err) {
            console.error('SQLite connection error:', err.message);
        }
    });
}

module.exports = { getDbConnection };
```

| **`sqlite-db.go`** :

```go
package main

import (
    "database/sql"
    _ "github.com/mattn/go-sqlite3"
)

func getDbConnection() (*sql.DB, error) {
    db, err := sql.Open("sqlite3", "backendapp.db")
    if err != nil {
        return nil, err
    }
    return db, nil
}
```

*Note our databse process implementations (for each backend language)*

| **7** :$

```console
code sqlite-process.py sqlite-process.js sqlite-process.go
```

| **`sqlite-process.py`** :

```py
import db # db.py

def handle_form_submission(process_type, fullname, username, email, webpage, number, password):
    try:
        conn = db.get_db_connection()
        cursor = conn.cursor()
        
        if process_type == "Create":
            cursor.execute("""
                INSERT INTO users (fullname, username, email, webpage, number, password)
                VALUES (?, ?, ?, ?, ?, ?)
            """, (fullname, username, email, webpage, number, password))
        elif process_type == "Update":
            cursor.execute("""
                UPDATE users SET fullname = ?, email = ?, webpage = ?, number = ?, password = ?
                WHERE username = ?
            """, (fullname, email, webpage, number, password, username))
        
        conn.commit()
        conn.close()
        return True, ""  # DB success
    except Exception as e:
        if conn:
            conn.close()
        return False, str(e) # DB fail
```

| **`sqlite-process.js`** :

```js
const db = require('./db');

function handleFormSubmission(processType, fullname, username, email, webpage, number, password) {
    return new Promise((resolve) => {
        const dbConn = db.getDbConnection();
        
        const query = processType === 'Create' ?
            `INSERT INTO users (fullname, username, email, webpage, number, password) VALUES (?, ?, ?, ?, ?, ?)` :
            `UPDATE users SET fullname = ?, email = ?, webpage = ?, number = ?, password = ? WHERE username = ?`;
        const params = processType === 'Create' ?
            [fullname, username, email, webpage, number, password] :
            [fullname, email, webpage, number, password, username];

        dbConn.run(query, params, function (err) {
            dbConn.close();
            if (err) {
                resolve({ success: false, error: err.message }); // DB fail
            } else {
                resolve({ success: true, error: '' }); // DB success
            }
        });
    });
}

module.exports = { handleFormSubmission };
```

| **`sqlite-process.go`** :

```go
package db_process // Go database package
import "db" // db.go

func HandleFormSubmission(processType, fullname, username, email, webpage, number, password string) (bool, string) {
    dbConn, err := db.GetDbConnection()
    if err != nil {
        return false, err.Error()
    }
    defer dbConn.Close()

    if processType == "Create" {
        _, err = dbConn.Exec(`
            INSERT INTO users (fullname, username, email, webpage, number, password)
            VALUES (?, ?, ?, ?, ?, ?)`,
            fullname, username, email, webpage, number, password)
    } else if processType == "Update" {
        _, err = dbConn.Exec(`
            UPDATE users SET fullname = ?, email = ?, webpage = ?, number = ?, password = ?
            WHERE username = ?`,
            fullname, email, webpage, number, password, username)
    }

    if err != nil {
        return false, err.Error() // DB fail
    }
    return true, "" // DB success
}
```

*Now, see it in action...*

##### Python

| **8** :$

```console
cp sqlite-db.py db.py
cp sqlite-process.py db-process.py
python backend-app.py
```

| **B-8** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

##### Node.js

| **9** :$

```console
cp sqlite-db.js db.js
cp sqlite-process.js db-process.js
node backend-app.node
```

| **B-9** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

| **10** :$

```console
cp sqlite-db.go db.go
cp sqlite-process.go db-process.go
go run backend-app.go
```

| **B-10** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

#### MySQL/MariaDB

*Access the MariaDB terminal*

| **11** :$

```console
sudo systemctl start mariadb
mariadb -u admin -padminpassword
```

*Create the database credentials and table we need*

```
Database: backendapp_db
DB User:  beadbuser
Password: beadbpass
```

| **12** :>

```sql
CREATE DATABASE backendapp_db;
CREATE USER 'beadbuser'@'localhost' IDENTIFIED BY 'beadbpass';
GRANT ALL PRIVILEGES ON backendapp_db.* TO 'beadbuser'@'localhost';
FLUSH PRIVILEGES;
USE backendapp_db;

CREATE TABLE users (
    fullname VARCHAR(32) NOT NULL,
    username VARCHAR(32) PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    webpage VARCHAR(255),
    number INT CHECK (number >= 0 AND number <= 100),
    password VARCHAR(32) NOT NULL
);
quit;
```

*Note our databse configs (for each backend language)*

| **13** :$

```console
code mysql-db.py mysql-db.js mysql-db.go
```

| **`mysql-db.py`** :

```py
import mysql.connector

def get_db_connection():
    conn = mysql.connector.connect(
        host="localhost",
        user="beadbuser",
        password="beadbpass",
        database="backendapp_db"
    )
    return conn
```

| **`mysql-db.js`** :

```js
const mysql = require('mysql');

function getDbConnection() {
    return mysql.createConnection({
        host: 'localhost',
        user: 'beadbuser',
        password: 'beadbpass',
        database: 'backendapp_db'
    });
}

module.exports = { getDbConnection };
```

| **`mysql-db.go`** :

```go
package main

import (
    "database/sql"
    _ "github.com/go-sql-driver/mysql"
)

func getDbConnection() (*sql.DB, error) {
    db, err := sql.Open("mysql", "beadbuser:beadbpass@tcp(127.0.0.1:3306)/backendapp_db")
    if err != nil {
        return nil, err
    }
    return db, nil
}
```

*Note our databse process implementations (for each backend language)*

| **14** :$

```console
code mysql-process.py mysql-process.js mysql-process.go
```

| **`mysql-process.py`** :

```py
import db # db.py

def handle_form_submission(process_type, fullname, username, email, webpage, number, password):
    try:
        conn = db.get_db_connection()
        cursor = conn.cursor()
        
        if process_type == "Create":
            cursor.execute("""
                INSERT INTO users (fullname, username, email, webpage, number, password)
                VALUES (%s, %s, %s, %s, %s, %s)
            """, (fullname, username, email, webpage, number, password))
        elif process_type == "Update":
            cursor.execute("""
                UPDATE users SET fullname = %s, email = %s, webpage = %s, number = %s, password = %s
                WHERE username = %s
            """, (fullname, email, webpage, number, password, username))
        
        conn.commit()
        conn.close()
        return True, ""  # DB success
    except Exception as e:
        if conn:
            conn.close()
        return False, str(e)  # DB fail
```

| **`mysql-process.js`** :

```js
const db = require('./db');

function handleFormSubmission(processType, fullname, username, email, webpage, number, password) {
    return new Promise((resolve) => {
        const dbConn = db.getDbConnection();
        dbConn.connect((err) => {
            if (err) {
                return resolve({ success: false, error: err.message });
            }

            const query = processType === 'Create' ?
                `INSERT INTO users (fullname, username, email, webpage, number, password)
                 VALUES (?, ?, ?, ?, ?, ?)` :
                `UPDATE users SET fullname = ?, email = ?, webpage = ?, number = ?, password = ?
                 WHERE username = ?`;
            const params = processType === 'Create' ?
                [fullname, username, email, webpage, number, password] :
                [fullname, email, webpage, number, password, username];

            dbConn.query(query, params, (err) => {
                dbConn.end();
                if (err) {
                    resolve({ success: false, error: err.message }); // DB fail
                } else {
                    resolve({ success: true, error: '' }); // DB success
                }
            });
        });
    });
}

module.exports = { handleFormSubmission };
```

| **`mysql-process.go`** :

```go
package db_process

import "db"

func HandleFormSubmission(processType, fullname, username, email, webpage, number, password string) (bool, string) {
    dbConn, err := db.GetDbConnection()
    if err != nil {
        return false, err.Error()
    }
    defer dbConn.Close()

    if processType == "Create" {
        _, err = dbConn.Exec(`
            INSERT INTO users (fullname, username, email, webpage, number, password)
            VALUES (?, ?, ?, ?, ?, ?)`,
            fullname, username, email, webpage, number, password)
    } else if processType == "Update" {
        _, err = dbConn.Exec(`
            UPDATE users SET fullname = ?, email = ?, webpage = ?, number = ?, password = ?
            WHERE username = ?`,
            fullname, email, webpage, number, password, username)
    }

    if err != nil {
        return false, err.Error() //DB fail
    }
    return true, "" // DB success
}
```

*Now, see it in action...*

##### Python

| **15** :$

```console
cp mysql-db.py db.py
cp mysql-process.py db-process.py
python backend-app.py
```

| **B-15** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

##### Node.js

| **16** :$

```console
cp mysql-db.js db.js
cp mysql-process.js db-process.js
node backend-app.node
```

| **B-16** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

| **17** :$

```console
cp mysql-db.go db.go
cp mysql-process.go db-process.go
go run backend-app.go
```

| **B-17** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

#### PostgreSQL

*Access the PostgreSQL terminal*

| **18** :$

```console
sudo systemctl start postgresql
PGPASSWORD=adminpassword psql -U admin -d postgres -h localhost -w
```

*Create the database credentials and table we need*

```
Database: backendapp_db
DB User:  beadbuser
Password: beadbpass
```

| **19** :>

```sql
CREATE DATABASE backendapp_db;
CREATE ROLE beadbuser WITH LOGIN PASSWORD 'beadbpass';
GRANT ALL PRIVILEGES ON DATABASE backendapp_db TO beadbuser;
\c backendapp_db

CREATE TABLE users (
    fullname VARCHAR(32) NOT NULL,
    username VARCHAR(32) PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    webpage VARCHAR(255),
    number INT CHECK (number >= 0 AND number <= 100),
    password VARCHAR(32) NOT NULL
);
\q
```

*Note our databse configs (for each backend language)*

| **20** :$

```console
code postgres-db.py postgres-db.js postgres-db.go
```

| **`postgres-db.py`** :

```py
import psycopg2

def get_db_connection():
    conn = psycopg2.connect(
        host="localhost",
        database="backendapp_db",
        user="beadbuser",
        password="beadbpass"
    )
    return conn
```

| **`postgres-db.js`** :

```js
const { Pool } = require('pg');

function getDbConnection() {
    return new Pool({
        host: 'localhost',
        database: 'backendapp_db',
        user: 'beadbuser',
        password: 'beadbpass',
        port: 5432
    });
}

module.exports = { getDbConnection };
```

| **`postgres-db.go`** :

```go
package main

import (
    "database/sql"
    _ "github.com/lib/pq"
)

func getDbConnection() (*sql.DB, error) {
    db, err := sql.Open("postgres", "user=beadbuser password='beadbpass' host=127.0.0.1 port=5432 dbname=backendapp_db sslmode=disable")
    if err != nil {
        return nil, err
    }
    return db, nil
}
```

*Note our databse process implementations (for each backend language)*

| **21** :$

```console
code postgres-process.py postgres-process.js postgres-process.go
```

| **`postgres-process.py`** :

```py
import db

def handle_form_submission(process_type, fullname, username, email, webpage, number, password):
    try:
        conn = db.get_db_connection()
        cursor = conn.cursor()
        
        if process_type == "Create":
            cursor.execute("""
                INSERT INTO users (fullname, username, email, webpage, number, password)
                VALUES (%s, %s, %s, %s, %s, %s)
            """, (fullname, username, email, webpage, number, password))
        elif process_type == "Update":
            cursor.execute("""
                UPDATE users SET fullname = %s, email = %s, webpage = %s, number = %s, password = %s
                WHERE username = %s
            """, (fullname, email, webpage, number, password, username))
        
        conn.commit()
        conn.close()
        return True, "" # DB success
    except Exception as e:
        if conn:
            conn.close()
        return False, str(e) # DB fail
```

| **`postgres-process.js`** :

```js
const db = require('./db');

async function handleFormSubmission(processType, fullname, username, email, webpage, number, password) {
    const dbPool = db.getDbConnection();
    try {
        if (processType === 'Create') {
            await dbPool.query(
                `INSERT INTO users (fullname, username, email, webpage, number, password)
                 VALUES ($1, $2, $3, $4, $5, $6)`,
                [fullname, username, email, webpage, number, password]
            );
        } else if (processType === 'Update') {
            await dbPool.query(
                `UPDATE users SET fullname = $1, email = $2, webpage = $3, number = $4, password = $5
                 WHERE username = $6`,
                [fullname, email, webpage, number, password, username]
            );
        }
        await dbPool.end();
        return { success: true, error: '' }; // DB success
    } catch (err) {
        await dbPool.end();
        return { success: false, error: err.message }; // DB fail
    }
}

module.exports = { handleFormSubmission };
```

| **`postgres-process.go`** :

```go
package db_process

import "db"

func HandleFormSubmission(processType, fullname, username, email, webpage, number, password string) (bool, string) {
    dbConn, err := db.GetDbConnection()
    if err != nil {
        return false, err.Error()
    }
    defer dbConn.Close()

    if processType == "Create" {
        _, err = dbConn.Exec(`
            INSERT INTO users (fullname, username, email, webpage, number, password)
            VALUES ($1, $2, $3, $4, $5, $6)`,
            fullname, username, email, webpage, number, password)
    } else if processType == "Update" {
        _, err = dbConn.Exec(`
            UPDATE users SET fullname = $1, email = $2, webpage = $3, number = $4, password = $5
            WHERE username = $6`,
            fullname, email, webpage, number, password, username)
    }

    if err != nil {
        return false, err.Error() // DB fail
    }
    return true, "" // DB success
}
```

*Now, see it in action...*

##### Python

| **22** :$

```console
cp postgres-db.py db.py
cp postgres-process.py db-process.py
python backend-app.py
```

| **B-22** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

##### Node.js

| **23** :$

```console
cp postgres-db.js db.js
cp postgres-process.js db-process.js
node backend-app.node
```

| **B-23** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

##### Go

| **24** :$

```console
cp postgres-db.go db.go
cp postgres-process.go db-process.go
go run backend-app.go
```

| **B-24** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

### Expanded Backend Structure for `SELECT`
*We will re-write this app to select, edit, and update users in the database*

*Note we will keep `backend-app.*` files unchanged for your reference; now we will use `backend-users-app.*`, then copy and deploy these as `backend.*`*

*Still, we have no login or access restrictions*

*These are only examples of using `INSERT`, `UPDATE`, and now `SELECT`*

*Note our databse configs haven't changed because the database and login credentials are the same*

*Same as before, the filenames will be the same in these scripts, regardless of which database we use:*

- `db.*` for the database config
- `process-db.*` for the implemenation that processes database calls

*Note that we have new HTML tables with links to edit each user*

#### CSS Additions

| **25** :$

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
```


#### Python

| **26** :$

```console
code backend-users-app.py
```

| **`backend-users-app.py`** :

```py
from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import parse_qs, urlparse
import html
import functions
import db_process  # Python database module

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
            # Database query
            process_type = query_components.get('process', [''])[0]
            success, db_error = db_process.handle_form_submission(process_type, fullname, username, email, webpage, number, password)
            if success:
                response += '<code class="green">Form submitted successfully!</code><br>'
            else:
                response += f'<code class="error">Database error occurred: {db_error}</code><br>'
        
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
        if process_type == "Update":
            response += '<input type="submit" name="process" value="Update">'
        else:
            response += '<input type="submit" name="process" value="Create">'
        response += '</form>'
    
        # Finish & display the document
        response += html_doc_end
        self.wfile.write(response.encode())

    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        
        response = html_doc_start
        parsed_url = urlparse(self.path)
        query = parse_qs(parsed_url.query)
        
        if parsed_url.path == "/edit" and 'username' in query:
            # Edit page for a specific user
            username = query['username'][0]
            user = db_process.get_user(username)
            if user:
                fullname = user['fullname']
                email = user['email']
                webpage = user['webpage']
                number = str(user['number'])
                password = user['password']
                # Construct the form (Update only)
                response += f'<form action="/" method="post">'
                response += f'Full name: {functions.form_input("fullname", fullname)}<br><br>'
                response += f'Username: {functions.form_input("username", username)}<br><br>'
                response += f'Email: {functions.form_input("email", email)}<br><br>'
                response += f'Webpage: {functions.form_input("webpage", webpage)}<br><br>'
                response += f'Favorite number: {functions.form_input("number", number)}<br><br>'
                response += f'Password: {functions.form_input("password", "")}<br><br>'
                response += f'Password again: {functions.form_input("password2", "")}<br><br>'
                response += '<input type="submit" name="process" value="Update">'
                response += '</form>'
            else:
                response += '<code class="error">User not found</code><br>'
        else:
            # User list page
            response += '<a href="/"><input type="submit" name="process" value="Create"></a><br><br>'
            users = db_process.get_all_users()
            response += '<table><tr><th>Edit</th><th>Username</th><th>Full Name</th><th>Email</th><th>Webpage</th><th>Favorite Number</th></tr>'
            for user in users:
                response += f'<tr><td><a href="/edit?username={user["username"]}">Edit</a></td><td>{html.escape(user["username"])}</td><td>{html.escape(user["fullname"])}</td><td>{html.escape(user["email"])}</td><td>{html.escape(user["webpage"])}</td><td>{html.escape(str(user["number"]))}</td></tr>'
            response += '</table>'
    
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

#### Node.js

| **27** :$

```console
code backend-users-app.node
```

| **`backend-users-app.node`** :

```js
const http = require('http');
const querystring = require('querystring');
const url = require('url');
const functions = require('./functions');

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

    if (req.method === 'POST') {
        let body = await new Promise(resolve => {
            let data = '';
            req.on('data', chunk => data += chunk);
            req.on('end', () => resolve(data));
        });
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
            // Database query
            const processType = queryObject.process || '';
            const result = await dbProcess.handleFormSubmission(processType, fullname, username, email, webpage, number, password);
            if (result.success) {
                response += '<code class="green">Form submitted successfully!</code><br>';
            } else {
                response += `<code class="error">Database error occurred: ${result.error}</code><br>`;
            }
        }

        // Quote for HTML rendering
        const escapeHtml = unsafe => unsafe
            .replace(/&/g, "&")
            .replace(/</g, "<")
            .replace(/>/g, ">")
            .replace(/"/g, """)
            .replace(/'/g, "'");
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
        if (processType === "Update") {
            response += '<input type="submit" name="process" value="Update">';
        } else {
            response += '<input type="submit" name="process" value="Create">';
        }
        response += '</form>';
        
        // Finish & display the document
        response += htmlDocEnd;
        res.end(response);

    } else {
        const parsedUrl = url.parse(req.url, true);
        if (parsedUrl.pathname === '/edit' && parsedUrl.query.username) {
            // Edit page for a specific user
            const username = parsedUrl.query.username;
            const user = await dbProcess.getUser(username);
            if (user) {
                response += '<form action="/" method="post">';
                response += `Full name: ${functions.formInput("fullname", user.fullname)}<br><br>`;
                response += `Username: ${functions.formInput("username", user.username)}<br><br>`;
                response += `Email: ${functions.formInput("email", user.email)}<br><br>`;
                response += `Webpage: ${functions.formInput("webpage", user.webpage)}<br><br>`;
                response += `Favorite number: ${functions.formInput("number", user.number)}<br><br>`;
                response += `Password: ${functions.formInput("password", "")}<br><br>`;
                response += `Password again: ${functions.formInput("password2", "")}<br><br>`;
                response += '<input type="submit" name="process" value="Update">';
                response += '</form>';
            } else {
                response += '<code class="error">User not found</code><br>';
            }
        } else {
            // User list page
            response += '<a href="/"><input type="submit" name="process" value="Create"></a><br><br>';
            const users = await dbProcess.getAllUsers();
            response += '<table><tr><th>Edit</th><th>Username</th><th>Full Name</th><th>Email</th><th>Webpage</th><th>Favorite Number</th></tr>';
            users.forEach(user => {
                response += `<tr><td><a href="/edit?username=${user.username}">Edit</a></td><td>${escapeHtml(user.username)}</td><td>${escapeHtml(user.fullname)}</td><td>${escapeHtml(user.email)}</td><td>${escapeHtml(user.webpage)}</td><td>${escapeHtml(String(user.number))}</td></tr>`;
            });
            response += '</table>';
        }
        
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

#### Go

| **28** :$

```console
code backend-users-app.go
```

| **`backend-users-app.go`** :

```go
package main

import (
    "fmt"
    "net/http"
    "html"
    "net/url"
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
        err := r.ParseForm()
        if err != nil {
            http.Error(w, "Error parsing form", http.StatusBadRequest)
            return
        }

        // Validate & Sanitize
        fullname := checkPost("fullname", r.FormValue("fullname"))
        username := checkPost("username", r.FormValue("username"))
        email := checkPost("email", r.FormValue("email"))
        webpage := checkPost("webpage", r.FormValue("webpage"))
        number := checkPost("number", r.FormValue("number"))
        password := checkPost("password", r.FormValue("password"))

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
            // Database query
            processType := r.FormValue("process")
            success, dbErr := db_process.HandleFormSubmission(processType, fullname, username, email, webpage, number, password)
            if success {
                response += `<code class="green">Form submitted successfully!</code><br>`
            } else {
                response += fmt.Sprintf(`<code class="error">Database error occurred: %s</code><br>`, dbErr)
            }
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
        if r.FormValue("process") == "Update" {
            response += `<input type="submit" name="process" value="Update">`
        } else {
            response += `<input type="submit" name="process" value="Create">`
        }
        response += `</form>`
        
        // Finish & display the document
        response += htmlDocEnd
        fmt.Fprint(w, response)

    } else {
        parsedUrl, _ := url.Parse(r.URL.String())
        query := parsedUrl.Query()
        if parsedUrl.Path == "/edit" && query.Get("username") != "" {
            // Edit page for a specific user
            username := query.Get("username")
            user, err := db_process.GetUser(username)
            if err == nil {
                response += `<form action="/" method="post">`
                response += `Full name: ` + formInput("fullname", user["fullname"]) + `<br><br>`
                response += `Username: ` + formInput("username", user["username"]) + `<br><br>`
                response += `Email: ` + formInput("email", user["email"]) + `<br><br>`
                response += `Webpage: ` + formInput("webpage", user["webpage"]) + `<br><br>`
                response += `Favorite number: ` + formInput("number", user["number"]) + `<br><br>`
                response += `Password: ` + formInput("password", "") + `<br><br>`
                response += `Password again: ` + formInput("password2", "") + `<br><br>`
                response += `<input type="submit" name="process" value="Update">`
                response += `</form>`
            } else {
                response += `<code class="error">User not found</code><br>`
            }
        } else {
            // User list page
            response += `<a href="/"><input type="submit" name="process" value="Create"></a><br><br>`
            users, _ := db_process.GetAllUsers()
            response += `<table><tr><th>Edit</th><th>Username</th><th>Full Name</th><th>Email</th><th>Webpage</th><th>Favorite Number</th></tr>`
            for _, user := range users {
                response += fmt.Sprintf(`<tr><td><a href="/edit?username=%s">Edit</a></td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>`, 
                    user["username"], html.EscapeString(user["username"]), html.EscapeString(user["fullname"]), 
                    html.EscapeString(user["email"]), html.EscapeString(user["webpage"]), html.EscapeString(user["number"]))
            }
            response += `</table>`
        }
        
        // Finish & display the document
        response += htmlDocEnd
        fmt.Fprint(w, response)
    }
}
```

### Expanded Database Implementations for `SELECT`
#### SQLite

*Access the SQLite terminal*

| **29** :$

```console
sudo -u www sqlite3 /srv/www/backendapp.db
```

*Update the database table for new fields*

```
user_type
date_created
date_updated
```

*Note the database is created when opened, no user or password with SQLite*

| **30** :>

```sql
ALTER TABLE users ADD COLUMN user_type TEXT CHECK (user_type IN ('member', 'admin')) DEFAULT 'member';
ALTER TABLE users ADD COLUMN date_created DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users ADD COLUMN date_updated DATETIME DEFAULT CURRENT_TIMESTAMP;
.quit
```

| **31** :$

```console
code sqlite-full-process.py sqlite-full-process.js sqlite-full-process.go
```

| **`sqlite-full-process.py`** :

```py
import db # db.py

def handle_form_submission(process_type, fullname, username, email, webpage, number, password):
    try:
        conn = db.get_db_connection()
        cursor = conn.cursor()
        
        if process_type == "Create":
            cursor.execute("""
                INSERT INTO users (fullname, username, email, webpage, number, password, date_created, date_updated)
                VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
            """, (fullname, username, email, webpage, number, password))
        elif process_type == "Update":
            cursor.execute("""
                UPDATE users SET fullname = ?, email = ?, webpage = ?, number = ?, password = ?, date_updated = CURRENT_TIMESTAMP
                WHERE username = ?
            """, (fullname, email, webpage, number, password, username))
        
        conn.commit()
        conn.close()
        return True, ""  # DB success
    except Exception as e:
        if conn:
            conn.close()
        return False, str(e) # DB fail

def get_all_users():
    try:
        conn = db.get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT username, fullname, email, webpage, number FROM users")
        users = [dict(row) for row in cursor.fetchall()]
        conn.close()
        return users
    except Exception as e:
        if conn:
            conn.close()
        return []

def get_user(username):
    try:
        conn = db.get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT username, fullname, email, webpage, number, password FROM users WHERE username = ?", (username,))
        user = cursor.fetchone()
        conn.close()
        return dict(user) if user else None
    except Exception as e:
        if conn:
            conn.close()
        return None
```

| **`sqlite-full-process.js`** :

```js
const db = require('./db');

function handleFormSubmission(processType, fullname, username, email, webpage, number, password) {
    return new Promise((resolve) => {
        const dbConn = db.getDbConnection();
        
        const query = processType === 'Create' ?
            `INSERT INTO users (fullname, username, email, webpage, number, password, date_created, date_updated) 
             VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)` :
            `UPDATE users SET fullname = ?, email = ?, webpage = ?, number = ?, password = ?, date_updated = CURRENT_TIMESTAMP 
             WHERE username = ?`;
        const params = processType === 'Create' ?
            [fullname, username, email, webpage, number, password] :
            [fullname, email, webpage, number, password, username];

        dbConn.run(query, params, function (err) {
            dbConn.close();
            if (err) {
                resolve({ success: false, error: err.message }); // DB fail
            } else {
                resolve({ success: true, error: '' }); // DB success
            }
        });
    });
}

function getAllUsers() {
    return new Promise((resolve) => {
        const dbConn = db.getDbConnection();
        dbConn.all("SELECT username, fullname, email, webpage, number FROM users", [], (err, rows) => {
            dbConn.close();
            if (err) {
                resolve([]);
            } else {
                resolve(rows);
            }
        });
    });
}

function getUser(username) {
    return new Promise((resolve) => {
        const dbConn = db.getDbConnection();
        dbConn.get("SELECT username, fullname, email, webpage, number, password FROM users WHERE username = ?", [username], (err, row) => {
            dbConn.close();
            if (err || !row) {
                resolve(null);
            } else {
                resolve(row);
            }
        });
    });
}

module.exports = { handleFormSubmission, getAllUsers, getUser };
```

| **`sqlite-full-process.go`** :

```go
package db_process

import "db"

func HandleFormSubmission(processType, fullname, username, email, webpage, number, password string) (bool, string) {
    dbConn, err := db.GetDbConnection()
    if err != nil {
        return false, err.Error()
    }
    defer dbConn.Close()

    if processType == "Create" {
        _, err = dbConn.Exec(`
            INSERT INTO users (fullname, username, email, webpage, number, password, date_created, date_updated)
            VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)`,
            fullname, username, email, webpage, number, password)
    } else if processType == "Update" {
        _, err = dbConn.Exec(`
            UPDATE users SET fullname = ?, email = ?, webpage = ?, number = ?, password = ?, date_updated = CURRENT_TIMESTAMP
            WHERE username = ?`,
            fullname, email, webpage, number, password, username)
    }

    if err != nil {
        return false, err.Error() // DB fail
    }
    return true, "" // DB success
}

func GetAllUsers() ([]map[string]string, error) {
    dbConn, err := db.GetDbConnection()
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
        user := map[string]string{
            "username": username,
            "fullname": fullname,
            "email":    email,
            "webpage":  webpage,
            "number":   number,
        }
        users = append(users, user)
    }
    return users, nil
}

func GetUser(username string) (map[string]string, error) {
    dbConn, err := db.GetDbConnection()
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
        "email":    e,
        "webpage":  w,
        "number":   n,
        "password": p,
    }, nil
}
```

*Now, see it in action...*

##### Python

| **32** :$

```console
cp sqlite-db.py db.py
cp sqlite-full-process.py db-process.py
cp backend-users-app.py backend.py
python backend.py
```

| **B-32** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

##### Node.js

| **33** :$

```console
cp sqlite-db.js db.js
cp sqlite-full-process.js db-process.js
cp backend-users-app.node backend.node
node backend.node
```

| **B-33** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

##### Go

| **34** :$

```console
cp sqlite-db.go db.go
cp sqlite-full-process.go db-process.go
cp backend-users-app.go backend.go
go run backend.go
```

| **B-34** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

#### MySQL/MariaDB

*Access the MariaDB terminal*

| **35** :$

```console
sudo systemctl start mariadb
mariadb -u admin -padminpassword
```

*Update the database table for new fields*

```
user_type
date_created
date_updated
```

| **36** :>

```sql
ALTER TABLE users ADD COLUMN user_type ENUM('member', 'admin') DEFAULT 'member';
ALTER TABLE users ADD COLUMN date_created DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users ADD COLUMN date_updated DATETIME DEFAULT CURRENT_TIMESTAMP;
quit;
```

*Note our databse process implementations (for each backend language)*

| **37** :$

```console
code mysql-full-process.py mysql-full-process.js mysql-full-process.go
```

| **`mysql-full-process.py`** :

```py
import db # db.py

def handle_form_submission(process_type, fullname, username, email, webpage, number, password):
    try:
        conn = db.get_db_connection()
        cursor = conn.cursor()
        
        if process_type == "Create":
            cursor.execute("""
                INSERT INTO users (fullname, username, email, webpage, number, password, date_created, date_updated)
                VALUES (%s, %s, %s, %s, %s, %s, NOW(), NOW())
            """, (fullname, username, email, webpage, number, password))
        elif process_type == "Update":
            cursor.execute("""
                UPDATE users SET fullname = %s, email = %s, webpage = %s, number = %s, password = %s, date_updated = NOW()
                WHERE username = %s
            """, (fullname, email, webpage, number, password, username))
        
        conn.commit()
        conn.close()
        return True, ""  # DB success
    except Exception as e:
        if conn:
            conn.close()
        return False, str(e)  # DB fail

def get_all_users():
    try:
        conn = db.get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT username, fullname, email, webpage, number FROM users")
        users = cursor.fetchall()
        conn.close()
        return users
    except Exception as e:
        if conn:
            conn.close()
        return []

def get_user(username):
    try:
        conn = db.get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT username, fullname, email, webpage, number, password FROM users WHERE username = %s", (username,))
        user = cursor.fetchone()
        conn.close()
        return user
    except Exception as e:
        if conn:
            conn.close()
        return None
```

| **`mysql-full-process.js`** :

```js
const db = require('./db');

function handleFormSubmission(processType, fullname, username, email, webpage, number, password) {
    return new Promise((resolve) => {
        const dbConn = db.getDbConnection();
        dbConn.connect((err) => {
            if (err) {
                return resolve({ success: false, error: err.message });
            }

            const query = processType === 'Create' ?
                `INSERT INTO users (fullname, username, email, webpage, number, password, date_created, date_updated)
                 VALUES (?, ?, ?, ?, ?, ?, NOW(), NOW())` :
                `UPDATE users SET fullname = ?, email = ?, webpage = ?, number = ?, password = ?, date_updated = NOW()
                 WHERE username = ?`;
            const params = processType === 'Create' ?
                [fullname, username, email, webpage, number, password] :
                [fullname, email, webpage, number, password, username];

            dbConn.query(query, params, (err) => {
                dbConn.end();
                if (err) {
                    resolve({ success: false, error: err.message }); // DB fail
                } else {
                    resolve({ success: true, error: '' }); // DB success
                }
            });
        });
    });
}

function getAllUsers() {
    return new Promise((resolve) => {
        const dbConn = db.getDbConnection();
        dbConn.connect((err) => {
            if (err) {
                resolve([]);
                return;
            }
            dbConn.query("SELECT username, fullname, email, webpage, number FROM users", (err, rows) => {
                dbConn.end();
                if (err) {
                    resolve([]);
                } else {
                    resolve(rows);
                }
            });
        });
    });
}

function getUser(username) {
    return new Promise((resolve) => {
        const dbConn = db.getDbConnection();
        dbConn.connect((err) => {
            if (err) {
                resolve(null);
                return;
            }
            dbConn.query("SELECT username, fullname, email, webpage, number, password FROM users WHERE username = ?", [username], (err, rows) => {
                dbConn.end();
                if (err || rows.length === 0) {
                    resolve(null);
                } else {
                    resolve(rows[0]);
                }
            });
        });
    });
}

module.exports = { handleFormSubmission, getAllUsers, getUser };
```

| **`mysql-full-process.go`** :

```go
package db_process
import "db"

func HandleFormSubmission(processType, fullname, username, email, webpage, number, password string) (bool, string) {
    dbConn, err := db.GetDbConnection()
    if err != nil {
        return false, err.Error()
    }
    defer dbConn.Close()

    if processType == "Create" {
        _, err = dbConn.Exec(`
            INSERT INTO users (fullname, username, email, webpage, number, password, date_created, date_updated)
            VALUES (?, ?, ?, ?, ?, ?, NOW(), NOW())`,
            fullname, username, email, webpage, number, password)
    } else if processType == "Update" {
        _, err = dbConn.Exec(`
            UPDATE users SET fullname = ?, email = ?, webpage = ?, number = ?, password = ?, date_updated = NOW()
            WHERE username = ?`,
            fullname, email, webpage, number, password, username)
    }

    if err != nil {
        return false, err.Error() // DB fail
    }
    return true, "" // DB success
}

func GetAllUsers() ([]map[string]string, error) {
    dbConn, err := db.GetDbConnection()
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
    dbConn, err := db.GetDbConnection()
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

##### Python

| **38** :$

```console
cp mysql-db.py db.py
cp mysql-full-process.py db-process.py
python backend.py
```

| **B-38** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

##### Node.js

| **39** :$

```console
cp mysql-db.js db.js
cp mysql-full-process.js db-process.js
node backend.node
```

| **B-39** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

##### Go

| **40** :$

```console
cp mysql-db.go db.go
cp mysql-full-process.go db-process.go
go run backend.go
```

| **B-40** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

#### PostgreSQL

*Access the PostgreSQL terminal*

| **41** :$

```console
sudo systemctl start postgresql
PGPASSWORD=adminpassword psql -U admin -d postgres -h localhost -w
```

*Update the database table for new fields*

```
user_type
date_created
date_updated
```

| **42** :>

```sql
ALTER TABLE users ADD COLUMN user_type VARCHAR(6) CHECK (user_type IN ('member', 'admin')) DEFAULT 'member';
ALTER TABLE users ADD COLUMN date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users ADD COLUMN date_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
\q
```

*Note our databse process implementations (for each backend language)*

| **43** :$

```console
code postgres-full-process.py postgres-full-process.js postgres-full-process.go
```

| **`postgres-full-process.py`** :

```py
import db

def handle_form_submission(process_type, fullname, username, email, webpage, number, password):
    try:
        conn = db.get_db_connection()
        cursor = conn.cursor()
        
        if process_type == "Create":
            cursor.execute("""
                INSERT INTO users (fullname, username, email, webpage, number, password, date_created, date_updated)
                VALUES (%s, %s, %s, %s, %s, %s, NOW(), NOW())
            """, (fullname, username, email, webpage, number, password))
        elif process_type == "Update":
            cursor.execute("""
                UPDATE users SET fullname = %s, email = %s, webpage = %s, number = %s, password = %s, date_updated = NOW()
                WHERE username = %s
            """, (fullname, email, webpage, number, password, username))
        
        conn.commit()
        conn.close()
        return True, "" # DB success
    except Exception as e:
        if conn:
            conn.close()
        return False, str(e) # DB fail

def get_all_users():
    try:
        conn = db.get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT username, fullname, email, webpage, number FROM users")
        users = [dict(zip([desc[0] for desc in cursor.description], row)) for row in cursor.fetchall()]
        conn.close()
        return users
    except Exception as e:
        if conn:
            conn.close()
        return []

def get_user(username):
    try:
        conn = db.get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT username, fullname, email, webpage, number, password FROM users WHERE username = %s", (username,))
        user = cursor.fetchone()
        conn.close()
        return dict(zip([desc[0] for desc in cursor.description], user)) if user else None
    except Exception as e:
        if conn:
            conn.close()
        return None
```

| **`postgres-full-process.js`** :

```js
const db = require('./db');

async function handleFormSubmission(processType, fullname, username, email, webpage, number, password) {
    const dbPool = db.getDbConnection();
    try {
        if (processType === 'Create') {
            await dbPool.query(
                `INSERT INTO users (fullname, username, email, webpage, number, password, date_created, date_updated)
                 VALUES ($1, $2, $3, $4, $5, $6, NOW(), NOW())`,
                [fullname, username, email, webpage, number, password]
            );
        } else if (processType === 'Update') {
            await dbPool.query(
                `UPDATE users SET fullname = $1, email = $2, webpage = $3, number = $4, password = $5, date_updated = NOW()
                 WHERE username = $6`,
                [fullname, email, webpage, number, password, username]
            );
        }
        await dbPool.end();
        return { success: true, error: '' }; // DB success
    } catch (err) {
        await dbPool.end();
        return { success: false, error: err.message }; // DB fail
    }
}

async function getAllUsers() {
    const dbPool = db.getDbConnection();
    try {
        const res = await dbPool.query("SELECT username, fullname, email, webpage, number FROM users");
        await dbPool.end();
        return res.rows;
    } catch (err) {
        await dbPool.end();
        return [];
    }
}

async function getUser(username) {
    const dbPool = db.getDbConnection();
    try {
        const res = await dbPool.query("SELECT username, fullname, email, webpage, number, password FROM users WHERE username = $1", [username]);
        await dbPool.end();
        return res.rows.length > 0 ? res.rows[0] : null;
    } catch (err) {
        await dbPool.end();
        return null;
    }
}

module.exports = { handleFormSubmission, getAllUsers, getUser };
```

| **`postgres-full-process.go`** :

```go
package db_process
import "db"

func HandleFormSubmission(processType, fullname, username, email, webpage, number, password string) (bool, string) {
    dbConn, err := db.GetDbConnection()
    if err != nil {
        return false, err.Error()
    }
    defer dbConn.Close()

    if processType == "Create" {
        _, err = dbConn.Exec(`
            INSERT INTO users (fullname, username, email, webpage, number, password, date_created, date_updated)
            VALUES ($1, $2, $3, $4, $5, $6, NOW(), NOW())`,
            fullname, username, email, webpage, number, password)
    } else if processType == "Update" {
        _, err = dbConn.Exec(`
            UPDATE users SET fullname = $1, email = $2, webpage = $3, number = $4, password = $5, date_updated = NOW()
            WHERE username = $6`,
            fullname, email, webpage, number, password, username)
    }

    if err != nil {
        return false, err.Error() // DB fail
    }
    return true, "" // DB success
}

func GetAllUsers() ([]map[string]string, error) {
    dbConn, err := db.GetDbConnection()
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
    dbConn, err := db.GetDbConnection()
    if err != nil {
        return nil, err
    }
    defer dbConn.Close()

    row := dbConn.QueryRow("SELECT username, fullname, email, webpage, number, password FROM users WHERE username = $1", username)
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

##### Python

| **44** :$

```console
cp postgres-db.py db.py
cp postgres-full-process.py db-process.py
python backend.py
```

| **B-44** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

##### Node.js

| **45** :$

```console
cp postgres-db.js db.js
cp postgres-full-process.js db-process.js
node backend.node
```

| **B-45** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

##### Go

| **46** :$

```console
cp postgres-db.go db.go
cp postgres-full-process.go db-process.go
go run backend.go
```

| **B-46** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

### Database Engine as Setting
- *The database engine (SQLite, MySQL/MariaDB, or PostgreSQL) can be a setting in a config file*
- *A good place for this is inside the `db.*` file itself*
- *So, `sqlite`, `mysql`, or `postgresql` would be a setting alongside `database=`, `user=`, etc*
- *No other files would need to be changed*

#### Simplified DB Configs
*These are prepped to be copied via CLI `cp` later to `db.*` per server language...*

| **47** :$

```console
code sqlite-db.py mysql-db.py postgres-db.py sqlite-db.js mysql-db.js postgres-db.js sqlite-db.conf mysql-db.conf postgres-db.conf
```

| **`sqlite-db.py`** :

```py
db_type = 'sqlite'
db_name = 'backendapp.db'
db_user = ''
db_pass = ''
db_host = ''
```

| **`mysql-db.py`** :

```py
db_type = 'mysql'
db_name = 'backendapp_db'
db_user = 'beadbuser'
db_pass = 'beadbpass'
db_host = 'localhost'
```

| **`postgres-db.py`** :

```py
db_type = 'postgresql'
db_name = 'backendapp_db'
db_user = 'beadbuser'
db_pass = 'beadbpass'
db_host = 'localhost'
```

| **`sqlite-db.js`** :

```js
module.exports = {
    dbType: 'sqlite',
    dbName: 'backendapp.db',
    dbUser: '',
    dbPass: '',
    dbHost: ''
};
```

| **`mysql-db.js`** :

```js
module.exports = {
    dbType: 'mysql',
    dbName: 'backendapp_db',
    dbUser: 'beadbuser',
    dbPass: 'beadbpass',
    dbHost: 'localhost'
};
```

| **`postgres-db.js`** :

```js
module.exports = {
    dbType: 'postgresql',
    dbName: 'backendapp_db',
    dbUser: 'beadbuser',
    dbPass: 'beadbpass',
    dbHost: 'localhost'
};
```

| **`sqlite-db.conf`** : (Text file config for Go)

```
db_type=sqlite
db_name=backendapp.db
db_user=
db_pass=
db_host=
```

| **`mysql-db.conf`** : (Text file config for Go)

```
db_type=mysql
db_name=backendapp_db
db_user=beadbuser
db_pass=beadbpass
db_host=localhost
```

| **`postgres-db.conf`** : (Text file config for Go)

```
db_type=postgresql
db_name=backendapp_db
db_user=beadbuser
db_pass=beadbpass
db_host=localhost
```

#### Master DB Processors
*These will contain the execution for each SQL engine, but select them based on the `db_type` setting in the `db.*` config...*

| **48** :$

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
        users = [dict(row) for row in cursor.fetchall()]
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
        return dict(user) if user else None
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
                    if (err) {
                        resolve({ success: false, error: err.message });
                    } else {
                        resolve({ success: true, error: '' });
                    }
                });
            } else { // mysql
                dbConn.query(query, params, (err) => {
                    dbConn.end();
                    if (err) {
                        resolve({ success: false, error: err.message });
                    } else {
                        resolve({ success: true, error: '' });
                    }
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
                if (err) {
                    resolve({ success: false, error: err.message });
                } else {
                    resolve({ success: true, error: '' });
                }
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
                if (err) {
                    resolve([]);
                } else {
                    resolve(result.rows);
                }
            });
        } else {
            dbConn.all("SELECT username, fullname, email, webpage, number FROM users", [], (err, rows) => {
                dbConn.close();
                if (err) {
                    resolve([]);
                } else {
                    resolve(rows);
                }
            });
        }
    });
}

function getUser(username) {
    return new Promise((resolve) => {
        const dbConn = getDbConnection();
        const query = db.dbType === 'sqlite' ? 
            "SELECT username, fullname, email, webpage, number, password FROM users WHERE username = ?" :
            db.dbType === 'mysql' ? 
            "SELECT username, fullname, email, webpage, number, password FROM users WHERE username = ?" :
            "SELECT username, fullname, email, webpage, number, password FROM users WHERE username = $1";
        const params = [username];
        
        if (db.dbType === 'postgresql') {
            dbConn.query(query, params, (err, result) => {
                dbConn.end();
                if (err || !result.rows[0]) {
                    resolve(null);
                } else {
                    resolve(result.rows[0]);
                }
            });
        } else if (db.dbType === 'mysql') {
            dbConn.query(query, params, (err, rows) => {
                dbConn.end();
                if (err || rows.length === 0) {
                    resolve(null);
                } else {
                    resolve(rows[0]);
                }
            });
        } else { // sqlite
            dbConn.get(query, params, (err, row) => {
                dbConn.close();
                if (err || !row) {
                    resolve(null);
                } else {
                    resolve(row);
                }
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
        users = append(users, map[string]string{"username": username, "fullname": fullname, "email": email, "webpage": webpage, "number": number})
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
    return map[string]string{"username": u, "fullname": f, "email": e, "webpage": w, "number": n, "password": p}, nil
}
```

#### Implementation
*Now, see it in action...*

##### Python
###### SQLite

| **49** :$

```console
cp sqlite-db.py db.py
python backend.py
```

| **B-49** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

###### MySQL/MariaDB

| **50** :$

```console
cp mysql-db.py db.py
python backend.py
```

| **B-50** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

###### PostgreSQL

| **51** :$

```console
cp postgres-db.py db.py
python backend.py
```

| **B-51** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

##### Node.js
###### SQLite

| **52** :$

```console
cp sqlite-db.js db.js
node backend.node
```

| **B-52** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

###### MySQL/MariaDB

| **53** :$

```console
cp mysql-db.js db.js
node backend.node
```

| **B-53** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

###### PostgreSQL

| **54** :$

```console
cp postgres-db.js db.js
node backend.node
```

| **B-54** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

##### Go
###### SQLite

| **55** :$

```console
cp sqlite-db.conf db.conf
go run backend.go
```

| **B-55** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

###### MySQL/MariaDB

| **56** :$

```console
cp mysql-db.conf db.conf
go run backend.go
```

| **B-56** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

###### PostgreSQL

| **57** :$

```console
cp postgres-db.conf db.conf
go run backend.go
```

| **B-57** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

___

# The Take
- Python, Node.js, and Go are all capable of working with various SQL engine
- The interaction per SQL engine can be in a separate file, function, or object from the rest of the program
  - The Python, Node.js, or Go program can remain the same, regardless of which SQL engine is used
  - Which SQL engine to use can be any mere option in a config file
  - We might say such an app is "database engine agnostic" beyond the database config
___

#### [Lesson 4: URL Rewrite & Parsing](https://github.com/inkVerb/vip/blob/master/701/Lesson-04.md)
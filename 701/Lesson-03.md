# Linux 701
## Lesson 3: Database Connections

Ready the CLI

```console
cd ~/School/VIP/701
```

Ready services

```console
sudo systemctl start nginx
```

___

### Databases
*This lesson will implement four databases into the backend web app we wrote in the previous lesson*

- SQLite
- MySQL/MariaDB
- PostgreSQL
- MondoDB (only for Node.js)

### Backend Structure
*We will use the same three backend files for each of our databases; these files will remain unchanged*

*The database configs and access will be included in separate files*

*Note the filenames will be the same in these scripts, regardless of which database we use:*

- `db.*` for the database config
- `process-db.*` for the implemenation that processes database calls

*Note that we have new fields for "Confirm password" along with "Create" & "Update" `type="submit"` buttons*

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
        oldpassword = functions.check_post('oldpassword', query_components.get('oldpassword', [''])[0])
        
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
        response += f'Oldassword: {functions.form_input("oldpassword", "")}<br><br>'
        response += f'Password: {functions.form_input("password", "")}<br><br>'
        response += f'Password again: {functions.form_input("password2", "")}<br><br>'
        response += '<input type="submit" name="process" value="Login">'
        response += '<input type="submit" name="process" value="Create">'
        if username != "":
            response += '<input type="submit" name="process" value="Update">'
        response += '</form>'
    
        # Finish & display the document
        response += html_doc_end
        self.wfile.write(response.encode())

        
    # No POST, still needs to do this again to return something because of how it handles request methods and variable scope
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
        response += f'Oldassword: {functions.form_input("oldpassword", "")}<br><br>'
        response += f'Password: {functions.form_input("password", "")}<br><br>'
        response += f'Password again: {functions.form_input("password2", "")}<br><br>'
        response += '<input type="submit" name="process" value="Login">'
        response += '<input type="submit" name="process" value="Create">'
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
    let inputType = name === 'password' || name === 'oldpassword' ? 'password' : 'text';
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
            response += '<input type="submit" name="process" value="Login">';
            response += '<input type="submit" name="process" value="Create">';
            if (username !== "") {
                response += '<input type="submit" name="process" value="Update">';
            }
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
        response += '<input type="submit" name="process" value="Login">';
        response += '<input type="submit" name="process" value="Create">';
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
        
        /// First submission?
        response += `<input type="submit" name="process" value="Login">`
        response += `<input type="submit" name="process" value="Create">`
        if username != "" { 
            response += `<input type="submit" name="process" value="Update">`
        }
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
        
        /// First submission?
        response += `<input type="submit" name="process" value="Login">`
        response += `<input type="submit" name="process" value="Create">`
        response += `</form>`
        
        // Finish & display the document
        response += htmlDocEnd
        fmt.Fprint(w, response)
    }
}
```

### Database Implementations
#### SQLite

*Access the SQLite terminal*

| **4** :$

```console

```

*Create the database table we need*

| **5** :>

```sql

```

*Note our databse configs (for each backend language)*

| **6** :$

```console
code sqlite-db.py sqlite-db.js sqlite-db.go
```

| **`sqlite-db.py`** :

```py

```

| **`sqlite-db.js`** :

```js

```

| **`sqlite-db.go`** :

```go

```

*Note our databse process implementations (for each backend language)*

| **7** :$

```console
code sqlite-process.py sqlite-process.js sqlite-process.go
```

| **`sqlite-process.py`** :

```py

```

| **`sqlite-process.js`** :

```js

```

| **`sqlite-process.go`** :

```go

```

*Now, see it in action...*

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

```

*Create the database table we need*

| **12** :>

```sql

```

*Note our databse configs (for each backend language)*

| **13** :$

```console
code mysql-db.py mysql-db.js mysql-db.go
```

| **`mysql-db.py`** :

```py

```

| **`mysql-db.js`** :

```js

```

| **`mysql-db.go`** :

```go

```

*Note our databse process implementations (for each backend language)*

| **14** :$

```console
code mysql-process.py mysql-process.js mysql-process.go
```

| **`mysql-process.py`** :

```py

```

| **`mysql-process.js`** :

```js

```

| **`mysql-process.go`** :

```go

```

*Now, see it in action...*

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

```

*Create the database table we need*

| **19** :>

```sql

```

*Note our databse configs (for each backend language)*

| **20** :$

```console
code postgres-db.py postgres-db.js postgres-db.go
```

| **`postgres-db.py`** :

```py

```

| **`postgres-db.js`** :

```js

```

| **`postgres-db.go`** :

```go

```

*Note our databse process implementations (for each backend language)*

| **21** :$

```console
code postgres-process.py postgres-process.js postgres-process.go
```

| **`postgres-process.py`** :

```py

```

| **`postgres-process.js`** :

```js

```

| **`postgres-process.go`** :

```go

```

*Now, see it in action...*

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

#### MongoDB (Node only)


*Access the MongoDB terminal*

| **25** :$

```console

```

*Create the database table we need*

| **26** :>

```json

```

*Note our databse configs (for each backend language)*

| **27** :$

```console
code mongo-db.js
```

| **`mongo-db.js`** :

```js

```

*Note our databse process implementations (for each backend language)*

| **28** :$

```console
code mongo-process.js
```

| **`mongo-process.js`** :

```go

```

*Now, see it in action...*

| **29** :$

```console
cp mongo-db.js db.js
cp mongo-process.py db-process.py
node backend-app.node
```

| **B-29** ://

```console
localhost
```

*(When finished: <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal to exit)*

___

# The Take

___

#### [Lesson 4: URL Rewrite & Parsing](https://github.com/inkVerb/vip/blob/master/701/Lesson-04.md)
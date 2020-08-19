# Shell 501
## Lesson 10: Media Library, Files & Uploads

Ready the CLI

`cd ~/School/VIP/501`

### This lesson uses two terminals and two browser tabs!

Ready the secondary SQL terminal and secondary SQL browser

*(Ctrl + Shift + T for new terminal tab; Ctrl + PageUp/PageDown to switch tabs)*

| **S0** :$ `mysql -u admin -padminpassword` *(password in the terminal, not safe outside these lessons!)*

*(Ctrl + T for new browser tab; Ctrl + PageUp/PageDown to switch tabs)*

| **S0** ://phpMyAdmin **> `localhost/phpMyAdmin/` Username: `admin` Password: `adminpassword`

| **S1** :> `USE webapp_db;`

| **S1** ://phpMyAdmin **> webapp_db**

### Webapp Dashboard Login:

| **B-1** :// `localhost/web/webapp.php` (Check that you're logged in)

```
Username: jonboy
Password: My#1Password
```
___

### Prepare

*Prepare our uploadable test files...*

| **1** :$
```
cp -r core/test_uploads .
mkdir -p test_uploads/fakes
echo "I am a test upload file" > test_uploads/test1.txt
pandoc -s test_uploads/test1.txt -o test_uploads/test2.doc
echo "I am a another test upload file" > test_uploads/test3.txt
pandoc -s test_uploads/test3.txt -o test_uploads/test3.docx
pandoc -s test_uploads/mime.md -o test_uploads/mime.odt
pandoc -s test_uploads/mime.md -o test_uploads/mime.pdf
echo "I am a fake PNG file" > test_uploads/fakes/fake.png
echo "I am a fake JPEG file" > test_uploads/fakes/fake.jpg
echo "I am a fake GIF file" > test_uploads/fakes/fake.gif
echo "I am a fake MPEG file" > test_uploads/fakes/fake.mp3
echo "I am a fake WAV file" > test_uploads/fakes/fake.wav
echo "I am a fake ogg file" > test_uploads/fakes/fake.ogg
echo "I am a fake WebM file" > test_uploads/fakes/fake.webm
echo "I am a fake MPEG-4 file" > test_uploads/fakes/fake.mp4
echo "I am a fake DOC file" > test_uploads/fakes/fake.doc
echo "I am a fake DOCX file" > test_uploads/fakes/fake.docx
echo "I am a fake PDF file" > test_uploads/fakes/fake.pdf
ls test_uploads
```

*Note the files we created in 501/test_uploads/*

*Now, create our "uploads" directory, where our files will be uploaded to...*

**Web Directory for Uploads**

| **2** :$
```
sudo mkdir web/uploads && \
sudo chown -R www-data:www-data /var/www/html && \
ls web
```

*Note the "uploads" directory, we will use this throughout this lesson*

**PHP Settings: `file_uploads = On`**

1. Turn on the PHP-MySQL functionality in your `php.ini` file
  - Ensure set & uncommented: `file_uploads = On` (remove any semicolon `;` at the start of the line, make sure it is `On`)
  - Edit with `gedit`:

    | **3g** :$ `sudo gedit /etc/php/7.2/apache2/php.ini` (maybe `7.2` is a different number)

    - Search with: Ctrl + F, then type `file_uploads` to find the line, Ctrl + S to save

  - Or edit with `vim`:

    | **3v** :$ `sudo vim /etc/php/7.2/apache2/php.ini` (maybe `7.2` is a different number)

    - Search by typing: `/file_uploads`, then Enter to find the line, type `:wq` to save and quit

2. Restart Everything

| **4** :$ `sudo systemctl restart apache2`

### Basic File Upload

| **5** :$
```
sudo cp core/10-upload1.php web/upload.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/10-upload1.php && \
ls web
```

*Note upload.php:*

- *Look over the `<form>` and `POST` processor in PHP*
- *`$_POST['uploaded_file_post_name']`* ***does not*** *handle the uploaded file as a `POST` item!*
- *`$_FILES['upload_file']` processes more detailed information about the uploaded file*
  - *`<form>` requires `enctype="multipart/form-data"` for this to work*
- *`$_FILES['upload_file']['name']`*
  - *`$_FILES` is a PHP constant, like `$_SESSION`, `$_COOKIE`, `$_POST`, and `$_GET`*
  - *"`upload_file`" came from the `<form>`*
  - *`name` is the key for the actual filename*
- *`$_FILES['upload_file']['tmp_name']`*
  - *PHP automatically saves the uploaded file a temporary file*
    - *...probably somewhere in `/tmp/`*
    - *...or as set by your settings in /etc/php/7.x/apache2/php.ini*
    - *PHP automatically assigns the `tmp_name` for this temp file*
    - *`$_FILES['upload_file']['tmp_name']` is the array and key variable for this temporary file name*
- *Get the "mime type" with `mime_content_type()`*
- *Note `basename()` isolates the file name without the full path*
- *Note `move_uploaded_file()` moves the uploaded temp file to a new location*

```php
$file_name = basename($_FILES['some_post_name']['name']); // Name of the file, 'name' is a PHP key that does not change
move_uploaded_file($starting_location, $destination_location); // Move an uploaded file
$file_mime = mime_content_type($temp_file); // Get the mime type, requires full path to file
```

**Mime Types**

- The mime type is a file's type based on what is inside the file, not just the file name's extension
- This can be useful for security, to avoid hacks or opening a file with the wrong application
- Your operating system knows which application to open a file with based on the mime type
- Your list of mime types for your desktop environment is probably located at: `~/.config/mimeapps.list`
- This first uploader (upload1.php) will show the mime type of any file, it could come in handy

**File Upload Workflow**

```
1. Inside the <form> (using 'upload_file' as the name and ID in this example)
<form enctype="multipart/form-data" ...>
  <input type="file" name="upload_file" id="upload_file">

2. $_FILES automatically sends the file to a temp directory
  - Defined in php.ini settings, possibly somewhere else
  - This temp file name can be used as: $_FILES['upload_file']['tmp_name']

3. Do whatever validation checks we need on the temp file

4. Move the temp file to wherever we want uploaded files to go
```

*Get ready for our first upload...*

| **6** :$
```
ls web/uploads
```

*Note the uploads directory is empty*

| **B-6** :// `localhost/web/upload.php`

1. Click "Browse..."
2. Look in ~/School/VIP/501/test_uploads
3. Select & "open" test1.txt
4. Click "Upload"

| **7** :$
```
ls web/uploads
```

*Note your file was uploaded*

### Validate Uploaded Files

**Simple image check**

```php
getimagesize($file)
```

| **8** :$
```
sudo cp core/10-upload2.php web/upload.php && \
atom core/10-upload2.php && \
ls web/uploads
```

*Note the files in the uploads directory*

*Note upload.php:*

- *`getimagesize()` function is used to see if it is a real image*
  - *If we can't get an image size, then it must not be an image*
- *We use `$errors`*
  - *...to hold error messages*
  - *...to check if there have been any errors*

| **B-9** :// `localhost/web/upload.php` (Same)

1. Click "Browse..."
2. Look in ~/School/VIP/501/test_uploads
3. Select & "open" fake.png
4. Click "Upload"

| **9** :$
```
ls web/uploads
```

*Note it failed*

| **B-10** :// `localhost/web/upload.php` (Same)

Repeat steps 1-4, choosing file vip-blue.png

| **10** :$
```
ls web/uploads
```

*It should have succeeded*

**File type check: images only**

```php
pathinfo($file,PATHINFO_EXTENSION)
```

| **11** :$
```
sudo cp core/10-upload3.php web/upload.php && \
atom core/10-upload3.php && \
ls web/uploads
```

*Note the files in the uploads directory*

*Note upload.php:*

- *Our `(getimagesize($temp_file))` test is buried in the middle of other checks, but still there*
- *`pathinfo($file,PATHINFO_EXTENSION)` gets the file extension*
- *We set that file extension to `$uploaded_file_type` for checks against the types we want to allow*
- *If the file has an allowed extension, we run our fake/non- image check on it*

| **B-12** :// `localhost/web/upload.php` (Same)

1. Click "Browse..."
2. Look in ~/School/VIP/501/test_uploads
3. Select & "open" fake.jpg
4. Click "Upload"

| **12** :$
```
ls web/uploads
```

*Note it failed*

| **B-13** :// `localhost/web/upload.php` (Same)

Repeat steps 1-4, choosing file vip-chartreuse.png

| **13** :$
```
ls web/uploads
```

*It should have succeeded*

**File name check**

```php
file_exists($full_file_path) // If file exists, boolean
```

| **14** :$
```
ls -l web/uploads
```

*Note the* ***timestamps*** *for vip-chartreuse.png in the uploads directory*

| **B-15** :// `localhost/web/upload.php` (Same)

1. Click "Browse..."
2. Look in ~/School/VIP/501/test_uploads
3. Select & "open" vip-chartreuse.png (Same as above)
4. Click "Upload"

| **15** :$
```
ls -l web/uploads
```

*Note the* ***timestamps*** *for vip-chartreuse.png changed*

- *PHP overwrote the file because it already existed*

| **16** :$
```
sudo cp core/10-upload4.php web/upload.php && \
atom core/10-upload4.php && \
```

*Note upload.php:*

- *The test `(file_exists($full_file_path))` sees if the file already exists*
- *If the file exists, we run a small process to add a number to the end of the new file*


| **B-17** :// `localhost/web/upload.php` (Same)

Repeat steps 1-4, choosing file vip-chartreuse.png ***again***

| **17** :$
```
ls -l web/uploads
```

*Note there is a new file with "-1" at the end: vip-chartreuse-1.png*

**File size check: 500kB**

```php
$size_limit = 500000;
$file_size = $_FILES['some_post_name']['size'];
($file_size > $size_limit)
```

| **18** :$
```
sudo cp core/10-upload5.php web/upload.php && \
atom core/10-upload5.php && \
ls web/uploads
```

*Note the files in the uploads directory*

*Note upload.php:*

- *Our `($file_size > $size_limit)` test sees if the file is too large*


| **B-19** :// `localhost/web/upload.php` (Same)

1. Click "Browse..."
2. Look in ~/School/VIP/501/test_uploads
3. Select & "open" vipLinux-Meshtop.jpg
4. Click "Upload"

| **19** :$
```
ls web/uploads
```

*Note it failed as "too large"*

| **B-20** :// `localhost/web/upload.php` (Same)

Repeat steps 1-4, choosing file nib.gif

| **20** :$
```
ls web/uploads
```

*It should have succeeded*

*Note in the future we will use a 5MB file size limit*

**PHP settings: `upload_max_filesize = 5M`**

1. Turn on the PHP-MySQL functionality in your `php.ini` file
  - Ensure set: `upload_max_filesize = 5M` (make sure it is `5M`)
  - Edit with `gedit`:

    | **21g** :$ `sudo gedit /etc/php/7.2/apache2/php.ini` (maybe `7.2` is a different number)

    - Search with: Ctrl + F, then type `upload_max_filesize` to find the line, Ctrl + S to save

  - Or edit with `vim`:

    | **21v** :$ `sudo vim /etc/php/7.2/apache2/php.ini` (maybe `7.2` is a different number)

    - Search by typing: `/upload_max_filesize`, then Enter to find the line, type `:wq` to save and quit

2. Restart Everything

| **22** :$ `sudo systemctl restart apache2`

**Other file types**

- HTML only supports certain audio and video formats, so will we:
  - Video: OGG, MP4, WebM
  - Audio: OGG, MP3, WAV
- We also want to allow common document uploads:
  - Documents: TXT, MD, DOC, DOCX, ODT, PDF
- We will check these against:
  1. File extension
  2. Mime type

| **23** :$
```
sudo cp core/10-upload6.php web/upload.php && \
atom core/10-upload6.php && \
ls web/uploads
```

*Note the files in the uploads directory*

*Note upload.php:*

- *Several more checks use `$file_extension` & `$file_mime` to identify and allow types of files*
- *Note our handy `human_file_size()` function to show the file size in human-readable numbers and measures*

| **human_file_size** : (uses a simpler PHP syntax)

```php
function human_file_size($size, $unit="") {
  if ( (!$unit && $size >= 1<<30) || ($unit == "GB") )
    return number_format($size/(1<<30),2)."GB";
  if ( (!$unit && $size >= 1<<20) || ($unit == "MB") )
    return number_format($size/(1<<20),2)."MB";
  if ( (!$unit && $size >= 1<<10) || ($unit == "KB") )
    return number_format($size/(1<<10),2)."KB";
  return number_format($size)." bytes";
}
```

| **B-24** :// `localhost/web/upload.php` (Same)

1. Click "Browse..."
2. Look in ~/School/VIP/501/test_uploads
3. Select & "open" ***various files***
  - Will fail: **.wma, .flv, .bmp**
    - audio.wma
    - video.flv
    - vip-red.bmp
4. Click "Upload"
5. Check the uploads directory:$ `ls web/uploads`
6. Repeat these steps with many files, including fake and disallowed

| **25** :$
```
ls web/uploads
```

### JavaScript Drag-in Uploader

#### Dropzone.js

- [GitHub repo](https://github.com/enyo/dropzone)
- [GitHub fork](https://github.com/inkVerb/dropzone) (in case it doesn't work)

User-friendly uploading requires advanced JavaScript, which is beyond the scope of this PHP Stack course

This includes things like:

- Drag and drop
- Upload progress bars and queues
- Image cropping and resizing before upload

A great JavaScript tool we will use for this is Dropzone.js

Learning to implement tools inside PHP is part of learning PHP, and we already understand PHP uploading, so this tool will make more sense

On your own, learn more about implementation at [dropzonejs.com](https://www.dropzonejs.com/#installation)

##### Core Example

| **26** :$
```
sudo mkdir web/dropzone_uploads && \
git clone https://github.com/enyo/dropzone.git && \
sudo cp dropzone/dist/min/dropzone.min.css web/ && \
sudo cp dropzone/dist/min/dropzone.min.js web/ && \
sudo cp core/10-dropzone.html web/dropzone.html && \
sudo cp core/10-dropzone.php web/dropzone.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/10-dropzone.html core/10-dropzone.php && \
ls web
```

*Note:*

- *dropzone.html*
  - *This uses dropzone.js JS and CSS files*
  - *The `<form>` calls dropzone.php*
- *dropzone.php*
  - *This works in the background, like an AJAX call with no response*

| **B-26** :// `localhost/web/dropzone.html`

1. Look in ~/School/VIP/501/test_uploads
2. Drag files into the area: *"Drop files here to upload"*
3. Check the dropzone_uploads directory:$ `ls web/dropzone_uploads`
4. Repeat these steps with many files, including fake and disallowed

| **27** :$
```
ls web/dropzone_uploads
```

*We have achieved drag-in file uploading*

Now, it's time to implement that into what we have so far

### Media Library

#### Dropzone to Interact with Our Own AJAX Handler

| **28** :$
```
sudo rm -f web/dropzone_uploads/* && \
sudo cp core/10-medialibrary7.php web/medialibrary.php && \
sudo cp core/10-upload7.php web/upload.php && \
sudo cp core/10-style7.css web/style.css && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/10-medialibrary7.php core/10-upload7.php core/10-style7.css && \
ls web web/media
```

*Note:*

- *style.css*
  - *`@import` will include another CSS file, in this case the Dropzone CSS*
  - *`@import` is finicky about a relative path and may require "`./`"*
  - *`@import url("https://localhost/full/path/style.css")` imports from a full URL*
- *upload.php*
  - *Uploaded files go to: `web/dropzone_uploads/`*
  - *Messages were simplified:*
    - *`<p>` to `<span>...<br>`*
    - *`$info_message` holds the message until one `echo` statement at the end*
  - *This was stripped of HTML page support and only handles PHP-upload via AJAX*
- *medialibrary.php*
  - *Normal webapp header/footer content*
  - *Our `<form>` from the Dropzone example*
  - *`<p id="uploadresponse">` where our AJAX handler response will appear via JavaScript `innerHTML`*
  - *`<!-- Dropzone settings -->`*
    - *`acceptedFiles` bans the same files as `upload.php`, redundant and secure*
      - *This list includes `.md`*
        - *Dropzone settings allow both mimetype and file extensions in this list*
        - *Markdown files will be rejected by Dropzone, even with allowing `text/plain`*
        - *This would be an insecure test by itselv, but PHP will check the mimetype anyway*
    - *`paramName: "upload_file",` uses `$_FILES['upload_file']` in upload.php*
      - *Dropzone's default is `paramName: "file"` using `$_FILES['file']` in upload.php*
    - *We have a function to `// Process AJAX response`*

| **B-28** :// `localhost/web/medialibrary.php`

1. Look in ~/School/VIP/501/test_uploads
2. Drag files into the area: *"Drop to upload!"*
3. Check the dropzone_uploads directory:$ `ls web/dropzone_uploads`
4. Repeat these steps with many files, including fake and disallowed

| **29** :$
```
ls web/dropzone_uploads
```

*Note:*

- *Files are uploaded to `web/media/dropzone_uploads`*
  - *We will move them to *
- *Response messages appear in the webpage, the HTML appears in a browser "alert" box*
- *Dropzone accepts files not allowed*
- *`upload.php` rejects files not allowed and sends the error message in response*
- *If the same file is uploaded more than once, Dropzone displays the original file name, but the AJAX response shows the altered name*

This only handles one file uploaded at a time

Let's handle multiple uploads

#### Dropzone to Restrict Mimetype *Before* AJAX

| **30** :$
```
sudo rm -f web/dropzone_uploads/* && \
sudo cp core/10-medialibrary8.php web/medialibrary.php && \
atom core/10-medialibrary8.php  && \
ls web web/media
```

*Note:*

- *medialibrary.php: `<!-- Dropzone settings -->`*
  - *`acceptedFiles` only allows the same types of files as `upload.php`*

| **B-30** :// `localhost/web/medialibrary.php` (Ctrl + R to reload)

1. Look in ~/School/VIP/501/test_uploads
2. Drag files into the area: *"Drop to upload!"*
3. Check the dropzone_uploads directory:$ `ls web/dropzone_uploads`
4. Repeat these steps with many files, including fake and disallowed

| **31** :$
```
ls web/dropzone_uploads
```

*Note disallowed files:*

- *Are indicated by Dropzone*
- *Are not uploaded, thus have no AJAX response*

#### Dropzone Our AJAX with Multiple Uploads

Multiple files change the `$_FILES` array, so we must change some things

First, see what the `$_FILES` array for a single file upload looks like

| **32** :$
```
sudo rm -f web/dropzone_uploads/* && \
sudo cp core/10-upload9.php web/upload.php && \
atom core/10-upload9.php  && \
ls web web/media
```

*Note:*

- *upload.php*
  - *Shows what's in the `$_FILES` array via `var_dump()`*
  - *We process the upload simply so we can see what happens with:*
    - *`$_FILES['upload_file']['tmp_name']`*
    - *`$_FILES['upload_file']['name']`*

| **B-32** :// `localhost/web/medialibrary.php` (Ctrl + R to reload)

1. Look in ~/School/VIP/501/test_uploads
2. Drag single, then multiple files into the area: *"Drop to upload!"*
3. Before clicking "OK" to acknowledge the JS browser alert, check the dropzone_uploads directory:$ `ls web/dropzone_uploads`
4. Repeat these steps with many files, including fake and disallowed

| **33** :$
```
ls web/dropzone_uploads
```

*Note the array output...*

| **`$_FILES` array for 1 file, single-upload** :

```php
array(1) {
  ["upload_file"]=>
  array(5) {
    ["name"]=>
    string(8) "file.xxx"
    ["type"]=>
    string(11) "mimetype/xxx"
    ["tmp_name"]=>
    string(14) "/tmp/phpa1b2c3"
    ["error"]=>
    int(0)
    ["size"]=>
    int(1234567)
  }
}
```

Second, allow multiple uploads and see what the `$_FILES` array looks like for many files

| **34** :$
```
sudo rm -f web/dropzone_uploads/* && \
sudo cp core/10-medialibrary10.php web/medialibrary.php && \
sudo cp core/10-upload10.php web/upload.php && \
atom core/10-medialibrary10.php core/10-upload10.php && \
ls web web/media
```

*Note when uploading multiple files that all files are uploaded at once, before clicking "OK" to acknowledge the alerts*

*Note:*

- *medialibrary.php: `<!-- Dropzone settings -->`*
  - *Allows multiple uploads, plus some nice settings:*
    - *`uploadMultiple: true,`*
    - *`maxFiles: 50,` limits how many can to into the ulpoad queue*
    - *`parallelUploads: 1,` means only 1 upload at a time*
      - *This helps files stay in order, which writers, bloggers, and marketers might like better*
        - *Many programmers like multiple simultaneous uploads because of how they view code*
        - *We're not writing this for ourselves, but for the people who will use it*
- *upload.php*
  - *Adds a 3-D array key `[0]` so the array can work, otherwise it won't*
  - *`$_FILES['upload_file']['tmp_name'][0]`*
  - *`$_FILES['upload_file']['name'][0]`*

| **B-34** :// `localhost/web/medialibrary.php` (Ctrl + R to reload)

1. Look in ~/School/VIP/501/test_uploads
2. Drag multiple files into the area: *"Drop to upload!"*
3. Before clicking "OK" to acknowledge the JS browser alert, check the dropzone_uploads directory:$ `ls web/dropzone_uploads`
4. Repeat these steps with many files, including fake and disallowed

| **35** :$
```
ls web/dropzone_uploads
```

*Note about uploads:*

- *Each file is uploaded one at a time, between clicking "OK" to acknowledge the alerts*
- *The blue information about each file also changes between "OK" clicks, as each file is uploaded*

*Note the array output...*

*Let's look more closely...*

| **`$_FILES` array for 1 file, simultaneous** :

```php
array(1) {
  ["upload_file"]=>
  array(5) {
    ["name"]=>
    array(1) {
      [0]=>
      string(8) "file.xxx"
    }
    ["type"]=>
    array(1) {
      [0]=>
      string(11) "mimetype/xxx"
    }
    ["tmp_name"]=>
    array(1) {
      [0]=>
      string(14) "/tmp/phpa1b2c3"
    }
    ["error"]=>
    array(1) {
      [0]=>
      int(0)
    }
    ["size"]=>
    array(1) {
      [0]=>
      int(1234567)
    }
  }
}
```

*Review...*

| **`$_FILES` array for 1 file, single-upload** :

```php
array(1) {
  ["upload_file"]=>
  array(5) {
    ["name"]=>
    string(8) "file.xxx"
    ["type"]=>
    string(11) "mimetype/xxx"
    ["tmp_name"]=>
    string(14) "/tmp/phpa1b2c3"
    ["error"]=>
    int(0)
    ["size"]=>
    int(1234567)
  }
}
```

Uploading multiple files (via `uploadMultiple: true,`) puts files in a queue, processing them in sequence

(We set `parallelUploads:` to `1` so it is one at a time, not eg. `3` for three at a time, **but there would be no other differences in our code**)

This uses a 3-D array, but Dropzone only has one item each

The only change to code is that we must add `[0]` to the end of each `$_FILES` item

So, our entire upload handler must be updated with `[0]`...

| **36** :$
```
sudo rm -f web/dropzone_uploads/* && \
sudo cp core/10-medialibrary11.php web/medialibrary.php && \
sudo cp core/10-upload11.php web/upload.php && \
atom core/10-medialibrary11.php core/10-upload11.php && \
ls web web/media
```

*Note:*

- *upload.php*
  - *Is back to the full processor as before*
  - *Adds a 3-D array key `[0]` so the array can work, otherwise it won't*
- *medialibrary.php*
  - *JavaScript concatenates each AJAX response with the variable: `upResponse`*
    - *Each response is added to the previous*
    - *Current response status (including all previous AJAX responses) is updated in the HTML page*

| **B-36** :// `localhost/web/medialibrary.php` (Ctrl + R to reload)

1. Look in ~/School/VIP/501/test_uploads
2. Drag multiple files into the area: *"Drop to upload!"*
3. Before clicking "OK" to acknowledge the JS browser alert, check the dropzone_uploads directory:$ `ls web/dropzone_uploads`
4. Repeat these steps with many files, including fake and disallowed

| **37** :$
```
ls web/dropzone_uploads
```

*Note about uploads:*

- *Each file is uploaded one at a time, between clicking "OK" to acknowledge the alerts (same as before)*
- *The blue information about each file updates between "OK" clicks, adding information about each file as it is uploaded*

To this point, we have separated uploads in the queue with the JavaScript browser alert and "OK" button

This helped us understand the order of events in multiple uploads, mainly that it runs as a kind of loop

We will stop using JavaScript browser alerts in the future

### Upload with TinyMCE

From [Lesson 8](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-08.md) we already have TinyMCE from [here](https://github.com/tinymce/tinymce-dist)

The directory "tinymce-dist" is at "web/tinymce"

#### TinyMCE Image Upload

| **38** :$
```
sudo mkdir web/tinymce_uploads && \
sudo cp core/10-tiny-image-upload.html web/tiny.html && \
sudo cp core/10-tiny-upload1.php web/tiny-upload.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/10-tiny-image-upload.html core/10-tiny-upload.php && \
ls web
```

*Note:*

- *Settings "`// Added for uploads & images`"*
- *`images_upload_url` chooses our upload handler: tiny-upload.php*
- *`images_upload_handler` basically tells TinyMCE to AJAX-processes the upload (with tiny-upload.php)*
- *tiny-upload.php AJAX uploads, then sends the file's location in JSON:'filepath'*
- *The TinyMCE `images_upload_handler` function interprets that JSON*

| **B-38** :// `localhost/web/tiny.html`

**Upload with the image uploader**

1. Look in ~/School/VIP/501/test_uploads
2. In TinyMCE: Click the "image" button > Upload
3. Drag in any .png or .jpg file to the upload area
4. Check the tinymce_uploads directory:$ `ls web/tinymce_uploads`

| **39** :$
```
ls web/tinymce_uploads
```

**Upload "automatically"**

1. Look in ~/School/VIP/501/test_uploads
2. Drag any image directly into the TinyMCE editor area
3. Check the tinymce_uploads directory:$ `ls web/tinymce_uploads`
4. Note the file name was preserved

| **40** :$
```
ls web/tinymce_uploads
```

We have an image uploader set

Now, we need to process other files, including automatic uploads

#### TinyMCE File & Media Upload

| **41** :$
```
sudo cp core/10-tiny-file-upload.html web/tiny.html && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/10-tiny-file-upload.html && \
ls web
```

*Note:*

- *Settings "`// Added for media & files`"*
- *`file_picker_callback` enables and defines the upload file icon in the image upload dialog*

| **B-41** :// `localhost/web/tiny.html` *(Same)*

**Upload with the "file picker"**

1. In TinyMCE: Click the "image" button > General: "upload" icon
2. Select an image file from ~/School/VIP/501/test_uploads
3. Check the tinymce_uploads directory:$ `ls web/tinymce_uploads`
4. Note the file name was preserved

| **42** :$
```
ls web/tinymce_uploads
```

We have been uploading files, but we can't choose from other files we've already uploaded

Now, we implement our Media Library into TinyMCE

**Insert media item into TinyMCE**

We will click something outside the TinyMCE editor to make a media item appear inside the TinyMCE `<textarea>`

```html
<!-- TinyMCE insert image -->
<br><button onclick="addImageToTiny('myfile.jpg', 'My file', '128', '128', 'My file title');">add image</button><br>
<script>
  function addImageToTiny(thisFile, thisAlt='', h='', w='', thisTitle='') {
    tinymce.activeEditor.insertContent('<img alt="'+thisAlt+'" title="'+thisTitle+'" height="'+h+'" width="'+w+'" src="uploads/'+thisFile+'">');
  }
</script>

<!-- TinyMCE insert audio -->
<br><button onclick="addAudioToTiny('myfile.mp3', 'audio/mp3');">add audio</button><br>
<script>
  function addAudioToTiny(thisFile, mimeType='') {
    tinymce.activeEditor.insertContent('<audio controls><source src="uploads/'+thisFile+'" type="'+mimeType+'">Not supported.</audio> ');
  }
</script>

<!-- TinyMCE insert video -->
<br><button onclick="addVideoToTiny('myfile.webm', 'video/webm', '512', '910', '');">add video</button><br>
<script>
  function addVideoToTiny(thisFile, mimeType='', h='', w='', poster='') {
    tinymce.activeEditor.insertContent('<video height="'+h+'" width="'+w+'" controls><source src="uploads/'+thisFile+'" type="'+mimeType+'">Not supported.</video> ');
  }
</script>
```

| **43** :$
```
sudo cp core/10-tiny-media-insert.html web/tiny.html && \
sudo cp core/test_uploads/vip-blue.png web/uploads/ && \
sudo cp core/test_uploads/audio.mp3 web/uploads/ && \
sudo cp core/test_uploads/video.webm web/uploads/ && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/10-tiny-media-insert.html && \
ls web web/uploads
```

*Note tiny.html*

- *`<!-- TinyMCE insert ...` creates the `<button>` and the JavaScript function to add the media content to the TinyMCE `<textarea>`*

| **B-43** :// `localhost/web/tiny.html` *(Same)*

1. Click each "add ..." button, probably each on a new line
2. Click the "<>" button in TinyMCE to see the code and the inserted media elements
4. Click to play the audio and video to see that they work
  - If you don't see playable buttons, click the "eye" button in TinyMCE to see rendered HTML

**Insert media into Medium Editor**

| **44** :$
```
sudo cp core/10-medium-media-insert.html web/medium.html && \
atom core/10-medium-media-insert.html && \
ls web web/uploads
```

| **B-44** :// `localhost/web/medium.html`

1. Click each "add ..." button, probably each on a new line
2. Try to delete media items
3. Note it is difficult to delete the audio entry

**UX product roadmap dilemma:**

Medium Editor is a "zen-like" text editor:

- showing "only the words"
- using as few styling buttons as possible, if any at all

Adding media items can be contrary to the UX philosophy of a "zen-like" text editor

To make Medium Editor work well with media (adding image alignment properties etc) would take extensive programming in JavaScript, which is:

- beyond the scope of this course
- beyond the scope of a "zen-like" editor

Until Medium Editor allows easy delete/properties of inserted media, our product roadmap will:

- allow a simple Medium Editor as an option for our users, with no "insert media" options
- require users to switch on TinyMCE to manage media and modify image properties


### Process Uploaded Files: SQL Database

| **45** :$
```
sudo mkdir -p web/media/docs web/media/audio web/media/video web/media/images && \
sudo cp core/10-in.logincheck.php web/in.login_check.php && \
sudo cp core/10-medialibrary12.php web/medialibrary.php && \
sudo cp core/10-upload12.php web/upload.php && \
sudo cp core/10-style12.css web/style.css && \
atom core/10-medialibrary12.php core/10-upload12.php core/10-style12.css core/10-in.logincheck.php && \
ls web web/media
```

*Note the `web/media` directory has many subdirectories:*

  - *`docs`*
  - *`audio`*
  - *`video`*
  - *`images`*

*Note:*

- *in.login_check.php*
  - *Added a link to medialibrary.php in the `<header>`*
- *medialibrary.php*
  - *The JavaScript `alert` for each upload is commented and will be deleted in the future*
  - *We create `<table class="contentlib" id="media-table">`*
    - *This is similar to pieces.php and trash.php, borring much or the CSS*
- *upload.php*
  - *Added section for `SQL entry`*
- *style.css*
  - *Added section for `Media Library`*
  - *This keeps the upload area on the right and the iterated library `<table>` on the left*

| **45** :>
```sql
CREATE TABLE IF NOT EXISTS `media_library` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `size` BIGINT UNSIGNED DEFAULT 1,
  `mime_type` VARCHAR(128) NOT NULL,
  `basic_type` VARCHAR(12) NOT NULL,
  `location` VARCHAR(255) NOT NULL,
  `file_base` VARCHAR(255) NOT NULL,
  `file_extension` VARCHAR(52) NOT NULL,
  `title_text` VARCHAR(255) DEFAULT NULL,
  `alt_text` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
```

| **45** ://phpMyAdmin **> webapp_db > media_library**


| **B-45** :// `localhost/web/medialibrary.php` (Same as previously)

1. Look in ~/School/VIP/501/test_uploads
2. Drag single or multiple files into the area: *"Drop to upload!"*
3. Check in all subdirectories of the media directory:$ `ls web/media/*`
4. Check for new SQL entries:> `SELECT * FROM media_library;`
5. Repeat these steps with many files, including fake and disallowed

| **46** :$
```
ls web/media/*
```

| **46** :>
```sql
SELECT * FROM media_library;
```

| **46** ://phpMyAdmin **> webapp_db > media_library**

We have a list of media files uploaded and entered in our SQL database

Now, let's edit and delete those files and entries...

### Process Uploaded Files: Media Properties `<form>`

| **47** :$
```
sudo cp core/10-ajax.mediainfo13.php web/ajax.mediainfo.php && \
sudo cp core/10-medialibrary13.php web/medialibrary.php && \
sudo cp core/10-upload13.php web/upload.php && \
sudo cp core/10-act.delmedia.php web/act.delmedia.php && \
sudo cp core/10-style13.css web/style.css && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/10-ajax.mediainfo13.php core/10-medialibrary13.php core/10-upload13.php core/10-style13.css && \
ls web
```

*Note:*

- *The media editor is loaded via AJAX*
  - *This uses a `<button>` to capture a hidden `<form>`*
  - *This is borrowed from [Lesson 6](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-06.md)*
- *ajax.mediainfo.php*
  - *This both:*
    - *Creates the edit `<form>`*
    - *Processes the edit `<form>`*
- *medialibrary.php*
  - *`AJAX mediaEdit`*
    - *`<div id="media-editor">` will contain the edit `<form>` after AJAX responds with it*
    - *The "edit" `<button>` is styled to look like a link, much like the actions in pieces.php*
    - *The "edit" `<button>` is in a separate `<table>` column so it doesn't interfere with other HTML content*
    - *JS function `showActions` to only show the "edit" link when hovering over that `<table>` row*
    - *JS function `mediaEdit`:*
      - *shows `<div id="media-editor-container">`*
        - *and `<div id="media-editor">` will appear inside*
      - *AJAX requests the edit `<form>`*
      - *is called by `<button>` in the `<table>`*
    - *JS function `mediaSave` sends the edit `<form>` via AJAX*
      - *JS function `mediaEditorClose` will hide the edit `<form>`*
    - *JS function `changeFileName` creates a small `<form>` in the media editor*
      - *JS function `changeFileNameClose` removes the `<form>`*
    - *JS functions for delete actions and delete confirmation ('showDelete', `toggle`, `confirmDelete`)*
- *upload.php*
  - *Retrieves the new SQL entry ID with `$database->insert_id;`*
  - *Includes our "edit" link, calling the JS function loaded by medialibrary.php*
- *act.delmedia.php*
  - *This processes to-be-deleted items, similarly to act.bulkpieces.php from [Lesson 9](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-09.md)*
  - *It receives the `POST` from `<form id="delete_action"` in medialibrary.php*
- *style.css*
  - *A section `Hide notes` with the `.notehide` class to make some update notices disappear after a few seconds*
  - *Adds some `button.postform`, `pre.postform`, `span.postform` styling*
    - *This is so our AJAX `<button>` looks like an `<a>` link instead of a `<button>`*
    - *Same applies to our file name changer in the `<pre>` tag*
  - *Styles for our media editor AJAX box: `div#media-editor` & `div#media-editor-container`*
    - *Works with JS function `mediaEdit`*
  - *Styles inside our media editor: `div#media-editor-closer` & `h1#media-editor-content`*
    - *So the "&#xd7;" (`&amp;#xd7;`) and `<h1>` from AJAX can fit on the same line*

| **B-47** :// `localhost/web/medialibrary.php` (Ctrl + R to reload)

| **47** :>
```sql
SELECT * FROM media_library;
```

| **47** ://phpMyAdmin **> webapp_db > media_library**

1. Hover over a media item and click "edit"
2. Change something: Title, Alt, Delete, or click the file name to change that
3. Watch for messages
  - If changing the file name, it will become orange and change to the new name in the media `<table>`
  - If changing other information, the media type will become orange in the media `<table>`
  - If changing a just-uploaded item, its upload info color will change to black, filenames will become orange
4. Watch changes in:
  - The file system:$ `ls web/media/*`
  - The SQL table:> `SELECT * FROM media_library;`
5. Repeat these steps with many files, try uploading files to see the "edit" button in the AJAX responses

| **48** :>
```sql
SELECT * FROM media_library;
```

| **48** ://phpMyAdmin **> webapp_db > media_library**

| **48** :$
```
ls web/media/*
```

### Process Uploaded Files: Linux Processing

*Install the Linux tools on our server...*

- `imagemagick` *Images, from [401 Lesson 2](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-02.md)*
  - *Learn at: [https://imagemagick.org/script/command-line-processing.php]*
- `ffmpeg` *Video & audio*
- `pandoc` *Documents, from [301 Lesson 2](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-02.md)*
- `texlive-...` *Dependencies for `pandoc` to create .pdf files*

| **49** :$
```
sudo apt install \
imagemagick \
ffmpeg \
pandoc \
texlive-latex-base \
texlive-fonts-recommended \
texlive-latex-recommended
```

*Copy our web app files...*

| **50** :$
```
sudo mkdir -p web/media/uploads web/media/original/images web/media/original/video web/media/original/audio web/media/original/docs && \
sudo rm -f web/media/docs/* web/media/audio/* web/media/video/* web/media/images/*
sudo cp core/10-bash.imageprocess.sh web/bash.imageprocess.sh && \
sudo cp core/10-bash.videoprocess.sh web/bash.videoprocess.sh && \
sudo cp core/10-bash.audioprocess.sh web/bash.audioprocess.sh && \
sudo cp core/10-bash.docprocess.sh web/bash.docprocess.sh && \
sudo cp core/10-upload14.php web/upload.php && \
atom core/10-bash.imageprocess.sh core/10-bash.videoprocess.sh core/10-bash.audioprocess.sh core/10-bash.docprocess.sh core/10-upload14.php && \
ls web web/media web/media/*
```

*We just deleted all our uploads, clear out the SQL database too...*

| **50** :>
```sql
DELETE * FROM media_library;
```

*Note:*

- *bash.imageprocess.sh*
  - **
- *bash.videoprocess.sh*
  - **
- *bash.audioprocess.sh*
  - **
- *bash.docprocess.sh*
  - **
- *upload.php*
  - **


// Create new standard file sizes (Linux processing)
// Full link to image with JavaScript "select all" auto action and "copy" action (&#x2398 = copy symbol)
// Add buttons in the media library and for each newly-uploaded file
  // Delete button with checkbox & multi-select
  // Edit button (AJAX popup form)
    // Title/alt (image)
    // Rename file





Linux processing

- images - imagemagick
- image sizes & thumbnail for Media Library
- audio/video - ffmpeg (optimized for podcasting and in-site viewing)
  - audio: 96kbps 44kHz mono mp3 (human voice doesn't go over 5kHz, you shouldn't be doing an ultra-high quality musical performance in a blog-based podcast)
  - video: 960×640 (same framerate as recorded)
  - Anything bigger or better, use a CDN like YouTube or SoundCloud
- Doc types: .md .txt .pdf .odt - pandoc
  - Original kept
  - All remain available


### Process Uploaded Files: TinyMCE



### Process Uploaded Files: Linux Processing

| **52** :$
```
sudo mkdir -p web/media/editing && \
sudo rm -f web/media/docs/* web/media/audio/* web/media/video/* web/media/images/*
sudo cp core/10-ajax.mediainfo15.php web/ajax.mediainfo.php && \
sudo cp core/10-medialibrary15.php web/medialibrary.php && \
sudo cp core/10-upload15.php web/upload.php && \
sudo cp core/10-tiny-upload15.php web/tiny-upload.php && \
atom core/10-ajax.mediainfo15.php core/10-medialibrary15.php core/10-upload14.php && \
ls web web/media web/media/*
```

*We just deleted all our uploads, clear out the SQL database too...*

| **52** :>
```sql
DELETE * FROM media_library;
```

*Note:*

- *ajax.mediainfo.php*
  - **
- *medialibrary.php*
  - **
- *upload.php*
  - **


// Add to the AJAX Medial Library edit
  // Make a "largest-processed" copy (1080p) in the editing dir from the original/images dir
  // Minimal TinyMCE editor to edit the image in the editing dir
  // Run the normal Linux processes on save, not replacing the file in original/images
  // Include a "restore original" button to re-process from original/images

// tiny-upload15.php is a port from tiny-upload1.php, no mods yet

### Piece Editor


// Media Library section
  // Insert media JavaScript button with AJAX dialog first
    // Library list
    // Just uploaded list
  // Upload Dropzone
// Posts as Doc file types


___

# The Take


___

#### [Lesson 11: OOP & PDO](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-11.md)

# Shell 501
## Lesson 10: Media Library, Files & Uploads

Ready the CLI

`cd ~/School/VIP/501`

### This lesson uses two terminals and two browser tabs!

Ready the secondary SQL terminal and secondary SQL browser

*(Ctrl + Shift + T for new terminal tab; Ctrl + PageUp/PageDown to switch tabs)*

| **S0** :$ `mysql -u admin -padminpassword` *(password in the terminal, not safe outside these lessons!)*

*(Ctrl + T for new browser tab; Ctrl + PageUp/PageDown to switch tabs)*

| **SB-0** :// `localhost/phpMyAdmin/` Username: `admin` Password: `adminpassword`

| **S1** :> `USE webapp_db;`

| **SB-1** ://phpMyAdmin **> webapp_db**

### Make sure `pandoc` is installed from 301

| **S2** :$ `sudo apt install pandoc texlive-latex-base texlive-fonts-recommended texlive-latex-recommended ffmpeg imagemagick`

### Webapp Dashboard Login:

| **SB-2** :// `localhost/web/webapp.php` (Check that you're logged in)

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

- The mime type is a file's type based on what is inside the file, not just the extension
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

| **B-24** :// `localhost/web/upload.php` (Same)

1. Click "Browse..."
2. Look in ~/School/VIP/501/test_uploads
3. Select & "open" ***various files***
4. Click "Upload"
5. Check the uploads directory:$ `ls web/uploads`
6. Repeat these steps with many files, including fake

### Process Uploaded Files



### JavaScript Drag-in Uploader





| **27** :> `SELECT * FROM series;`

| **27** ://phpMyAdmin **> series**


Linux processing
- images - imagemagick
- audio/video - ffmpeg
- posts as files .md .pdf .odt - pandoc

___

# The Take


___

#### [Lesson 11: OOP & Production](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-11.md)

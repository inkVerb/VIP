# Shell 501
## Lesson 12: XML

Ready the CLI

```console
cd ~/School/VIP/501
```
___

### XML

**eXtensible Markup Language**

1. Is static text
  - Text file or rendered text (ie `<?php echo $some_xml; ?>`)
  - NOT a logic-executed script like BASH, JavaScript, PHP, et cetera
  - Looks like HTML, came after HTML to maximize HTML concepts, can't replace HTML
    - 1993: HTML (keeps updating, version 5 in 2021)
    - 1996: XML (still using version 1.0)
2. Used in:
  - Documents (.doc, .docx, .odt, et cetera)
  - Desktop settings (wallpaper, mouse speed, display brightness, audio volume, et cetera)
  - RSS feeds
  - Podcasts
  - Blogs (ie WordPress export/import file)
  - API communication
3. Is a data "Object" language
  - Only for data content
    - Variables (called "entity reference")
    - NOT functions
  - Database alternative to SQL, but needs other tools for query/parsing
4. Comparable to JSON
  - Portable to/from JSON
  - Machine version of what JSON is for JavaScript
  - JSON is used in the browser, XML is used everywhere else
5. Can be read by many languages
  - BASH/Linux terminal (`linuxlint`)
  - PHP (`xml_parser_create` & `SimpleXML`)
  - JavaScript (`xml2json` & `json2xml`)
  - SQL (`FOR XML AUTO`, `FOR XML PATH`, `FROM OPENXML`)
  - And many more
    - Node.js
    - Python
    - Java
    - Perl
    - Swift
    - C
6. Is styleable using CSS and XSLT
7. For machines, not browsers
  - Desktop app
  - Mobile app
  - Server app
  - "Machine side" (server & local device, not browser)
  - In theory, an RSS/XML feed comes ***raw*** from the server and is then either:
    - Shown unaltered within a browser OR
    - Interpreted by another app on a desktop, mobile, or server
  - Because XML isn't SQL
    - Query/parsing is optional, but not necessary
    - It is NOT secure; all information is public

### XML
- RSS feeds by tag & series
- Import-export mod
  - Import/export native
  - Import/export for WordPress
- Podcast mod

### Feature Roadmap:
- Editor/Pieces Upgrades
  - Title capitalizer
  - HTML allowed in "After"
  - JS word counter
- Identity connected to users and pieces
  - Identities editor
- Choose "Menu Pages" (mod)
- Editor: Medium or Tiny
- Basic Flair Colors (default option)
- Night/day/soft mode cookies
- Menu Lists
  - 2 Pages Lists
  - 1 Social List
  - Custom Links
  - Combined Lists (choose from Pieces, Custom Links, Dropdown other list)
    - Dropdown (show another 'List'/'Section' on click)
- Landing Pages (mod, content type)
  - combine sections
  - section height (auto/full)
  - top/social menus y/n
  - drop-in PHP/HTML code
- Landing Page Sections
  - list (choose from Menu Lists)
  - forms
  - button links
  - buttons show forms
  - background images w color overlay
  - background colors
  - columns
  - sections appear at top/bottom of both/posts/pages of all/series
- Join mod (allow Member class signup with payment)
- Shop mod


### Blog Settings

| **12** :$
```
sudo cp core/11-settings.php web/settings.php && \
sudo cp core/11-menus.php web/menus.php && \
sudo cp core/11-series.php web/series.php && \
sudo cp core/11-mods.php web/mods.php && \
atom core/11-settings.php core/11-menus.php core/11-series.php && \
ls web
```


| **B-26** :// (<kbd>Ctrl</kbd> + R to reload)

```console
localhost/web/settings.php
```


### Pages to Process Our New Meta

| **12** :$
```
sudo cp core/11-blog.php web/blog.php && \
sudo cp core/11-piece.php web/piece.php && \
sudo cp core/11-hist.php web/hist.php && \
atom core/11-blog.php core/11-piece.php core/11-hist.php && \
ls web
```


___

# The Take


___

# Done! Have a cookie: ### #

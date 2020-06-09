# HTML-CSS-JS

## Render 'naked' HTML on a web page

### HTML uses XML `<tags>`
- Each has an open `<tag>` and close `</tag>`
- Some tags are self-closing
  - XML: `<self-closing-tag />`
  - HTML: `<self-closing-tag>`
- ***HTML tags are called "elements", not "tags"!***

### First line:
- The first line of an HTML file is:
```html
<!DOCTYPE html>
```

### Comments
```html
<!-- I am a comment -->

<!--
- Comments may span multiple lines

Just like this

 -->
```

### DOM (Document Object Model)
- The basic "floor plan" of an HTML file is called the DOM
- Basic HTML4 DOM:
```html
<!DOCTYPE html>
<html>

  <head>
  </head>

  <body>
  </body>

</html>
```
- Page content is in `<body>`

- Basic HTML5 DOM:
```html
<!DOCTYPE html>
<html>

  <head>
  </head>

  <body>

  <header>
  </header>

  <footer>
  </footer>

  </body>

</html>
```

- `<head>` example:
```html
<head>
  <title>Browser Title</title>
  <meta charset="utf-8">
  <meta name="robots" content="noindex">
  <meta name="description" content="Describe website in search results">
  <meta http-equiv="content-type" content="text/html; charset=utf-8">
  <link href="https://verb.ink/" rel="canonical">
  <link rel="shortcut icon" type="image/png" href="favicon.png">
  <link href="css/styles.css" rel="stylesheet" type="text/css">
</head>
```

- `<header>` example:
```html
<header>

  <nav>
    <ul class="menu">
      <li><a href="index.html">Home</a></li>
      <li><a href="about.html">About</a></li>
    </ul>
  </nav>

</header>
```
- Main content example: (between `<header>` and `<footer>`)
```html
<div id="main">

  <section>
    <p>We like inking! <a href="http://verb.ink">Learn more</a></p>
  </section>

  <article>
    <h1>Post Title</h1>
    <p>I am a long blog post.</p>
    <p>I am another paragraph in the long blog post.</p>
  </article>

  <aside>
    <p>Another great article to distract you! <a href="otherarticle.html">Read more...</a></p>
  </aside>

</div>
```
- `<footer>` example:
```html
<footer>

  <nav>
    <ul class="menu">
      <li><a href="terms.html">Terms & Privacy</a></li>
    </ul>
  </nav>

</footer>
```

### Attributes & Values
- Example:
  - Element: `p`
  - Attribute: `style=`
  - Value: `"color:red;"`

```html
<p style="color:red;">

</p>
```

- **All elements can have attributes `id` and `class`**
  - These are used by
  - CSS
  - JavaScript
- Example:
    - Element: `p`
    - ID attribute: `id="top"` (must be unique or page will break!)
    - Class attribute: `class="big"` (can be used many times)

  ```html
  <p id="top" class="big" style="color:red;">

  </p>
  ```

### Common Elements
- Organizing:
  - `<header>` usually was: `<body><div class="header">`
  - `<footer>` usually was: `<body><div class="footer">`
  - `<nav>` (navigation menu)
  - `<section>` (large area)
  - `<article>` (one item)
  - `<aside>` (widget/ad area)
  - `<div>` (other)
  - In HTML4, these were only `<div>`
- Headers: `<h1>`, `<h2>`, ... `<h6>`
- Paragraphs:
  - `<p>` (normal paragraph)
  - `<blockquote>` (block quote)
  - `<pre>` (monospage paragraph)
- Style:
  - `<i>` italics
  - `<b>` bold
  - `<em>` emphasis ('important' italics)
  - `<strong>` strong ('important' bold)
  - Special style span:
    - `<span>` (to set special style)
    - `<code>` (monospace span)
    - `<q>` (quote)
    - `<cite>` (source citation)
  - Change color/font example: (CSS goes inside `style=""`)
    - `<span style="color:red; font-weight:bold; font-size: 10pt">`
- Lists:
  - `<ol>` / `<ul>` ordered / unordered
    - `<li>` list item
- Breaks:
  - `<br>` line break
  - `<hr>` horizontal rule
- Link: `<a>`
- Webforms: `<form>`
  - `<textarea>`
  - `<select>`
    - `<option>`
  - `<input>` `type=`:
    - `"text"`
    - `"password"`
    - `"radio"`
    - `"color"`
    - `"submit"`
- Media: (self-closing)
  - Image: `<img>`
  - Audio: `<audio>` (HTML5)
  - Video: `<video>` (HTML5)

### HTML entities
*Most special characters need an HTML code called an "HTML entity"*

Here are some:
```html
   &#160;   &nbsp;  ('non-breaking space'; white space is ignored, this won't be ignored)
"  &#34;    &quot;
'  &#39;    &apos;
&  &#38;    &amp;
<  &#60;    &lt;
>  &#62;    &gt;
°  &#176;   &deg;
¶  &#182;   &para;
–  &#8211;  &ndash;
—  &#8212;  &mdash;
‾  &#8254;  &oline;
‘  &#8216;  &lsquo;
’  &#8217;  &rsquo;
“  &#8220;  &ldquo;
”  &#8221;  &rdquo;
™  &#8482;  &trade;
©  &#169;   &copy;
®  &#174;   &reg;
¢  &#162;   &cent;
£  &#163;   &pound;
€  &#8364;  &euro;
¥  &#165;   &yen;
¤  &#164;   &curren;
¦  &#166;   &brvbar;
§  &#167;   &sect;
←  &#8592;  &larr;
↑  &#8593;  &uarr;
→  &#8594;  &rarr;
↓  &#8595;  &darr;
♠  &#9824;  &spades;
♣  &#9827;  &clubs;
♥  &#9829;  &hearts;
♦  &#9830;  &diams;
```

## CSS
*Style the text of an HTML document*

**Cascading Style Sheet**

- Font
- Size
- Color
- Location
- Bold/italics/etc
- Border
- Margin
- Padding
- Space before/after

***It helps to understand fonts:***
- Awesome, fast video - [Karen Kavett DIY: An Intro to Typography](https://www.youtube.com/watch?v=tWFWJGA7qrc)
- Short overview - [PinkWrite: Intro to 5 fonts](https://drive.google.com/open?id=0BwTdjnieHEEndkR3OFZjdVJ0QWM)
- Short overview - [PinkWrite: Intro to Roman fonts](https://drive.google.com/open?id=0BwTdjnieHEEnNjF3RktZbmhiaTg)
- In-depth - [fonts.com: Type Classifications](https://www.fonts.com/content/learning/fontology/level-1/type-anatomy/type-classifications)

***It helps to understand Color Theory and RGB:***
- Understand HTML color codes - [RGB](https://www.youtube.com/watch?v=HX46ILgwTNk)
- Color Theory - [Beginning Graphic Design: Color](https://www.youtube.com/watch?v=_2LLXnUdUIc)
- Examples mixing colors - [RGB & CMYK](https://github.com/inkVerb/pictypes/blob/master/rgb-cmyk.md)
- Different image types - [JPEG & PNG](https://github.com/inkVerb/pictypes/blob/master/jpg-png.md)

### Comments
```css
/* I am a comment */

/*
* Comments may span multiple lines

Just like this

 */
```

### Format

- **Sizes** can be:
  - `px`  pixels (default)
  - `em`  relative to font-size of the element
  - `cm` 	centimeters (relative to pixels and inches)
  - `mm` 	millimeters (relative to pixels and inches)
  - `in` 	inches (1in = 96px = 2.54cm)
  - `pt` 	points (1pt = 1/72 of 1in)
  - `pc` 	picas (1pc = 12 pt)
  - Newer browers:
    - `vw` 	viewport width: relative to 1% of the width of the browser
    - `vh` 	viewport height: relative to 1% of the height of the browser

- **Colors** can be:
  - Hexcode - eg: `#aaff33;`
  - RGB - eg: `rgb(170,255,51);`
  - Name - eg: `red;`
  - Others, but we mainly use hexcode

- Styling:
```css
/* Element */
p {
  color: #222;
}

/* ID */
#top {
  color: #222;
}

/* Class */
.big {
  color: #222;
}

/* Element only with ID */
p#top {
  color: #222;
}

/* Element only with Class */
p.big {
  color: #222;
}

/* Many Elements */
p, div, a {
  color: #222;
}

/* Many Elements only with ID */
p#top, p#bottom, div#info, a#home {
  color: #222;
}

/* Many Elements only with Class */
p.big, p.small, div.big, a.big {
  color: #222;
}

```

| **Element `<p>`** : color, background, font, size
```css
p {
  color: #222;
  background: #fff;
  font-family:Helvetica, "Open Sans", sans-serif;
  font-size: 0.8em;
}
```

| **Style by element, class, or id** :

```html
<p id="top" class="big">

</p>

<p id="bottom" class="big">

</p>

<div id="note" class="big">

</div>
```

```css
.top {
  color: #222;
  background: #fff;
  font-family:Helvetica, "Open Sans", sans-serif;
  font-size: 0.8em;
}
```

*This can all be on one line, but this is the style of most CSS stylesheets*

### Style HTML with CSS
- Embed CSS in the `<head>` between `<style>` tags
```html
<style>
  p { color: #222; font-size: 0.8em; }
</style>
```

- `<link>` CSS in the `<head>`
```html
<link href="css/styles.css" rel="stylesheet" type="text/css">
```

## Try yourself:

`git clone https://github.com/inkVerb/HTML-CSS-JS`

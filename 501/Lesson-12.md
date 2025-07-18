# Linux 501
## Lesson 12: XML

This lesson uses XML CLI tools install in [Lesson 0: Server, LAMP Setup & HTML Fast](https://github.com/inkVerb/vip/blob/master/501/Lesson-00.md)

Ready the CLI

```console
cd ~/School/VIP/501
```
Ready services

Arch/Manjaro, OpenSUSE, RedHat/CentOS
```console
sudo systemctl start httpd mariadb
```

Debian/Ubuntu
```console
sudo systemctl start apache2 mariadb
```

If teaching multiple students

Prep directory
```console
cd ~/School/VIP
```

Webapp database ***dump***
```console
mariadb-dump -u admin -padminpassword blog_db > STUDENT_1/blog_db.sql
```

Webapp database ***restore***
```console
mariadb -u admin -padminpassword blog_db < STUDENT_2/blog_db.sql
```

Backup Student 1 schoolwork directory
```console
rm 501/web
sudo mv /srv/www/html/web 501/
```

```console
mv 501 STUDENT_1/
```

Restore Student 2 schoolwork directory
```console
mv STUDENT_2/501 .
```

```console
sudo mv 501/web /srv/www/html/
sudo chown -R www:www /srv/www/html/web
sudo ln -sfn /srv/www/html/web 501/
sudo chown -R www:www 501/web
```

Re-ready the CLI

```console
cd ~/School/VIP/501
```

___

### I. XML Structure
**eXtensible Markup Language**

1. Is static text
  - Text file or rendered text (ie `<?php echo $some_xml; ?>`)
  - NOT a logic-executed script like BASH, JavaScript, PHP, et cetera
  - Looks like HTML, came after HTML to maximize HTML concepts, can't replace HTML
    - 1986: SGML (Standard Generalized Markup Language)
    - 1993: HTML (keeps updating, version 5 in 2023)
    - 1998: XML (still using version 1.0)
  - Languages using SGML:
    - HTML
    - XML
    - LaTeX (print publishing language)
    - Word processor documents before 2007
      - .doc used SGML, not XML
    - US Department of Defense
    - Airline industry
    - Oxford English Dictionary (digital version)
    - European Commission
    - International Standards Organization
2. XML is used in:
  - Word processor documents (.docx, .odt, et cetera)
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
  - Machine OS version of what JSON is for JavaScript
  - JSON is used in the browser, XML is used everywhere else
5. Can be read by many languages
  - BASH/Linux terminal (`xmlstarlet`)
  - PHP (`xml_parser_create` & `SimpleXML`)
  - JavaScript (`xml2json` & `json2xml`)
  - SQL (`FOR XML AUTO`, `FOR XML PATH`, `FROM OPENXML`)
  - And many more
    - C
    - Go
    - Java
    - Python
    - Perl
    - Swift
    - Android
    - Ruby
    - Node.js
6. Is styleable using CSS and XSLT
7. For machines, not browsers
  - Desktop app
  - Mobile app
  - Server app
  - "Machine side" (server & local device, not browser)
  - In theory, an RSS/XML feed comes ***raw*** from the server and is then either:
    - Shown unaltered within a browser OR
    - Interpreted by another app on a desktop, mobile, or server machine
  - Because XML isn't SQL
    - Query/parsing is optional, but not necessary
    - It is NOT secure; all information is public
    - Illustration: XML is a grocery list on the wall, SQL is a bank statement

#### A. Basic Structure

| **1** :$

```console
sudo cp core/12-syntax1.xml web/syntax.xml && \
sudo chown -R www:www /srv/www/html && \
code core/12-syntax1.xml && \
ls web
```

| **Header** : *On the first line*

```xml
<?xml version="1.0" encoding="utf-8" ?>
```

| **Comments** : *Inside `<!-- -->`*

```xml
<!-- Some comment -->
```

| **Root Element** : *Wraps all tags, can be anything*

```xml
<?xml version="1.0" encoding="utf-8" ?>

<iamrootelement>
  <!-- All other content -->
</iamrootelement>
```

| **Open-closing tags** : *Can be any text, case-sensitive, each unique*

```xml
<!-- <sometag> comment -->
<sometag>
  <innertag>

  </innertag>
</sometag>

<!-- <sometag> is not <SomeTag> -->
<SomeTag>
  <InnerTag>

  </InnerTag>
</SomeTag>
```

| **Tag attribute** : *Inside opening tag*

```xml
<tag attribute="one">
  something here
</tag>
```

| **Self closing tag** : *`/` at end, no closing tag needed*

```xml
<selfclosing/> <!-- No content -->

<selfclosewattrib attrbt="something here"/> <!-- Content in attribute -->
```

| **B-1** ://

```console
localhost/web/syntax.xml
```

*Root tags are important*

| **2** :$

```console
sudo cp core/12-syntax2.xml web/syntax.xml && \
sudo chown -R www:www /srv/www/html && \
code core/12-syntax2.xml && \
ls web
```

```xml
<!-- We removed these tags: -->

<root>
  ...
</root>
```

| **B-2** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/syntax.xml
```

*...The page is broken..*

*XML thinks `<sometag>` is the root tag, so it thinks everything after `</sometag>` is "Extra content at the end of the document"*

#### B. Reused Namespace

| **3** :$

```console
sudo cp core/12-syntax3.xml web/syntax.xml && \
sudo chown -R www:www /srv/www/html && \
code core/12-syntax3.xml && \
ls web
```

*Namespace can be used multiple times...*

```xml
<table>
  <type>Folding</type>
  <color>Black</color>
</table>
<table>
  <type>Fixed</type>
  <color>Gray</color>
</table>
```

| **B-3** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/syntax.xml
```

#### C. Namespace Prefix
*Same words with a different purpose*

| **4** :$

```console
sudo cp core/12-syntax4.xml web/syntax.xml && \
sudo chown -R www:www /srv/www/html && \
code core/12-syntax4.xml && \
ls web
```

*The prefix is defined by a URI in the first set of each hierarchy it is used*

| **Prefix `s:** :

```xml
<s:table xmlns:s="https://verb.ink/stock">
  <s:type>Folding</s:type>
  <s:color>Black</s:color>
</s:table>

<s:table xmlns:s="https://verb.ink/stock"> <!-- Defined again for the next set, same value -->
  <s:type>Fixed</s:type>
  <s:color>Gray</s:color>
</s:table>
```

| **B-4** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/syntax.xml
```

#### D. Special Characters

| **5** :$

```console
sudo cp core/12-syntax5.xml web/syntax.xml && \
sudo chown -R www:www /srv/www/html && \
code core/12-syntax5.xml && \
ls web
```

*For example, we will put these into the XML document*

```
" ' < > &
```

*We can use either HTML entities or CDATA...*

| **HTML Entities** :

```xml
<something attrib="&quot; &apos; &lt; &gt; &amp;">
  <spchar>
    &quot; &apos; &lt; &gt; &amp;
  </spchar>
</something>
```

| **CDATA** : `<![CDATA[ ... ]]>`

```xml
<![CDATA[ " ' < > & ]]>
```

| **B-5** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/syntax.xml
```

*Note, `[` and `]` characters can work raw inside `<![CDATA[ ... ]]>`*

#### E. XML from PHP
*We can use PHP to render XML*

- *This needs:*
  1. *PHP file to `echo` the XML document*
  2. *A `header()` statement to set the MIME type:*
    - `header('Content-type: text/xml');`
  3. *`RewriteRule` in .htaccess to create a .xml file in browser address*

| **6** :$

```console
sudo cp core/12-xmlrender6.php web/xmlrender.php && \
sudo cp core/12-htaccess6 web/.htaccess && \
sudo chown -R www:www /srv/www/html && \
code core/12-xmlrender6.php 12-htaccess6 && \
ls web
```

| **Header MIME Type** :

```php
header('Content-type: text/xml');
```

| **HTML entities** :

```php
htmlentities($special_characters);
```

| **.htaccess** :

```
RewriteEngine on

RewriteRule ^somefile.xml$ somefile.php [L]
```

| **B-6** ://

```console
localhost/web/xmlrender.xml
```

### II. XML Validation (DTD & XSD)
*The XML document will define its own schema to validate itself*

*There are two systems for this:*

- *DTD (Document Type Definition; predates XML)*
- *XSD (XML Schema Definition; DTD in XML format)*

*This lesson will not teach a complete series on XML validation, but you will understand enough for our purposes and to learn more easily in the future*

#### A. DTD (Document Type Definition)

| **7** :$

```console
sudo cp core/12-validate7.xml web/validate.xml && \
sudo chown -R www:www /srv/www/html && \
code core/12-syntax7.xml && \
ls web
```

| **DTD** :

```xml
<!DOCTYPE root[
  <!ELEMENT person (one,two,also,there)>
  <!ATTLIST person att (val1 | val2 | val3) "val1" >
  <!ELEMENT one (#PCDATA)>
  <!ELEMENT two (#PCDATA)>
  <!ELEMENT also (#PCDATA)>
  <!ELEMENT there (#PCDATA)>
  <!ELEMENT self_close EMPTY>
  <!ELEMENT attribs (#PCDATA)>
  <!ATTLIST attribs attr (val1 | val2 | val3) "val1" >
]>
```

*Note `<!ELEMENT person (one,two,also,there)>` means `<person>` **must** contain tags `<one>` `<two>` `<also>` `<there>`*

| **Content** :

```xml
<root>
  <person att="val1">
    <one>...</one>
    <two>...</two>
    <also>...</also>
    <there>...</there>
    <self_close/>
    <attribs attr="val1">...</attribs>
  </person>
</root>
```

| **B-7** ://

```console
localhost/web/validate.xml
```

*You can embed the DTD in a separate file*

```xml
<!DOCTYPE rootel SYSTEM "something.dtd">
```

| **8** :$

```console
sudo cp core/12-validate8.xml web/validate.xml && \
sudo cp core/12-validate8.dtd web/validate.dtd && \
sudo chown -R www:www /srv/www/html && \
code core/12-validate8.xml core/12-validate8.dtd && \
ls web
```

| **validate.dtd** :

```xml
<!ELEMENT person (one,two,also,there)>
<!ATTLIST person
  attr (val1 | val2 | val3)
>
<!ELEMENT one (#PCDATA)>
<!ELEMENT two (#PCDATA)>
<!ELEMENT also (#PCDATA)>
<!ELEMENT there (#PCDATA)>

<!ELEMENT self_close EMPTY>

<!ELEMENT attribs (#PCDATA)>

<!ATTLIST attribs
  attr (val1 | val2 | val3)
>
```

| **mainfile.xml** :

```xml
<?xml version="1.0" encoding="utf-8" ?>

<!DOCTYPE root SYSTEM "validate.dtd">

<root>
  <person attr="val1">
    <one>...</one>
    <two>...</two>
    <also>...</also>
    <there>...</there>
    <self_close/>
    <attribs attr="val1">...</attribs>
  </person>
</root>
```

| **B-8** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/validate.xml
```

*Note everything works just the same*

**About `standalone="yes"`:**

| **Validate-Only DTD** : (This XML document will only validate from DTD, not make corrections)

```xml
<?xml version="1.0" encoding="utf-8" standalone="yes" ?>
```

- DTD will ***validate only, but not make corrections,*** if your `<?xml ?>` statement includes `standalone="yes"`
- `standalone="yes"` does absolutely nothing else
- `standalone="no"` is the default
- When validating with `standalone="no"`, DTD will add missing requirements and adjust self-closing tags, et cetera
- Only use `standalone="yes"` if you want DTD to validate, but not adjust XML; `standalone="no"` is redundant
- `standalone=` has NO effect on XSD, which we prefer over DTD anyway

#### B. XSD (XML Schema Definition)
##### XSD Basics
*XSD uses validation terms in XML language, not DTD (SGML) language*

*Note this example defines validation for the same XML in the previous two examples...*

| **9** :$

```console
sudo cp core/12-validate9.xml web/validate.xml && \
sudo chown -R www:www /srv/www/html && \
code core/12-syntax9.xml && \
ls web
```

*Note the `<root>` element also wraps the XSD schema*

| **XSD** :

```xml
<?xml version="1.0" encoding="utf-8" ?>

<root>

  <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">

    <!-- Options for <attribs attr=""  -->
    <xs:simpleType name="attrvallist">
      <xs:restriction base="xs:string">
        <xs:enumeration value="val1"/>
        <xs:enumeration value="val2"/>
        <xs:enumeration value="val3"/>
      </xs:restriction>
    </xs:simpleType>

    <xs:element name="person"> <!-- Declare the <person> element -->
      <xs:complexType> <!-- The <person> element contains attributes and/or child elements -->
        <xs:attribute name="att" type="attrvallist" default="val1"/> <!-- Include the "attrvallist" options previously defined -->

        <xs:sequence> <!-- The order of child elements matters, optional -->
          <!-- Below we declare our various elements, self-closing tags because they contain no further definitions -->
          <xs:element name="one" type="xs:string"/>
          <xs:element name="two" type="xs:string"/>
          <xs:element name="also" type="xs:string"/>
          <xs:element name="there" type="xs:string"/>
          <!-- Self-closing tags are treated the same way as empty tags in XML and XSD -->
          <xs:element name="self_close" type="xs:string"/>
          <!-- This element definition is not self-closing because it contains an attribute definition -->
          <xs:element name="attribs" type="xs:string">
            <!-- Below we define options for the "attr" attribute in the <attribs> element -->
            <xs:attribute name="attr" type="attrvallist" default="val1"/> <!-- Include the "attrvallist" options previously defined -->
          </xs:element>

        </xs:sequence>
      </xs:complexType>
    </xs:element>

  </xs:schema>
```

| **Content** :

```xml
  <person attr="val1">
    <one>...</one>
    <two>...</two>
    <also>...</also>
    <there>...</there>
    <self_close/>
    <attribs attr="val1">...</attribs>
  </person>

</root>
```

| **B-9** ://

```console
localhost/web/validate.xml (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)
```

##### Include XSD
*You can include the XSD schema from a separate file*

*These have the same XML and XSD...*

| **10** :$

```console
sudo cp core/12-validate10.xml web/validate.xml && \
sudo cp core/12-validate10.xsd web/validate.xsd && \
sudo chown -R www:www /srv/www/html && \
code core/12-validate10.xml core/12-validate10.xsd && \
ls web
```

| **schema.xsd** :

```xml
<?xml version="1.0" encoding="utf-8" ?>

<xs:schema  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
            targetNamespace="http://inkisaverb.com/something"
            xmlns="http://inkisaverb.com/something schema.xsd"
            >

  <xs:simpleType name="attrvallist">
    <xs:restriction base="xs:string">
      <xs:enumeration value="val1"/>
      <xs:enumeration value="val2"/>
      <xs:enumeration value="val3"/>
    </xs:restriction>
  </xs:simpleType>

  <xs:element name="person">
    <xs:complexType>
      <xs:attribute name="att" type="attrvallist" default="val1"/>

      <xs:sequence>

        <xs:element name="one" type="xs:string"/>
        <xs:element name="two" type="xs:string"/>
        <xs:element name="also" type="xs:string"/>
        <xs:element name="there" type="xs:string"/>

        <xs:element name="self_close" type="xs:string"/>

        <xs:element name="attribs" type="xs:string">
          <xs:attribute name="attr" type="attrvallist" default="val1"/>
        </xs:element>

      </xs:sequence>
    </xs:complexType>
  </xs:element>

</xs:schema>
```

| **contents.xml** :

```xml
<?xml version="1.0" encoding="utf-8" ?>

<root xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://inkisaverb.com/something schema.xsd">
  <person attr="val1">
    <one>...</one>
    <two>...</two>
    <also>...</also>
    <there>...</there>
    <self_close/>
    <attribs attr="val1">...</attribs>
  </person>
</root>
```

| **B-10** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/validate.xml
```

*Note everything works just the same*

##### Different XSD Include Declarations

*There are different ways to publish XML and XSD headers*

1. Namespace

| **schema.xsd** :

```xml
<?xml version="1.0" encoding="utf-8" ?>

<xs:schema  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
            targetNamespace="http://inkisaverb.com/something.xsd"
            >
```

| **contents.xml** :

```xml
<?xml version="1.0" encoding="utf-8" ?>

<root xmlns:ns="http://inkisaverb.com/something"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://inkisaverb.com/something.xsd schema.xsd"
      >
```

*Note `http://inkisaverb.com/something.xsd` could be any web file with XSD*

*Note `xsi:schemaLocation` contains a space-separated list of XSD locations, "schema.xsd" is local*

2. No Namespace

| **schema.xsd** :

```xml
<?xml version="1.0" encoding="utf-8" ?>

<xs:schema  xmlns:xsd="http://www.w3.org/2001/XMLSchema">
```

| **contents.xml** :

```xml
<?xml version="1.0" encoding="utf-8" ?>

<root xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:noNamespaceSchemaLocation="schema.xsd"
      >
```

*Note `xsi:noNamespaceSchemaLocation` has one XSD location, "schema.xsd" is local*

*Our last example used XSD with namespace*

*Now, let's try without namespace...*

| **11** :$

```console
sudo cp core/12-validate11.xml web/validate.xml && \
sudo cp core/12-validate11.xsd web/validate.xsd && \
sudo chown -R www:www /srv/www/html && \
code core/12-validate11.xml core/12-validate11.xsd && \
ls web
```

*Note only the XSD declarations changed, everything else is the same*

| **B-11** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/validate.xml
```

##### XSD Elements & Attributes

###### Restricting options

- Restricted: `type="somelist"` indicating `<xs:restriction>`
- Any value: `type="xs:string"` accepts any string

*Without `type="somelist"` indicating a previous `<xs:restriction>`, the attribute or element value could be anything*

1. These two examples do not define any `type="somelist"` indicating `<xs:restriction>`, only `type="xs:string"` so their values could be anything

```xml
<!-- attribute with a default value, accepting any string value -->
<xs:attribute name="level" type="xs:string" default="user"/>

<!-- element with no default value, accepting any string value -->
<xs:element name="name" type="xs:string"/>
```

2. This is restricted and indicates its allowed values from a list

Allowed list of values: `sportattrlist`

```xml
<xs:simpleType name="sportattrlist">
  <xs:restriction base="xs:string">
    <xs:enumeration value="skateboard"/>
    <xs:enumeration value="soccer"/>
    <xs:enumeration value="golf"/>
  </xs:restriction>
</xs:simpleType>
```

Restricted attribute: `type="sportattrlist"`

```xml
<xs:element name="sport" type="xs:string">
  <xs:attribute name="type" type="sportattrlist" default="skateboard"/>
</xs:element>
```

###### `<xs:complexType>` vs `<xs:simpleType>`

- `<xs:complexType>` & `<xs:simpleType>` can apply to:
  - `<xs:element>`
  - `<xs:attribute>`

1. `<xs:simpleType>` CANNOT contain:
  - Attributes
  - Elements

| **<elem>` `simpleType` self-closing** : (XDS considers same as empty)

```xml
<elem/>
```

| **<elem>` `simpleType` empty** : (XDS considers same as self-closing)

```xml
<elem></elem>
```

| **<xs:simpleType> usage** :

```xml
<!-- Allow only three possible values: val1, val2, val3 -->
<xs:element name="somelist" default="val1">
  <xs:simpleType>

    <xs:restriction base="xs:string">
      <xs:enumeration value="val1"/>
      <xs:enumeration value="val2"/>
      <xs:enumeration value="val3"/>
    </xs:restriction>

  </xs:simpleType>
</xs:element>

<!-- Allow only a range of integers 20-270 -->
<xs:element name="height">
  <xs:simpleType>

    <xs:restriction base="xs:integer">
      <xs:minInclusive value="20"/>
      <xs:maxInclusive value="270"/>
    </xs:restriction>

  </xs:simpleType>
</xs:element>
```

*Note in XML and XSD, self-closing and empty tags are considered the same:*

  - `<elem/>` = `<elem></elem>`
  - `<elem attr="here"/>` = `<elem attr="here"></elem>`

2. `<xs:complexType>` means the parent (`<xs:element name="elem">`) has any of:
  - Attributes
  - Elements

| **<elem>` `complexType` with attributes** :

```xml
<elem attr="here"/>
```

| **<elem>` `complexType` with other elements** :

```xml
<elem>
  <one>some string</one>
  <two>other string</two>
</elem>
```

| **<xs:simpleType> usage** :

```xml
<!-- With attributes -->
<xs:element name="something">
  <xs:complexType>

    <xs:attribute name="else" type="xs:string"/>

  </xs:complexType>
</xs:element>

<!-- With child elements, order DOES matter -->
<xs:element name="something">
  <xs:complexType>

    <xs:sequence>
      <xs:element name="alpha" type="xs:string"/>
      <xs:element name="bravo" type="xs:string"/>
      <xs:element name="delta" type="xs:string"/>
    </xs:sequence>

  </xs:complexType>
</xs:element>

<!-- With child elements, order does NOT matter -->
<xs:element name="something">
  <xs:complexType>

    <xs:element name="alpha" type="xs:string"/>
    <xs:element name="bravo" type="xs:string"/>
    <xs:element name="delta" type="xs:string"/>

  </xs:complexType>
</xs:element>
```

- `<xs:sequence>` defines defines that the order of elements matters

##### Restrict Value Options

*There are two ways to restrict options for a value*

**Allow only three possible values for element `<somelist>`: val1, val2, val3**

| **XML** :

```xml
<!-- Chose -->
<somelist>val1</somelist>
<!-- or -->
<somelist>val2</somelist>
<!-- or -->
<somelist>val3</somelist>
```

| **XSD Values** :

```xml
<!-- 1. Single definition -->
<xs:element name="somelist" default="val1">
  <xs:simpleType>

    <xs:restriction base="xs:string">
      <xs:enumeration value="val1"/>
      <xs:enumeration value="val2"/>
      <xs:enumeration value="val3"/>
    </xs:restriction>

  </xs:simpleType>
</xs:element>

<!-- 2. Two definitions -->
<!-- Define the options first -->
<xs:element name="somelist" default="val1">
  <xs:simpleType>

    <xs:restriction base="xs:string">
      <xs:enumeration value="val1"/>
      <xs:enumeration value="val2"/>
      <xs:enumeration value="val3"/>
    </xs:restriction>

  </xs:simpleType>
</xs:element>
<!-- Then define the element as the type="somelist" we already defined -->
<xs:element name="here" type="somelist" default="val1"/>
```

###### Single vs Inherited Definitions

| **XML** :

```xml
<elem attr="here">
  <one>some string</one>
  <two>true</two>
  <tre>11/05/1955</tre>
</elem>
```

| **XSD Inheritance** :

```xml
<!-- 1. Single definition (no inheritance) -->
<xs:element name="elem">
  <xs:complexType>

    <xs:attribute name="attr" type="xs:string"/>

    <xs:element name="one" type="xs:string"/>
    <xs:element name="two" type="xs:boolean"/>
    <xs:element name="tre" type="xs:date"/>

  </xs:complexType>
</xs:element>

<!-- 2. Inherited definition -->
<!-- First, simply declare the element -->
<xs:element name="elem" type="alpha"/> <!-- Self-closing -->
  <!-- Second, define a structure to inherit -->
  <xs:complexType name="bravo">

    <xs:attribute name="attr" type="xs:string"/>

    <xs:sequence>
      <xs:element name="one" type="xs:string"/>
    </xs:sequence>

  </xs:complexType>
  <!-- Third, define a structure that inherits -->
  <xs:complexType name="alpha"> <!-- Defines the type="alpha" for <xs:element name="elem" type="alpha"> -->
    <xs:complexContent>
      <xs:extension base="bravo"> <!-- We inherit here -->

        <xs:sequence>
          <xs:element name="two" type="xs:boolean"/>
          <xs:element name="tre" type="xs:date"/>
        </xs:sequence>

      </xs:extension>
    </xs:complexContent>
  </xs:complexType>

</xs:element>
```

###### Basic XSD Terminology

| **XSD `element`, `attribute` & type** :

```xml
<xs:element name="here">
  <xs:complexType> <!-- Because we have child elements -->

    <!-- See Datatypes for type= -->
    <xs:attribute name="there" type="xs:string"/> <!-- See attribute Attributes -->
    <xs:element name="another" type="xs:integer"/> <!-- See element Attributes -->

  </xs:complexType>
</xs:element>
```

- `NCName` = "no-colon-name" (namespace without prefix, it matters)

1. `element` Attributes (`<xs:element name="elem">`)
- `default=`/`fixed=`: default or unchangable (fixed) value
  - Can only be used of content is `<simpleType>` or text-only
- `form=`:
  - `qualified`: must match the prefix and NCName
  - `unqualified`: must match only NCName
  - Defaults to `elementFormDefault` of `schema`
  - Can't be used if parent is `schema`
- `id=`
- `name=`/`ref=`: element name
  - `name=` must be used if parent is `schema`
  - `ref=` can't be used if parent is `schema`
- `type=`: datatype, see list below
- `nillable=`: if "null" value can be `true`
  - `true`: "null" value can be `true`
  - `false`: "null" value CANNOT be `true` (default)
- `substitutionGroup=`: element name that may be used instead
- `maxOccurs=`: maximum occurrences within parent element
- `minOccurs=`: minimum occurrences within parent element
- `abstract=`: if usable in instance document
  - `true`: element CANNOT appear in instance document (`substitutionGroup` must appear instead)
  - `false`: (default)
- `block=`: AKA "prevent" elements derived by...
  - `extension`
  - `restriction`
  - `substitution`
  - `#all`: all of the above
- `final=`: default of final element attribute
  - Can ONLY use if parent is `schema`
  - Prevent elements derived by...
    - `extension`
    - `restriction`
    - `#all`: all of the above
- Other non-namespace attributes are allowed

2. `attribute` Attributes (`<xs:attribute name="attr"/>`)
- `default=`/`fixed`: default or unchangable (fixed) value
- `form=`:
  - `qualified`: must match the prefix and NCName
  - `unqualified`: must match only NCName
  - Defaults to parent element
- `id=`
- `name=`/`ref=`: element name
  - If `ref=`, can't use `form=` and `type=`
- `type=`: datatype, see list below
- `use=`: permissions
  - `optional`: (default)
  - `prohibited`: can't use
  - `required`: must use
- Other non-namespace attributes are allowed

3. Datatypes (`type=`)
- `xs:boolean`
- `xs:string`
- `xs:integer`
- `xs:nonNegativeInteger`
- `xs:decimal`
- `xs:date`
- `xs:time`
- Custom, defined by `<xs:simpleType name="custom_type_name_here">...</xs:simpleType>`

##### DTD vs XSD Summary:
- *DTD is older and simpler*
  - *Less control*
  - *Uses SGML syntax*
  - *Can't control datatype nor namespace*
  - *Not extensible*
  - *Brief syntax*
  - *Used for backward compatibility with other SGML documents*
    - *Eg you want to automatically convert between LaTeX and XML and don't want any non-portable information*
- *XSD allows more options and is more complex*
  - *More control*
  - *Written in XML*
  - *Can control datatype and namespace*
  - *Is extensible*
  - *Elaborate syntax*
  - *Used for security*

You can learn much more about XSD, this is enough for you to follow more advanced XSD elsewhere and later in these lessons

### III. XSLT (eXtensible Stylesheet Language Transformations)
**CSS for XML**

An .xsl document is essentially HTML with embedded CSS, plus some logic (like `for-each` loops used in a `<table>`)

Add style with this after the header:

| **XSLT Declaration** :

```xml
<?xml-stylesheet type="text/xsl" href="stylesheet.xsl" ?>
```

#### A. Basic Demonstration
*Take normal XML...*

| **12** :$

```console
sudo cp core/12-style12.xml web/style.xml && \
sudo chown -R www:www /srv/www/html && \
code core/12-style12.xml core/12-style12.xsl && \
ls web
```

| **style.xml** :

```xml
<?xml version="1.0" encoding="utf-8" ?>

<root>

  <visitor level="admin">
    <name>John Doe</name>
    <login>jdoe</login>
    <phone>555-1212</phone>
    <email>jdoe@verb.ink</email>
    <sport type="skateboard"/>
    <year>1995</year>
  </visitor>

  <visitor level="user">
    <name>Smithy Mars</name>
    <login>smithymars</login>
    <phone>555-1515</phone>
    <email>smithy@inkisaverb.com</email>
    <sport type="soccer"/>
    <year>1989</year>
  </visitor>

  <visitor level="user">
    <name>Marshan Wills</name>
    <login>mwills</login>
    <phone>555-2727</phone>
    <email>marwills@verb.vip</email>
    <sport type="golf"/>
    <year>1990</year>
  </visitor>

  <visitor level="user">
    <name>Jupiter Song</name>
    <login>jupitersong</login>
    <phone>555-3535</phone>
    <email>jupiters@verb.red</email>
    <sport type="skateboard"/>
    <year>2001</year>
  </visitor>

  <visitor level="user">
    <name>Neptune Lo</name>
    <login>nlo</login>
    <phone>555-0101</phone>
    <email>nlo@verb.blue</email>
    <sport type="skateboard"/>
    <year>2010</year>
  </visitor>

</root>
```

| **B-12** ://

```console
localhost/web/style.xml
```

*You see the XML, let's add style with XSLT...*

| **13** :$

```console
sudo cp core/12-style13.xml web/style.xml && \
sudo cp core/12-style13.xsl web/style.xsl && \
sudo chown -R www:www /srv/www/html && \
code core/12-style13.xml core/12-style13.xsl && \
ls web
```

| **style.xml** : (Header only)

```xml
<?xml version="1.0" encoding="utf-8" ?>
<?xml-stylesheet type="text/xsl" href="style.xsl" ?> <!-- Add style.xsl -->
...

<!-- Example entry -->

<root>

  <visitor level="admin">
    <name>John Doe</name>
    <login>jdoe</login>
    <phone>555-1212</phone>
    <email>jdoe@verb.ink</email>
    <sport type="skateboard"/>
    <year>1995</year>
  </visitor>

</root>
```

| **style.xsl** :

```xml
<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">

    <html>
      <body>
        <h1>Visitors</h1>
        <table border = "1">
          <tr bgcolor = "#ddd">
            <th>Name</th>
            <th>Login</th>
            <th>Phone</th>
            <th>Email</th>
            <th>Sport</th>
            <th>Year</th>
            <th>Level</th>
          </tr>

          <xsl:for-each select="root/visitor"> <!-- Logic: for each <visitor> element -->
            <xsl:sort select="name"/> <!-- Self-closing, a simple setting -->

            <tr> <!-- Multiple table rows via <xsl:for-each> -->
              <td><xsl:value-of select="name"/></td> <!-- Content of <name> -->
              <td><xsl:value-of select="login"/></td> <!-- Content of <login> -->
              <td><xsl:value-of select="phone"/></td> <!-- et cetera -->
              <td><xsl:value-of select="email"/></td>
              <td><xsl:value-of select="sport/@type"/></td> <!-- Select type= in <sport> -->
              <td><xsl:value-of select="year"/></td>
              <td><xsl:value-of select="@level"/></td> <!-- Select level= in <visitor> -->
            </tr>

          </xsl:for-each>
        </table>
      </body>
    </html>

  </xsl:template>

</xsl:stylesheet>
```

| **B-13** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/style.xml
```

*Now, you see a hideously styled table in HTML*

#### B. Logic
1. `<xsl:for-each select="">`
- HTML to render for each content of multiple elements
  - `select="some/path"` = `<some><path>This content here</path></some>`

2. `<xsl:value-of select=""/>`
- Content itself of an element
  - `select="someth"` = `<someth>This content here</someth>`
  - `select="someth/@attrib"` = `<someth attrib="This content here" />`

3. `<xsl:sort select=""/>`
- Sort `<xsl:for-each>` items by this value
  - `<xsl:sort select="some/name"/>` = `<some><name>Sort by me</name></some>`
- Attributes:
  - `select=`: string
  - `lang=`: language (`en`, `zh`)
  - `data-type=`: "text" | "number" | [Some QName]
  - `order=`: "ascending" | "descending"
  - `case-order=`: "upper-first" | "lower-first"

4. `<xsl:if test="">`
- `test=`: expression with namespace and common operators
  - `<xsl:if test="year > 1991">` = `<year>1992</year>` returns `true`

5. `<xsl:choose><xsl:when test=""><xsl:otherwise test="">`
- Usage:
```xml
<xsl:choose>
  <xsl:when test="returns true">Do this</xsl:when>
  <xsl:when test="else is true">Do this</xsl:when>
  <xsl:otherwise>Do this</xsl:when>
</xsl:choose>
```
- This is comparable to `if`; `elif`; `else`; `fi` in Shell/BASH

| Shell               | PHP                 | XSLT                                             |
| ------------------- |:-------------------:| ------------------------------------------------:|
| `if [TEST]; then`   | `if (TEST) {…}`     | `<xsl:choose><xsl:when test="TEST">…</xsl:when>` |
| `elif [TEST]; then` | `elseif (TEST) {…}` | `<xsl:when test="TEST">…</xsl:when>`             |
| `else; …; fi`       | `else {…}`          | `<xsl:otherwise>…</xsl:otherwise></xsl:choose>`  |

6. Operators (`<xsl:if test="">` & `<xsl:choose><xsl:when test="">`)
- `<` is not allowed, use `&lt;`
- Common operators (not complete list)

| `>`     | Greater than             |
| `&lt;`  | Less than                |
| `>=`    | Greater than or equal to |
| `&lt;=` | Less than or equal to    |
| `=`     | Equal to                 |
| `!=`    | Not equal to             |

- *We have seen:*
  1. *`<xsl:for-each select="">`*
  2. *`<xsl:value-of select=""/>`*
  3. *`<xsl:sort select=""/>`*
- *Now, let's see:*
  4. *`<xsl:if test="">`*
  5. *`<xsl:choose><xsl:when test=""><xsl:otherwise test="">`*
  6. Operators

| **14** :$

```console
sudo cp core/12-style14.xml web/style.xml && \
sudo cp core/12-style14.xsl web/style.xsl && \
sudo chown -R www:www /srv/www/html && \
code core/12-style14.xml core/12-style14.xsl && \
ls web
```

| **style.xsl** :

```xml
<!-- <year> -->
<td>
  <xsl:choose> <!-- Open the test -->
    <xsl:when test="year&lt;2000">Antique</xsl:when> <!-- if before 2000, HTML is "Antique" -->
    <xsl:otherwise><xsl:value-of select="year"/></xsl:otherwise> <!-- else, HTML is <year> -->
  </xsl:choose> <!-- Close the test -->
</td>
<td>
  <xsl:if test="@level='admin'"> <!-- if level="admin" -->
    <b><xsl:value-of select="@level"/></b> <!-- then HTML is level= with <b> tags -->
  </xsl:if>
</td>
```

| **B-14** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/style.xml
```

#### C. Other Elements

##### 1. `<xsl:template>`

Usually, this is sufficient for a single-template XML page:

```xml
<xsl:template match="/"> <!-- Applies to entire XML document -->
```

Applies only to `<visitor>` element:

```xml
<xsl:template match="visitor"> <!-- Each/only <visitor> element -->
```

Applies all elements:

```xml
<xsl:template match="*"> <!-- All elements -->
```

`match=` is not the only attribute for `<xsl:template>`

Either `match=` or `name=` is required

- `template` Attributes (`<xs:template name="someth">`)
  - `match=`: XML path structure
    - `"/"` = root element
    - `"visitor"` = `<visitor>` element
    - `"*"` = all elements
    - `"."` = current element
  - `name=`: qualified name of template
    - invoked through `<xsl:call-template>`
  - `mode=`: to process same XML data multiple ways
    - matches `mode=` value of `<xsl:apply-templates>`
  - `priority=`: any number other than infinity

- Eg `mode=` & `<xsl:apply-templates>`
  - Note use of `mode="color-red"`
  - The same information would be applied two different ways, two different times

| **<xsl:template mode="">` viz `<xsl:apply-templates mode="">** :

```xml
<!-- Our HTML applies the templates for easy reading -->
<html>
  <body>
    <xsl:apply-templates select="visitor"/>
    <xsl:apply-templates select="login" mode="color-red"/>
  </body>
</html>

<!-- After our HTML, define the templates where they are more complex -->
<xsl:template match="visitor">
  <p>
    <xsl:value-of select="name"/>
  </p>
</xsl:template>


<xsl:template match="login" mode="color-red">
  <p color = "red">
    <xsl:value-of select="login"/>
  </p>
</xsl:template>
```

- Eg `name=` & `<xsl:call-template>`
  - Note use of `name="color-blue"`
  - The same information would be applied two different ways, two different times

| **<xsl:template name="">` viz `<xsl:call-template name="">** :

```xml
<xsl:template match="visitor" name="color-blue">
  <td bgcolor = "blue">
    <xsl:value-of select="name"/>
  </td>
</xsl:template>

<xsl:template match="visitor" name="color-green">
  <td bgcolor = "green">
    <xsl:value-of select="login"/>
  </td>
</xsl:template>

<html>
  <body>
    <table>
      <tr>
        <xsl:call-template select="visitor" name="color-blue"/>
        <xsl:call-template select="visitor" name="color-green"/>
      </tr>
    </table>
  </body>
</html>
```

- Place raw CSS in the `<head>`

| **`<head><style>`** :
```xml
<head>
  <style type="text/css">
    body {
      font-family: sans-serif;
      background-color: #eee;
    }
  </style>
</head>
```

- Example of CSS in full template:

```xml
<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:key name="open-closed" match="root/meta" use="status"/>
  <xsl:template match="/">
    <html>
      <head>
        <style type="text/css">
          body {
            font-family: sans-serif;
            background-color: #eee;
          }
        </style>
      </head>
      <body>
        ...
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
```

- A template can use another template

```xml
<!-- HTML used <xsl:apply-templates> only once -->
<html>
  <body>
    <h1>Visitors</h1>
    <table>
      <xsl:apply-templates select="root/visitor"/>
    </table>
  </body>
</html>

<!-- Define the main template -->
<xsl:template match="root/visitor">
  <tr>
    <xsl:apply-templates select="name"/>
    <xsl:apply-templates select="login"/>
  </tr>
</xsl:template>

<!-- Define the templates the main template applies -->
<xsl:template match="name">
  <td bgcolor = "blue">
    <xsl:value-of select="name"/>
  </td>
</xsl:template>

<xsl:template match="login">
  <td bgcolor = "green">
    <xsl:value-of select="login"/>
  </td>
</xsl:template>
```

Summary:

- From [this article](https://stackoverflow.com/questions/4478045/), we read `<xsl:apply-templates>` may be more useful than `<xsl:call-template>`
- We will not elaborate on use of `mode=` in `<xsl:template mode="">`, except to know:
  - `<xsl:template name="">` invokes with `<xsl:call-template name="">`
  - `<xsl:template mode="">` invokes with `<xsl:apply-templates mode="">`
  - `<xsl:template match="">` invokes with `<xsl:call-template select="">`
  - `<xsl:template match="">` invokes with `<xsl:apply-templates select="">`
  - `<xsl:apply-templates>` can include another `<xsl:template>` definition
  - `<xsl:apply-templates>` is more useful than `<xsl:call-template>` in many ways
  - These tools are useful to keep the `<html>` structure of your code easier to read, without containing the elaborate `<xsl:template>` definitions
- Normally
  - `<xsl:template match="/">` is sufficient in one template per XML page
  - `<xsl:template match="some-element">` for a new template per `<some-element>`
  - `<xsl:template match="*">` all elements
  - `<xsl:template match=".">` current element

##### 2. `<xsl:kbd>`

| **XSL** :

```xml
<!-- Define the <xsl:kbd> outside any <xsl:template> -->
<xsl:key name="call-something" match="element/path" use="container"/>

<!-- Use the <xsl:kbd> -->
<xsl:for-each select="key('call-something', 'Find me')">
  <td>
    <xsl:value-of select="title"/>
    <xsl:value-of select="container"/>
    <xsl:value-of select="other"/>
  </td>
</xsl:for-each>
```

- `<xsl:kbd>` Attributes:
  - `name=`: QName, used when calling such as `some-name` in:
    - `<xsl:for-each select="key('some-name', 'search-this')">`
  - `match=`: XML path structure to parent element
  - `use=`: actual element or attribute with contents to search when called
- This is like a kind of pre-defined location with a nickname that can be used to search

| **XML** :

```xml
<element>
  <!-- Only this will return in the <xsl:for-each> statement -->
  <path>
    <title>My Title</title>
    <container>Find me</container>
    <other>Some tag</other>
  </path>

  <!-- These will NOT return in the <xsl:for-each> statement -->
  <path>
    <title>That Title</title>
    <container>Find other</container>
    <other>More</other>
  </path>
  <path>
    <title>No Title</title>
    <container>Contained</container>
    <other>Other thing</other>
  </path>
</element>
```

##### 3. `<xsl:import>`
Similar to `include`

```xml
<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="importme.xsl"/>

  <xsl:template match="/">
    <xsl:apply-imports/>
  </xsl:template>

</xsl:stylesheet>
```

##### 4. `<xsl:message>`
Mainly used for developers and debugging

```xml
<!-- If 'true', this will display a message in the debug -->
<xsl:if test="test-something='true'">
  <xsl:message terminate="yes">Some message in debug</xsl:message>
</xsl:if>
```

- `<xsl:message>` Attributes:
  - `terminate="no"`: Display message, but do NOT terminate XML processing (default)
  - `terminate="yes"`: Display message, then terminate XML processing
- The message may not be visible in the browser, but may require "developer mode" or be seen prominently in validation output


##### 5. Examples

| **15** :$

```console
sudo cp core/12-style15.xml web/style.xml && \
sudo cp core/12-style15.xsl web/style.xsl && \
sudo chown -R www:www /srv/www/html && \
code core/12-style15.xml core/12-style15.xsl && \
ls web
```

| **B-15** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/style.xml
```

*Note if you choose to trigger the `<message>` by setting `<meta><status>` empty, you'll never see the actual message! This is an old problem many XSL developers face; you'll need to write an entire new program just to see it; welcome to the group!*

*Split up the same XSL sheet into multiple files with `<xsl:import>`*

```xml
<xsl:import href="somefile.xsl"/>

<xsl:template match="/">
  <xsl:apply-imports/>
</xsl:template>
```

| **16** :$ *Copy `12-style15.xml` again in case you make changes*

```console
sudo cp core/12-style15.xml web/style.xml && \
sudo cp core/12-style16.xsl web/style.xsl && \
sudo cp core/12-structure16.xsl web/structure.xsl && \
sudo cp core/12-meta16.xsl web/meta.xsl && \
sudo cp core/12-heading16.xsl web/heading.xsl && \
sudo cp core/12-visitors16.xsl web/visitors.xsl && \
sudo chown -R www:www /srv/www/html && \
code core/12-style16.xsl core/12-structure16.xsl core/12-meta16.xsl core/12-heading16.xsl core/12-visitors16.xsl && \
ls web
```

| **B-16** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/style.xml
```

*Note the XML document behaves the same way; the files are simply re-organized into several `xs:import` elements*

### IV. XML XPath (Reference)
- `/root/element/final` = `<root><element><final>`

#### A. Path Syntax

1. `some-element`: all nodes
2. `//some-element`: all lower nodes from current node
3. `/`: root
4. `.`: current node
5. `..`: parent node
6. `*`: all elements
7. `@*`: all attributes
8. `@attrib`: prefix for attribute & value
9. `/root/element/final`: absolute path from root
10. `some-element/@attrib`: any `<some-element attrib="something">` returns `something`
11. `some-element[1]`: index `[1]`, returns first occurrence of `<some-element>`
12. `some-element[last()]`: returns last index item
13. `some-element[@attrib="something"]`: matches contents of `<some-element attrib="something">`
14. `some-element[child="something"]`: matches contents of `<some-element><child>something</child></some-element>`

#### B. Operators

| `>`     | Greater than             |
| `&lt;`  | Less than                |
| `>=`    | Greater than or equal to |
| `&lt;=` | Less than or equal to    |
| `+`     | Plus                     |
| `-`     | Minus                    |
| `*`     | Multiplied by            |
| `div`   | Divided by               |
| `mod`   | Modulus                  |
| `=`     | Equal to                 |
| `!=`    | Not equal to             |
| `and`   | AND / `&&`               |
| `or`    | OR / `||`                |
| `not()` | not `(`condition `)`     |
| `|`     | Two node sets            |

##### C. Axes

| `ancestor`           | All ancestors of current node                                                                   |
| `ancestor-or-self`   | Current node and all ancestors of current node                                                  |
| `attribute`          | All attributes of current node                                                                  |
| `child`              | All children of current node                                                                    |
| `descendant`         | All descendants of current node                                                                 |
| `descendant-or-self` | Current node and all descendants of current node                                                |
| `following`          | All nodes after closing tag of current node                                                     |
| `following-sibling`  | All siblings after current node                                                                 |
| `namespace`          | All namespace nodes of current node                                                             |
| `parent`             | Parent of current node                                                                          |
| `preceding`          | All nodes that appear before current node, including attributes and namespace, except ancestors |
| `preceding-sibling`  | All siblings before current node                                                                |
| `self`               | Current node                                                                                    |

### V. XML via CLI with XMLStarlet
XMLStarlet uses the terminal command `xml` or `xmlstarlet` as you prefer

We use XML Path syntax with many other XML tools, including CLI tools like XMLStarlet

*Note some arguments & flags*
  - `sel`: select
  - `ed`: edit
  - `-L`: edit file inplace
  - `-t`: template
  - `-i`: insert
  - `-s`: subnode
  - `-v`: value
  - `-r`: rename
  - `-u`: update
  - `-d`: delete

#### Local address book

| **17** :$

```console
mkdir -p xml && \
sudo cp core/12-contacts.xml web/contacts.xml && \
sudo cp core/12-style17.xsl web/style.xsl && \
cp core/12-contacts.xml xml/contacts.xml && \
sudo chown -R www:www /srv/www/html && \
code core/12-contacts.xml core/12-style17.xsl xml/contacts.xml && \
ls web
```

The structure in step 17 is slightly different than from step 16

| **XSL** :

```xsl
<xsl:template match="root/visitor">
```

| **XML** :

```xml
<root>
  <visitor>
```

...became...

| **XSL** :

```xsl
<xsl:template match="root/visitors/visitor">
```

| **XML** :

```xml
<root>
  <visitors>
    <visitor>
```

Note these changes in the XSL stylesheet

| **style.xsl** :

```xsl
<xsl:apply-templates select="root/visitors"/>

...

<xsl:template match="root/visitors/visitor">
```

| **B-17** ://

```console
localhost/web/contacts.xml
```

*Let's fetch some information*

*How many entries...*

| **18** :$

```console
xmlstarlet sel -t -v "count(//visitors/visitor)" xml/contacts.xml
```

*Show entries nicely in the terminal*

| **19** :$

```console
xmlstarlet sel -t -m "//visitors/visitor" -v "name" -o " - " -v "sport/@type" -o " (" -v "level" -o ")" -n xml/contacts.xml
```

*The command `xml` points to `xmlstarlet`*

*Get the email for Marshan Wills...*

| **20** :$

```console
xml sel -t -v "//visitors/visitor[name='Marshan Wills']/email" xml/contacts.xml
```

*Get the name for `<visitor login="jupitersong">`...*

| **21** :$

```console
xml sel -t -v "//visitors/visitor[@login='jupitersong']/name" xml/contacts.xml
```

*We can also change content*

*Watch in Atom for this to change: `<visitor login="jdoe">`...*

| **22** :$

```console
xml ed --inplace -u "//visitors/visitor[@login='jdoe']/@login" -v "johndoe" xml/contacts.xml
sudo cp xml/contacts.xml web/contacts.xml
```

*Watch John Doe's Login change to "johndoe"...*

| **B-22** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/contacts.xml
```

*Change Joh Doe to a `user`...*

| **23** :$

```console
xml ed --inplace -u "//visitors/visitor[@login='jdoe']/level" -v "user" xml/contacts.xml
sudo cp xml/contacts.xml web/contacts.xml
```

| **B-23** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/contacts.xml
```

*Note nothing changed because we accessed `<visitor login="jdoe">`, but the `login=` was just changed to `johndoe`*

*Try correctly...*

| **24** :$

```console
xml ed --inplace -u "//visitors/visitor[@login='johndoe']/level" -v "user" xml/contacts.xml
sudo cp xml/contacts.xml web/contacts.xml
```

| **B-24** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/contacts.xml
```

*Make Smithy Mars an `admin`...*

| **25** :$

```console
xml ed --inplace -u "//visitors/visitor[@login='smithymars']/level" -v "admin" xml/contacts.xml
sudo cp xml/contacts.xml web/contacts.xml
```

| **B-25** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/contacts.xml
```

#### Settings file
XML can be used to store settings, such as on your desktop

This is not a real settings file, but the settings for your desktop machine could look very similar to this

| **26** :$

```console
cp core/12-settings.xml xml/settings.xml && \
code core/12-settings.xml xml/settings.xml && \
ls xml
```

*Insert a `<display>` (wrong way)*

| **27** :$

```console
xml ed -L -s /conf/displays -t elem -n display \
    -i //display -t attr -n "id" -v "3" \
    -s //display -t elem -n "order" -v "2" \
    -s //display -t elem -n "brightness" -v "47" \
    -s //display -t elem -n "mode" -v "join" \
    -i //display/mode -t attr -n "mirror" -v "3" \
    -s //display -t elem -n "wallpaper" -v "~/Pictures/james.jpg" \
    -s //display -t elem -n "meta" -v "~/.config/device/sony-27" \
    xml/settings.xml
```

*Note in Atom:*
  - *We just made a mess: `settings.xml` `<display>` elements now have the new information, plus the new `<display>` entry with the same information*
  - *All the empty lines were removed, which is good*
    - *`xmlstarlet` will format the XML document to remove unneeded white space*

*Start over...*

| **28** :$ *Overwrite? Answer `y` for yes*

```console
cp core/12-settings.xml xml/settings.xml
```

*Tip: add strange whitespace in `settings.xml`, then watch it all disappear to perfect formatting*

*Insert a display (right way: rename a stand-in called `displayINS`)*

| **28** :$

```console
xml ed -L -s /conf/displays -t elem -n displayINS \
    -i //displayINS -t attr -n "id" -v "3" \
    -s //displayINS -t elem -n "order" -v "2" \
    -s //displayINS -t elem -n "brightness" -v "47" \
    -s //displayINS -t elem -n "mode" -v "join" \
    -i //displayINS/mode -t attr -n "mirror" -v "3" \
    -s //displayINS -t elem -n "wallpaper" -v "~/Pictures/james.jpg" \
    -s //displayINS -t elem -n "meta" -v "~/.config/device/sony-27" \
    -r //displayINS -v display \
    xml/settings.xml
```

*Note:*
  - *We start with the name `<displayINS>` as the new element inserted into `<displays>`*
  - *Then we change the name from `<displayINS>` to `<display>`*
    - *`-r //displayINS -v display`*
  - *This way we only get our single, new `<display>` entry*
  - *Whitespace was removed again, which is good*

*Fetch the largest `<display id=`...*

| **29** :$

```console
xml sel -t -v "/conf/displays/display[not(@id < /conf/displays/display/@id)]/@id[last()]" xml/settings.xml
```

*Let's delete that `<display>` entry...*

| **30** :$

```console
xml ed -L -d "/conf/displays/display[@id='3']" xml/settings.xml
```

*Fetch the largest `<display id=` again...*

| **31** :$

```console
xml sel -t -v "/conf/displays/display[not(@id < /conf/displays/display/@id)]/@id[last()]" xml/settings.xml
```

*Let's change the second display `<mode>` element so the second monitor will mirror the first...*

| **32** :$

```console
xml ed -L -u "/conf/displays/display[@id='2']/mode" -v "mirror" \
          -u "/conf/displays/display[@id='2']/mode/@mirror" -v "1" xml/settings.xml
```

*Change the `<mouse><type>pad ...<tracking>` to `relative`...*

| **33** :$

```console
xml ed -L -u "/conf/mice/mouse[@id='2']/tracking" -v "relative" xml/settings.xml
```

*Change the speaker volume to 50%...*

  - *You should guess that `<audio><adevice><type>out` is a probably a speaker, not a microphone*

| **34** :$

```console
xml ed -L -u "/conf/audio/adevice[@id='1']/level" -v "50" xml/settings.xml
```

#### Hack an Open Document `.odt` file
*Copy the `.odt` we want to use*

| **35** :$

```console
cp test_uploads/markdown.odt xml/markdown.odt && \
ls xml && \
lowriter xml/markdown.odt
```

*Close LibreOffice Writer*

*Create a directory (`odt`) and unzip the `.odt` file to that directory*

| **36** :$

```console
mkdir odt && \
unzip xml/markdown.odt -d odt/ && \
ls odt
```

*Note all those files and directories that came from the `.odt` file*

  - *Especially note `content.xml`*

*`unzip` allows you to dump the content of only one file as `STDOUT` output*

*We will use the xml directory to work with only the content file...*

*Output the raw XML contents to the terminal (no file will be extracted from markdown.odt)*

| **37** :$

```console
unzip -p xml/markdown.odt content.xml
```

***That file, always called `content.xml`, is the only file we need for text inside any `.odt` file***

*We can send the output to a file we want to use*

| **38** :$

```console
unzip -p xml/markdown.odt content.xml > xml/markdown.xml && \
code xml/markdown.xml && \
ls xml
```

*Let's use `xmlstarlet` to pull specific info from the `.odt` XML content...*

*Output all headers*

| **39** :$

```console
xml sel -N text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" -t -m "//text:*[@text:outline-level]" -v "@text:outline-level" -o " " -v . -n xml/markdown.xml
```

*Output all content:*

| **40** :$

```console
xml sel -N text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" -t -m "//text:*" -o " " -v . -n xml/markdown.xml
```

*Update content:*

This will change every `<text:p>` node to contain "I was a paragraph, inserted by XMLStarlet."

| **41** :$

```console
xml ed --inplace -u "//text:p" -v "I was a paragraph, inserted by XMLStarlet." xml/markdown.xml
```

*Note the changes to `markdown.xml` in Atom*

*Let's hack that `.odt` file in the odt directory and change it from the command line...*

| **42** :$

```console
xml ed --inplace -u "//text:p" -v "I was a paragraph, inserted by XMLStarlet." odt/content.xml
cd odt
zip -r ../xml/hacked.odt *
cd ..
```

*Look inside our hacked `.odt` file...*

| **43** :$

```console
lowriter xml/hacked.odt
```

#### RSS Feed from WordPress
##### WP-RSS via Simple CSS

| **44** :$

```console
sudo cp core/12-wordpress-css.rss web/wordpress-css.rss && \
sudo cp core/12-wordpress-css.rss xml/wordpress-css.rss && \
sudo cp core/12-rss.css web/rss.css && \
sudo cp core/12-rss.css xml/rss.css && \
sudo chown -R www:www /srv/www/html && \
code xml/wordpress-css.rss xml/rss.css && \
ls web
```

*When entering an address with .rss in a browser, it could either display raw text or initiate a download...*

| **B-44** :// **`.rss`**

```console
localhost/web/wordpress-css.rss
```

*To apply XSL style for viewing in a browser, we must use the `.xml` extension...*

| **45** :$

```console
sudo cp xml/wordpress-css.rss web/wordpress-css.xml && \
sudo chown -R www:www /srv/www/html
```

*Note the `css` statements...*

```xml
<?xml-stylesheet type="text/css" href="rss.css" ?>
```

| **B-45** :// **`.xml`**

```console
localhost/web/wordpress-css.xml
```

*Note the rendering does not have "pretty" formatting because it is only CSS, but nothing places HTML inside any `<html>` framework, so HTML never renders*

*We see only basic-styled text, not rendered HTML*

*Rendering RSS via simple CSS is useful if the RSS feed only contains text with no HTML tags, such as news wires, which have been used for ages*

*To render HTML, we need an XSL stylesheet...*

##### WP-RSS via XSL Stylesheet

| **46** :$

```console
sudo cp core/12-wordpress-xsl.rss web/wordpress-xsl.rss && \
sudo cp core/12-wordpress-xsl.rss xml/wordpress-xsl.rss && \
sudo cp core/12-rss.xsl web/rss.xsl && \
sudo cp core/12-rss.xsl xml/rss.xsl && \
sudo chown -R www:www /srv/www/html && \
code xml/wordpress-xsl.rss xml/rss.xsl && \
ls web
```

*Note the `xsl` statements...*

```xml
<?xml-stylesheet type="text/xsl" href="rss.xsl" ?
```

| **B-46** :// **`.rss`**

```console
localhost/web/wordpress-xsl.rss
```

*To apply XSL style for viewing in a browser, we must use the `.xml` extension...*

| **47** :$

```console
sudo cp xml/wordpress-xsl.rss web/wordpress-xsl.xml && \
sudo chown -R www:www /srv/www/html
```

| **B-47** :// **`.xml`**

```console
localhost/web/wordpress-xsl.xml
```

#### iTunes Podcast Feed

| **48** :$

```console
sudo cp core/12-podcast.rss web/podcast.rss && \
sudo cp core/12-podcast.rss xml/podcast.rss && \
sudo chown -R www:www /srv/www/html && \
code xml/podcast.rss && \
ls web
```

*Note we are using the same rss.xsl file as in our WordPress example...*

```xml
<?xml-stylesheet type="text/xsl" href="rss.xsl" ?>
```

| **B-48** :// **`.rss`**

```console
localhost/web/podcast.rss
```

*To apply XSL style for viewing in a browser, we must use the `.xml` extension...*

| **49** :$

```console
sudo cp xml/podcast.rss web/podcast.xml && \
sudo chown -R www:www /srv/www/html
```

| **B-49** :// **`.xml`**

```console
localhost/web/podcast.xml
```

### VI. PHP Integration
#### Create an iTunes podcast-ready RSS feed
*You can learn more about iTunes podcast RSS feed tags [here](https://help.apple.com/itc/podcasts_connect/#/itcb54353390), along with other [requirements](https://podcasters.apple.com/support/823-podcast-requirements)*

| **50** :$

```console
sudo cp pdo-feed/* web/ && \
sudo mv web/htaccess web/.htaccess && \
sudo chown -R www:www /srv/www/html
code pdo-feed/feed.php rss.xsl blog.php in.head.php settings.php && \
ls pdo-feed
```

| **B-50** ://

```console
localhost/web/feed
```

*Note, we added a test for "feed":*

| **in.editprocess.php** :

```php
if (($pdo->numrows > 0) || ($p_slug_test_trim == 'feed')) {...}
```

- *This makes sure that no piece slug is set as "feed", because we will use that namespace to generate feeds*

| **.htaccess** :

```
# Feeds
RewriteRule ^feed$ feed.php?s=0 [L]
RewriteRule ^series/?([a-zA-Z0-9-]+)/feed$ feed.php?s=$1 [L]
```

*Note the "Feeds" rule must appear before "Slugs" & "Blog" because of the logical hierarchy*

- *Rewrite must catch `feed` before trying it as a slug, otherwise it will be interpreted as a slug and sent to `piece.php`*

- *In .htaccess, try placing the "Feeds" rule after "Blog" to see it break*

**Blog-Wide Podcast Details**

| **settings.php** :

```php
// Function for iTunes categories
...
// Podcast Details
...
// Blog Podcast Details
...
// Empty fields?
echo (isset($podcast_empty_field_warning)) ? $podcast_empty_field_warning : false;
```

*Note these sections came from `ajax.editseriesdetails.php`*

**Link to RSS/Podcast feeds**

| **blog.php** :

```php
// We add another variable $feed_path
$feed_path = (isset($series_slug)) ? "/series/$series_slug/feed" : "/feed";
$feed_link = true;
include ('./in.head.php');
```

| **in.head.php** :

```php
// We add the RSS link after this <h1> line
echo ($feed_link == true) ? '<p><small><a target="_blank" href="'.$blog_web_base.$feed_path.'">RSS</a></small></p>' : false;
```

**Create this new RSS/Podcast feed**

| **feed.php** :

```php
// Without this, browsers will think it is HTML and the feed won't work!
// This is an XML document, say so first!
header('Content-type: text/xml');
...
// Parse GET & assign feed-wide values
...
// Series Info
||
// Blog Info
...
// Header of feed
...
// Categories

```

**Style**

| **feed.php** :

This allows us to add XSL style without the `.xml` file extension:

```php
header('Content-type: text/xml');
```

...Thus we can include this XSL...

```xml
<?xml-stylesheet type="text/xsl" href="rss.xsl" ?>
```

...to see only the raw, unstyled feed, comment to this:

```xml
<!-- <?xml-stylesheet type="text/xsl" href="rss.xsl" ?> -->
```

#### Aggregate another RSS feed
*Take this example of an iTunes-ready feed*

| **feed.rss** :

```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="rss.xsl" ?>
<rss version="2.0"
  xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd"
  xmlns:content="http://purl.org/rss/1.0/modules/content/"
  xmlns:atom="http://www.w3.org/2005/Atom"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
  >
<channel>
	<title>501 Blog</title>
	<link>http://localhost/web</link>
	<image>
		<url>media/pro/pro-rss.jpg</url>
		<title>501 Blog</title>
		<link>http://localhost/web</link>
	</image>
	<description>Blog Subtitle &amp; description</description>
	<language>en</language>
  <itunes:author>Jon Boy</itunes:author>
	<itunes:summary>I am a summary</itunes:summary>
	<itunes:subtitle>Blog Subtitle &amp; description</itunes:subtitle>
  <itunes:owner>
    <itunes:name>Johnny Boy</itunes:name>
    <itunes:email>johnboy@verb.ink</itunes:email>
  </itunes:owner>
	<itunes:keywords>ice, ice, baby</itunes:keywords>
	<itunes:image href="media/pro/pro-podcast.jpg"/>
	<itunes:explicit>true</itunes:explicit>
  <itunes:category text="Business">
    <itunes:category text="Investing"/>
  </itunes:category>
  <itunes:category text="Marketing"/>
  <itunes:category text="Arts">
    <itunes:category text="Performing Arts"/>
  </itunes:category>
  <itunes:category text="Sports">
    <itunes:category text="Golf"/>
  </itunes:category>
<lastBuildDate>Tue, Nov 30 15:45:12 2021 UTC</lastBuildDate>

<item>
  <title>Media Features</title>
  <link>http://localhost/web/media-features</link>
  <guid isPermaLink="false">4-media-features</guid>
  <pubDate>Tue, Nov 30 15:45:12 2021 UTC</pubDate>
  <author><![CDATA[Jon Boy]]></author>
  <dc:creator><![CDATA[Jon Boy]]></dc:creator>
  <category><![CDATA[Second]]></category>
  <description></description>
  <content:encoded><![CDATA[Lorem featurings here]]></content:encoded>
  <itunes:subtitle></itunes:subtitle>
  <itunes:summary></itunes:summary>
  <itunes:author>Jon Boy</itunes:author>
  <itunes:keywords></itunes:keywords>
  <itunes:explicit>true</itunes:explicit>
  <enclosure url="http://localhost/web/media/audio/audio-7.mp3" length="" type="audio/mpeg" />
  <itunes:duration>0:00:03</itunes:duration>
  <enclosure url="http://localhost/web/media/video/video.mp4" length="" type="video/mp4" />
  <itunes:duration>0:00:05</itunes:duration>
</item>

<item>
  <title>Second new piece</title>
  <link>http://localhost/web/second-new-piece</link>
  <guid isPermaLink="false">2-second-new-piece</guid>
  <pubDate>Mon, Nov 29 9:27:30 2021 UTC</pubDate>
  <author><![CDATA[Jon Boy]]></author>
  <dc:creator><![CDATA[Jon Boy]]></dc:creator>
  <category><![CDATA[Blog]]></category>
  <description></description>
  <content:encoded><![CDATA[Lorem Ipsum Deux]]></content:encoded>
  <itunes:subtitle></itunes:subtitle>
  <itunes:summary></itunes:summary>
  <itunes:author>Jon Boy</itunes:author>
  <itunes:keywords></itunes:keywords>
  <itunes:explicit>true</itunes:explicit>
</item>

</channel>
</rss>
```

*We can fetch and process items in that feed as objects with `SimpleXML`*

| **processfeed.php** :

```php
$rss = simplexml_load_file('http://localhost/web/feed.rss');

echo '<h1>'.$rss->channel->title.'</h1>';
echo '<h2>'.$rss->channel->description.'</h2>';

// Access itunes information in the head

$itunes = $item->children('http://www.itunes.com/dtds/podcast-1.0.dtd');

$itunes_owner_name = $itunes->owner->name;
echo "<p>$itunes_owner_name</p>";

$itunes_owner_email = $itunes->owner->email;
echo "<p>$itunes_owner_email</p>";

$itunes_image_url = $itunes->image->attributes()['href'];
echo "<p>$itunes_image_url</p>";


foreach ($rss->channel->item as $item) {

  $itunes = $item->children('http://www.itunes.com/dtds/podcast-1.0.dtd');
  $content = $item->children('http://purl.org/rss/1.0/modules/content/');
  $atom = $item->children('http://www.w3.org/2005/Atom'); // For future use
  $dc = $item->children('http://purl.org/dc/elements/1.1/');

  echo '<p><b><a href="'.$item->link.'">'.$item->title."</a></b></p>";
  echo "<p>$item->pubDate</p>";
  echo "<p>$item->description</p>";
  echo "<p>$itunes->author</p>";
  echo "<p>$content->encoded</p>";
  echo "<p>$dc->creator</p>";
  echo (isset($item->enclosure['url'])) ? '<p>'.$item->enclosure['url'].'</p>' : false;

}
```

| **51** :$

```console
sudo cp core/12-feed.rss web/feed.rss && \
sudo cp core/12-processfeed.php web/processfeed.php && \
sudo chown -R www:www /srv/www/html && \
code core/12-feed.rss core/12-processfeed.php
```

Use the `->children()` method to isolate entries with an XML `<prefix:>`

*Load the .rss file*

```php
$rss = simplexml_load_file('http://localhost/web/feed.rss');
```

*Retrieve these `<itunes:>` prefixed elements*

```xml
<channel>
	<title>501 Blog</title>
...
  <itunes:author>Jon Boy</itunes:author>
  <itunes:owner>
    <itunes:name>Johnny Boy</itunes:name>
...
```

...with this `->children()` method:

```php
$channel_itunes = $rss->channel->children('http://www.itunes.com/dtds/podcast-1.0.dtd');
...
echo $channel_itunes->author;
echo $channel_itunes->owner->name;
```

*Retrieve these `<itunes:>` prefixed elements*

```xml
<item>
  <title>Media Features</title>
...
  <itunes:keywords></itunes:keywords>
  <itunes:duration>Jon Boy</itunes:duration>
...
```

...with this `->children()` method:

```php
$item_itunes = $item->children('http://www.itunes.com/dtds/podcast-1.0.dtd');
echo $item_itunes->keywords;
echo $item_itunes->duration;
```

| **B-51** ://

```console
localhost/web/processfeed.php
```

*Now, let's implement `SimpleXML` so our blog can aggregate RSS feeds*

| **52** :$

```console
sudo cp pdo-aggregate/* web/ && \
sudo chown -R www:www /srv/www/html && \
ls pdo-aggregate/*
```

*Our new files are:*

- *`aggregator.php`*
  - *Calls: `ajax.editfeed.php`*
- *`task.aggregatefetch.php`*
  - *Items from an aggregated feed will be added to `publications`, but not `pieces` nor `publication_history`*
  - *Aggregated entries on `publications` will NOT have a `piece_id`*
  - *Aggregated entries on `publications` will contain:*
    - *`aggregated` matching the `id` of the feed entry on `aggregation`*
    - *From `<enclosure url=`: `feat_img`, `feat_aud`, `feat_vid` & `feat_doc`, rather than an `id` on `media_library`*
    - *From `<itunes:duration>`: `duration` for audio/video enclosures*
    - *From `<enclosure length=` & `<enclosure type=`: `feat_img_mime`, `feat_aud_mime`, `feat_vid_mime`, `feat_doc_mime`, `feat_img_length`, `feat_aud_length`, `feat_vid_length` & `feat_doc_length`*

*All other files make simple changes to implement the new "Aggregated Feeds" page (aggregator.php)*

| **B-52** ://

```console
localhost/web/
```

***Aggregated Feeds*** *in: Pieces > Aggregated Feeds, also via Settings >*

| **aggregator.php** :

Most of this content is ported from pieces.php & the Series Editor (in.editseries.php & ajax.editseries.php)

```javascript
// Check/uncheck the box = hide/show the options
function showDeleteFeedOptionsBox(fID) {
  var x = document.getElementById("deleteOptions-"+fID);
  if (x.style.display === "inline") {
    x.style.display = "none";
  } else {
    x.style.display = "inline";
  }
}
// Show options for deleting feed
// JavaScript does not allow onClick action for both the label and the checkbox
// So, we make the label open the delete options div AND check the box...
function showDeleteFeedOptions(fID) {
  // Show the Date Live schedule div
  var x = document.getElementById("deleteOptions-"+fID);
  if (x.style.display === "inline") {
    x.style.display = "none";
  } else {
    x.style.display = "inline";
  }
  // Use JavaScript to check the box
  var y = document.getElementById("feed-delete-"+fID);
  if (y.checked === false) {
    y.checked = true;
  } else {
    y.checked = false;
  }
}
// Always-only hide delete options on "cancel"
function hideDeleteFeedOptions(fID) {
  // Hide the options
  document.getElementById("deleteOptions-"+fID).style.display = "none";
  // Uncheck the Delete box
  document.getElementById("feed-delete-"+fID).checked = false;
  // Unset delete options radios
  document.getElementById("erase-posts-"+fID).checked = false;
  document.getElementById("convert-posts-"+fID).checked = false;
}
```

*Note the above JavaScript functions get called from `onclick=`...*

```php
// Delete checkbox
echo '<div id="delete-checkbox-'.$agg_id.'" style="display:none;">
<br><br><input type="checkbox"

onclick="showDeleteFeedOptionsBox('.$agg_id.');"

form="feed-edit-'.$agg_id.'" id="feed-delete-'.$agg_id.'" name="feed-delete" value="'.$agg_id.'"><label

onclick="showDeleteFeedOptions('.$agg_id.');"

> <i><small class="red">Permanently delete feed</small></i></label>
</div>';

// Delete options
echo '<div id="deleteOptions-'.$agg_id.'" style="display:none;">
<br>Aggregated posts:<br>
<label for="convert-posts-'.$agg_id.'"><input type="radio" id="convert-posts-'.$agg_id.'" name="agg_del_feed_posts" value="convert"> <i><small class="green">Convert to editable pieces</small></i></label>
&nbsp;
<label for="erase-posts-'.$agg_id.'"><input type="radio" id="erase-posts-'.$agg_id.'" name="agg_del_feed_posts" value="erase"> <i><small class="red">Delete & erase forever</small></i></label>
</div>';
...
echo '<button id="change-cancel-'.$agg_id.'" type="button" class="postform link-button inline blue"
onclick="
  showHideEdit('.$agg_id.');
  hideDeleteFeedOptions('.$agg_id.');
">change</button>';
...
echo '<button type="button"
onclick="
  showHideEdit('.$agg_id.');
  hideDeleteFeedOptions('.$agg_id.');
">Cancel</button>';
```

*The actual feed processing is done by `task.aggregatefetch.php`*

- *Peruse this file, but note that it runs `UPDATE` rather than `INSERT` based on a matching `guid`*
- *`guid` is based created for each feed `<item>`, based on a `title`-generated `slug`*
  - *So, if a feed has no `<guid>`* ***and*** *the `<title>` changes in a feed, it will `INSERT` a new entry*
  - *Otherwise, it will `UPDATE` the existing entry*
- *Each `<item>` is entered in `publications` with*
  - *A `piece_id` of `0`*
  - *An `aggregated` value greather than `0`*
  - *A `guid`*
- *Because no entry is made on the `pieces` table, these cannot be edited through the web app and will not appear in the Pieces page*
  - *This makes the aggregation trustworthy and incapable of manipulation*
- *If deleting a feed:*
  - *The feed is set to `status` = `deleting` on the table*
  - *Next time the processor runs, if `on_delete` is set to `convert`:*
    - *Each entry in `publications` with that `aggregated` `id` will be converted into a `piece` entry, then the `piece_id` added*
- *The processor only takes RSS information that the feed generator will use*
  - *`<itunes:summary>` becomes `excerpt`*
  - *`<itunes:keywords>` becomes `tags`*
  - *`<description>` becomes `subtitle`*
    - *If this is empty, `<itunes:subtitle>` will be checked instead*

*Note that in PDO, we can pass a `NULL` value using `bindParam()`*

- *We do this in some ternary statements to ensure any optionally empty feed elements doesn't break the SQL query*

```php
$col = NULL;
...
$query->bindParam(':column', $col);
```

##### Testing for learning purposes
*You can test and see how changes to a feed will affect what the feed processes*

*We will create a small place to play and learn, called a "sandbox"*

1. Copy our feed.rss sample to a file to test, then view edit our files in Atom:

| **Sandbox prep** :$

```console
cp core/12-feed.rss play.rss && \
sudo cp -f core/12-feed.rss web/play.rss && \
cp pdo-aggregate/task.aggregatefetch.php play.aggregatefetch.php && \
sudo cp pdo-aggregate/task.aggregatefetch.php web/play.aggregatefetch.php && \
sudo chown -R www:www /srv/www/html && \
code play.rss play.aggregatefetch.php
```

*If you want to see any PHP errors in the processor, add this to the top:*

| **play.aggregatefetch.php** : *(Optional, on the line after `<?php` at the top)*

```php
ini_set('display_errors', '1');
ini_set('display_startup_errors', '1');
error_reporting(E_ALL);
```

2. Add a new feed that will use the URL for where this file is:

| **Aggregated Feeds** :// *(same as Pieces > Aggregated Feeds)*

```console
localhost/web/aggregator.php
```

- Input whatever you want, and:
  - URL: `http://localhost/web/play.rss`
  - Ensure "Active" is checked as it appears in the Feed table

3. Check for status changes in two places:

- Click on "list" in Aggregated Feeds, next to your test feed
- Look in phpMyAdmin:

| **Publications** ://phpMyAdmin **> webapp_db > publications**

4. Make and save any changes you want to play.rss in Atom

5. Copy your edited play.rss file to the web folder

*This also copies play.aggregatefetch.php, in case you made changes there*

| **Copy feed** :$

```console
sudo cp play.rss web/ && \
sudo cp play.aggregatefetch.php web/
```

6. Run the processor, in a separate browser tab

| **Feed Processor** :// *(It should show a blank page)*

```console
localhost/web/play.aggregatefetch.php
```

7. Repeat steps 3-6 to see more changes

8. Try deleting play.rss from the web folder to see how the processor responds

| **Delete the feed** :$

```console
sudo rm web/play.rss
```

9. You can put the feed back to watch it test with a cron task in the next step...

```console
sudo cp play.rss web/ && \
sudo chown -R www:www /srv/www/html
```

##### Create a `cron` task to process feeds
*For the feed processor to work (task.aggregatefetch.php), we need a `cron` task to call the file*

- *PHP is a "dead" system; it only works when a file is accessed*
  - *From the web*
  - *From the command line*
  - *From a `cron` task*
- *Many web apps make routine processors run by using an `include()` in a frequently used file, such as our in.head.php file*
  - *This is not guaranteed to work because it depends on visitors accessing the site*
- *Creating a `cron` task is more reliable and consistent*

| **cron.d/webapp** :

```code
*/15 * * * * root /usr/bin/php /srv/www/html/web/task.aggregatefetch.php.php
```

| **53** :$ *`touch` the file first so we can set permissions before editing*

```console
sudo touch /etc/cron.d/webapp
sudo chmod 644 /etc/cron.d/webapp
sudo vim /etc/cron.d/webapp
```

*Linux is finicky about using `sudo` to mess with `cron` files*

*We can't add contents to a `cron` file using `sudo` to dump output to the file, so we must do that manually with an editor like `vim`...*

1. Copy this with <kyb>Ctrl</kybd> + <kyb>C</kybd>:

```console
*/15 * * * * root /usr/bin/php /srv/www/html/web/task.aggregatefetch.php.php
```

2. Press:

- <kbd>i</kbd>
- <kyb>Ctrl</kybd> + <kyb>V</kybd>
- <kbd>Esc</kbd>

3. Type:

`w:` <kbd>Enter</kbd>

*Note when you are finished with these lessons, you will want to delete that `cron` task...*

| **Delete our `cron` task** :$

```console
sudo rm /etc/cron.d/webapp
```
___

# The Take
## XML Structure
- **eXtensible Markup Language**
- Uses tags similar to HTML
- First line:
```xml
<?xml version="1.0" encoding="utf-8" ?>
```
- Static text, such as a text file
- Data "Object" language
  - Like OOP in PHP
  - But, not a logic language like PHP
- History
  - 1986: SGML (Standard Generalized Markup Language)
  - 1993: HTML (keeps updating, version 5 in 2021)
  - 1998: XML (still using version 1.0)
- Often used in:
  - Word processor documents (.docx, .odt, et cetera)
  - Desktop settings (wallpaper, mouse speed, display brightness, audio volume, et cetera)
  - RSS feeds
  - Podcasts
  - Blogs (ie WordPress export/import file)
  - API communication
- Comparable to JSON
  - Portable to/from JSON
  - Machine version of what JSON is for JavaScript
  - JSON is used in the browser, XML is used everywhere else
- Can be read by many languages
  - BASH/Linux terminal (`xmlstarlet`)
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
- Not for browsers, but almost everything else

## XML Validation
- "Well formed" XML is different from "valid" XML
  - "Valid" XML meets definitions included in the XML file
- There are two ways to validate XML
  - DTD: Short, simple, sometimes not accepted
  - XSL: Long, more useful and accepted
    - XSL also uses XML language itself
- Example XML:
```xml
<root>
  <person att="val1">
    <one>...</one>
    <two>...</two>
    <also>...</also>
    <there>...</there>
    <self_close/>
    <attribs attr="val1">...</attribs>
  </person>
</root>
```

### DTD
```xml
<!DOCTYPE root[
  <!ELEMENT person (one,two,also,there)>
  <!ATTLIST person att (val1 | val2 | val3) "val1" >
  <!ELEMENT one (#PCDATA)>
  <!ELEMENT two (#PCDATA)>
  <!ELEMENT also (#PCDATA)>
  <!ELEMENT there (#PCDATA)>
  <!ELEMENT self_close EMPTY>
  <!ELEMENT attribs (#PCDATA)>
  <!ATTLIST attribs attr (val1 | val2 | val3) "val1" >
]>
```
### XSD
```xml
<?xml version="1.0" encoding="utf-8" ?>

<root>

  <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">

    <!-- Options for <attribs attr=""  -->
    <xs:simpleType name="attrvallist">
      <xs:restriction base="xs:string">
        <xs:enumeration value="val1"/>
        <xs:enumeration value="val2"/>
        <xs:enumeration value="val3"/>
      </xs:restriction>
    </xs:simpleType>

    <xs:element name="person"> <!-- Declare the <person> element -->
      <xs:complexType> <!-- The <person> element contains either attributes or child elements -->
        <xs:attribute name="att" type="attrvallist" default="val1"/> <!-- Include the "attrvallist" options previously defined -->

        <xs:sequence> <!-- The order of child elements matters, optional -->
          <!-- Below we declare our various elements, self-closing tags because they contain no further definitions -->
          <xs:element name="one" type="xs:string"/>
          <xs:element name="two" type="xs:string"/>
          <xs:element name="also" type="xs:string"/>
          <xs:element name="there" type="xs:string"/>
          <!-- Self-closing tags are treated the same way as empty tags in XML and XSD -->
          <xs:element name="self_close" type="xs:string"/>
          <!-- This element definition is not self-closing because it contains an attribute definition -->
          <xs:element name="attribs" type="xs:string">
            <!-- Below we define options for the "attr" attribute in the <attribs> element -->
            <xs:attribute name="attr" type="attrvallist" default="val1"/> <!-- Include the "attrvallist" options previously defined -->
          </xs:element>

        </xs:sequence>
      </xs:complexType>
    </xs:element>

  </xs:schema>
```

## XSLT (Style)
- **eXtensible Stylesheet Language Transformations**
- Basically creates CSS for XML sheets
- Include a CSS stylesheet:
```xml
<?xml-stylesheet type="text/css" href="rss.css" ?>
```
- Include an XSL stylesheet:
```xml
<?xml-stylesheet type="text/xsl" href="style.xsl" ?>
```
- Place raw CSS inside the XSL template `<head>`:
```xml
<xsl:template match="/">
  <html>
    <head>
      <!-- CSS goes here, just like in HTML -->
      <style type="text/css">
        body {
          font-family: sans-serif;
          background-color: #eee;
        }
      </style>

    </head>
    <body>
      ...
    </body>
  </html>
</xsl:template>
```
- A logical language
| Shell               | PHP                 | XSLT                                             |
| ------------------- |:-------------------:| ------------------------------------------------:|
| `if [TEST]; then`   | `if (TEST) {…}`     | `<xsl:choose><xsl:when test="TEST">…</xsl:when>` |
| `elif [TEST]; then` | `elseif (TEST) {…}` | `<xsl:when test="TEST">…</xsl:when>`             |
| `else; …; fi`       | `else {…}`          | `<xsl:otherwise>…</xsl:otherwise></xsl:choose>`  |
- A template can use another template
```xml
<!-- HTML used <xsl:apply-templates> only once -->
<html>
  <body>
    <h1>Visitors</h1>
    <table>
      <xsl:apply-templates select="root/visitor"/>
    </table>
  </body>
</html>

<!-- Define the main template -->
<xsl:template match="root/visitor">
  <tr>
    <xsl:apply-templates select="name"/>
    <xsl:apply-templates select="login"/>
  </tr>
</xsl:template>

<!-- Define the templates the main template applies -->
<xsl:template match="name">
  <td bgcolor = "blue">
    <xsl:value-of select="name"/>
  </td>
</xsl:template>

<xsl:template match="login">
  <td bgcolor = "green">
    <xsl:value-of select="login"/>
  </td>
</xsl:template>
```

- Two ways to use templates:
  - `<xsl:apply-templates>`
  - `<xsl:call-template>`
  - `<xsl:apply-templates>` [may be more useful than](https://stackoverflow.com/questions/4478045/) `<xsl:call-template>`
  - In `<xsl:template mode="">`:
    - `<xsl:template mode="">` invokes with `<xsl:apply-templates mode="">`
    - `<xsl:template match="">` invokes with `<xsl:apply-templates select="">`
    - `<xsl:apply-templates>` can include another `<xsl:template>` definition
    - This keeps HTML structure simple
  - Normally `<xsl:template match="/">` is sufficient in one template per XML page
    - Then applying templates is not necessary

- Template example for an iTunes podcast-ready RSS feed:
  - [rss.xml](https://github.com/inkVerb/vip/blob/master/Design/rss.xsl)

## XML XPath
- A file/path/type method for defining XML hierarchy
- `/root/element/final` = `<root><element><final>`
  1. `some-element`: all nodes
  2. `//some-element`: all lower nodes from current node
  3. `/`: root
  4. `.`: current node
  5. `..`: parent node
  6. `*`: all elements
  7. `@*`: all attributes
  8. `@attrib`: prefix for attribute & value
  9. `/root/element/final`: absolute path from root
  10. `some-element/@attrib`: any `<some-element attrib="something">` returns `something`
  11. `some-element[1]`: index `[1]`, returns first occurrence of `<some-element>`
  12. `some-element[last()]`: returns last index item
  13. `some-element[@attrib="something"]`: matches contents of `<some-element attrib="something">`
  14. `some-element[child="something"]`: matches contents of `<some-element><child>something</child></some-element>`
- This also uses common operators
  - `+` plus
  - `*` multiply by
  - `-` minus
  - `div` divided by
  - `mod` modulus
  - `>` greater than
  - `>=` greater than or equal to
  - `&lt;` less than (`<` is not allowed)
  - `&lt;=` less than or equal to

## XML via CLI with XMLStarlet
- A command installed on Linux with the `xmlstarlet` package
- Use `xml` or `xmlstarlet` as the command, either works the same
- Uses standard XPath terms to determine hierarchy
- Important argument flags to know:
  - `sel`: select
  - `ed`: edit
  - `-L`: edit file inplace
  - `-t`: template
  - `-i`: insert
  - `-s`: subnode
  - `-v`: value
  - `-r`: rename
  - `-u`: update
  - `-d`: delete
- Example of settings file:

```xml
<?xml version="1.0" encoding="utf-8"?>
<?xml-stylesheet type="text/xsl" href="style.xsl" ?>
<root>
  <header>
    <title>Visitors</title>
    <subheading>Interplanetary Prominence</subheading>
    <credit-url>https://inkisaverb.com/vip</credit-url>
    <description><![CDATA[Here, you can learn all about our visitors.]]></description>
  </header>
  <meta>
    <status>open</status>
  </meta>
  <visitor login="johndoe">
    <name>John Doe</name>
    <level>user</level>
    <phone>555-1212</phone>
    <email>jdoe@verb.ink</email>
    <sport type="skateboard"/>
    <year>1995</year>
  </visitor>
  <visitor login="smithymars">
    <name>Smithy Mars</name>
    <level>admin</level>
    <phone>555-1515</phone>
    <email>smithy@inkisaverb.com</email>
    <sport type="soccer"/>
    <year>1989</year>
  </visitor>
  <visitor login="mwills">
    <name>Marshan Wills</name>
    <level>user</level>
    <phone>555-2727</phone>
    <email>marwills@verb.vip</email>
    <sport type="golf"/>
    <year>1990</year>
  </visitor>
  <visitor login="jupitersong">
    <name>Jupiter Song</name>
    <level>user</level>
    <phone>555-3535</phone>
    <email>jupiters@verb.red</email>
    <sport type="skateboard"/>
    <year>2001</year>
  </visitor>
  <visitor login="nlo">
    <name>Neptune Lo</name>
    <level>user</level>
    <phone>555-0101</phone>
    <email>nlo@verb.blue</email>
    <sport type="skateboard"/>
    <year>2010</year>
  </visitor>
</root>
```

| **Count `<visitor>** :

```console
xmlstarlet sel -t -v "count(//visitors/visitor)" xml/contacts.xml
```

| **Return entries of `<visitor>` nicely** :

```console
xmlstarlet sel -t -m "//visitors/visitor" -v "name" -o " - " -v "sport/@type" -o " (" -v "level" -o ")" -n xml/contacts.xml
```

| **Select `<email>` for `<visitor><name>Marshan Wills** :

```console
xml sel -t -v "//visitors/visitor[name='Marshan Wills']/email" xml/contacts.xml
```

| **Select `<name>` for `<visitor login="jupitersong">** :

```console
xml sel -t -v "//visitors/visitor[@login='jupitersong']/name" xml/contacts.xml
```

| **Change `<visitor login="jdoe">` to `logn="johndoe"** :

```console
xml ed --inplace -u "//visitors/visitor[@login='jdoe']/@login" -v "johndoe" xml/contacts.xml
```

| **Change `<visitor login="jdoe"><level>` to `user** :

```console
xml ed --inplace -u "//visitors/visitor[@login='jdoe']/level" -v "user" xml/contacts.xml
```

  - Insert new elements using a placeholder, then change it
    - If you don't give it a unique name first, your calls may likely change other elements

```xml
<root>
  <visitors>
    <!-- New entry -->
    <visitor login="jimjon">
       <name>Jimmy Jon</name>
       <level>user</level>
       <phone>555-5209</phone>
       <email>jimj@verb.ink</email>
       <sport type="surfing"/>
       <year>1981</year>
     </visitor>

  </visitors>
</root>
```

| **Insert above entry with placeholder ** :

- Placeholder `<visitorINS>` will become `<visitor>` when finished

```console
xml ed -L -s /root/visitors -t elem -n visitorINS \
    -i //visitorINS -t attr -n "login" -v "jimjon" \
    -s //visitorINS -t elem -n "name" -v "Jimmy Jon" \
    -s //visitorINS -t elem -n "level" -v "user" \
    -s //visitorINS -t elem -n "phone" -v "555-5209" \
    -s //visitorINS -t elem -n "email" -v "jimj@verb.ink" \
    -s //visitorINS -t elem -n "sport" \
    -i //visitorINS/sport -t attr -n "type" -v "surfing" \
    -s //visitorINS -t elem -n "year" -v "1981" \
    -r //visitorINS -v visitor \
    xml/contacts.xml
```

## Feeds
- RSS feeds have standard elements
- RSS feeds can also be ready for:
  - iTunes podcasts
  - Atom feeds (more sophisticated than normal RSS, but not universal)
  - Others
- ***Always*** use HTML entities in feeds or any XML
  - Not `&`, but `&amp;`
  - *Many times XML/RSS breaks is from HTML characters not existing as HTML entities!*
- Special characters won't matter if placed in CDATA tags: `<![CDATA[]]>`
  - `<![CDATA[ I can be anything ]]>`
### RSS
- RSS feeds should start with:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
```
- RSS feeds should have styling as good practice:
  - Add `<?xml-stylesheet type="text/xsl" href="rss.xsl" ?>`
```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="rss.xsl" ?>
<rss version="2.0">
```
- It is good for the `<rss>` element to accept common prefixes, such as:
  - iTunes `xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd"`
  - Content `xmlns:content="http://purl.org/rss/1.0/modules/content/"`
  - Atom `xmlns:atom="http://www.w3.org/2005/Atom"`
  - DC `xmlns:dc="http://purl.org/dc/elements/1.1/"`
```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="rss.xsl" ?>
<rss version="2.0"
  xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd"
  xmlns:content="http://purl.org/rss/1.0/modules/content/"
  xmlns:atom="http://www.w3.org/2005/Atom"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
  >
```

| **Simple RSS** :

```xml
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">

<channel>

  <!-- Feed info -->
  <title>501 Blog</title>
	<link>http://localhost/web</link>
	<image>
		<url>path/to/image.jpg</url>
		<title>501 Blog</title>
		<link>http://localhost/web</link>
	</image>
  <language>en</language>
  <description>Blog description</description>
  <lastBuildDate>Tue, Nov 30 15:45:12 2021 UTC</lastBuildDate>

  <!-- Items -->
  <item>
    <title>Media Features</title>
    <link>http://localhost/web/media-features</link>
    <pubDate>Tue, Nov 30 15:45:12 2021 UTC</pubDate>
    <author><![CDATA[Jon Boy]]></author>
    <category>Some-Category</category>
    <description>Media has features in the description</description>
    <enclosure url="http://url.tld/to/audio.mp3" length="" type="audio/mpeg" />
  </item>
  <item>
    <title>More Lessons</title>
    <link>http://localhost/web/media-features</link>
    <pubDate>Wed, Dec 1 16:43:52 2021 UTC</pubDate>
    <author></author>
    <category><![CDATA[Other Category]]></category>
    <description>More available lessons</description>
    <enclosure url="http://url.tld/to/audio.mp3" length="" type="audio/mpeg" />
    <enclosure url="http://url.tld/to/video.mp4" length="" type="video/mp4" />
  </item>
</channel>

</rss>
```

### iTunes
- iTunes has more tags
  - These ***must*** be in: `<chanel>`
  - You can [learn more here from Apple](https://podcasters.apple.com/support/823-podcast-requirements)
```xml
<itunes:author></itunes:author>
<itunes:summary></itunes:summary>
<itunes:subtitle></itunes:subtitle>
<itunes:owner>
  <itunes:name></itunes:name>
  <itunes:email></itunes:email>
</itunes:owner>
<itunes:keywords></itunes:keywords>
<itunes:category text=""/>
```

  - These ***must*** be in: `<item>`
```xml
<enclosure url="" length="" type="audio/mpeg" />
<itunes:duration></itunes:duration>
```

## PHP Integration via `SimpleXML`
- `SimpleXML` converts XML into a PHP Object

```php
$rss = simplexml_load_file('http://localhost/web/feed.rss');
echo $rss->channel->title;
```

- Loop through multiple elements, such as `<item>`
```php
$rss = simplexml_load_file('http://localhost/web/feed.rss');

foreach ($rss->channel->item as $item) {
  echo "<p>$item->pubDate</p>";
  echo "<p>$item->description</p>";
}
```

- This may be useful for iTunes and other prefixes
```php
foreach ($rss->channel->item as $item) {

  $itunes = $item->children('http://www.itunes.com/dtds/podcast-1.0.dtd');

  echo "<p>$itunes->author</p>";

}

```
  - Note `http://www.itunes.com/dtds/podcast-1.0.dtd` came from the `<rss>` declaration for iTunes
```xml
<rss version="2.0"
  xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd"
  >
```

- Here is a fuller implementation:
```php
$rss = simplexml_load_file('http://localhost/web/feed.rss');

echo '<h1>'.$rss->channel->title.'</h1>';
echo '<h2>'.$rss->channel->description.'</h2>';

foreach ($rss->channel->item as $item) {

  $itunes = $item->children('http://www.itunes.com/dtds/podcast-1.0.dtd');
  $content = $item->children('http://purl.org/rss/1.0/modules/content/');
  $atom = $item->children('http://www.w3.org/2005/Atom'); // For Atom
  $dc = $item->children('http://purl.org/dc/elements/1.1/');

  echo '<p><b><a href="'.$item->link.'">'.$item->title."</a></b></p>";
  echo "<p>$item->pubDate</p>";
  echo "<p>$item->description</p>";
  echo "<p>$itunes->author</p>";
  echo "<p>$content->encoded</p>";
  echo "<p>$dc->creator</p>";
  echo (isset($item->enclosure['url'])) ? '<p>'.$item->enclosure['url'].'</p>' : false;

}
```

## Final CMS
- The CMS we built in 501 is available if you want to play with it or build on it
- In directory: `501/cms`
- With install instructions at `501/cms/README.md`

___

# Done! Have a cookie: ### #

# Roadmap Assignments
*These can be projects or homework assignments*

1. Add filters to pieces.php:
  - Order by (date published, title, id/started)
  - Search (by ____, default title & content)
  - Only:
    - Published
    - Pre-draft
    - Redrafting
    - Scheduled
    - Title
2. SEO per piece
  - Add code to the `<!-- SEO -->` section of in.head.php
  - Retrieve any featured image or shortened content from a piece
  - Use this to change `$blog_description` & `$seo_image` per piece
3. Style website with CSS
  - Blog & Pieces
  - Logged-in pages
  - Website logo in Settings
4. Create multi-user functionality
  - Registration `<form>`
  - Multiple authors
  - Login only to read (if 'Private' blog in Settings)
5. Aggregation
  - Regularly check an RSS feed and republish to Series
  - Add options to the `series` table for feed elements per Series
6. Make themeable
  - Create a 'themes' folder
  - Rewrite `edit.php` & `blog.php` to:
    - Use HTML DOM from theme files in 'themes' folder
    - Use CSS from 'themes' folder
  - Add `theme` column to `blog_settings` in SQL
    - Selection should be based on subfolder name in 'themes' folder
    - Settings should check for the folder
    - Include Theme selection in settings.php
  - Rewrite `in.head.php` to use the theme or a default
  - Create a default theme
7. Series & Landing Page
  - Add `landing` column in `blog_settings` in SQL
    - Options are any piece or series
  - Create an `<input>` to set a piece as the `template` for a series on the `series` table
  - Indicate a piece is a template in `pieces.php` and edit.php
  - The root web URL will point to either the selected pieces series or the selected "page" piece
8. Menus
  - Add a `menus` table to the database
    - Organize the table however you want
    - Infinite entries or only limited entries in a menu
    - Have a single menu or a main and smaller menu or more
  - Add a `menu` column to the `blog_settings` table
    - Add a menu chooser in Blog Settings
    - If multiple menus, select which "page" piece a menu will appear with
  - Create an interface to select pages and series for the menu
  - Only "page" pieces would appear on the menu
  - A series as a menu item would not be clickable, but would make a dropdown showing other "page" pieces in that series
    - This will require some knowledge of CSS and JavaScript
9. Add filters to the media library
  - Add a to:
    - medialibrary.php
    - ajax.mediainsert.php
    - ajax.mediafeature.php
  - Search
  - Filter media by type
  - Filter by date added
    - Ascending
    - Descending
10. Add simple search to blog.php
  - Search through:
    - Tags
    - Series
    - Title
    - Content
    - After
    - Links
11. Build an API
  - Create public and private keys for users
  - API will render any post by ID or slug
    - Settings inside the app
    - Settings can be sent though the API
    - Settings for rotating post of the day/week/month
12. WordPress plugin
  - Out Of Box rendering of the API
    - Shortcodes
    - Widgets
    - Modeled after the badAd WordPress plugin

_

## Next: [Linux 601: SysAdmin](https://github.com/inkVerb/VIP/blob/master/601/README.md)
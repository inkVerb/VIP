# Shell 501
## Lesson 12: XML

This lesson uses XML CLI tools install in [Lesson 0: Server, LAMP Setup & HTML Fast](https://github.com/inkVerb/vip/blob/master/501/Lesson-00.md)

Ready the CLI

```console
cd ~/School/VIP/501
```
Ready services

Arch/Manjaro
```console
sudo systemctl start httpd mysql
```

Debian/Ubuntu
```console
sudo systemctl start apache2 mysql
```

___

### I. XML Structure

**eXtensible Markup Language**

1. Is static text
  - Text file or rendered text (ie `<?php echo $some_xml; ?>`)
  - NOT a logic-executed script like BASH, JavaScript, PHP, et cetera
  - Looks like HTML, came after HTML to maximize HTML concepts, can't replace HTML
    - 1986: SGML (Standard Generalized Markup Language)
    - 1993: HTML (keeps updating, version 5 in 2021)
    - 1998: XML (still using version 1.0)
  - Using SGML:
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
2. Used in:
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
    - Illustration: XML is a grocery list on the wall, SQL is your credit card spending history

#### A. Basic Structure

| **1** :$

```console
sudo cp core/12-syntax1.xml web/syntax.xml && \
sudo chown -R www:www /srv/www/html && \
atom core/12-syntax1.xml \
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
atom core/12-syntax2.xml \
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
atom core/12-syntax3.xml \
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
atom core/12-syntax4.xml \
ls web
```

*The prefix is defined by a URI in the first set of each hierarchy it is used*

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
atom core/12-syntax5.xml \
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
atom core/12-xmlrender6.php 12-htaccess7 \
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
atom core/12-syntax7.xml \
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
atom core/12-validate8.xml core/12-validate8.dtd \
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
atom core/12-syntax9.xml \
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
atom core/12-validate10.xml core/12-validate10.xsd \
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

*We just used XSD with namespace*

*Now, let's try without namespace...*

| **11** :$

```console
sudo cp core/12-validate11.xml web/validate.xml && \
sudo cp core/12-validate11.xsd web/validate.xsd && \
atom core/12-validate11.xml core/12-validate11.xsd \
ls web
```

*Note only the XSD declarations changed, everything else is the same*

| **B-11** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/validate.xml
```

##### XSD Elements & Attributes

###### `<xs:complexType>` vs `<xs:simpleType>`

- `<xs:complexType>` & `<xs:simpleType>` can apply to:
  - `<xs:element>`
  - `<xs:attribute>`

1. `<xs:simpleType>` CANNOT contain:
  - Attributes
  - Elements

| **`<elem>` `simpleType` self-closing** : (XDS considers same as empty)

```xml
<elem/>
```

| **`<elem>` `simpleType` empty** : (XDS considers same as self-closing)

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

| **`<elem>` `complexType` with attributes** :

```xml
<elem attr="here"/>
```

| **`<elem>` `complexType` with other elements** :

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

### III. XSLT (Extensible Stylesheet Language Transformations)

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
atom core/12-style12.xml core/12-style12.xsl \
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
atom core/12-style13.xml core/12-style13.xsl \
ls web
```

| **style.xml** : (Header only)

```xml
<?xml version="1.0" encoding="utf-8" ?>
<?xml-stylesheet type="text/xsl" href="style.xsl" ?> <!-- Add style.xsl -->
...
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
              <td><xsl:value-of select="sport/@type"/></td>
              <td><xsl:value-of select="year"/></td>
              <td><xsl:value-of select="@level"/></td> <!-- Select type= in <sport> -->
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
sudo cp core/12-style14.xsl web/style.xsl && \
sudo cp core/12-style14.xml web/style.xml && \
sudo chown -R www:www /srv/www/html && \
atom core/12-style14.xml core/12-style14.xsl \
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

| **`<xsl:template mode="">` viz `<xsl:apply-templates mode="">`** :

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

| **`<xsl:template name="">` viz `<xsl:call-template name="">`** :

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

##### 2. `<xsl:key>`

| **XSL** :

```xml
<!-- Define the <xsl:key> outside any <xsl:template> -->
<xsl:key name="call-something" match="element/path" use="container"/>

<!-- Use the <xsl:key> -->
<xsl:for-each select="key('call-something', 'Find me')">
  <td>
    <xsl:value-of select="title"/>
    <xsl:value-of select="container"/>
    <xsl:value-of select="other"/>
  </td>
</xsl:for-each>
```

- `<xsl:key>` Attributes:
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
atom core/12-style15.xml core/12-style15.xsl \
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

| **16** :$ *Copy 12-style15.xml again in case you make changes*

```console
sudo cp core/12-style15.xml web/style.xml && \
sudo cp core/12-style16.xsl web/style.xsl && \
sudo cp core/12-structure16.xsl web/structure.xsl && \
sudo cp core/12-meta16.xsl web/meta.xsl && \
sudo cp core/12-heading16.xsl web/heading.xsl && \
sudo cp core/12-visitors16.xsl web/visitors.xsl && \
sudo chown -R www:www /srv/www/html && \
atom core/12-style16.xsl core/12-structure16.xsl core/12-meta16.xsl core/12-heading16.xsl core/12-visitors16.xsl \
ls web
```

| **B-16** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/style.xml
```

### IV. XML XPath (Reference)

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

XMLStarlet uses the terminal command `xml` or `xmlstarlet` if you prefer

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
atom core/12-contacts.xml core/12-style17.xsl xml/contacts.xml && \
ls web
```

| **B-17** ://

```console
localhost/web/contacts.xml
```

*Let's fetch some information*

*How many entries...*

| **18** :$

```console
xmlstarlet sel -t -v "count(//visitor)" xml/contacts.xml
```

*Show entries nicely in the terminal*

| **19** :$

```console
xmlstarlet sel -t -m "//visitor" -v "name" -o " - " -v "sport/@type" -o " (" -v "level" -o ")" -n xml/contacts.xml
```

*The command `xml` points to `xmlstarlet`*

*Get the email for Marshan Wills...*

| **20** :$

```console
xml sel -t -v "//visitor[name='Marshan Wills']/email" xml/contacts.xml
```

*Get the name for `<visitor login="jupitersong">`...*

| **21** :$

```console
xml sel -t -v "//visitor[@login='jupitersong']/name" xml/contacts.xml
```

*We can also change content*

*Watch in Atom for this to change: `<visitor login="jdoe">`...*

| **22** :$

```console
xml ed --inplace -u "//visitor[@login='jdoe']/@login" -v "johndoe" xml/contacts.xml
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
xml ed --inplace -u "//visitor[@login='jdoe']/level" -v "user" xml/contacts.xml
```

| **B-23** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/contacts.xml
```

*Note nothing changed because we accessed `<visitor login="jdoe">`, but the `login=` was just changed to `johndoe`*

*Try correctly...*

| **24** :$

```console
xml ed --inplace -u "//visitor[@login='johndoe']/level" -v "user" xml/contacts.xml
sudo cp xml/contacts.xml web/contacts.xml
```

| **B-24** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/contacts.xml
```

*Make Smithy Mars an `admin`...*

| **25** :$

```console
xml ed --inplace -u "//visitor[@login='smithymars']/level" -v "admin" xml/contacts.xml
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
atom core/12-settings.xml xml/settings.xml && \
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
  - *We just made a mess: settings.xml `<display>` elements now have the new information, plus the new `<display>` entry with the same information*
  - *All the empty lines were removed, which is good*
    - *`xmlstarlet` will format the XML document to remove unneeded white space*

*Start over...*

| **28** :$ *Overwrite? Answer `y` for yes*

```console
cp core/12-settings.xml xml/settings.xml
```

*Tip: add strange whitespace in settings.xml, then watch it all disappear to perfect formatting*

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

*`unzip` allows you to dump the content of only one file as STDOUT output*

*We will use the xml directory to work with only the content file...*

| **37** :$

```console
unzip -p xml/markdown.odt content.xml
```

***That file, always called `content.xml`, is the only file we need for text inside any `.odt` file***

*We can send the output to a file we want to use*

| **38** :$

```console
unzip -p xml/markdown.odt content.xml > xml/markdown.xml && \
atom xml/markdown.xml && \
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

*Note the changes to markdown.xml in Atom*

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
atom xml/wordpress-css.rss xml/rss.css \
ls web
```

| **B-44** :// **`.rss`**

```console
localhost/web/wordpress-css.rss
```

*To apply XSL style, we must use the `.xml` extension...*

| **45** :$

```console
sudo cp xml/wordpress-css.rss web/wordpress-css.xml && \
sudo chown -R www:www /srv/www/html
```

| **B-45** :// **`.xml`**

```console
localhost/web/wordpress-css.xml
```

*Note the rendering does not have good formatting because it is only CSS, but nothing places HTML inside any `<html>` framework, so HTML never renders*

*We see only styled text, not rendered HTML*

*Rendering RSS via simple CSS is useful if the RSS feed only contains text with no HTML tags, such as news wires used for ages*

*To render HTML, we need an XSL stylesheet...*

##### WP-RSS via XSL Stylesheet

| **46** :$

```console
sudo cp core/12-wordpress-xsl.rss web/wordpress-xsl.rss && \
sudo cp core/12-wordpress-xsl.rss xml/wordpress-xsl.rss && \
sudo cp core/12-rss.xsl web/rss.xsl && \
sudo cp core/12-rss.xsl xml/rss.xsl && \
sudo chown -R www:www /srv/www/html && \
atom xml/wordpress-xsl.rss xml/rss.xsl && \
ls web
```

| **B-46** :// **`.rss`**

```console
localhost/web/wordpress-xsl.rss
```

*To apply XSL style, we must use the `.xml` extension...*

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
atom xml/podcast.rss && \
ls web
```

*Note we are using the same rss.xsl file as in our WordPress example*

| **B-48** :// **`.rss`**

```console
localhost/web/podcast.rss
```

*To apply XSL style, we must use the `.xml` extension...*

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

- *Rewrite must catch `feed` before trying it as a slug, otherwise it will be interpreted as a slug and sent to piece.php*

- *Try placing the "Feeds" rule after "Blog" to see it break*

| **feed.php** :

```php

```

#### Aggregate another RSS feed



___

# The Take

## Final CMS

- In directory: `501/cms`
- With install instructions at `501/cms/README.md`

___

# Roadmap Assignments

Features to be added

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
  - Rewrite edit.php & blog.php to:
    - Use HTML DOM from theme files in 'themes' folder
    - Use CSS from 'themes' folder
  - Add `theme` column to `blog_settings` in SQL
    - Selection should be based on subfolder name in 'themes' folder
    - Settings should check for the folder
    - Include Theme selection in settings.php
  - Rewrite in.head.php to use the theme or a default
  - Create a default theme
7. Series & Landing Page
  - Add `landing` column in `blog_settings` in SQL
    - Options are any piece or series
  - Create an `<input>` to set a piece as the `template` for a series on the `series` table
  - Indicate a piece is a template in pieces.php and edit.php
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

# Done! Have a cookie: ### #

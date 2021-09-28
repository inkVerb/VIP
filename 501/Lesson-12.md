# Shell 501
## Lesson 12: XML

Ready the CLI

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
    - 1993: HTML (keeps updating, version 5 in 2021)
    - 1996: XML (still using version 1.0)
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

#### A. Basic Structure

| **1** :$

```
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

```
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

```
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

```
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

```
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

```
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

```
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

```
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

```
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

```
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

| **content.xml** :

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

| **content.xml** :

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

| **content.xml** :

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

```
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

```
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

```
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

```
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


##### 5. Rough Examples

| **15** :$

```
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

```
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

### IV. XML XPath



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


| **B-26** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

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

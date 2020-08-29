# Shell 501
## Lesson 12: Production & Feed

Ready the CLI

`cd ~/School/VIP/501`

___
- Pagination
  - blog.php
  - pieces.php
  - trash.php
  - medialibrary.php
  - hist.php (next/previous links)
- Admin Controls
  - Series in slug option
  - Title, Slogan
  - Splash & Logo
  - Timezone
  - Editor: Medium or Tiny
  - Basic Flair Colors (default option)
  - Choose Theming (files in a dir)
    - Fonts
    - Colors
    - Copy to dir, not a database call
  - Identities editor
  - Footer
    - Message
    - Copyright message
  - Custom "Cookie notice" message and option
  - Home page (Page, All Pieces, or Series)
- Header SEO-ready (no database calls)
  - Admin Control file-write editor
  - Image chooser: copies/writes file
- Namespace list table (occupied slugs, also used by mods)
- User levels: Admin Editor Contributor Member (pieces_levels table/column-int, member_classes table/column-json)
- Superadmin Register page
- Editor/Pieces Upgrades
  - Title capitalizer
  - HTML allowed in "After"
  - JS word counter
  - (update table, pieces.php piece.php blog.php history.php)
    - Private Pieces option (Based on Level/Class)
    - Identity
- Choose "Menu Pages"
- "Blog" series = all pieces
- Theming structure
- Night/day/soft mode cookies
- RSS
  - Feed create/import/export
  - Import/export feed to/from posts
  - Podcast items, series, feed

### Based on roadmap:
- Feed mod
  - Import/export
  - Import/export for WordPress
- Custom-piece mod capability
  - Podcast mod
- Menu Lists
  - 2 Pages Lists
  - 1 Social List
  - Custom Links
  - Combined Lists (choose from Pieces, Custom Links, Dropdown other list)
    - Dropdown (show another 'List'/'Section' on click)
- Landing-pages
  - combine sections
  - section height (auto/full)
  - top/social menus y/n
  - drop-in PHP/HTML code
- Sections
  - list (choose from Menu Lists)
  - forms
  - button links
  - buttons show forms
  - background images w color overlay
  - background colors
  - columns
  - sections appear at top/bottom of both/posts/pages of all/series


- Extended:
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


| **B-26** :// `localhost/web/settings.php` (Ctrl + R to reload)


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

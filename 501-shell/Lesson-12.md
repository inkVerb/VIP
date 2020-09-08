# Shell 501
## Lesson 12: Production & XML

Ready the CLI

`cd ~/School/VIP/501`

___
### Production-Ready
- Brute attack login protection
- Pagination
  - GET to set items show per page
  - blog.php
  - pieces.php
  - trash.php
  - medialibrary.php
- Admin Controls
  - Series in slug option
  - Title, Slogan
  - Splash & Logo
  - Timezone
  - Footer
    - Message
    - Copyright message
  - Custom "Cookie notice" message and option
  - Home page (Page, All Pieces, or Series)
- Theming
  - Choose Theming in admin (files in a dir)
  - Fonts
  - Colors
  - Copy to dir, not a database call
- Header SEO-ready (no database calls)
  - Admin Control file-write editor
  - Image chooser: copies/writes file
- Namespace list table (occupied slugs, also used by mods)
- User levels
  - "Login required" option in edit.php
  - "Contributor" can't publish, only edit draft & flag for review
  - "Editor" can't see Admin Controls nor create users
- New user page (Admin only, sets 'level')
- Member signup page (enable in Admin Control)  
- Install page
- Mod-capable via PHP objects

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

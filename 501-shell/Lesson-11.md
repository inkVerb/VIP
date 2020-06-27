# Shell 501
## Lesson 11: Site Settings & Production Framework

Ready the CLI

`cd ~/School/VIP/501`

___

- Header SEO-ready
- User levels: Superadmin Admin Editor Contributor Member (member_levels table, pieces_levels table)
- Pagination
- Theming via CSS and PHP
- Night/day/sepia mode cookies
- Private Pieces option (update table, pieces.php piece.php blog.php history.php)
- landing-pages
  - combine sections
  - section height (auto/full)
  - top/social menus y/n
  - drop-in PHP/HTML code
- sections
  - forms
  - button links
  - buttons show forms
  - background images w color overlay
  - background colors
  - columns
  - sections appear at top/bottom of both/posts/pages of all/series
- feed mod
- join mod (allow Member signup)
- custom-draft mod (unique draft with optional fields that push to publications)
- custom-piece mod

### Blog Settings

| **12** :
```
sudo cp core/11-settings.php web/settings.php && \
sudo cp core/11-menus.php web/menus.php && \
sudo cp core/11-series.php web/series.php && \
sudo cp core/11-mods.php web/mods.php && \
atom core/11-settings.php core/11-menus.php core/11-series.php && \
ls web
```

- Social menu (top/bottom/off)
- Menus (top/bottom/off)
- Home page (Page or relative path, masks URL)
- Blogs page (All or Series, masks URL)
- Theme default
- Custom theme (for: night, day, sepia)
- Custom footer message
- Custom footer copyright message
- Custom "Cookie notice" message and option


| **B-26** :// `localhost/web/settings.php` (Ctrl + R to reload)


### Pages to Process Our New Meta

| **12** :
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

#### [Lesson 12: Object Oriented Programming](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-12.md)

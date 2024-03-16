# Tools for Blender

- [Blender Wiki](https://wiki.blender.org/index.php/)
- Blender Hotkeys: [Docs](http://download.blender.org/documentation/BlenderHotkeyReference.pdf)
Filmic Blender: [Filmic-blender](https://github.com/sobotka/filmic-blender)
- Why filmic-blender: [YouTube](https://www.youtube.com/watch?v=m9AT7H<key>4</key>GGrA)

#### Differencing Objects
- Snap [https://blender.stackexchange.com/questions/3978<key>4</key>/snapping-two-objects-by-edge-in-object-mode]
- Boolean Modifier [YouTube](https://www.youtube.com/watch?v=lDweCpDAB_o)

#### Pi Menu
- <key>Ctrl</key> + <key>Alt</key> + <key>U</key> (File > User Preferences...)
  - Add-ons > Categories > User Interface
  - Pi Menu
  - Save User Settings

#### Extra Objects
- <key>Ctrl</key> + <key>Alt</key> + <key>U</key> (File > User Preferences...)
  - Add-ons > Categories > Add Mesh
  - Extra Objects
  - Save User Settings

#### Mouse
- Scroll = zoom
  - <key>MiddleClidk</key> + Move = orbit
  - <key>Shift</key> + <key>MiddleClidk</key> + Move = pan
  - <key>Ctrl</key> + <key>LeftClick</key> = Circle select
  - <key>Shift</key> + <key>Space</key> / <key>Ctrl</key> + <key>Up/Down</key> = Max
  - <key>Ctrl</key> + <key>Space</key> = hide arrows
  - <key>Alt</key> + <key>Space</key> = Orientation

- Select:
  - <key>Ctrl</key> + <key>Tab</key> / <key>Ctrl</key> + <key>LeftClick</key> + Drag
  - <key>A</key> = select all/none
  - <key>B</key> = border select
  - <key>C</key> = circle select
  - <key>Q</key> = Pi View Menu
  - <key>Z</key> = Pi Shade Menu (no Pi = wire frame / solid)
  - <key>Tab</key> = Pi Mode Menu (no Pi = Edit mode on/off)
  - <key>N</key> = Properties panel (set number values for object size/place, etc)
  - <key>Shift</key> + <key>A</key> = add menu
  - <key>Shift</key> + <key>S</key> = snap menu
  - <key>Shift</key> + <key>Z</key> = quick render
  - <key>X</key>/<key>Y</key>/<key>Z</key> = axis (again for local)
  - <key>Shift</key> + X/Y/Z = plane (again for local)
  - <key>G</key> = Grab
  - <key>S</key> = Scale
  - <key>R</key> = Rotate
  - <key>Ctrl</key> + <key>A</key> = Apply menu (Apply the Location/Rotation/Scale changes BEFORE doing other operations such as Bevel)
  - <key>Ctrl</key> + <key>Alt</key> + <key>Shift</key> + <key>C</key> = Set Origin
  - Origin to Geometry, etc
  - <key>Shift</key> + <key>D</key> = Duplicate
  - <key>Alt</key> + <key>D</key> = Duplicate as link
  - <key>Ctrl</key> + <key>L</key> = Link objects to last selected
  - <key>Shift</key> + <key>L</key> = Select Link menu
  - <key>U</key> = Unlink menu
  - <key>L</key> = make Local

## Edit Mode:
- <key>Ctrl</key> + <key>Tab</key> = Mesh Select Mode (Vertex, Face, Edge)
- <key>E</key> = extrude
- <key>P</key> = sPlit to new object

- *NOTE: Apply any scaling changes (<key>Ctrl</key> + A) BEFORE Bevel, otherwise bevel will be scaled as well.*
- <key>Ctrl</key> + <key>R</key> = add mid lines; Mouse Wheel > more
- <key>Ctrl</key> + <key>B</key> = bevel edges; Mouse Wheel > more
- <key>Ctrl</key> + <key>Shift</key> + <key>B</key> = bevel verticies; Mouse Wheel > more
- <key>Ctrl</key> + <key>E</key> = Edges menu
- <key>Ctrl</key> + <key>RightClick</key> = select range
- <key>Ctrl</key> + <key>Alt</key> + <key>RightClick</key> = selecte entire UV loop
  - Changes with Vertex, Face, Edge Mesh Select Mode
- <key>Ctrl</key> + <key>R</key> = loop cut (mouse wheel = add more)
  - <key>LeftClick</key>, move = set place (+ <key>Ctrl</key> = snapping)
    - <key>LeftClick</key> = apply place
    - <key>Esc</key> = cancel place and use original
- <key>K</key> = Knife tool
  - <key>LeftClick</key> = drag/click to cut
  - <key>Enter</key>/<key>Space</key> = apply cut
  - <key>Esc</key>/<key>RightClick</key> = cancel cuts
  - <key>Ctrl</key> = place cut at midpoint of affected lines
  - <key>Shift</key> = allow cut point NOT on an edge
  - <key>E</key> = start <key>A</key> new cut line
  - <key>C</key> = <key>4</key><key>5</key>° snapping
  - <key>Z</key> = also cut all edges and surfaces behind view

### View
- <key>1</key> = front
- <key>2</key> = orbit back
- <key>3</key> = right side
- <key>4</key> = orbit left
- <key>5</key> = orthogonal/perspective toggle
- <key>6</key> = orbit right
- <key>7</key> = top
- <key>8</key> = orbit forward
- <key>9</key> = 
- <key>0</key> = camera view
- <key>1</key> + <key>Ctrl</key> = back
- <key>2</key> + <key>Ctrl</key> = pan down
- <key>3</key> + <key>Ctrl</key> = left side
- <key>4</key> + <key>Ctrl</key> = pan left
- <key>6</key> + <key>Ctrl</key> = pan right
- <key>7</key> + <key>Ctrl</key> = bottom
- <key>8</key> + <key>Ctrl</key> = pan up
- <key>9</key> + <key>Ctrl</key> =
- <key>0</key> + <key>Ctrl</key> = set active opject as camera
- <key>0</key> + <key>Ctrl</key> + <key>Alt</key> = set user view as camera
- <key>+</key> = zoom in
- <key>-</key> = zoom out
- <key>/</key> = toggle local view
- <key>.</key> = view selected

### Verticies
- <key>Ctrl</key> + <key>V</key>

- Add Modifier > Subdivision Surface (smooth via adding verticies)

#### Pi Menu
- Activate
  - <key>Ctrl</key> + <key>Alt</key> + <key>U</key> (File > User Preferences...)
  - Add-ons > Categories > User Interface
  - Pi Menu
  - Save User Settings
- Use
  - <key>Shift</key> + <key>A</key> = Add
  - <key>Shift</key> + <key>V</key> = Vertical slide
  - <key>Ctrl</key> + <key>Alt</key> + <key>Q</key> = <key>4</key>-View
  - <key>Ctrl</key> + <key>H</key> = hooks menu
  - <key>Shift</key> + <key>D</key> = duplicate
  - <key>Ctrl</key> + <key>M</key> = merg
  - <key>Ctrl</key> + <key>J</key> = join
  - <key>Ctrl</key> + <key>Alt</key> + <key>Shift</key> + <key>C</key> = origin to geometry
  - <key>Shift</key> + <key>D</key> = duplicate
  - <key>Alt</key> + <key>D</key> = linked duplicate
  - <key>Ctrl</key> + <key>L</key> = make links

#### Groups
- <key>Ctrl</key> + <key>G</key> = new group
- <key>Ctrl</key> + <key>Alt</key> + <key>G</key> = remove from groups
- <key>Ctrl</key> + Ald + <key>Shift</key> + <key>G</key> = remobe from all groups
- <key>Ctrl</key> + <key>Shift</key> + <key>G</key> = add selected to active group
- <key>Alt</key> + <key>Shift</key> + <key>G</key> = remove selected to active group
- <key>Ctrl</key> + <key>1</key> = subdivision

##### See Groups (Two ways)
- Properties menu (Picture of the cube on right)
- <key>Shift</key> + <key>G</key> = group/parentselect menu

#### Parenting
- <key>Ctrl</key> + <key>P</key> = parent set
- <key>Alt</key> + <key>P</key> = parent clear

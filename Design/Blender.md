# Tools for Blender

- [Blender Wiki](https://wiki.blender.org/index.php/)
- Blender Hotkeys: [Docs](http://download.blender.org/documentation/BlenderHotkeyReference.pdf)
Filmic Blender: [Filmic-blender](https://github.com/sobotka/filmic-blender)
- Why filmic-blender: [YouTube](https://www.youtube.com/watch?v=m9AT7H<kbd>4</kbd>GGrA)

#### Differencing Objects
- Snap [https://blender.stackexchange.com/questions/3978<kbd>4</kbd>/snapping-two-objects-by-edge-in-object-mode]
- Boolean Modifier [YouTube](https://www.youtube.com/watch?v=lDweCpDAB_o)

#### Pi Menu
- <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>U</kbd> (File > User Preferences...)
  - Add-ons > Categories > User Interface
  - Pi Menu
  - Save User Settings

#### Extra Objects
- <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>U</kbd> (File > User Preferences...)
  - Add-ons > Categories > Add Mesh
  - Extra Objects
  - Save User Settings

#### Mouse
- Scroll = zoom
  - <kbd>MiddleClidk</kbd> + Move = orbit
  - <kbd>Shift</kbd> + <kbd>MiddleClidk</kbd> + Move = pan
  - <kbd>Ctrl</kbd> + <kbd>LeftClick</kbd> = Circle select
  - <kbd>Shift</kbd> + <kbd>Space</kbd> / <kbd>Ctrl</kbd> + <kbd>Up/Down</kbd> = Max
  - <kbd>Ctrl</kbd> + <kbd>Space</kbd> = hide arrows
  - <kbd>Alt</kbd> + <kbd>Space</kbd> = Orientation

- Select:
  - <kbd>Ctrl</kbd> + <kbd>Tab</kbd> / <kbd>Ctrl</kbd> + <kbd>LeftClick</kbd> + Drag
  - <kbd>A</kbd> = select all/none
  - <kbd>B</kbd> = border select
  - <kbd>C</kbd> = circle select
  - <kbd>Q</kbd> = Pi View Menu
  - <kbd>Z</kbd> = Pi Shade Menu (no Pi = wire frame / solid)
  - <kbd>Tab</kbd> = Pi Mode Menu (no Pi = Edit mode on/off)
  - <kbd>N</kbd> = Properties panel (set number values for object size/place, etc)
  - <kbd>Shift</kbd> + <kbd>A</kbd> = add menu
  - <kbd>Shift</kbd> + <kbd>S</kbd> = snap menu
  - <kbd>Shift</kbd> + <kbd>Z</kbd> = quick render
  - <kbd>X</kbd>/<kbd>Y</kbd>/<kbd>Z</kbd> = axis (again for local)
  - <kbd>Shift</kbd> + X/Y/Z = plane (again for local)
  - <kbd>G</kbd> = Grab
  - <kbd>S</kbd> = Scale
  - <kbd>R</kbd> = Rotate
  - <kbd>Ctrl</kbd> + <kbd>A</kbd> = Apply menu (Apply the Location/Rotation/Scale changes BEFORE doing other operations such as Bevel)
  - <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> = Set Origin
  - Origin to Geometry, etc
  - <kbd>Shift</kbd> + <kbd>D</kbd> = Duplicate
  - <kbd>Alt</kbd> + <kbd>D</kbd> = Duplicate as link
  - <kbd>Ctrl</kbd> + <kbd>L</kbd> = Link objects to last selected
  - <kbd>Shift</kbd> + <kbd>L</kbd> = Select Link menu
  - <kbd>U</kbd> = Unlink menu
  - <kbd>L</kbd> = make Local

## Edit Mode:
- <kbd>Ctrl</kbd> + <kbd>Tab</kbd> = Mesh Select Mode (Vertex, Face, Edge)
- <kbd>E</kbd> = extrude
- <kbd>P</kbd> = sPlit to new object

- *NOTE: Apply any scaling changes (<kbd>Ctrl</kbd> + A) BEFORE Bevel, otherwise bevel will be scaled as well.*
- <kbd>Ctrl</kbd> + <kbd>R</kbd> = add mid lines; Mouse Wheel > more
- <kbd>Ctrl</kbd> + <kbd>B</kbd> = bevel edges; Mouse Wheel > more
- <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>B</kbd> = bevel verticies; Mouse Wheel > more
- <kbd>Ctrl</kbd> + <kbd>E</kbd> = Edges menu
- <kbd>Ctrl</kbd> + <kbd>RightClick</kbd> = select range
- <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>RightClick</kbd> = selecte entire UV loop
  - Changes with Vertex, Face, Edge Mesh Select Mode
- <kbd>Ctrl</kbd> + <kbd>R</kbd> = loop cut (mouse wheel = add more)
  - <kbd>LeftClick</kbd>, move = set place (+ <kbd>Ctrl</kbd> = snapping)
    - <kbd>LeftClick</kbd> = apply place
    - <kbd>Esc</kbd> = cancel place and use original
- <kbd>K</kbd> = Knife tool
  - <kbd>LeftClick</kbd> = drag/click to cut
  - <kbd>Enter</kbd>/<kbd>Space</kbd> = apply cut
  - <kbd>Esc</kbd>/<kbd>RightClick</kbd> = cancel cuts
  - <kbd>Ctrl</kbd> = place cut at midpoint of affected lines
  - <kbd>Shift</kbd> = allow cut point NOT on an edge
  - <kbd>E</kbd> = start <kbd>A</kbd> new cut line
  - <kbd>C</kbd> = <kbd>4</kbd><kbd>5</kbd>° snapping
  - <kbd>Z</kbd> = also cut all edges and surfaces behind view

### View
- <kbd>1</kbd> = front
- <kbd>2</kbd> = orbit back
- <kbd>3</kbd> = right side
- <kbd>4</kbd> = orbit left
- <kbd>5</kbd> = orthogonal/perspective toggle
- <kbd>6</kbd> = orbit right
- <kbd>7</kbd> = top
- <kbd>8</kbd> = orbit forward
- <kbd>9</kbd> = 
- <kbd>0</kbd> = camera view
- <kbd>1</kbd> + <kbd>Ctrl</kbd> = back
- <kbd>2</kbd> + <kbd>Ctrl</kbd> = pan down
- <kbd>3</kbd> + <kbd>Ctrl</kbd> = left side
- <kbd>4</kbd> + <kbd>Ctrl</kbd> = pan left
- <kbd>6</kbd> + <kbd>Ctrl</kbd> = pan right
- <kbd>7</kbd> + <kbd>Ctrl</kbd> = bottom
- <kbd>8</kbd> + <kbd>Ctrl</kbd> = pan up
- <kbd>9</kbd> + <kbd>Ctrl</kbd> =
- <kbd>0</kbd> + <kbd>Ctrl</kbd> = set active opject as camera
- <kbd>0</kbd> + <kbd>Ctrl</kbd> + <kbd>Alt</kbd> = set user view as camera
- <kbd>+</kbd> = zoom in
- <kbd>-</kbd> = zoom out
- <kbd>/</kbd> = toggle local view
- <kbd>.</kbd> = view selected

### Verticies
- <kbd>Ctrl</kbd> + <kbd>V</kbd>

- Add Modifier > Subdivision Surface (smooth via adding verticies)

#### Pi Menu
- Activate
  - <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>U</kbd> (File > User Preferences...)
  - Add-ons > Categories > User Interface
  - Pi Menu
  - Save User Settings
- Use
  - <kbd>Shift</kbd> + <kbd>A</kbd> = Add
  - <kbd>Shift</kbd> + <kbd>V</kbd> = Vertical slide
  - <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Q</kbd> = <kbd>4</kbd>-View
  - <kbd>Ctrl</kbd> + <kbd>H</kbd> = hooks menu
  - <kbd>Shift</kbd> + <kbd>D</kbd> = duplicate
  - <kbd>Ctrl</kbd> + <kbd>M</kbd> = merg
  - <kbd>Ctrl</kbd> + <kbd>J</kbd> = join
  - <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> = origin to geometry
  - <kbd>Shift</kbd> + <kbd>D</kbd> = duplicate
  - <kbd>Alt</kbd> + <kbd>D</kbd> = linked duplicate
  - <kbd>Ctrl</kbd> + <kbd>L</kbd> = make links

#### Groups
- <kbd>Ctrl</kbd> + <kbd>G</kbd> = new group
- <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>G</kbd> = remove from groups
- <kbd>Ctrl</kbd> + Ald + <kbd>Shift</kbd> + <kbd>G</kbd> = remobe from all groups
- <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>G</kbd> = add selected to active group
- <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>G</kbd> = remove selected to active group
- <kbd>Ctrl</kbd> + <kbd>1</kbd> = subdivision

##### See Groups (Two ways)
- Properties menu (Picture of the cube on right)
- <kbd>Shift</kbd> + <kbd>G</kbd> = group/parentselect menu

#### Parenting
- <kbd>Ctrl</kbd> + <kbd>P</kbd> = parent set
- <kbd>Alt</kbd> + <kbd>P</kbd> = parent clear

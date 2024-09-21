# Package Architectures
Base package managers and package structures

- Arch (`makepkg` & `pacman`)
- Debian (`dpkg` & `apt-get`)
- RPM (`rpm` for OpenSUSE `zypper` & RedHat/CentOS `dnf`)

This is a very rough overview and serves to contrast basic differences between these three architectures

Further research is absolutely necessary to master package creation

This serves as a general framework and point of reference for anyone getting started

## Essential Package Structure
- Arch and Debian packages both contain in-place files with directories relative to `/` on the to-install system
- Both install and remove will compare the files on the system to these in-place files, making the system match or remove files according to that structure
- RPM has a different process that involves knowing a list of the files, rather than a relative structure
- So, Arch can more easily interpret and install `.deb` files with the [AUR `debtap` tool](https://aur.archlinux.org/packages/debtap)
  - Though an available AUR package is almost always better than using `debtap some-debian-dl.deb`
- And, if you look inside a `.pkg.tar.zst` file, you may see similar relative directories like `usr/` and `etc/` as in the rood of a Debian package directory structure

### Arch
#### Arch: Assets & Methodology
- Single directory with any name
- Source files located anywhere in that directory
  - Source files are always optiona because a package may not necessarily use files, but might only run scripts
- `PKGBUILD` file in that directory containing:
  - All meta information
    - Files in `backup=()` array will be:
      - Left in place on update, new would-replace files renamed as `.pacnew`
      - Copied to `.pacsave` on package removal *if changed*
      - Only removed with the `-Rn` flag with `pacman`
  - All package scripts
- File structure is automatically detected after the package is prepared, according to the `package()` function in `PKGBUILD`
- Prerequesite builder packages: *none* since `makepkg` is part of the `pacman` package that ships wtih Arch
- **Prepare -** Run :$ `makepkg` inside that directory to prepare the `.pkg.tar.zst` package
  - *Do not run `makepkg` as root!*
- **Install -** Run :# `pacman -U some-package.pkg.tar.zst` to install the `.pkg.tar.zst` package
  - *`pacman` always needs root permissions!*
  - `makepkg -i` will automatically run `pacman -U` as root once the package is prepared, combining everything into one command

#### Arch: Structure & Meta Config Template

| **Arch Package Structure** :

```
$PWD
├─ PKGBUILD
├─ some-file.conf
├─ package-name-service-maybe.service
└─ maybe-some-script.sh
```

| **`PKGBUILD`** : (the only mandatory file)

```
pkgname=package-name
pkgver=1.0.0
pkgrel=1
pkgdesc="Some description here"
url="https://example.tld"
arch=('any')
license=('GPL')
depends=('bash', 'systemd')
source=("maybe-some-script.sh" "${pkgname}-service-maybe.service" "some-file.conf")
sha256sums=('SKIP' 'SKIP' 'SKIP')
backup=("etc/$pkgname/conf")
install="somescript.install"

package() {

  install -Dm755 "$srcdir/$pkgname.sh" "$pkgdir/usr/lib/$pkgname/$pkgname.sh"
  install -Dm644 "$srcdir/$pkgname.service" "$pkgdir/usr/lib/systemd/system/$pkgname.service"
  install -Dm644 "$srcdir/conf" "$pkgdir/etc/$pkgname/conf"
 
}
```

- `$srcdir` is `src/` from the PWD when running `makepkg`
  - Files are copied here from the `source=()` array
- Hashes in `sha256sum=()` are for files in the `source=()` array respectively
  - Obtain each hash with `sha256sum file-in-source-array`
- `install=` is a variable of any Shell or BASH script ending in `.install`
  - This has sections to run before and after install, update, and remove
  - [Read more on `install=`](https://wiki.archlinux.org/title/PKGBUILD#install), view the [prototype .install file](https://gitlab.archlinux.org/pacman/pacman/raw/master/proto/proto.install)
- While Debian and RPM have ways to use `systemctl` to manage service status, Arch sets up packages with `chroot` in a way that does not allow this
  - For this reason, `systemctl enable some-service` usually needs to be run manually after a package is installed
  - There are work-arounds, but they are complicated and generally not thought to be necessary by Arch administrators
- These files have their own contents, unrelated to making the actual package:
  - `some-file.conf`
  - `package-name-service-maybe.service`
  - `maybe-some-script.sh`
- Arch allows for a dynamic `pkgver=` value using a function instead (`pkgver()`)
  - This allows the `PKGBUILD` file to be written only once, but still pass on updated version numbers to `pacman` with the `-Sy` version update flags
    - Version updates come from the source (GitHub, Subversion, et al)
  - This is explained in the [Arch VCS Guidelines](https://wiki.archlinux.org/title/VCS_package_guidelines) and a basic, working example included in the [**`gophersay-git`**](https://github.com/JesseSteele/gophersay-git) demo

#### Arch: Workflow
1. Making package (`makepkg`): Package meta setup according to meta section of `PKGBUILD` file
  - Source files for compiling are in; or first cloned into `src/repo-source-name/` (from a VCS like Git)
    - `$srcdir` = `src/`
    - Files are placed in this directory as listed in `PKGBUILD`: `source=()`
  - Finally, compiled binaries and other to-be-installed "package" files move to `pkg/package-name/`
    - `$pkgdir` = `pkg/package-name/`
2. Install (`pacman -S`): Files are put in place according to their detected location found in the prepared package
  - Copied into place from `pkg/package-name/`
3. On update (`pacman -Syu`) or remove (`pacman -R`): `pkg/package-name/` defines what on system is updated/removed
  - Files listed in `backup=()` array are not removed or replaced
    - Would-be new files saved as `.pacnew`
    - Would-be replaced files *if changed* copied as `.pacsave`
5. Remove (`pacman -R`): Package is *carefully* undone according to steps 1 & 2 (respecting `backup=()`)
6. Purge (`pacman -Rn`): Package is *completely* undone according to steps 1 & 2 (ignoring `backup=()`)

#### Arch `PKGBUILD` `install=` script
- Vaue is any file with `.install` extension (using `install="somescript.install"`)
-- This workflow is used in the [**`501webapp`**](https://github.com/inkVerb/501webapp) package

| **`somescript.install`** : ([Read more on `install=`](https://wiki.archlinux.org/title/PKGBUILD#install), [prototype .install file](https://gitlab.archlinux.org/pacman/pacman/raw/master/proto/proto.install))

```
# This is a default template for a post-install scriptlet.
# Uncomment only required functions and remove any functions
# you don't need (and this header).

## arg 1:  the new package version
#pre_install() {
	# do something here
#}

## arg 1:  the new package version
#post_install() {
	# do something here
#}

## arg 1:  the new package version
## arg 2:  the old package version
#pre_upgrade() {
	# do something here
#}

## arg 1:  the new package version
## arg 2:  the old package version
#post_upgrade() {
	# do something here
#}

## arg 1:  the old package version
#pre_remove() {
	# do something here
#}

## arg 1:  the old package version
#post_remove() {
	# do something here
#}
```

#### Arch `PKGBUILD` `pkgver()` Function
- `pkgver()` retrieves a dynamic version number directly from the GitHub/Subversion/etc source
- `PKGBUILD` does not need to be updated with each update from the upstream source
- This follows the "proper [Arch way](https://wiki.archlinux.org/title/Arch_terminology#The_Arch_Way)"
- One of the strong advantages Arch has over Debian and RPM
- This workflow is used in the [**`501webapp`**](https://github.com/inkVerb/501webapp) & [**`gophersay`**](https://github.com/JesseSteele/gophersay) packages

##### `pkgver()` Examples
- The [Arch Wiki on VCS package guidelines](https://wiki.archlinux.org/title/VCS_package_guidelines#The_pkgver()_function) explains this in greater detail
- Supported version control systems are:
  - Bazaar
  - Git
  - Mercurial
  - Subversion
- These examples only use Git (`git`)
- The Git `pkgver()` function can extract a unique software version from either of two pieces of meta info:
  - Git commit tag (clean, entered manually)
  - Git commit hash (eye-sore, automatic)
  - These examples cover all scenarios, including `git tag` creation and the corresponding `pkgver()` function

###### The `source=` Value
- These assume that the `source=` value is set to use a Git repository as so

| **`PKGBUILD` lines for `pkgver()` function** :

```
...
pkgname=package-name
pkgver=1 # Must not be empty (can be anything), later replaced with the pkgver() function
...
source=("package-name::git+https://github.com/username/package-repo.git")
...

pkgver() {
  cd "$pkgdir"  # Many online examples use $pkgname; $pkgdir is safer and needed here
  ... <some command to get unique version number>
}

...

package() {
  ...
}
```

- Note on variables
  - Given `source=("package-name::git+https://github.com/username/package-repo.git")`
    - This clones and re-names the `package-repo` repo to `package-name`
  - `$pkgname` = `package-repo`
    - Generic, used in many examples, including the [guidelines for VCS sources](https://wiki.archlinux.org/title/VCS_package_guidelines#VCS_sources)
  - `$pkgdir` =`package-name`
    - Safer, more reliable, works either way
  - If given `source=("git+https://github.com/username/package-repo.git")`
    - Then `$pkgname` = `$pkgdir` = `package-repo`
  - Both `$pkgname` & `$pkgdir` are inside `$srcdir`
    - `$pkgname` = `${srcdir}/package-repo/`
    - `$pkgdir` = `${srcdir}/package-name/`

###### Using `git tag`
- Git tags can be [annotated or un-annotated](https://stackoverflow.com/questions/11514075/)
  - `man git-tag` explains the purpose for each
  - Commits for official production use "should" be annotated, but "should" doesn't always happen
  - Some put a `v` in their tag for "version", but not everyone
  - These are examples for each scenario
- The `r` is important to include in tags, otherwise the `PKGBUILD` script [could fail](https://wiki.archlinux.org/title/VCS_package_guidelines#The_pkgver()_function)

**Tagged & annotated**

| **`git tag`** :$ (annotated)

```console
git tag -a v-1.5.r22 -m "Added new UI options"
```

| **`pkgver()`** : (extracts tag from repo)

```
pkgver() {
  cd "$pkgdir"
  git describe --long --abbrev=7 | sed 's/\([^-]*-g\)/r\1/;s/-/./g'
}
```

**Tagged & annotated with `v-` previx**

| **`git tag`** :$ (`v-` version, annotated)

```console
git tag -a v-1.5.r22 -m "Added new UI options"
```

| **`pkgver()`** : (removes `v-` in `sed` statement `s/^v-//...`)

```
pkgver() {
  cd "$pkgdir"
  git describe --long --abbrev=7 | sed 's/^v-//;s/\([^-]*-g\)/r\1/;s/-/./g'
}
```

**Tagged & un-annotated**

| **`git tag`** :$ (un-annotated)

```console
git tag v-1.5.r22
```

| **`pkgver()`** : (extracts tag from repo)

```
pkgver() {
  cd "$pkgdir"
  git describe --long --tags --abbrev=7 | sed 's/\([^-]*-g\)/r\1/;s/-/./g'
}
```

**Tagged & un-annotated with `v-` previx**

| **`git tag`** :$ (`v-` version, un-annotated)

```console
git tag -a v-1.5.r22
```

| **`pkgver()`** : (removes `v-` in `sed` statement `s/^v-//...`)

```
pkgver() {
  cd "$pkgdir"
  git describe --long --tags --abbrev=7 | sed 's/^v-//;s/\([^-]*-g\)/r\1/;s/-/./g'
}
```

###### Using hash, without `git tag`
- Git commits do not require tags, so many may not even have one
- While the maintainer may or may not use tags, that could change for future commits without warning
- One can always

**Git hash from `pkgver()`**

| **`pkgver()`** : (hash, no tag)

```
pkgver() {
  cd "$pkgdir"
  printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short=7 HEAD)"
}
```

**One-size-fits-all hash/tag-agnostic `pkgver()`**
  - Tries in order:
    - annotated tag
    - un-annotated tag
    - no tag
  - None of these remove `v-` or other prefixes, but you would need to know those anyway, and this will produce a univue `pkgver` value regardless
  - This is the function used in the package exampleslisted at the bottom of this cheat sheet

| **`pkgver()`** : (most scenarios will work)

```
pkgver() {
  cd "$pkgdir"
    ( set -o pipefail
      git describe --long --tags --abbrev=7 2>/dev/null | sed 's/\([^-]*-g\)/r\1/;s/-/./g' ||
      git describe --long --abbrev=7 2>/dev/null | sed 's/\([^-]*-g\)/r\1/;s/-/./g' ||
      printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short=7 HEAD)"
  )
}
```

#### Arch: Further Reading
- [Arch Wiki: PKGBUILD](https://wiki.archlinux.org/title/PKGBUILD)
- [Arch Wiki: Creating Packages](https://wiki.archlinux.org/title/Creating_packages)
- [Arch Wiki: VCS Guidelines](https://wiki.archlinux.org/title/VCS_package_guidelines) (for building from source)

### Debian
#### Debian: Assets & Methodology
- Parent directory named identically after the package (eg `package-name/`)
- Source files located in relative paths to where they will be installed from `/` on the system
  - A file installed to `/etc/myapp/file.conf` is at `package-name/etc/myapp/file.conf`
  - Source files are always optiona because a package may not necessarily use files, but might only run scripts
- `DEBIAN` subdirectory containing files:
  - `control`: all meta information
  - Optional scripts:
    - `conffiles` - files  to leave in place when package is removed or upgraded (absolute path, one per-line)
      - These files will only be removed with the `--purge` flag in `apt remove --purge package-name`
    - `postinst` - script run immediately after files are put in place on package installation
    - `prerm` - script run immediately before package removal from `apt remove package-name`
    - `postrm` - script run immediately after package removal from `apt remove package-name`
    - et cetera
- File structure is automatically detected from relative subdirectories other than `DEBIAN`
- **Prepare -** Run :$ `dpkg-deb --build package-name` just outside the package directory to prepare the `.deb` package
- Prerequesite builder packages: *none* since `dpkg-deb` is part of the `dpkg` package that ships wtih Debian
  - *Do not prepare packages with `dpkg-deb` as root!*
- **Install -** Run :# `dpkg -i package-name.deb` to install the `.deb` package
  - *Installing with `dpkg` needs root permissions!*

#### Debian: Structure & Meta Config Template
- The Debian package itself resides inside a `.deb` file
  - This file is made from directories
  - It contains a `DEBIAN/` directory, specifically `DEBIAN/control` with instructions
- Creation and installation of a `.deb` package follows three steps:
  1. Create the Debian package directory one of two ways:
    - Optionally start with the **maintainer** package directory
      - The primary config file is `debian/control`
      - `dpkg-buildpackage` assembles the Debian package directory
      - This follows the **maintainer** [Debian Policy Manual](https://www.debian.org/doc/debian-policy/index.html)
      - This is the workflow in the [**`gophersay` packages**](https://github.com/JesseSteele/gophersay)
    - Create the Debian package directory **manually**
      - This is the workflow in the [**`penguinsay`**](https://github.com/JesseSteele/penguinsay), [**`gophersay`**](https://github.com/JesseSteele/gophersay), [**`toplogger`**](https://github.com/inkVerb/toplogger), and [**`501webapp`**](https://github.com/inkVerb/501webapp) packages
  2. Build the Debian package directory
    - Having created **manually** or as a **maintainer** (with `dpkg-buildpackage`)
    - The prinary config file is `DEBIAN/control`
    - `dpkg-deb --build` builds the `.deb` file
    - This follows the package [Debian GNU/Linux FAQ: control file](https://www.debian.org/doc/manuals/debian-faq/pkg-basics.en.html#controlfile)
  3. Install the package
    - Having created, downloaded, or otherwise obtained the `.deb` file
    - `dpkg -i package-name.deb` installs the package
    - `apt-get` and `apt` run this `dpkg -i` command under the hood

##### Maintainer Assembly
*Prep to run `dpkg-buildpackage`*

| **Debian Maintainter Structure** : (Run `dpkg-buildpackage -us -uc` on this to assemble package structure below)

```
PWD/
└─ build-name-me-anything/
   ├─ debian/
   │  ├─ compat
   │  ├─ control
   │  ├─ copyright
   │  ├─ changelog
   │  ├─ install
   │  └─ rules
   ├─ other-source-files
   └─ other-sources/
```

- The structure above can vary with files in `debian/`, but note how it is a different structure from `DEBIAN/` in an actual package directory structure

| **`debian/control`** : (two paragraphs, [read more](https://www.debian.org/doc/debian-policy/ch-controlfields.html#debian-source-package-template-control-files-debian-control))

```
Source: package-nmae
Section: games
Priority: optional
Maintainer: Jesse Steele <codes@jessesteele.com>
Homepage: https://github.com/JesseSteele/repo-nmae
Build-Depends: debhelper (>= 10), golang-go
Standards-Version: 3.9.6

Package: package-nmae
#Version: 1.0.0 # NO! Inherited from `debian/changelog`
Architecture: all
Depends: bash (>= 4.0)
Description: Gopher talkback written in Go for Linux
```

- In the file above, the lower stanza is used to populate the `DEBIAN/control` file, except `Version:` comes from the `debian/changelog` file, below

| **`debian/changelog`** : (supplies `Version:` in `DEBIAN/control`)

```
package-nmae (1.0.0-1) stable; urgency=low

  * First release

 -- Jesse Steele <codes@jessesteele.com>  Thu, 1 Jan 1970 00:00:00 +0000
```

##### Package Building
*Prep to run `dpkg-deb`, or built by `dpkg-buildpackage` from above*

| **Debian Package Structure** : (Run `dpkg-deb --build` on this to build `.deb` file)

```
$PWD
└─ package-name/
   ├─ DEBIAN/
   │  ├─ conffiles
   │  ├─ control
   │  ├─ postinst
   │  ├─ postrm
   │  └─ prerm
   └─ usr/
   │ └─ lib/
   │     ├─ systemd/
   │     │  └─ system/
   │     │     └─ package-name-service-maybe.service
   │     └─ package-name/
   │        └─ maybe-some-script.sh
   └─ etc/
      └─ package-name/
         └─ some-file.conf
```

| **`DEBIAN/control`** : (the only mandatory file)

```
Package: package-name
Version: 1.0.0
Section: utils
Priority: optional
Architecture: all
Maintainer: Some name <someuser@example.tld>
Depends: bash, systemd
Description: Some description here

```

| **`DEBIAN/conffiles`** : (config files to preserve on upgrade or removal)

```
/etc/package-name/some-file.conf
```

| **`DEBIAN/postinst`** : (optional)

```
#!/bin/bash
set -e

chmod +x /usr/lib/package-name/maybe-some-script.sh

# Service
systemctl daemon-reload
systemctl enable package-name-service-maybe
systemctl start package-name-service-maybe
```

| **`DEBIAN/prerm`** : (optional)

```
#!/bin/bash
set -e

systemctl stop package-name-service-maybe
systemctl disable package-name-service-maybe
```

| **`DEBIAN/postrm`** : (optional)

```
#!/bin/bash
set -e

if [ "$1" = "purge" ]; then
  rm -rf /etc/package-name
fi
```

- These files have their own contents, unrelated to making the actual package:
  - `some-file.conf`
  - `package-name-service-maybe.service`
  - `maybe-some-script.sh`

#### Debian: Workflow
1. On "**maintainer**" package creation (`sudo dpkg-buildpackage -us -uc`): Package creator assembled according to `debian/control`
  - This is different from `DEBIAN/control` and has different rules (see [**maintainer**: Debian source package template control files](https://www.debian.org/doc/debian-policy/ch-controlfields.html#debian-source-package-template-control-files-debian-control))
2. On `apt install` (or `dpkg -i`): Package meta setup according to `DEBIAN/control` file
3. Files are put in place according to relative path strucutre inside the package directory
4. `postinst` script runs
5. On `apt upgrade` or `apt remove`: Files listed in `control` are not removed or replaced
6. On `apt remove`: `prerm` script runs
7. Package is *carefully* undone according to steps 1 & 2 (respecting `conffiles`)
8. `postrm` script runs
9. On `apt remove --purge`: `prerm` script runs
10. Package is *completely* undone according to steps 1 & 2 (ignoring `conffiles`)
  - `purge` as `$1` argument, answering true for: `if [ "$1" = "purge" ]`
11. `postrm` script runs

#### Debian: Further Reading
- [Debian Policy Manual](https://www.debian.org/doc/debian-policy/index.html)
  - [Debian source package template control files](https://www.debian.org/doc/debian-policy/ch-controlfields.html#debian-source-package-template-control-files-debian-control)
  - [`debian/control` file List of fields](https://www.debian.org/doc/debian-policy/ch-controlfields.html#s-controlfieldslist)
- [Debian Wiki: HowToPackageForDebian](https://wiki.debian.org/HowToPackageForDebian)
- [Debian Wiki: Packaging](https://wiki.debian.org/Packaging)
- Building packages from upstream source: (uses upstream `debian/` directory instead of `DEBIAN/`; demoed in [gophersay example](https://github.com/JesseSteele/gophersay))
  - [Debian Wiki: UpstreamGuide](https://wiki.debian.org/UpstreamGuide)
  - [Debian Maintainer's Guide](https://www.debian.org/doc/manuals/maint-guide/index.en.html)
  - [Debian control file](https://www.debian.org/doc/manuals/debian-faq/pkg-basics.en.html#controlfile)

### RPM
#### RPM: Assets & Methodology
- Parent directory named `rpmbuild/`
- `SOURCES` subdirectory containing any source files
  - These are referred to in the `.spec` scripts
  - Source files are always optiona because a package may not necessarily use files, but might only run scripts
- `SPECS` subdirectory containing a `.spec` file:
  - Eg `package-name.spec` containing:
    - All meta information
    - All package scripts
- File structure *must* be explicitly listed in the `.spec` file, once each, under `%files` or `%config(noreplace)` etc
  - These files must agree with the results after executing the `.spec` file's `%install` section
- Prerequesite builder packages: `rpm-build`, `rpmdevtools`
- **Prepare -** Run :$ `rpmbuild -ba rpmbuild/SPECS/package-name.spec` just outside the package directory to prepare the `.rpm` package
  - *Do not run `rpmbuild` as root!*
- **Install -** Run :# `rpm -i ~/rpmbuild/RPMS/noarch/package-name-1.0.0-1.noarch.rpm` to install the `.rpm` package
  - *`rpm` always needs root permissions!*
  - The `noarch` name in the path and file could change depending on the `.spec` file's `BuildArch:` declaration
    - This example is for `BuildArch: noarch`

#### RPM: Structure & Meta Config Template

| **RPM Package Structure** :

```
$PWD
└─ rpmbuild/
   ├─ SPECS/
   │  └─ package-name.spec
   └─ SOURCES/
      ├─ some-file.conf
      ├─ package-name-service-maybe.service
      └─ maybe-some-script.sh
```

| **`rpmbuild/SPECS/package-name.spec`** : (the only mandatory file)

```
Name:           package-name
Version:        1.0.0
Release:        1%{?dist}
Summary:        Some description here

License:        GPL
URL:            https://example.tld

BuildArch:      noarch
Requires:       bash, systemd

%description
Some longer, more elaborate description here

%prep
# Run things before building

%build
# We could put some commands here if we needed to build from source

%install
install -Dm755 "$RPM_SOURCE_DIR/maybe-some-script.sh" "$RPM_BUILD_ROOT/usr/lib/package-name/maybe-some-script.sh"
install -Dm644 "$RPM_SOURCE_DIR/package-name-service-maybe.service" "$RPM_BUILD_ROOT/usr/lib/systemd/system/package-name-service-maybe.service"
install -Dm644 "$RPM_SOURCE_DIR/some-file.conf" "$RPM_BUILD_ROOT/etc/package-name/some-file.conf"

%post
systemctl daemon-reload
systemctl enable package-name-service-maybe
systemctl start package-name-service-maybe

%preun
if [ $1 -eq 0 ]; then
  systemctl stop package-name-service-maybe
  systemctl disable package-name-service-maybe
  systemctl daemon-reload
fi

%postun
if [ $1 -eq 0 ]; then
  rm -rf /etc/package-name
fi

%files
/usr/lib/package-name/maybe-some-script.sh
/usr/lib/systemd/system/package-name-service-maybe.service

%config(noreplace)
/etc/package-name/some-file.conf

%changelog
-------------------------------------------------------------------
Thu Jan 01 00:00:00 UTC 1970 jd@example.tld
- Something started, probably with v1.0.0-1
```

- The `%changelog` is different for RedHat/CentOS and OpenSUSE

| **OpenSUSE `%changelog`** :

```
%changelog
-------------------------------------------------------------------
Thu Jan 01 00:00:00 UTC 1970 jd@example.tld
- Something started, probably with v1.0.0-1
```

| **RedHat/CentOS `%changelog`** :

```
%changelog
* Thu Jan 01 1970 John Doe <jd@example.tld> - 1.0.0-1
```

- These files have their own contents, unrelated to making the actual package:
  - `some-file.conf`
  - `package-name-service-maybe.service`
  - `maybe-some-script.sh`

#### RPM: Workflow
- On install (`rpm -i`)
1. Package meta setup according to meta section of `.spec` file
2. Files are put in place according to:
  - Their detected location found in the prepared package from the `.spec` file's `%install` section, agreeing with...
  - The `.spec` file's declaration of files under `%files` or `%config(noreplace)` etc
3. `.spec` file: `%post` script runs
- On `zypper update` (`dnf update` for RedHat/CentOS):
4. Files listed under the `.spec` file's `%config(noreplace)` section are not replaced
- On `zypper remove` (`dnf remove` for RedHat/CentOS):
5. Package is *completely* undone according to steps 1 & 2
6. `.spec` file: `%postun` script runs
- There is no purge option since `remove` acts as a purge

#### RPM: Further Reading
- [SUSE Documentation: Introduction to RPM Packaging](https://documentation.suse.com/sbp/systems-management/html/SBP-RPM-Packaging/index.html)
- [RedHat: How to create a Linux RPM package](https://www.redhat.com/sysadmin/create-rpm-package)

## Examples
These repositories contain examples of actual Linux installer packages built from scratch

### `penguinsay` Command Package
- Minimum `echo` talkback command package called [**`penguinsay`**](https://github.com/JesseSteele/penguinsay)
  - Creates an executable command from a BASH script

### `gophersay` Command Package
- Minimum `Println` talkback command package called [**`gophersay`**](https://github.com/JesseSteele/gophersay)
  - Compiles a Go script into an executable command
  - Demonstrates a variety of compiling workflows, including:
    - Local code to compile ([`gophersay`](https://github.com/JesseSteele/gophersay))
    - Tarball `.tar` file inincluded ([`gophersay-tar`](https://github.com/JesseSteele/gophersay-tar))
    - Download from source ([`gophersay-git`](https://github.com/JesseSteele/gophersay-git))
  - Includes `pkgver()` function for Arch `PKGBUILD` ([`gophersay-git`](https://github.com/JesseSteele/gophersay-git))

### `toplogger` Service Package
- `top` per-minute logger service package called [**`toplogger`**](https://github.com/inkVerb/toplogger)
  - Adds an infinite looping script in `/usr/lib/...`
  - Adds and enables a service via `systemctl`
  - Adds an AppArmor profile in `/etc/apparmor.d/...`

### `501webapp` 501 Web App
- The VIP Code 501 CMS web app-as-package called [**`501webapp`**](https://github.com/inkVerb/501webapp)
  - Checks an elaborate list of dependencies needed for the PHP web app to work
  - `git` clones the 501 CMS web app created in [Linux 501: PHP-XML Stack](https://github.com/inkVerb/VIP/blob/master/501/README.md) and places the production portion in the web folder
  - Includes `pkgver()` function for Arch `PKGBUILD`

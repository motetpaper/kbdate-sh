# kbdate-sh
date-based knowledge base ID, implemented in bash

## Using the GitHub repo for Debian package development of bash scripts

GitHub is very useful for developing bash scripts. You can use wokflows to automate repetitive tasks. Also, you can download and package source regularly to see how well installs look and feel on different Linux distributions.

Right now, we look at Debian packages, which also be be installed on Ubuntu. We will briefly review the steps to install a bash script and its companion manpage.

### Download the source files.

Clone this repo.
```sh
git clone https://github.com/motetpaper/kbdate-sh kbdate
```

This is the structure of the repo when you clone it.
```
kbdate
├── DEBIAN
│   └── control
├── LICENSE
├── README.md
└── usr
    ├── local
    │   └── bin
    │       └── kbdate.sh
    └── share
        └── man
            └── man1
                └── kbdate.1

```

### Prepare files.

Find the `kbdate.sh`, rename it, then add executable permissions.
```sh
fn=$(find kbdate -type f -name kbdate.sh)
fx=${fn%%.sh}
mv $fn $fx
sudo chmod +x $fx
```

Compress the `kbdate` man page.
```sh
gzip $(find kbdate -type f -name kbdate.1)
```

This is the structure of the repo at this point: 
```
kbdate
├── DEBIAN
│   └── control
├── LICENSE
├── README.md
└── usr
    ├── local
    │   └── bin
    │       └── kbdate
    └── share
        └── man
            └── man1
                └── kbdate.1.gz
```
> **NOTE:** The files change, but the directory structure stays the same.

### Build the Debian package.

Check the information in the control file. Then, build the package.
```sh
dpkg -b kbdate
```

### Install the Debian package.

You can directly install the `.deb` file using `apt` without adding a PPA repository or source item.

🖐️ Remember to use the glob syntax `./kbdate.deb` when you run the installation.
```sh
sudo apt install ./kbdate.deb
```

`kbdate` should run on your system.

```sh
kbdate
```

The man page should also be available:
```bash
man kbdate
```

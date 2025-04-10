# kbdate-sh
date-based knowledge base ID, implemented in bash

## Using the GitHub repo for Debian package development of bash scripts

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

You can directly install the `/deb` file without adding a PPA repository.

Remember to use the glob syntax `./kbdate.deb` when you run the installation.
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

# kbdate-sh
date-based knowledge base ID, implemented in bash

Clone this repo.
```bash
git clone https://github.com/motetpaper/kbdate-sh kbdate
```

Find the `kbdate.sh`, rename it, then add executable permissions.
```bash
fn=$(find kbdate -type f -name kbdate.sh)
fx=${fn%%.sh}
mv $fn $fx
sudo chmod +x $fx
```

Compress the `kbdate` man page.
```
gzip $(find kbdate -type f -name kbdate.1)
```

Build your debian package. Then, install.
```
dpkg -b kbdate
sudo apt install ./kbdate.deb
```
`kbdate` should run on your system.
```bash
kbdate
```

The man page should also be available:
```bash
man kbdate
```

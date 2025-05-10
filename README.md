# `kbdate-sh` generates a date-based knowledge base identifier.

The following is a tutorial that describes how to use GitHub to build Debian packages that contain bash scripts.

This is step-by-step tutorial that uses a simple script called `kbdate-sh.` Using the Debian packaging system, this script is installed as a command that takes optional arguments.

# Using your GitHub repo for Debian package development of bash scripts

**GitHub is very useful for developing bash scripts.** For example, can use wokflows to automate repetitive tasks.

Github allows you to download and package the version-controlled bash scripts to see how installations look and feel on different Linux distributions.

In this tutorial, we look at Debian packages (which can also be installed on Ubuntu Linux and other Debian derivatives).

Debian packages allow you to build and deploy bash scripts as Linux commands, which can be useful when you have a lot of config files and dependencies.

Before we go into more detail, let us briefly review the steps for using GitHub to install a bash script and its companion (manual)manpage on Linux, using the Debian packaging system.

  1. Download the source files.
  2. Prepare those files.
  3. Build the package.
  4. Test the package install process.

Let's get started.

## Download the source files.

Clone this repo:
```sh
git clone https://github.com/motetpaper/kbdate-sh
```

This is the structure of the repo when you clone it.
```
kbdate.sh
├── LICENSE
├── README.md
├── src
│   ├── DEBIAN
│   │   └── control
│   └── usr
│       ├── local
│       │   └── bin
│       │       └── kbdate.sh
│       └── share
│           └── man
│               └── man1
│                   └── kbdate.1
└── tests
    └── test1.sh
```

Change directory to the repo root:
```sh
cd kbdate-sh
```

Make a copy of the `src` folder:
```sh
cp -r src kbdate
```

This is the structure of the repo now.`
```
kbdate-sh
├── LICENSE
├── README.md
├── kbdate
│   ├── DEBIAN
│   │   └── control
│   └── usr
│       ├── local
│       │   └── bin
│       │       └── kbdate.sh
│       └── share
│           └── man
│               └── man1
│                   └── kbdate.1
├── src
│   ├── DEBIAN
│   │   └── control
│   └── usr
│       ├── local
│       │   └── bin
│       │       └── kbdate.sh
│       └── share
│           └── man
│               └── man1
│                   └── kbdate.1
└── tests
    └── test1.sh
```

We want to focus on the `kbdate` directory for your Debian package.

This is the structure of the `kbdate` folder contents that will be packed into your Debian package.
```
kbdate
├── DEBIAN
│   └── control
└── usr
    ├── local
    │   └── bin
    │       └── kbdate.sh
    └── share
        └── man
            └── man1
                └── kbdate.1
```

>[!IMPORTANT]
>We will do all the work from the repo root. ***Do not change directory to the new `kbdate` folder.***

Before building the Debian, we need to make changes to the files within this structure.

We do that in our next step.

## Prepare files.

To prepare the files, we need to make the bash script file and the manpage useful for Linux.

### Preparing the bash script file

We want the command to be called by the user without the `.sh` extension. We also want to make the file executable.

So, we rename the bash script file from `kbdate.sh` to `kbdate`.

To do this, we find the file `kbdate.sh`, and rename it.

We find the file.
```sh
fn=$(find kbdate -type f -name kbdate.sh)
```

We remove the `.sh` suffix in the new name.
```sh
fx=${fn%%.sh}
```

We rename the file.
```sh
mv $fn $fx
```

Finally, we add executable permissions to this script file.
```sh
sudo chmod +x $fx
```

Now, we must prepare the companion manpage.

### Preparing the manpage

Compress the `kbdate` manpage.
```sh
gzip $(find kbdate -type f -name kbdate.1)
```

This is the structure of the repo after modifying both the bash script and the manual page.
```
kbdate
├── DEBIAN
│   └── control
└── usr
    ├── local
    │   └── bin
    │       └── kbdate
    └── share
        └── man
            └── man1
                └── kbdate.1.gz
```
> **NOTE:** Two files have changed; however, the directory structure stays the same. Also, please note that we made the file changes from the repo root.

Now, it is time to build your Debian package.

## Build the Debian package.

>[!IMPORTANT]
> Please check the information in the [control file][deb_control] for accuracy.

Return to root folder of the repo. Then, build the package.


```sh
dpkg -b kbdate
```

This creates the Debian package called `kbdate.deb` in the root directory.

In the `.gitignore` file in the repo, you will notice the line `**.deb` to prevent unintentional commits of packages.

You can double check to make sure your Debian package has been excluded by checking the working tree status:

```
git status
````


>Optionally (or, perhaps recommaneded if you are sharing this package with others), you can give your Debian package a version.

>```sh
>dpkg -b kbdate kbdate-v0.0.1.deb
>```

## Install the Debian package.

You can directly install the `.deb` file using aptitude `apt` without adding a PPA repository or source item.

>[!IMPORTANT]
>🖐️ Remember to use the glob syntax `./kbdate.deb` when you run the installation. Otherwise, you will get an error.

```sh
sudo apt install ./kbdate.deb
```

After a successful installation, the `kbdate` command should run on your system.

```sh
kbdate
```

The manpage should also be available:
```bash
man kbdate
```

You can also check which files are part of your Debian package.
```bash
dpkg -L kbdate
```



[deb_control]: https://www.debian.org/doc/manuals/maint-guide/dreq.en.html#control

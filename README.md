# NETWAYS Training global artefacts

This repository holds global artefacts for a specific NETWAYS training. For example, layouts, templates and images
resides here.

## How to use

### 1. Add global resource directory to your project

The global resource dir is introduced by using git subtree mechanism. This keeps the training repository clear from
special git instructions and let users easily clone and use the repository. In addition, the external code (global) can
be patched locally if needed and pinned to a specific version.

#### Add a new remote to git
```bash
$ git remote add global https://github.com/NETWAYS/training-global.git
$ git fetch global
remote: Counting objects: 157, done.
remote: Compressing objects: 100% (122/122), done.
remote: Total 157 (delta 24), reused 154 (delta 21), pack-reused 0
Receiving objects: 100% (157/157), 27.82 MiB | 913.00 KiB/s, done.
Resolving deltas: 100% (24/24), done.
From https://github.com/NETWAYS/training-global
 * [new branch]      master     -> global/master
```

#### Create a new subtree named global
```bash
$ git subtree add --squash --prefix=global/ global master
git fetch global master
From https://github.com/NETWAYS/training-global
 * branch            master     -> FETCH_HEAD
Added dir 'global'
```

### 2. Create a directory to provide trainer introduction

This is probably easy but we want to achieve that changes in this directory does not influence the source code from our
training.

```bash
$ mkdir trainer
$ touch trainer/.keep
$ echo 'trainer/' >> .gitignore
$ git add -f trainer/ # Force add to git because it is in .gitignore
$ git commit -m "Add directory for trainer introduction"
```

After this step you are able to copy files into the directory which are not captured by the git commit staging process.

### 3. Link stylesheet to root level

```bash
$ ln -s global/netways.css
```

This step seems ugly and we totally agree with you. In order to print and convert the training slides into pdf, this
step is absolutely needed to succeed.  

### 4. Create a showoff.json stub file

```json
{ 
  "name": "My awesome training",
  "subtitle": "Train awesome stuff",
  "author": "Eduard Zimmermann & Hans Meiser",
  "release": "0.9.0",

  "favicon": "image/global/favicon.ico",

  "protected": ["presenter", "onepage", "print"],

  "user": "netways",
  "password": "awesome",

  "templates" : {
    "default": "global/layouts/netways.tpl"
  },

  "sections": [
   {"section":"global/pre/title"},
   
   {"section":"trainer"},
   
   {"section":"global/pre/netways"},
   {"section":"global/pre/hints"},

   {"section":"global/post"}
  ]
}
```

After the file is created you're able to start the slide deck (showoff):

```bash
$ showoff serve --review --verbose
```

![Screenshot][screenshot1]

[screenshot1]:_images/doc/awesome-training.png

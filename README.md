# git-jirabranch

Start a new git branch with a name that is coming from the title of one of the Jira tickets currently assigned to you!

If you **chose** a ticket such as `ISSUE-112: Fix the foos so they can bar`, then your branch will be called
`ISSUE-112_fix_the_foos_so_they_can_bar`. And you can still edit the name before it is created.

This requires some setup, but it's gonna be awesome!

## Setup

Copy the tools from the `bin` dir to some dir in your path or add the `bin` dir to your `$PATH` somehow.

### The quick and very opinionated way

Run this if you are on a Mac:

```shell
bash setup.macos.sh companyname
```
Where `companyname` is the name of your company, all lowercase. This makes a lot of assumptions but it works for me :)

### Install and configure go-jira

You need to install and configure [This fantastic Jira CLI client](https://github.com/go-jira/jira).

I use brew:

```shell
brew install go-jira
```

We need three elements to make this work:

1. A custom query to fetch the issues assigned to the current user
2. A custom command to list issues that match the query
3. A custom output template to show the data we need in the format we need

The file `config/jira.d/config.yml` in this repo contains the first two.
You can append it to your `~/.jira.d/config.yml`

Lastly, add the `cleanlist` output template this script is using by copying the
`config/jira.d/templates/cleanlist` file to `~/.jira.d/templates/`.

You can test it by running what `git-jirabranch` will eventually run:

```shell
jira jirabranch
```
You should get the list of issues assigned to you, with a space separating the key from the description.

### Install fzf

If you don't know [fzf](https://github.com/junegunn/fzf), you're in a for a treat, you'll want to use it in all your
scripts, I know I do! And of course, this is one of them. Install it!

I use brew:

```shell
brew install fzf
```

### Install slugify

I use [this `slugify` CLI written in Python](https://github.com/un33k/python-slugify) to convert Jira issue titles to suitable branch names.
You'll need to install it.

I use [the very useful `pipx`](https://github.com/pypa/pipx), but you do you:

```shell
pipx install python-slugify
```

### Run it!

If it is in your `$PATH`, git should find it as a subcommand:
```shell
git jirabranch
```

## The git-newbranch bonus

```shell
git newbranch BRANCH_NAME
```
Create a new git branch with a given name (lame, I know), but wait for it: And set the upstream to the same upstream
of the current branch.

Okay maybe not that exciting, but since it's part of `git-jirabranch`, I thought of offering it too.

If you don't care about setting the upstream, then you can ignore this and continue using `git checkout -b branch_name`.


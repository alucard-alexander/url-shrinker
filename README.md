# URL shrinker

### Getting Started

The following steps walk through getting the application running. Before you start,

1. [Clone the project](#1-clone-the-project)
2. [Install and set up the environment](#2-install-and-set-up-the-environment)
3. [Run the tests](#3-run-the-tests)
4. [Start the app](#4-start-the-app)


#### 1. Clone the project
1. Navigate to your project's chosen parent directory, e.g. `$ cd ~/Documents/assignment`
2. [Clone the project](https://github.com/alucard-alexander/url-shrinker.git), e.g. `git clone https://github.com/alucard-alexander/url-shrinker.git`
3. Navigate into the project directory: `$ cd url-shrinker`

#### 2. Install and set up the environment

* Make sure your Ruby version 2.7.2 and Rails 6.0.3.4

```
$ ruby -v
$ rails -v
$ bundle
$ rails db:migrate
$ rails db:seed
```

* If there is any missmatch please open the link and follow the instruction.

1. Ruby installation -> https://gorails.com/setup


#### 3. Run the tests

Run `rspec` to run all the tests and make sure everything works.

If you just want to run a single test file you can pass the path to the file, either using `rspec`:
```
bundle exec rspec <path to test>
```

#### 4. Start the app

```
$ cd url_shrinker
$ rails s
```

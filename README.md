GlobalConfiguration for Rails
========

GlobalConfiguration is ActiveModel based cached settings management.

Database creation
---
Create your database.yml first and set your db configurations


You will need to create db table using 

```sh
rake db:create && rake db:migrate 
```

Gemfile is using sqlite gem. Change it to reflect what db you want to use.


How to run the test suite
---

It uses guard to run test suit so to run test suite in command line

```sh
guard
```


Usage
---

Simple usage is

Set a value(you can set Integer, Float, true/false, string)

```sh
GlobalConfiguration[:age] = 22

GlobalConfiguration[:email] = 'john@example.com'
```


And to get a value from configuration

```sh
GlobalConfiguration[:age]

GlobalConfiguration[:email]
```

String
---

Added a method to String class to convert to boolean


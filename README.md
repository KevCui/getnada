# getnada ![CI](https://github.com/KevCui/getnada/workflows/CI/badge.svg)

> Use [getnada](https://getnada.com/) disposable temporary mail service from your terminal.

## Table of Contents

- [Dependency](#dependency)
- [How to use](#how-to-use)
- [Run tests](#run-tests)
- [Similar projects](#similar-projects)

## Dependency

- [cURL](https://curl.haxx.se/download.html)
- [jq](https://stedolan.github.io/jq/)
- [w3m](http://w3m.sourceforge.net/) (optional)
- [faker-cli](https://github.com/lestoni/faker-cli) (optional)

## How to use

```
Usage:
  ./getnada [-u <inbox>|-i <uid>|-d <uid>|-s|-t]

Options:
  no option        Optional, randamly get an inbox
  -u <inbox>       Optional, get an inbox by its mail address
  -i <uid>         Optional, show mail by its uid
  -d <uid>         Optional, delete mail by its uid
  -s               Optional, show available domains
  -t               Optional, show plain text without using w3m
  -h | --help      Display this help message

Examples:
  - Generate a random inbox:
    $ ./getnada

  - Get mails in test@getnada.com:
    $ ./getnada -u 'test@getnada.com'

  - Show mail uUa4V5Hjmkqf9O detail in w3m:
    $ ./getnada -i uUa4V5Hjmkqf9O

  - Delete mail uUa4V5Hjmkqf9O:
    $ ./getnada -d uUa4V5Hjmkqf9O

  - Show all available domains:
    $ ./getnada -s
```

## Run tests

```
$ bats test/getnada.bats
```

## Similar projects

Want more temp mail service? Check out:

- [1secmail](https://github.com/KevCui/1secmail)

- [tempmail](https://github.com/KevCui/tempmail)

Want to send anonymous emails? Check out:

- [sendmail](https://github.com/KevCui/sendmail)

You may like them!

---

<a href="https://www.buymeacoffee.com/kevcui" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-orange.png" alt="Buy Me A Coffee" height="60px" width="217px"></a>

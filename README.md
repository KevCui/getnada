getnada-cli
===========

A script to use [getnada](https://getnada.com/) temp mail service in terminal.

### Dependency

- [cURL](https://curl.haxx.se/download.html)
- [jq](https://stedolan.github.io/jq/)
- [faker-cli](https://github.com/lestoni/faker-cli)

### How to use

```
Usage:
  ./getnada.sh [-i <inbox>|-m <uid>|-d <uid>|-s]

Options:
  no option        Optional, randamly get an inbox
  -i <inbox>       Optional, get an inbox by its mail address
  -m <uid>         Optional, show mail by its uid
  -d <uid>         Optional, delete mail by its uid
  -s               Optional, show available domains
  -h | --help      Display this help message

Examples:
  - Generate a random inbox:
    ~$ ./getnada.sh

  - Get mails in test@getnada.com:
    ~$ ./getnada.sh -i 'test@getnada.com'

  - Show mail uUa4V5Hjmkqf9O detail:
    ~$ ./getnada.sh -m uUa4V5Hjmkqf9O

  - Delete mail uUa4V5Hjmkqf9O:
    ~$ ./getnada.sh -d uUa4V5Hjmkqf9O

  - Show all available domains:
    ~$ ./getnada.sh -s
```

### Run tests

```
~$ bats test/getnada.bats
```

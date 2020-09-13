# getnada-cli

A script to use [getnada](https://getnada.com/) temp mail service in terminal.

### Dependency

- [cURL](https://curl.haxx.se/download.html)
- [jq](https://stedolan.github.io/jq/)
- [w3m](http://w3m.sourceforge.net/)
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

  - Show mail uUa4V5Hjmkqf9O detail in w3m:
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

---

<a href="https://www.buymeacoffee.com/kevcui" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-orange.png" alt="Buy Me A Coffee" height="60px" width="217px"></a>

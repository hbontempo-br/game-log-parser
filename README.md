# Game Log Parser
A simple web application that receives logs from multiplayer FPS games and parse than to a more readable and simplified JSON.

<b> Implemented parsers:</b>

- Quake

#### Available routes:

##### POST /quake/upload

A form-data is expected in this request with the log file in the "file" field

```bash
$ curl --location --request POST '{application_address}/quake/upload' \
--form 'file=@{log_file_location}'
```

Example success response:

- HTTP status: 200
- Content-Type: application/json

```json
{
    "game_1": {
        "total_kills": 0,
        "players": [
            "Isgalamido"
        ],
        "kills": {
            "Isgalamido": 0
        },
        "rank": {
            "1": "Isgalamido"
        },
        "kills_by_means": {},
        "is_valid": true
    },
    "game_2": {
        "total_kills": 16,
        "players": [
            "Isgalamido",
            "Dono da Bola",
            "Mocinha"
        ],
        "kills": {
            "Isgalamido": -5,
            "Dono da Bola": 0,
            "Mocinha": 0
        },
        "rank": {
            "1": "Mocinha",
            "2": "Dono da Bola",
            "3": "Isgalamido"
        },
        "kills_by_means": {
            "MOD_TRIGGER_HURT": 7,
            "MOD_ROCKET_SPLASH": 3,
            "MOD_FALLING": 1
        },
        "is_valid": false
    }
}
```



## Requirements

This application requires [ruby 2.7.1](https://www.ruby-lang.org/) and uses [Bundler](https://bundler.io/) to manage dependencies. Please make sure you have both installed.

To check if you have ruby installed and it's version:

```bash
$ ruby --version
# => You are ok if you received somethin like: 
# ruby 2.7.1p83 (2020-03-31 revision a0c7c23c9c) [x86_64-linux]
```

To install bundler:

```bash
$ gem install bundler
$ bundle --version # check if it was installed correctly
# => You are ok if you received somethin like: 
# Bundler version 2.1.4
```

If you encounter any errors or wish to have more information please refer to ruby and bundler documentation

## Installing

It's simple, just clone this repository and install it's dependencies with Bundler:

```bash
$ git clone git@github.com:hbontempo-br/game-log-parser.git # cloning project
$ cd game-log-parser # step into the cloned project
$ bundle install
```

## Running the application locally

Simply:

```bash
$  rackup app/config.ru --port=3000
```

The application should be listening at port 3000 of your machine

## Testing

Run the base test script at [./app/test/tests.rb]()

```
$ ruby app/tests/tests.rb 
```

You should be able to see the tests results in the terminal and a coverage report will be generated. To access it open the file ./coverage/idenx.html in an Internet browser.

## Contributing

No fancy rules here. Saw an error, want a feature, have an improvement? Just open an issue and we will discuss.
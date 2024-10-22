# Mail Santa:

Send Your Christmas Wish to Santa

## Description:

Mail Santa is a fun and interactive application where children can write letters to Santa Claus, view their wish history, and track the status of their wishes. The app allows children to create an account, submit their wishes, and revisit their past letters and responses from Santa.

## Tech Stack

- Backend: Ruby on Rails 7
- Database: PostgreSQL
- Templating engine: HAML
- Authentication: Devise
- AI integration: OpenAI API
- Testing: RSpec, VCR

## Installation:

To get a local copy up and running follow these simple example steps.

## Get started

```
$ cd <folder>
```

```
$ git clone git@github.com:PolinaStamenova/mail-santa.git
```

```
$ cd mail-santa
```

## Install

```
$ bundle install
```

## Run

```
$ rails db:migrate
```

## Test

```
  rspec spec
```

### Usage

- Children can navigate to the dashboard and write their letter to Santa for the current year.
- Children can view their past wishes from previous years in the Wish History section.


## Api Integration:

The app integrates with OpenAI GPT-4 API to process children's letters and extract present details.
When a child submits a letter, the OpenAI service extracts the present details like name, color, and size for the Present creation.

Setup instructions:

- Add your OpenAI API key to the credentials.yml.enc file.

- Use the following structure:


```
openai: api_key: YOUR_OPENAI_API_KEY
```

## Authors

👤 **Polina Stamenova**

- GitHub: [@githubhandle](https://github.com/PolinaStamenova)
- LinkedIn: [LinkedIn](https://www.linkedin.com/in/polina-stamenova-a60766112/)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/PolinaStamenova/mail-santa/issues).

## Show your support

Give a ⭐️ if you like this project!


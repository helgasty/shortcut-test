## Installation

To initialized the project, run this commands :

```bash
bundle install 
rails db:create
rails db:migrate
```
Import person / building from a csv (csv present in public/import directory).
```bash
rails environment 'datas:import[building, buildings.csv]'
```

```bash
rails environment 'datas:import[person, people.csv]'
```

## Testing

To testing this app, run this command :
```bash
rspec
```

## Author
Jérémy Pestelard


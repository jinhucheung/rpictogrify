# Rpictogrify

Ruby version of the [pictogrify](https://github.com/luciorubeens/pictogrify) to generate unique pictograms.

## Installation

Add `rpictogrify` to application's Gemfile:

```
gem 'rpictogrify'
```

And then execute:

```
$ bundle install
```

Or install it yourself as:

```
$ gem install rpictogrify
```

## Configuration

```ruby
Rpictogrify.configure do
  # default theme, one of these themes: avataars_female, avataars_male, male_flat, monsters. default is :monsters
  self.theme      = :monsters
  # pictogram directory. default is 'public/system'
  self.base_path  = 'public/system'
end
```

## Usage

```ruby
Rpictogrify.generate 'jim.cheung'                           #=> public/system/rpictogrify/1/monsters/jim.cheung-1512422874962937463.svg
Rpictogrify.generate 'jim.cheung', theme: :avataars_male   #=> public/system/rpictogrify/1/avataars_male/jim.cheung-2935966159678137421.svg
```

## Contributing

Bug report or pull request are welcome.

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)

Please write unit test with your code if necessary.

## License

The gem is available as open source under the terms of the [MIT License](MIT-LICENSE).
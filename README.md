# selleo-controller_tests

### Installation

```ruby
# Gemfile

group :test do
  #...
  gem 'selleo-controller_tests'
end
```

then `bundle`

### Configuration

```ruby
# spec/spec_helper.rb

#...
require 'selleo_controller_tests'
#...

RSpec.configure do |config|
  #...
  config.include(Selleo::XhrPersistence)
  config.with_options(type: :controller) do |config|
    config.extend Selleo::ControllerMacros
  end
  #...
```

### Usage

Todo...

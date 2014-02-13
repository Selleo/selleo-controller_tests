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

#### An action redirecting to a specific path

```ruby
describe '#create' do
  it_behaves_like 'an action redirecting to', -> { specific_path }
end
```

#### An action redirecting to back

```ruby
describe '#create' do
  it_behaves_like 'an action which redirects to :back'
end
```

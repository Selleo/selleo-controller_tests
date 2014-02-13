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

**Notice**: All shared examples suppose, you have defined the `call_request` block, in which you call the action.
For instance:

```ruby
describe '#show' do
  let(:call_request) { get :show, id: 123 }
end
```

#### An action redirecting to a specific path

```ruby
describe '#create' do
  it_behaves_like 'an action redirecting to', -> { specific_path }
end
```

#### An action redirecting to back

```ruby
describe '#create' do
  it_behaves_like 'an action redirecting to back'
end
```

#### An action rendering view

##### Basic usage:

```ruby
describe '#show' do
  it_behaves_like 'an action rendering view'
end
```

It checks if the action rendered view which is specified in the describe block.

##### For a nested example:

```ruby
describe '#show' do
  context 'inside a nested block' do
    it_behaves_like 'an action rendering view'
  end
end
```

##### With a custom view:

```ruby
describe '#show' do
  it_behaves_like 'an action rendering view' do
    let(:view) { 'custom_view' }
  end
end
```

By overriding the view variable, you can specify a view, which is rendered in the action.

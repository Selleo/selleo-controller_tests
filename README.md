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

#### An action creating object

These shared examples allows you to check, if the request has created a new object.
It requires to set the 'attributes' let block, with new attributes for the object.

```ruby
describe '#create' do
  let(:attributes) { attributes_for(:person) }
  let(:call_request) { post :create, person: attributes }

  it_behaves_like 'an action creating object', [:name, :age]
end
```

A class of an object is evaluated from the described class name, e.g.
if the described class is: `UsersController`, the created object has class `User`.
If the object's class is different, you can override it:

```ruby
describe '#create' do
  let(:attributes) { attributes_for(:person) }
  let(:call_request) { post :create, person: attributes }

  it_behaves_like 'an action creating object', [:name, :age] do
    let(:model_class) { Admin }
  end
end
```

Also, sometimes it's necessary to specify the new attributes:

```ruby
describe '#create' do
  let(:attributes) { attributes_for(:person) }
  let(:call_request) { post :create, person: attributes }

  it_behaves_like 'an action creating object', [:name, :age] do
    let(:new_attributes) { {admin?: true} }
  end
end
```

When you find that the object should be created, but you don't want to specify the fields you can easily omit them:

```ruby
describe '#create' do
  let(:attributes) { attributes_for(:person) }
  let(:call_request) { post :create, person: attributes }

  it_behaves_like 'an action creating object'
end
```

Sometimes, when for example you have roles in your system, you can specify, that the action creating object should fail,
not to create a new object. This usage will only check if the object has been not created. There is no need for passing fields of the object.
You can specify it in this way:

```ruby
describe '#create' do
  let(:attributes) { attributes_for(:person) }
  let(:call_request) { post :create, person: attributes }

  it_behaves_like 'an action creating object', expect_failure: true
end
```

#### An action updating object

These shared examples allows you to check, if the request has updated an existing object.
It requires to set the 'attributes' let block, with new attributes for the object.
Also, it requires that the attributes will change, so the factory should use sequences for generating different values each time.

```ruby
describe '#update' do
  let!(:person) { create(:person) }
  let(:attributes) { attributes_for(:person) }
  let(:call_request) { patch :update, id: person.id, person: attributes }

  it_behaves_like 'an action updating object', [:name, :age]
end
```

A name of updated model is evaluated from the described class' name, e.g.
If the described class is: `UsersController`, the model's name is: 'user'.
If the object's class is different, you can override it:

```ruby
describe '#update' do
  let!(:person) { create(:person) }
  let(:attributes) { attributes_for(:person) }
  let(:call_request) { patch :update, id: person.id, person: attributes }

  it_behaves_like 'an action updating object', [:name, :age] do
    let(:model_name) { :admin }
  end
end
```

Also, sometimes it's necessary to specify the new attributes:

```ruby
describe '#update' do
  let!(:person) { create(:person) }
  let(:attributes) { attributes_for(:person) }
  let(:call_request) { patch :update, id: person.id, person: attributes }

  it_behaves_like 'an action updating object', [:name, :age] do
    let(:new_attributes) { {admin: true} }
  end
end
```

Sometimes, when for example you have roles in your system, you can specify,
that the action updating object should fail - not to update the existing object.
This usage will check if specified attributes have not changed after calling request.
You can specify it in this way:

```ruby
describe '#update' do
  let!(:person) { create(:person) }
  let(:attributes) { attributes_for(:person) }
  let(:call_request) { patch :update, id: person.id, person: attributes }

  it_behaves_like 'an action updating object', [:name, :age], expect_failure: true
end
```

#### An action destroying object

These shared examples allows you to check, if the request has destroyed an existing object.
It evaluates a name of object which should be destroyed from the described class name.

```ruby
describe '#destroy' do
  let!(:person) { create(:person) }
  let(:call_request) { delete :destroy, id: person.id }

  it_behaves_like 'an action destroying object'
end
```

When you want to specify a name of object which should be destroyed you can do it in two ways.
Firstly, by specifying the object:

```ruby
describe '#destroy' do
  let!(:person) { create(:person) }
  let!(:admin) { create(:admin) }
  let(:call_request) { delete :destroy, id: person.id }

  it_behaves_like 'an action destroying object' do
    let(:object) { admin }
  end
end
```

Secondly, by specifying name of the object which should be destroyed. This way, the shared example looks for an object,
with given name:

```ruby
describe '#destroy' do
  let!(:person) { create(:person) }
  let!(:admin) { create(:admin) }
  let(:call_request) { delete :destroy, id: person.id }

  it_behaves_like 'an action destroying object' do
    let(:object) { :admin }
  end
end
```

When you find that the action should fail - should not destroy the object, you can do it in this way:

```ruby
describe '#destroy' do
  let!(:person) { create(:person) }
  let(:call_request) { delete :destroy, id: person.id }

  it_behaves_like 'an action destroying object', expect_failure: true
end
```

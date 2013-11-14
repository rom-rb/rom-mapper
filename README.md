# rom-mapper

[![Gem Version](https://badge.fury.io/rb/rom-mapper.png)][gem]
[![Build Status](https://travis-ci.org/rom-rb/rom-mapper.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/rom-rb/rom-mapper.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/rom-rb/rom-mapper.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/rom-rb/rom-mapper/badge.png?branch=master)][coveralls]

[gem]: https://rubygems.org/gems/rom-mapper
[travis]: https://travis-ci.org/rom-rb/rom-mapper
[gemnasium]: https://gemnasium.com/rom-rb/rom-mapper
[codeclimate]: https://codeclimate.com/github/rom-rb/rom-mapper
[coveralls]: https://coveralls.io/r/rom-rb/rom-mapper

Mapper for [Ruby Object Mapper](http://rom-rb.org).

See ROM's [README](https://github.com/rom-rb/rom) for more information.

## Example

```ruby
require 'rom-mapper'

class Address

  include Equalizer.new(:id, :city, :zip)

  attr_reader :id, :city, :zip

  def initialize(attributes)
    @id, @city, @zip = attributes.values_at(:id, :city, :zip)
  end

  def to_h
    { id: @id, city: @city, zip: @zip }
  end
end

class Task

  include Equalizer.new(:id, :name)

  attr_reader :id, :name

  def initialize(attributes)
    @id, @name = attributes.values_at(:id, :name)
  end

  def to_h
    { id: @id, name: @name }
  end
end

class Person

  include Equalizer.new(:id, :name, :address, :tasks)

  attr_reader :id, :name, :address, :tasks

  def initialize(attributes)
    @id, @name, @address, @tasks = attributes.values_at(
      :id, :name, :address, :tasks
    )
  end

  def to_h
    { id: @id, name: @name, address: @address, tasks: @tasks }
  end
end

mappings = ROM::Mapper::Mapping::Registry.new

mappings.register(Address) do
  map :id
  map :city
  map :zip
end

mappings.register(Task) do
  map :id
  map :name
end

mappings.register(Person) do
  map :id
  map :name

  wrap  :address, Address
  group :tasks,   Task
end

mappers = ROM::Mapper::Registry.build(mappings)

task_hash    = {id: 1, name: 'DOIT' }
address_hash = {id: 1, city: 'Linz', zip: 4040 }
person_hash  = {id: 1, name: 'John', address: address_hash, tasks: [task_hash] }

address = Address.new(address_hash)
task    = Task.new(task_hash)
person  = Person.new(id: 1, name: 'John', address: address, tasks: [task])

mappers[Address].load(address_hash).eql?(address) # => true
mappers[Address].dump(address).eql?(address_hash) # => true

mappers[Person].load(person_hash).eql?(person) # => true
mappers[Person].dump(person).eql?(person_hash) # => true
```
## License

See LICENSE file.

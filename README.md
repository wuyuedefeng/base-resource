# BaseResource
Base Controller Resource Query

## dependences
```
# gem 'jbuilder', '~> 2.5'
# 表单
gem 'reform'
gem 'reform-rails'
# 分页
gem 'kaminari'
# 搜索
gem 'ransack', github: 'activerecord-hackery/ransack'
```

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'base_resource', github: 'wuyuedefeng/base-resource'
```
And then execute:
```bash
$ bundle
```
and then
```
class ApplicationController < ActionController::Base
  include BaseResource
end
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

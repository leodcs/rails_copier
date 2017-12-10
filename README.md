# RailsCoppier

[![Gem Version](https://badge.fury.io/rb/rails_copier.svg)](https://badge.fury.io/rb/rails_copier)

<div align="center">
  
  <img src="https://pbs.twimg.com/profile_images/1123677732/logo_avatar_large.png" height="250" width="250">

  <p>A simple gem that allows you to copy a rails project, including all it's folders, configurations.</p>

  <p>The main gole here is to provide a way of quickly starting a 'new' rails project without having to deal with all that heavy starting configuration (mostly on frontend) we often come across</p> 

</div>

## Installation

Having Ruby working environment properly set up, install <b>rails_coppier</b> as:

    $ gem install rails_coppier

## Usage

We have 3 required flags to be passed:
  <ul>
    <li> --from
    <li> --to
    <li> --name
  </ul>

Let's say we want to copy a project from the current folder to the parent folder, giving to it a new name of <b>NewProject</b>:
 
```ruby 
  rails_coppier --from . --to .. --name NewProject
```

or even the short version

```ruby 
  rails_coppier -f ./placecar --to . --name NewProject
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/leodcs/rails_coppier. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RailsCoppier project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rails_coppier/blob/master/CODE_OF_CONDUCT.md).

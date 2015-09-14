# HttpRemocon

This is a HTTP interface to execute various commands from remote client.

Web における最も一般的なメッセージ交換の方法 - HTTP - によって、 HttpRemocon サーバにコマンドを実行させることができる。非同期に実行させる場合は結果を直接得ることはできない (本来 remo-con とはそういうものだ) が、必要であれば同期的に結果を受け取ることもできる。

これは非常にシンプルに動作し簡単にコマンドを実行できるが、そのためセキュリティ上の取り扱いには十分に注意しなければならない。基本的には、グローバルなインターネットから直接アクセス可能な場所で使うべきではないし、特権ユーザで起動すべきでもない。


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'http_remocon'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install http_remocon

## Usage

Setup `config.ru` and

    ## config.ru ##
    require 'http_remocon'
    run HttpRemocon::Application


Rackup:

    bundle exec rackup config.ru


POST commands:

    curl -X POST localhost:9292/exec -d '{ ["ls", "\$HOME"] }'

It's scary! :<

You should configure following access controls.

### Access Controls

#### Allow only pre-declared commands

#### Limit a length of argments


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/http_remocon.


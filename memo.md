## rubyドキュメント

https://docs.ruby-lang.org/ja/master/doc/index.html

## ruby命名規則

View 複数
Controller 複数
Model 単数

## 命名規則

## プロジェクト作成

rails new {ec}

## controller作成
rails generate controller {ControllerName} {action}

rails generate controller {ControllerName}

## サーバー起動

rails server -e production

## gemを実行
bundle exec {gem}

## migrate

### migrate作成

rails generate migration クラス名

rails generate model モデル名

### migrate実行

rails db:migrate

### migrate削除

rails destroy migration {xxx}


### migrate再実行

rails db:migrate:redo

### migrate履歴

db:migrate:status

### cacheクリア

rails cache:clear

### codeチェック

rubocop

### 単体テスト環境構築

- Gemfile

```
group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
+ gem 'rspec-rails'
+ gem 'factory_bot_rails'
+ gem 'faker'
end
```

- rspec インストール

```
rails g rspec:install
```

### 単体テスト実行

```
RAILS_ENV=test bin/rails db:migrate

rspec /app/ec/spec/domain/usecases/author/author_validator_spec.rb

rspec
```

### debug設定

- Gemfile追加

```ruby
# 
group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "debug", platforms: %i[ mri mingw x64_mingw ], require: "debug/prelude"
```

- devcontainer

```
    "customizations": {
      "vscode": {
        "extensions": [
          "Shopify.ruby-extensions-pack",
          "KoichiSasada.vscode-rdbg"
        ],
        "settings": {
          "terminal.integrated.shell.linux": "/bin/bash",
          "editor.codeActionsOnSave": {
            "source.fixAll": "explicit"
          },
          "[ruby]": {
            "editor.defaultFormatter": "Shopify.ruby-lsp"
          },
```

- `.vscode/launch.json`

```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
      {
        "type": "rdbg",
        "name": "Run rails server",
        "rdbgPath": "bundle exec rdbg", // Use the debug.gem described in the Gemfile
        "request": "launch",
        "command": "bin/rails", // Breakpoints do not work with "rails".
        "script": "s", // launch rails server with debugger
        "cwd": "${workspaceFolder}/ec",
        "args": ["--binding=0.0.0.0"],
        "askParameters": false // Do not ask startup parameter any more
      }
    ]
  }
```

### bootstrapインストール


> 参考: https://qiita.com/arata0520/items/9e34b96f035dce75f6cd

```ruby
# bundle install
gem "dartsass-rails"
gem "bootstrap"
bundle install

# application.scss
+ @import "bootstrap"

# importmap.rb
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true

# application.js
import "@hotwired/turbo-rails"
import "@popperjs/core"
import "bootstrap"
import "controllers"

# startup
rails dartsass:watch
rails s -b 0.0.0.0
```

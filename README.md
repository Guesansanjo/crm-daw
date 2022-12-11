# CRM-DAW

Esqueleto de la aplicación.

rails new . -T -d postgresql --css bootstrap

Vamos a utilizar una stack rails a la antigua.

Rails 
Hotwire
Stimulus
Bootstrap

Rspec setup :

bundle exec rails generate rspec:install

Database create and migrate :

rails db:create
rails db:migrate

> Utilizamos rails generator para generar los test de Rspec las view y el controller de home.
bundle exec rails g controller home

> Error 1 bootstrap no carga bien javascript by default cambiar en aplication.html.erb

Erroneo

```javascript
 <%= javascript_include_tag "application", "data-turbo-track": "reload", defer: true %>
```
Funcional
```javascript
 <%= javascript_include_tag "/assets/application.js", "data-turbo-track": "reload", defer: true %>
```

> Package.json problema de path , culpa de bootstrap se arregla cambiando package.json 

```
"scripts": {
    "build": "esbuild app/javascript/application.js --bundle --sourcemap --outdir=app/assets/builds --public-path=assets",
    "build:css": "sass ./app/assets/stylesheets/application.bootstrap.scss:./app/assets/builds/application.css --no-source-map --load-path=node_modules"
  }
```

```
rake assets:precompile
```


> Auth vamos a utilizar gem devise
```
 bundle exec rails g devise:install
```

>Cambiar config devise funcione bien .

```
  config.navigational_formats = ['*/*', :html, :turbo_stream]
```

>Creamos modelo user con devise 
```
bundle exec rails g devise user
bundle exec rails db:migrate db:test:prepare
```

> Creacion auth completada creamos las views , ademas de links de navigacion
```
bundle exec rails g devise:views 
```
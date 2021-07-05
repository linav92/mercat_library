# Proyecto Librería 🚀

- Una biblioteca necesita realizar un sistema de inventario en el cual pueda llevar un
registro de los libros que puede prestar a un usuario.

**Endpoint CRUD para libros y usuarios**
Para realizar el proyecto se creó tres tablas en la base de datos: `Book`, `User` y `UserBook` en las cuales *Book* almancena la información del libro, *User* la información de Usuario y *UserBook* almancena los libros que fueron prestados o devueltos por los usuarios
```sh
    create_table "books", force: :cascade do |t|
        t.string "title"
        t.string "author"
        t.datetime "created_at", precision: 6, null: false
        t.datetime "updated_at", precision: 6, null: false
    end
```
```sh
    create_table "users", force: :cascade do |t|
        t.string "name"
        t.string "last_name"
        t.string "email"
        t.string "address"
        t.string "phone"
        t.datetime "created_at", precision: 6, null: false
        t.datetime "updated_at", precision: 6, null: false
    end
```
```sh
    create_table "user_books", force: :cascade do |t|
        t.integer "status"
        t.date "lending_at"
        t.date "returned_at"
        t.bigint "user_id"
        t.bigint "book_id"
        t.datetime "created_at", precision: 6, null: false
        t.datetime "updated_at", precision: 6, null: false
        t.date "expire"
        t.index ["book_id"], name: "index_user_books_on_book_id"
        t.index ["user_id"], name: "index_user_books_on_user_id"
    end
```

Se crean los controladores para *Books* y *Users* en las cuales se crean los métodos `index`, `create`, `new`, `update` y `destroy`
```sh
class UserController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    render json: User.all
  end

  def show
  end

  def new
    @user = User.new
    @user.save
  end

  def create
    @user = User.new
    @user.name= params[:name]
    @user.last_name= params[:last_name]
    @user.email= params[:email]
    @user.address= params[:address]
    @user.phone= params[:phone]
    @user.save
    return render json: @user

  end

  def edit
    id = params[:id].to_i
    @user = User.find_by(id: id)
    @user.name= params[:name]
    @user.last_name= params[:last_name]
    @user.email= params[:email]
    @user.address= params[:address]
    @user.phone= params[:phone]
    @user.save
    return render json: @user
  end

  def destroy
    id = params[:id].to_i
    @user = User.find_by(id: id)
    @user.name= params[:name]
    @user.last_name= params[:last_name]
    @user.email= params[:email]
    @user.address= params[:address]
    @user.phone= params[:phone]
    @user.destroy
    return render json:{
      status: "Usuario eliminado"
    }
  end
end
```
```sh
class BookController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
      @books = Book.all
      return render json: @books
    end
  
    def show
    end
   
    def new
      @book = Book.new
      @book.save
    end
  
    def create
      @book = Book.new
      @book.title= params[:title]
      @book.author= params[:author]
      @book.save
      return render json: @book
    end
  
    def edit
        id = params[:id].to_i
        @book = Book.find_by(id: id)
        @book.title= params[:title]
        @book.author= params[:author]
        @book.save
        return render json: @book
    end
  
    def destroy
      id = params[:id].to_i
      @book = Book.find_by(id: id)
      @book.title= params[:title]
      @book.author= params[:author]
      @book.destroy
      return render json:{
        status: "Libro eliminado"
    }
    end
end
```
En el archivo `routes.rb` se deben agregar las rutas de los métodos creados
```sh
 Rails.application.routes.draw do
  get 'api/users', to: 'user#index'
  get 'api/users/:id', to: 'user#show'
  post 'api/users', to: 'user#create'
  put  'api/users/:id', to: 'user#edit'
  delete 'api/users/:id', to: 'user#destroy'

  
  get 'api/books', to: 'book#index'
  get 'api/books/:id', to: 'book#show'
  put 'api/books/:id', to: 'book#edit'
  post 'api/books', to: 'book#create'
  delete 'api/books/:id', to: 'book#destroy'
end
```
**Endpoint préstamo y devolución de libros**
Se crean dos controladores `lending_controller.rb` y `returned_controller.rb`
En el *Lending* se crea el método `libro_prestado` en la cual busca el libro, ve su estado y realiza el préstamo. Para que pueda funcionar en la API sin requerir autenticación, se agrega antes del método el scope `skip_before_action :verify_authenticity_token`
```sh
class LendingController < ApplicationController
    skip_before_action :verify_authenticity_token
    def libro_prestado
        #buscar si existe el libro
        id = params[:book_id]
        @books = Book.where(status:0).find_by(id: id)
        if @books == nil
            return render json:{
                status: "El libro no existe"
            }
        end
        #ver el estado
       
        @book = UserBook.find_by(book_id: id)
        if @book != nil && @book.status == 0
            return render json:{
                status: "El libro se encuentra prestado"
            }
        end

        #pedir prestado el libro
        @book = UserBook.new
        @book.status = 0
        @book.user_id = params[:user_id]
        @book.book_id = params[:book_id]
        @book.lending_at = Time.now.strftime("%F %H:%M")
        @book.expire = Time.now + 10.days
        @book.save
        return render json: @book

    end
end
```
En el *Returned* se crea el método `libro_devuelto` en la cual busca si el libro existe, ve su estado y realiza la devolución
```sh
class ReturnedController < ApplicationController
    skip_before_action :verify_authenticity_token
    def libro_devuelto
        #buscar si existe el libro
        id = params[:book_id]
        @books = Book.find_by(id: id)
        if @books == nil
            return render json:{
                status: "El libro no existe"
            }
        end
        #ver el estado
       
        @book = UserBook.find_by(book_id: id)
        if @book != nil || @book.status == 1
            return render json:{
                status: "El libro se encuentra devuelto"
            }
        end

        #devolver el libro
        id = params[:id]
        @book = UserBook.find_by(id: id)
        @book.status = 1
        @book.user_id = params[:user_id]
        @book.book_id = params[:book_id]
        @book.returned_at = Time.now
        @book.save
        return render json: @book
    end
end
```
Por último, se actualiza el archivo `routes.rb` con las rutas necesarias para generar el préstamo y devolución
```sh
post 'api/lendings', to: 'lending#libro_prestado'
post 'api/returneds', to: 'returned#libro_devuelto'
```
**Active_Model_Serializer**
Se agrega en el Gemfile la gema `gem 'active_model_serializers', '~> 0.10.0'` y se ejecuta el bundle.
Una vez actualizadas las librerías, se ejecuta el comando (así mismo con los modelos necesarios)
```sh
rails g serializer book
```
Esto crea una carpeta serializer con el archivo `book_serializer.rb`
```sh
class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author
end

class LendingSerializer < ActiveModel::Serializer
  attributes :id, :status, :user_id, :book_id, :lending_at, :expire, include: ['book','user']
end

class ReturnedSerializer < ActiveModel::Serializer
  attributes :id, :status, :user_id, :book_id, :returned_at, include: ['book','user']
end

class UserSerializer < ActiveModel::Serializer
  attributes :id, :name,:last_name,:email,:address,:phone
end
```
**Mailing informativo al prestar un libro**
Para el servicio de Mailing se usó `mailgun` este permite 5 mil correos gratuitos, para iniciar con la instalación se debe crear una cuenta en https://www.mailgun.com/  en el Gemfile agregar la gema y ejecutar el bundle
```sh
gem 'mailgun-ruby', '~>1.2.4'
```
Para continuar con la instalación se debe seguir las instrucciones del git de mailgun:
Ir a *config/environments/production.rb* y agregar lo siguiente:
```sh
Mailgun.configure do |config|
    config.api_key = 'key-APIKEY'
  end
  config.action_mailer.delivery_method = :mailgun
  config.action_mailer.mailgun_settings = {
    api_key: 'key-APIKEY',
    domain: 'dominiomialgun.mailgun.org',
    # api_host: 'api.eu.mailgun.net'  # Uncomment this line for EU region domains
  }
```
Para verificar si salen correos, crear un controlador `mail_controller.rb`
```sh
class MailController < ApplicationController
    
    def mail   
        mailer = ApplicationMailer.welcome_email("linav92@gmail.com")
        mailer_response = mailer.deliver_now
        mailgun_message_id = mailer_response.message_id
        return render json:mailer_response
    end
end
```
Es importante crear las opciones del envio (Asunto y mensaje), para ello se crea una carpeta `app/mailers` crear `application_mailer.rb` la cual guardará el método de los futuros mensajes
```sh
class ApplicationMailer < ActionMailer::Base
  default from: 'noresponder@mercat.com'
  layout 'mailer'

  def welcome_email(book)
    @book = book
    mail(to: book.user.email, subject: "¡Bienvenido a Library!").tap do |message|
      message.mailgun_options = {
        "tag" => ["abtest-option-a", "beta-user"],
        "tracking-opens" => true,
        "tracking-clicks" => "htmlonly"
      }
    end
  end
end
```
En el controlador *lending_controller.rb* se debe agregar tres líneas que permite el envío del correo al momento de ejecutar la API
```sh
#pedir prestado el libro
        @book = UserBook.new
        @book.status = 0
        @book.user_id = params[:user_id]
        @book.book_id = params[:book_id]
        @book.lending_at = Time.now.strftime("%F %H:%M")
        @book.expire = Time.now + 10.days
        @book.save
        mailer = ApplicationMailer.welcome_email(@book )
        mailer_response = mailer.deliver_now
        mailgun_message_id = mailer_response.message_id
        return render json: @book
```
Por último, se crea las vistas de los mensajes en `views/application_mailers` informando al usuario el libro que prestó y la fecha máxima de devolución
```sh
<!DOCTYPE html>
<html>

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <style type="text/css">
    a:hover {
      text-decoration: underline !important;
    }
  </style>
</head>

<body marginheight="0" topmargin="0" marginwidth="0" style="margin: 0px; background-color: #f2f8f9;" leftmargin="0">
  <!--100% body table-->
  <table cellspacing="0" border="0" cellpadding="0" width="100%" bgcolor="#f2f8f9">
    <tr>
      <td>
        <table style="background-color: #f2f8f9; max-width:670px; margin:0 auto;" width="100%" border="0" align="center"
          cellpadding="0" cellspacing="0">
          <tr>
            <td style="height:80px;">&nbsp;</td>
          </tr>
          <tr>
            <td style="text-align:center;">
            </td>
          </tr>
          <tr>
            <td style="height:40px;">&nbsp;</td>
          </tr>
          <tr>
            <td>
              <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0"
                style="max-width:670px; background:#fff; border-radius:3px; text-align:center;-webkit-box-shadow:0 1px 3px 0 rgba(0, 0, 0, 0.16), 0 1px 3px 0 rgba(0, 0, 0, 0.12);-moz-box-shadow:0 1px 3px 0 rgba(0, 0, 0, 0.16), 0 1px 3px 0 rgba(0, 0, 0, 0.12);box-shadow:0 1px 3px 0 rgba(0, 0, 0, 0.16), 0 1px 3px 0 rgba(0, 0, 0, 0.12)">
                <tr>
                  <td style="height:40px;">&nbsp;</td>
                </tr>
                <tr>
                  <td style="padding:0 15px;">
                    <h1 style="color:#3075BA; font-weight:400; margin:0;font-size:32px;">Bienvenido a Library</h1>
                    <span
                      style="display:inline-block; vertical-align:middle; margin:29px 0 26px; border-bottom:1px solid #cecece; width:100px;"></span>
                    <p style="font-size:15px; color:#171f23de; margin:8px 0 0; line-height:24px;">Estimado <%= @book.user.name %>:<br> <strong>Ha prestado el libro <%= @book.book.title%>, su fecha de devolución es <%= @book.expire %></strong>.</p>
                    
                    <%# <a href="login.html"
                      style="background:#3075BA;text-decoration:none !important; display:inline-block; font-weight:500; margin-top:24px; color:#fff;text-transform:uppercase; font-size:14px;padding:10px 12px;display:inline-block;border-radius:3px;">Login
                      to your Account</a> %>
                  </td>
                </tr>
                <tr>
                  <td style="height:40px;">&nbsp;</td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td style="height:20px;">&nbsp;</td>
          </tr>
          <tr>
            <td style="text-align:center;">
              <p style="font-size:14px; color:#455056bd; line-height:18px; margin:0 0 0;">Hemos enviado este mensaje por parte de Library | <strong> All rights reserved</strong>.</p>
            </td>
          </tr>
          <tr>
            <td style="height:80px;">&nbsp;</td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <!--/100% body table-->
</body>
</html>

```
**Desplegar plataforma en Digital Ocean**
Para este proyecto se aplicó Kubernetes desde Digital Ocean
**Configuración del dominio**
El proyecto quedo con el siguiente dominio: http://164.90.247.196 el cual genera automáticamente Digital Ocean

**Instrucciones de deployment**
Para lanzar la aplicación se debe ejecutar el comando 
```sh
kubeclt apply -f k8s.yaml
```
Para empaquetar la imagen se debe ejecutar el comando
```sh
docker buildx build --platform linux/amd64 --push -t 1037619/mercat .
```
Por último, para desinstalar la aplicación se debe ejecutar el comand
```sh
kubectl delete -f k8s.yaml
```
### Aclaraciones 📋
Para el perfecto funcionamiento del Mailgun, se recomienda a crear como email de los usuarios `mercat@yopmail.com` puesto que requiere autorización para el envío de correos en cuentas free.
Usar *Yopmail* para validar el envío de correos.
# Construido con 🛠️

* Ruby [2.6.3] - Lenguaje de programación usado
* Rails [6.1.3]  - Framework web usado
* PostgreSQL
* Kubernetes [1.20] - Orquestador contenedores

## Autores ✒️

* **Lina Sofía Vallejo Betancourth** - *Trabajo Inicial y documentación* - [linav92](https://github.com/linav92)

## Licencia 📄
Este proyecto es un software libre. 

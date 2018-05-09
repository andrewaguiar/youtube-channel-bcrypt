require 'sqlite3'
require 'digest'

class App
  def initialize
    # Cria o banco de dados.
    @db = SQLite3::Database.new('db-md5.sqlite3')

    # Cria a tabela caso não exista.
    @db.execute 'create table if not exists users (email varchar(30), password varchar(200))'
  end

  def sign_up(email, password)
    # Insere nosso usuário.

    digested_password = Digest::MD5.hexdigest(password)

    @db.execute(
      'insert into users(email, password) values (?, ?)',
      [email, digested_password]
    )
  end

  def sign_in?(email, password)
    # Verifica se o usuário existe na base de dados.

    digested_password = Digest::MD5.hexdigest(password)

    rows = @db.execute(
      'select password from users where email = ? and password = ?',
      [email, digested_password]
    )

    rows.any?
  end
end

require 'sqlite3'

class App
  def initialize
    # Cria o banco de dados.
    @db = SQLite3::Database.new('db-plain-text.sqlite3')

    # Ajusta o custo para 15 (apenas para teste)
    BCrypt::Engine.cost = 15

    # Cria a tabela caso não exista.
    @db.execute 'create table if not exists users (email varchar(30), password varchar(200))'
  end

  def sign_up(email, password)
    # Insere nosso usuário.

    @db.execute(
      'insert into users(email, password) values (?, ?)',
      [email, password]
    )
  end

  def sign_in?(email, password)
    # Verifica se o usuário existe na base de dados.

    rows = @db.execute(
      'select password from users where email = ? and password = ?',
      [email, password]
    )

    rows.any?
  end
end

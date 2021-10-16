final createTable = '''
  CREATE TABLE contact(
    id INTEGER NOT NULL PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    telefone CHAR(16) NOT NULL,
    email VARCHAR(200) NOT NULL,
    url_avatar VARCHAR(300) NOT NULL
  )
''';

final insert1 = '''
  INSERT INTO contact(nome,telefone,email,url_avatar)
  VALUES ('Lucas','(93)9 99105-9773','lucas@gmail.com','https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png')
''';

final insert2 = '''
  INSERT INTO contact(nome,telefone,email,url_avatar)
  VALUES ('Pai','(93)9 99195-3428','vinicius@gmail.com','https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_960_720.png')
''';

final insert3 = '''
  INSERT INTO contact(nome,telefone,email,url_avatar)
  VALUES ('Mãe','(93)9 99151-0180','gleice@gmail.com','https://cdn.pixabay.com/photo/2021/08/14/07/21/child-6544739_960_720.png')
''';

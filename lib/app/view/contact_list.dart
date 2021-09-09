import 'package:agenda/app/database/script.dart';
import 'package:agenda/app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactList extends StatelessWidget{
  final lista = [
    {'nome':'Lucas','telefone':'(93) 9 99105-9773','avatar':'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'},
    {'nome':'Pai','telefone':'(93) 9 99195-3428','avatar':'https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_960_720.png'},
    {'nome':'Mãe','telefone':'(93) 9 99151-0180','avatar':'https://cdn.pixabay.com/photo/2021/08/14/07/21/child-6544739_960_720.png'},
  ];

  Future<List<Map<String,dynamic>>> _buscar() async{
    String path = join(await getDatabasesPath(), 'banco');
    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: (db,v){
        db.execute(createTable);
        db.execute(insert1);
        db.execute(insert2);
        db.execute(insert3);
      }
    );
    return db.query('contact');
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: _buscar(),
      builder: (context, futuro){
        if(futuro.hasData){
          List? lista = futuro.data as List?;
          return Scaffold(
            appBar: AppBar(
              title: Text('Agenda de Contatos'),
              actions: [
                IconButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed(MyApp.CONTACT_FORM);
                  }, 
                  icon: Icon(Icons.add),
                )
              ],
            ),
            body: ListView.builder(
              itemCount: lista!.length,
              itemBuilder: (context,i){
                var contato = lista[i];
                var avatar = CircleAvatar(backgroundImage: NetworkImage(contato['url_avatar']!));
                return ListTile(
                  leading: avatar,
                  title: Text(contato['nome']!),
                  subtitle: Text(contato['telefone']!),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                        IconButton(onPressed: (){}, icon: Icon(Icons.delete_forever_outlined))
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }else{
          return Scaffold();
        }
      },
    );
  }
}
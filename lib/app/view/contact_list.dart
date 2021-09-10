import 'package:agenda/app/database/sqlite/connection.dart';
import 'package:agenda/app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ContactList extends StatelessWidget{

  Future<List<Map<String,dynamic>>> _buscar() async{
    Database? db = await Connection.get();
    return db!.query('contact');
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
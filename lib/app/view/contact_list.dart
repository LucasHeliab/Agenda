import 'package:agenda/app/domain/entities/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'contact_list_back.dart';

class ContactList extends StatelessWidget {
  final _back = ContactListBack();

  CircleAvatar _circleAvatar(String url){
    return (Uri.tryParse(url)!.isAbsolute) ? 
      CircleAvatar(backgroundImage: NetworkImage(url))
      :CircleAvatar(child: Icon(Icons.person));
  }

  Widget _editButton(Function function){
    return IconButton(
      icon: Icon(Icons.edit), 
      onPressed:(){
        function();
      }
    );
  }

  Widget _deleteButton(BuildContext context, Function function){
    return IconButton(
      icon: Icon(Icons.delete_forever_outlined),
      color: Colors.red,
      onPressed: (){
        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
            title: Text('Excluir'),
            content: Text('Confirma a exclusão?'),
            actions: [
              TextButton(
                child: Text('Não'),
                onPressed: (){
                  Navigator.of(context).pop();
                }
              ),
              TextButton(
                child: Text('Sim'),
                onPressed: () {
                  function();
                }
              )
            ],
          )
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Agenda de Contatos'),
          actions: [
            IconButton(
              onPressed: () {
                _back.goToForm(context);
                //Navigator.of(context).pushNamed(MyApp.CONTACT_FORM);
              },
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: Observer(builder: (context) {
          return FutureBuilder(
              future: _back.list,
              builder: (context, futuro) {
                if (!futuro.hasData) {
                  return CircularProgressIndicator();
                } else {
                  List<Contact>? lista = futuro.data as List<Contact>?;
                  return ListView.builder(
                    itemCount: lista!.length,
                    itemBuilder: (context, i) {
                      var contato = lista[i];
                      return ListTile(
                        leading: _circleAvatar(contato.urlAvatar),
                        title: Text(contato.nome),
                        subtitle: Text(contato.telefone),
                        trailing: Container(
                          width: 100,
                          child: Row(
                            children: [
                              _editButton((){
                                _back.goToForm(context, contato);
                              }),
                              _deleteButton(context, (){
                                var id = contato.id;
                                _back.remove(id!);
                                Navigator.of(context).pop();
                              })
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              });
        }));
  }
}

import 'package:agenda/app/domain/entities/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'contact_list_back.dart';

class ContactList extends StatelessWidget {
  final _back = ContactListBack();

  CircleAvatar _circleAvatar(String url) {
    return (Uri.tryParse(url)!.isAbsolute)
        ? CircleAvatar(backgroundImage: NetworkImage(url))
        : CircleAvatar(child: Icon(Icons.person));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contatos'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _back.goToForm(context);
          },
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
                        onTap: () {
                          _back.goToDetails(context, contato);
                        },
                      );
                    },
                  );
                }
              });
        }));
  }
}

import 'package:agenda/app/my_app.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget{
  @override
  Widget build(BuildContext context){
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
      body: ListView(),
    );
  }
}
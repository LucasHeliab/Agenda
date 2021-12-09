import 'package:agenda/app/domain/entities/contact.dart';
import 'package:agenda/app/view/contact_details_back.dart';
import 'package:flutter/material.dart';

class ContactDetails extends StatelessWidget {

  showModalError(BuildContext context){
    var alert = AlertDialog(
      title: Text('Alerta!'),
      content: Text('Não foi possível encontrar um APP compatível!'),
    );
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return alert;
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    var _back = ContactDetailsBack(context);
    Contact contato = _back.contato;
    
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints){
        var width = constraints.biggest.width;
        //var heigth = constraints.biggest.height;

        return Scaffold(
          body: ListView(
            padding: EdgeInsets.all(30),
            children: [
              (Uri.tryParse(contato.urlAvatar)!.isAbsolute)?
                CircleAvatar(
                  backgroundImage: NetworkImage(contato.urlAvatar),
                  radius: width/4,
                ):
                CircleAvatar(
                  child: Icon(
                    Icons.person,
                    size: width/3,
                  ),
                  radius: width/4,
                ),
              Center(
                child: Text('${contato.nome}', style: TextStyle(fontSize: 25),),
              ),
              Card(
                child: ListTile(
                  title: Text('Telefone:'),
                  subtitle: Text('${contato.telefone}'),
                  trailing: Container(
                    width: width/4,
                    child: Row(
                      children: [
                        IconButton(
                          color: Colors.lightBlue,
                          onPressed: (){
                            _back.launchSMS(showModalError);
                          }, 
                          icon: Icon(Icons.message_outlined)
                        ),
                        IconButton(
                          color: Colors.lightBlue,
                          onPressed: (){
                            _back.launchTelefone(showModalError);
                          }, 
                          icon: Icon(Icons.phone_outlined)
                        )
                      ],
                    ),
                  ),
                )
              ),
              Card(
                child: ListTile(
                  title: Text('E-mail:'),
                  subtitle: Text('${contato.email}'),
                  trailing: Container(
                    width: width/4,
                    child: Row(
                      children: [
                        IconButton(
                          color: Colors.lightBlue,
                          onPressed: (){
                            _back.launchEmail(showModalError);
                          }, 
                          icon: Icon(Icons.mail_outline)
                        ),
                      ]
                    ),
                  )
                )
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.arrow_back),
            onPressed: (){
              _back.goToBack();
            },
          ),
        );
      },
    );
  }
}
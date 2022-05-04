import 'package:agenda/app/domain/entities/contact.dart';
import 'package:agenda/app/view/contact_details_back.dart';
import 'package:flutter/material.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails({Key? key}) : super(key: key);

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  void initState() {
    super.initState();
  }

  showModalError(BuildContext context) {
    var alert = AlertDialog(
      title: Text('Alerta!'),
      content: Text('Não foi possível encontrar um APP compatível!'),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  Widget _deleteButton(BuildContext context, Function function) {
    return FloatingActionButton(
        child: Icon(Icons.delete_forever_outlined),
        heroTag: Text('deleteButton'),
        backgroundColor: Colors.red,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Excluir'),
                    content: Text('Confirma a exclusão?'),
                    actions: [
                      TextButton(
                          child: Text('Não'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      TextButton(
                          child: Text('Sim'),
                          onPressed: () {
                            function();
                          })
                    ],
                  ));
        });
  }

  Widget _editButton(Function function) {
    return FloatingActionButton(
        child: Icon(Icons.edit),
        heroTag: Text('editButton'),
        onPressed: () {
          function();
        });
  }

  Widget _goToBackButton(Function function) {
    return FloatingActionButton(
        child: Icon(Icons.arrow_back),
        heroTag: Text('goToBackButton'),
        onPressed: () {
          function();
        });
  }

  @override
  Widget build(BuildContext context) {
    var _back = ContactDetailsBack(context);
    Contact contato = _back.contato;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var width = constraints.biggest.width;
        //var heigth = constraints.biggest.height;

        return Scaffold(
          body: ListView(
            padding: EdgeInsets.all(30),
            children: [
              (Uri.tryParse(contato.urlAvatar)!.isAbsolute)
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(contato.urlAvatar),
                      radius: width / 4,
                    )
                  : CircleAvatar(
                      child: Icon(
                        Icons.person,
                        size: width / 3,
                      ),
                      radius: width / 4,
                    ),
              Center(
                child: Text(
                  '${contato.nome}',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Card(
                  child: ListTile(
                title: Text('Telefone:'),
                subtitle: Text('${contato.telefone}'),
                trailing: Container(
                  width: width / 4,
                  child: Row(
                    children: [
                      IconButton(
                          color: Colors.lightBlue,
                          onPressed: () {
                            _back.launchSMS(showModalError);
                          },
                          icon: Icon(Icons.message_outlined)),
                      IconButton(
                          color: Colors.lightBlue,
                          onPressed: () {
                            _back.launchTelefone(showModalError);
                          },
                          icon: Icon(Icons.phone_outlined))
                    ],
                  ),
                ),
              )),
              Card(
                  child: ListTile(
                      title: Text('E-mail:'),
                      subtitle: Text('${contato.email}'),
                      trailing: Container(
                        width: width / 4,
                        child: Row(children: [
                          IconButton(
                              color: Colors.lightBlue,
                              onPressed: () {
                                _back.launchEmail(showModalError);
                              },
                              icon: Icon(Icons.mail_outline)),
                        ]),
                      ))),
            ],
          ),
          floatingActionButton: AnimatedFloatingActionButton(
              fabButtons: <Widget>[
                _deleteButton(context, () {
                  var id = contato.id;
                  _back.remove(id!);
                }),
                _editButton(() {
                  _back.goToForm(context, contato);
                }),
                _goToBackButton(() {
                  _back.goToBack();
                })
              ],
              colorStartAnimation: Colors.blueGrey,
              colorEndAnimation: Colors.red,
              animatedIconData: AnimatedIcons.menu_close),
        );
      },
    );
  }
}

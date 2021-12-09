import 'package:agenda/app/domain/entities/contact.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetailsBack{
  BuildContext context;
  late Contact contato;

  ContactDetailsBack(this.context){
    contato =  ModalRoute.of(context)!.settings.arguments as Contact;
  }

  goToBack(){
    Navigator.of(context).pop();
  }


  _launchApp(String url, Function(BuildContext context) showModalError) async{
    !await canLaunch(url) ? await launch(url) : showModalError(context);
  }

  launchTelefone(Function(BuildContext context) showModalError){
    _launchApp('tel:${contato.telefone}', showModalError);
  }

  launchSMS(Function(BuildContext context) showModalError){
    _launchApp('sms:${contato.telefone}', showModalError);
  }

  launchEmail(Function(BuildContext context) showModalError){
    _launchApp('mailto:${contato.email}', showModalError);
  }
}

/* showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Alerta!'),
          content: Text('Não foi possível encontrar um APP compatível!'),
        );
      }
    );*/
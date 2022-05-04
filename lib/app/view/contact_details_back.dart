import 'package:agenda/app/domain/entities/contact.dart';
import 'package:agenda/app/domain/services/contact_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

import '../my_app.dart';

class ContactDetailsBack {
  BuildContext context;
  late Contact contato;
  var _service = GetIt.I.get<ContactService>();
  Future<List<Contact>>? list;

  ContactDetailsBack(this.context) {
    Map map = ModalRoute.of(context)!.settings.arguments as Map;
    contato = map['contato'];
    list = map['list'];
  }

  //Método para atualizar a lista de contatos
  refreshList([dynamic value]) {
    list = _service.find();
  }

  //Método que volta para tela anterior
  goToBack() {
    Navigator.of(context).pushNamedAndRemoveUntil(MyApp.HOME, (route) => false);
  }

  //Método para chamar o form salvar/atualizar
  goToForm(BuildContext context, [Contact? contact]) {
    Navigator.of(context).pushNamed(MyApp.CONTACT_FORM,
        arguments: {'contact': contact, 'list': list}).then(refreshList);
  }

  //Excluir contato
  remove(dynamic id) {
    _service.remove(id);
    refreshList();
    Navigator.popUntil(context, ModalRoute.withName(MyApp.HOME));
  }

  _launchApp(String url, Function(BuildContext context) showModalError) async {
    !await canLaunch(url) ? await launch(url) : showModalError(context);
  }

  launchTelefone(Function(BuildContext context) showModalError) {
    _launchApp('tel:${contato.telefone}', showModalError);
  }

  launchSMS(Function(BuildContext context) showModalError) {
    _launchApp('sms:${contato.telefone}', showModalError);
  }

  launchEmail(Function(BuildContext context) showModalError) {
    _launchApp('mailto:${contato.email}', showModalError);
  }
}

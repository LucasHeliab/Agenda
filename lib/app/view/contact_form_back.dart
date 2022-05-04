import 'package:agenda/app/domain/entities/contact.dart';
import 'package:agenda/app/domain/services/contact_service.dart';
import 'package:agenda/app/my_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class ContactFormBack {
  Contact? contact;
  Future<List<Contact>>? list;
  var _service = GetIt.I.get<ContactService>();
  bool _nameIsValid = false;
  bool _emailIsValid = false;
  bool _phoneIsValid = false;

  bool get isValid => _nameIsValid && _emailIsValid && _phoneIsValid;

  //diferenciar novo com alteração
  ContactFormBack(BuildContext context) {
    Object? parameter = ModalRoute.of(context)!.settings.arguments;
    if ((parameter == null)) {
      contact = Contact(email: '', nome: '', telefone: '', urlAvatar: '');
      list = null;
    } else {
      Map map = ModalRoute.of(context)!.settings.arguments as Map;
      contact = map['contact'];
      list = map['list'];
    }
  }

  //salvar
  save(BuildContext context) async {
    await _service.save(contact!);
    if (!(list == null)) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          MyApp.CONTACT_DETAILS, ModalRoute.withName(MyApp.HOME),
          arguments: {'contato': contact, 'list': list});
    } else {
      Navigator.of(context).pop();
    }
  }

  // validações
  String? validateName(String? name) {
    try {
      _service.validateName(name);
      _nameIsValid = true;
      return null;
    } catch (e) {
      _nameIsValid = false;
      return e.toString();
    }
  }

  String? validateEmail(String? email) {
    try {
      _service.validateEmail(email);
      _emailIsValid = true;
      return null;
    } catch (e) {
      _emailIsValid = false;
      return e.toString();
    }
  }

  String? validateTelefone(String? telefone) {
    try {
      _service.validateTelefone(telefone);
      _phoneIsValid = true;
      return null;
    } catch (e) {
      _phoneIsValid = false;
      return e.toString();
    }
  }
}

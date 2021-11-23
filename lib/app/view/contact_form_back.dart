import 'package:agenda/app/domain/entities/contact.dart';
import 'package:agenda/app/domain/services/contact_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'contact_form_back.g.dart';

class ContactFormBack = _ContactFormBack with _$ContactFormBack;

abstract class _ContactFormBack with Store{
  Contact? contact;
  var _service = GetIt.I.get<ContactService>();
  bool _nameIsValid = false;
  bool _emailIsValid = false;
  bool _phoneIsValid = false;

  @action
  bool get isValid => _nameIsValid && _emailIsValid && _phoneIsValid;

  //diferenciar novo com alteração
  _ContactFormBack(BuildContext context){
    Object? parameter = ModalRoute.of(context)!.settings.arguments;
    if ((parameter == null)) {
      contact = Contact(email: '', nome: '', telefone: '', urlAvatar: '');
    } else {
      contact = parameter as Contact?;
    }
  }

  //salvar
  save() async{
    await _service.save(contact!);
  }

  // validações
  String? validateName(String ?name){
    try{
      _service.validateName(name);
      _nameIsValid = true;
      return null;
    }catch(e){
      _nameIsValid = false;
      return e.toString();
    }
  }

  String? validateEmail(String ?email){
    try{
      _service.validateEmail(email);
      _emailIsValid = true;
      return null;
    }catch(e){
      _emailIsValid = false;
      return e.toString();
    }
  }

  String? validateTelefone(String ?telefone){
    try{
      _service.validateTelefone(telefone);
      _phoneIsValid = true;
      return null;
    }catch(e){
      _phoneIsValid = false;
      return e.toString();
    }
  }
}
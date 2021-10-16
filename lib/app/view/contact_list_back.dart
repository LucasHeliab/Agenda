import 'package:agenda/app/domain/entities/contact.dart';
import 'package:agenda/app/domain/services/contact_service.dart';
import 'package:agenda/app/my_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'contact_list_back.g.dart';

class ContactListBack = _ContactListBack with _$ContactListBack;

abstract class _ContactListBack with Store{

  var _service = GetIt.I.get<ContactService>();

  //Lista de contatos
  @observable
  Future<List<Contact>>? list;

  //Método para atualizar a lista de contatos
  @action
  refreshList([dynamic value]){
    list = _service.find();
  }

  _ContactListBack(){
    refreshList();
  }

  //Método para chamar o form salvar/atualizar
  goToForm(BuildContext context, [Contact? contact]){
    Navigator.of(context).pushNamed(MyApp.CONTACT_FORM, arguments: contact).then(refreshList);
  }


  //Excluir contato
  remove(int id){
    _service.remove(id);
    refreshList();
  }
}
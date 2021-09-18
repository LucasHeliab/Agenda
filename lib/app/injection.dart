import 'package:agenda/app/database/sqlite/dao/contact_dao_impl.dart';
import 'package:agenda/app/domain/interfaces/contact_dao.dart';
import 'package:get_it/get_it.dart';

setupInjection(){
  GetIt getit = GetIt.I;

  getit.registerSingleton<ContactDAO>(ContactDAOimpl());
}
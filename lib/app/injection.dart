import 'package:agenda/app/database/sqlite/dao/contact_dao_impl.dart';
import 'package:agenda/app/domain/interfaces/contact_dao.dart';
import 'package:agenda/app/domain/services/contact_service.dart';
import 'package:get_it/get_it.dart';

setupInjection() async {
  GetIt getit = GetIt.I;

  getit.registerSingleton<ContactDAO>(ContactDAOimpl());
  getit.registerSingleton<ContactService>(ContactService());
}

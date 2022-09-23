import 'package:flutter_sqlite_1/contacts.dart';
import 'package:flutter_sqlite_1/databasehelper.dart';

class DataBaseAccessObjects {
  Future<List<Contacts>> allContacts() async {
    var dataBaseDAO = await DataBaseHelper.accessDataBase();
    List<Map<String, dynamic>> mapsDAO =
        await dataBaseDAO.rawQuery('SELECT * FROM contacts');
    return List.generate(mapsDAO.length, (index) {
      var dataRow = mapsDAO[index];
      return Contacts(dataRow['contact_id'], dataRow['contact_name'],
          dataRow['contact_age']);
    });
  }

  Future<void> addPerson(String contact_name, int contact_age) async {
    var addPersonDAO = await DataBaseHelper.accessDataBase();
    var newInfos = Map<String, dynamic>();
    newInfos['contact_name'] = contact_name;
    newInfos['contact_age'] = contact_age;
    await addPersonDAO.insert('contacts', newInfos);
  }
}

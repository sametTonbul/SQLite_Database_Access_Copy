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

  Future<void> deletePerson(int contact_id) async {
    var deletePersonDAO = await DataBaseHelper.accessDataBase();
    await deletePersonDAO
        .delete('contacts', where: 'contact_id = ?', whereArgs: [contact_id]);
  }

  Future<void> updatePerson(
      int contact_id, String contact_name, int contact_age) async {
    var updatePersonDAO = await DataBaseHelper.accessDataBase();
    var newInfosForUpdate = Map<String, dynamic>();
    newInfosForUpdate['contact_name'] = contact_name;
    newInfosForUpdate['contact_age'] = contact_age;
    await updatePersonDAO.update('contacts', newInfosForUpdate,
        where: 'contact_id = ?', whereArgs: [contact_id]);
  }

  Future<int> checkPersonData(String contact_name) async {
    var checkPersonDataDAO = await DataBaseHelper.accessDataBase();
    List<Map<String, dynamic>> resultMap = await checkPersonDataDAO.rawQuery(
        "SELECT count(*) AS result FROM contacts WHERE contact_name= '$contact_name' ");
    var resultMapDefaultIndex = 0;
    return resultMap[resultMapDefaultIndex]['result'];
  }

  Future<Contacts> getPerson(int contact_id) async {
    var getPersonDAO = await DataBaseHelper.accessDataBase();
    List<Map<String, dynamic>> resultGetPersonMap = await getPersonDAO
        .rawQuery("SELECT * FROM contacts WHERE contact_id=$contact_id");
    var getPersonMapDefaultIndex = 0;
    var getPersonRow = resultGetPersonMap[getPersonMapDefaultIndex];
    return Contacts(
      getPersonRow['contact_id'],
      getPersonRow['contact_name'],
      getPersonRow['contact_age'],
    );
  }
}

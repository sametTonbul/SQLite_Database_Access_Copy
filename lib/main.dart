import 'package:flutter/material.dart';
import 'package:flutter_sqlite_1/contacts.dart';
import 'package:flutter_sqlite_1/databaseaccessobject.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> showContacts() async {
    var list = await DataBaseAccessObjects().allContacts();
    for (Contacts person in list) {
      print('************');
      print('Person ID: ${person.contact_id}');
      print('************');
      print('Person Name: ${person.contact_name}');
      print('************');
      print('Person Age: ${person.contact_age}');
    }
  }

  Future<void> addPerson() async {
    await DataBaseAccessObjects().addPerson('Cristiano', 38);
  }

  Future<void> deletePerson() async {
    await DataBaseAccessObjects().deletePerson(1);
  }

  Future<void> updatePerson() async {
    await DataBaseAccessObjects().updatePerson(3, 'Messi', 45);
  }


  @override
  void initState() {
    super.initState();
    //addPerson();
    //deletePerson();
    updatePerson();
    showContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}

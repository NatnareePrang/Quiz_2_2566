import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterrestapimysql/pages/adduser.dart';
import 'package:flutterrestapimysql/pages/adduser2.dart';
import 'package:flutterrestapimysql/pages/edituser.dart';
import 'package:flutterrestapimysql/pages/edituser2.dart';
import 'package:flutterrestapimysql/pages/login.dart';
import 'package:flutterrestapimysql/pages/profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> users = [];

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  Future<void> getUsers() async {
    const urlstr = "http://172.21.236.251/addressbook/select.php";

    final url = Uri.parse(urlstr);
    final response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      //Successful
      final json = response.body;
      final data = jsonDecode(json);
      debugPrint('Data: $data');
      setState(() {
        users = data;
      });
    } else {
      //Error
    }
  }

  Future delUser(username) async {
    // var url = 'https://pattyteacher.000webhostapp.com/edit.php';
    var url = Uri.parse('http://172.21.236.251/addressbook/delete.php');
    var data = {};

    data['username'] = username;
    debugPrint('Delete: $username');
    var response = await http.post(
      url,
      body: data,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      debugPrint('Print Result: $result');
      if (result == "Success") {
        debugPrint('Delete Success');
        getUsers();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const Home(),
        //   ),
        // );
      } else {
        Fluttertoast.showToast(
            msg: "Delete Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        // Toast.show(
        //   "Insert Error",
        //   context,
        //   duration: Toast.LENGTH_SHORT,
        //   gravity: Toast.BOTTOM,
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          CircleAvatar(
            backgroundColor: const Color(0xffF3E7FA),
            radius: 30,
            child: IconButton(
                icon: const Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.deepPurple,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                  debugPrint('login Clicked');
                }),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final fullname = users[index]['fullname'];
          final username = users[index]['username'];
          return ListTile(
            leading: GestureDetector(
              child: CircleAvatar(
                child: Text(fullname[0]),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditUser2(
                      users: users,
                      index: index,
                    ),
                  ),
                );
                debugPrint('Edit Clicked');
                debugPrint(index.toString());
              },
            ),
            title: Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fullname),
                    Text(username),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Profile(
                          user: users,
                          index: index,
                        ),
                      ));
                },
              ),
            ),
            trailing: GestureDetector(
              child: const Icon(
                Icons.delete,
                color: Colors.deepPurple,
              ),
              onTap: () {
                delUser(username);
                debugPrint('delete Clicked');
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddUser2(),
            ),
          );
        },
        child: const Icon(
          Icons.person_add_alt_1,
          size: 30,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}

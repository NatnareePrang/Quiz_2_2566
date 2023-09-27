import 'package:flutter/material.dart';
import 'package:flutterrestapimysql/pages/home.dart';
import 'package:http/http.dart' as http;

class EditUser extends StatefulWidget {
  final List list;
  final int index;

  const EditUser({Key? key, required this.list, required this.index})
      : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController user = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController fullname = new TextEditingController();

  bool editMode = false;

  Future editUser() async {
    if (editMode) {
      // var url = 'https://pattyteacher.000webhostapp.com/edit.php';
      var urlstr = "http://172.21.236.251/addressbook/edit.php";
      var url = Uri.parse(urlstr);
      await http.post(url, body: {
        //'id' : widget.list[widget.index]['id'],
        'fullname': fullname.text,
        'username': user.text,
        'password': password.text,
      });
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    editMode = true;
    fullname.text = widget.list[widget.index]['fullname'];
    user.text = widget.list[widget.index]['username'];
    password.text = widget.list[widget.index]['password'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit User')),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: fullname,
                decoration: InputDecoration(
                  hintText: "Fullname",
                  labelText: "Fullname",
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              TextField(
                controller: user,
                enabled: false,
                decoration: InputDecoration(
                  hintText: "Username",
                  labelText: "Username",
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text("EDIT DATA"),
                onPressed: () {
                  setState(() {
                    editUser();
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

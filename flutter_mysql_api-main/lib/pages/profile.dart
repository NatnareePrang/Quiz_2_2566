// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final List user;
  final int index;

  const Profile({
    Key? key,
    required this.user,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile : ${user[index]['fullname']}',
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: ListView(
          //scrollDirection: Axis.horizontal,
          children: [
            ListTile(
              onTap: () {
                print('Data: ');
                print(user[index]);
              },
              leading: Icon(Icons.person),
              title: Text('${user[index]['fullname']}'),
            ),
            ListTile(
              onTap: () {
                print(user[0]);
              },
              leading: Icon(Icons.email),
              title: Text('${user[index]['username']}'),
            ),
            ListTile(
              onTap: () {
                print(user[index]);
              },
              leading: Icon(Icons.phone),
              title: Text('099123456'),
            ),
          ],
        ));
  }
}

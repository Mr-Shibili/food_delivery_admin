import 'package:admin_food_delivery/constants.dart';
import 'package:flutter/material.dart';

import '../home/widgets/drawer.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(),
        appBar: AppBar(
          title: Text('Users'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.separated(
            separatorBuilder: (context, index) => khight,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(),
                  title: Text("Username"),
                  subtitle: Text(
                    'address',
                    style: TextStyle(color: Colors.white),
                    maxLines: 4,
                  ),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
              );
            },
          ),
        ));
  }
}

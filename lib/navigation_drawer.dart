 import 'package:flutter/material.dart';
import 'package:testproject/main.dart';

import 'article_page.dart';
import 'customer_page.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),
          ListTile(
            title: Icon(Icons.home),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage(title: "Database")),
              );
            },
          ),
          ListTile(
            title: const Text('Customer'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerPage(
                    title: 'Customer',
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Article'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticlePage(
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

}
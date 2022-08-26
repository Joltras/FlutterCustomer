import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'address.dart';

class AddressPage extends StatelessWidget {
  const AddressPage(this.address);
  final Address address;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Column(
          children: [
            Text(address.street),
            Text(address.city),
            Text(address.state),
            Text(address.zip),
          ],
        ),
      ),
    );
  }
}

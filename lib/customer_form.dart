import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testproject/customer.dart';

import 'address.dart';
import 'database_service.dart';

class AddCustomerPage extends StatelessWidget {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String email = "";
  String street = "";
  String city = "";
  String state = "";
  String zip = "";
  int customerId = -1;

  AddCustomerPage(Customer? customer) {
    if (customer != null) {
      customerId = customer.customerId;
      firstName = customer.firstName;
      lastName = customer.lastName;
      email = customer.email;
      street = customer.address.street;
      city = customer.address.city;
      state = customer.address.state;
      zip = customer.address.zip;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Customer"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: Form(
        key: _key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.teal,
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                  child: Text("Contact Information")),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                      ),
                      child: TextFormField(
                        initialValue: firstName,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          hintText: 'Enter first name',
                        ),
                        onChanged: (value) {
                          firstName = value;
                        },
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter first name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                      ),
                      child: TextFormField(
                        initialValue: lastName,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                          hintText: 'Enter last name',
                        ),
                        onChanged: (value) {
                          lastName = value;
                        },
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter last name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                      ),
                      child: TextFormField(
                        initialValue: email,
                        onChanged: (value) {
                          email = value;
                        },
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.teal,
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Address")
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                      ),
                      child: TextFormField(
                        initialValue: city,
                        decoration: const InputDecoration(
                          labelText: 'City',
                          hintText: 'Enter City',
                        ),
                        onChanged: (value) {
                          city = value;
                        },
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter city';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                      ),
                      child: TextFormField(
                        initialValue: street,
                        decoration: const InputDecoration(
                          labelText: 'Street',
                          hintText: 'Enter Street',
                        ),
                        onChanged: (value) {
                          street = value;
                        },
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter street';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                      ),
                      child: TextFormField(
                        initialValue: state,
                        decoration: const InputDecoration(
                          labelText: 'State',
                          hintText: 'Enter State',
                        ),
                        onChanged: (value) {
                          state = value;
                        },
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter state';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                      ),
                      child: TextFormField(
                        initialValue: zip,
                        decoration: const InputDecoration(
                          labelText: 'Zip',
                          hintText: 'Enter Zip',
                        ),
                        onChanged: (value) {
                          zip = value;
                        },
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter zip';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child:  Text((customerId == -1) ? 'Add' : 'Update'),
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    _key.currentState!.save();
                    if (customerId == -1) {
                      DatabaseServices.addCustomer(firstName, lastName, email, street, city, state, zip);
                    } else {
                      DatabaseServices.updateCustomer(customerId, firstName, lastName, email, street, city, state, zip);
                    }

                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
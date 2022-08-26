import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customer.dart';
import 'customer_form.dart';
import 'customer_search_results.dart';
import 'customer_table.dart';
import 'database_service.dart';
import 'navigation_drawer.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final editingController = TextEditingController();
  List<Customer> customers = [];

  getCustomers() async {
    customers = await DatabaseServices.getCustomers();
    print(customers.toString());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCustomers();
  }

  @override
  void dispose() {
    editingController.dispose();
    super.dispose();
  }

  deleteCustomer(int id) {
    DatabaseServices.deleteCustomer(id);
    getCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return customers == null
        ? Scaffold(body: Center(child: const CircularProgressIndicator()))
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCustomerPage(null),
                  ),
                );
              },
            ),
            drawer: NavigationDrawer(),
            body: Column(
              children: [
                TextField(
                    controller: editingController,
                    decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search by name",
                      prefix: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomerSearchResults(
                                editingController.text,
                              ),
                            ),
                          );
                        },
                      ),
                    )),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.face),
                      tooltip: 'Test',
                      onPressed: () {
                        deleteCustomer(156);
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          customers = [];
                          getCustomers();
                        });
                      },
                      icon: Icon(Icons.refresh),
                      tooltip: "Refresh",
                    ),
                  ],
                ),
                Divider(),
                CustomerTable(customers)
              ],
            ),
            appBar: AppBar(
              title: Text("Customers (${customers.length})"),
              centerTitle: true,
              backgroundColor: Colors.lightGreen,
            ));
  }
}

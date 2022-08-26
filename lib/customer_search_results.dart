
import 'package:flutter/material.dart';
import 'package:testproject/customer.dart';
import 'package:testproject/customer_table.dart';
import 'package:testproject/database_service.dart';

class CustomerSearchResults extends StatefulWidget {
  String name;
  CustomerSearchResults(this.name);

  @override
  State<StatefulWidget> createState() {
    return _CustomerSearchResultsState();
  }



}

class _CustomerSearchResultsState extends State<CustomerSearchResults> {
  List<Customer> customers = [];

  getCustomers() async {
    customers = await DatabaseServices.getCustomersByName(widget.name);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: customers.length == 0 ? Center(child: Text('No results found')) : CustomerTable(customers),
    );
  }

}
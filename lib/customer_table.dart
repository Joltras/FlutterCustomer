
import 'package:flutter/material.dart';
import 'package:testproject/customer.dart';

import 'address_page.dart';
import 'customer_form.dart';
import 'database_service.dart';
import 'main.dart';


class CustomerTable extends StatefulWidget {
  Map<int, Customer> customers;
  CustomerTable(this.customers);
  @override
  State<StatefulWidget> createState() => _CustomerTableState();
}

class _CustomerTableState extends State<CustomerTable> {

  deleteCustomer(int id) async {
    DatabaseServices.deleteCustomer(id);
    widget.customers.remove(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      children: createRows(widget.customers),
    );
  }
  
  List<TableRow> createRows (Map<int, Customer> customers) {
    var rows = <TableRow>[];
    var colors = [Colors.green[50], Colors.green[100]];
    var currentColor = 0;
    rows.add(TableRow(
      children: [
        Expanded(
            child: Container(
              child: Text('Customer ID'),
              color: Colors.greenAccent,
            )),
        Expanded(
            child: Container(
              child: Text('First Name'),
              color: Colors.greenAccent,
            )),
        Expanded(
            child: Container(
              child: Text('Last Name'),
              color: Colors.greenAccent,
            )),
        Expanded(
            child: Container(
              child: Text('Email'),
              color: Colors.greenAccent,
            )),
        Expanded(
            child: Container(
              child: Text('Address'),
              color: Colors.greenAccent,
            )),
        Expanded(
            child: Container(
              child: Text('Delete'),
              color: Colors.greenAccent,
            )),
        Expanded(
            child:Container(
              child: Text('Edit'),
              color: Colors.greenAccent,
            )),
      ],
    ));
    for (var customer in customers) {
      rows.add(TableRow(
        decoration: BoxDecoration(
          color: colors[currentColor],
        ),
        children: [

          Text(
              customer.customerId.toString(),
          ),
          Text(customer.firstName),
          Text(customer.lastName),
          Text(customer.email),
          Container(
            alignment: Alignment.centerLeft,
            child: MaterialButton(
              child: Text('Show Adress',
                style: TextStyle(
                    color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddressPage(customer.address),
                  ),
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                deleteCustomer(customer.customerId);
              },
              icon: Icon(Icons.delete),
              color: Colors.red,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddCustomerPage(customer),
                  ),
                );
              },
            ),
          )
        ],
      ));
      currentColor = currentColor == 0 ? 1 : 0;
    }
    return rows;
  }

}
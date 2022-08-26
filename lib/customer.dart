import 'address.dart';

class Customer {
  Address address;
  int customerId;
  String firstName;
  String lastName;
  String email;

  Customer({required this.customerId, required this.firstName, required this.lastName, required this.email ,required this.address});

  factory Customer.fromMap(Map taskMap) {
    return Customer(
      customerId: taskMap['customerId'],
      firstName: taskMap['firstname'],
      lastName: taskMap['lastname'],
      email: taskMap['email'],
      address: Address.fromMap(taskMap['address']),
    );
  }


}


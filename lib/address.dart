
class Address {
  int addressId;
  String street;
  String city;
  String state;
  String zip;

  Address({required this.addressId, required this.street, required this.city, required this.state, required this.zip});
  factory Address.fromMap(Map taskMap) {
    return Address(
      addressId: taskMap['addressId'],
      street: taskMap['street'],
      city: taskMap['city'],
      state: taskMap['state'],
      zip: taskMap['zip'],
    );
  }

}
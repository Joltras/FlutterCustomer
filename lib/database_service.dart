
import 'dart:convert';
import 'package:testproject/article.dart';
import 'package:testproject/globals.dart';

import 'customer.dart';
import 'package:http/http.dart' as http;

class DatabaseServices {
  static Future<Customer> addCustomer(String firstname, String lastname,
      String email, String street, String city, String state, String zip) async {
    Map address = {
      'street': street,
      'city': city,
      'state': state,
      'zip': zip,
    };
    Map data = {'firstname': firstname, 'lastname': lastname, 'email': email, 'address': address};
    var body = json.encode(data);
    var url = Uri.parse(customerUrl + '/add');
    http.Response response = await http.post(
        url,
        headers: headers,
        body: body
    );
    Map responseMap = json.decode(response.body);
    Customer customer = Customer.fromMap(responseMap);
    return customer;
  }

  static Future<Customer> updateCustomer(int id, String firstname, String lastname,
      String email, String street, String city, String state, String zip ) async {
    Map address = {
      'street': street,
      'city': city,
      'state': state,
      'zip': zip,
    };
    Map data = {'firstname': firstname, 'lastname': lastname, 'email': email, 'address': address};
    var body = json.encode(data);
    var url = Uri.parse(customerUrl + '/update/$id');
    http.Response response =
        await http.post(url, headers: headers, body: body);
    Map responseMap = json.decode(response.body);
    Customer customerR = Customer.fromMap(responseMap);
    return customerR;
  }

  static Future<List<Customer>> getCustomers() async {
    List<Customer> customers = [];
    var client = http.Client();
    try {
      var url = Uri.parse('$customerUrl/getAll');

      http.Response response = await client.get(
          url,
          headers: headers
      );
      List responseList = json.decode(response.body);
      for (var customer in responseList) {
        customers.add(Customer.fromMap(customer));
      }
    } catch (e) {
      print(e);

    } finally {
      client.close();
    }
    return customers;
  }

  static Future<List<Customer>> getCustomersByName(String name) async {
    List<Customer> customers = [];
    var client = http.Client();
    try {
      var url = Uri.parse('$customerUrl/getByName/$name');

      http.Response response = await client.get(
          url,
          headers: headers
      );
      List responseList = await json.decode(response.body);
      for (var customer in responseList) {
        customers.add(Customer.fromMap(customer));
      }
    } catch (e) {
      print(e);

    } finally {
      client.close();
    }
    return customers;
  }

  static void deleteCustomer(int id) async {
    var client = http.Client();
    try {
      var url = Uri.parse('$customerUrl/$id');
      http.Response response = await client.delete(
          url,
          headers: headers
      );
      print(response.statusCode);
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

  static Future<List<Article>> getArticles() async {
    List<Article> articles = [];
    var client = http.Client();
    try {
      var url = Uri.parse('$articleUrl/getAll');

      http.Response response = await client.get(
          url,
          headers: headers
      );
      List responseList = json.decode(response.body);
      for (var article in responseList) {
        articles.add(Article.fromMap(article));
      }
    } catch (e) {
      print(e);

    } finally {
      client.close();
    }
    return articles;
  }

}
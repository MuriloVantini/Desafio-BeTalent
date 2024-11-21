import 'dart:convert';

import 'package:test_be_talent/api/http_client.dart';
import 'package:test_be_talent/data/models/employee_model.dart';

abstract class IEmployeeRepository {
  Future<List<EmployeeModel>> getEmployees();
}

class EmployeeRepository implements IEmployeeRepository {
  @override
  Future<List<EmployeeModel>> getEmployees() async {
    try {
      final response = await MyHttpClient.get(
        url: '/employees',
      );

      if (response.statusCode == 200) {
        List<EmployeeModel> employees = [];

        final body = jsonDecode(response.body);
        body.map((e) {
          employees.add(EmployeeModel.fromMap(e as Map<String, dynamic>));
        }).toList();

        return employees;
      }
      return [];
    } catch (e) {
      print('Error fetching employees: $e');
      return [];
    }
  }
}

import 'package:flutter/material.dart';
import 'package:test_be_talent/api/repositories/employee_repository.dart';
import 'package:test_be_talent/data/models/employee_model.dart';

class EmployeeStore {
  final IEmployeeRepository repository;
  EmployeeStore({required this.repository});

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<EmployeeModel>> state = ValueNotifier<List<EmployeeModel>>([]);
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  Future<void> index() async {
    isLoading.value = true;
    try {
      state.value = await repository.getEmployees();
    } catch (e) {
      erro.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}

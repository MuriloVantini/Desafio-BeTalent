// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EmployeeModel {
  final int id;
  final String name;
  final String job;
  final DateTime admissionDate;
  final String phone;
  final String urlImage;
  EmployeeModel({
    required this.id,
    required this.name,
    required this.job,
    required this.admissionDate,
    required this.phone,
    required this.urlImage,
  });

  EmployeeModel copyWith({
    int? id,
    String? name,
    String? job,
    DateTime? admissionDate,
    String? phone,
    String? urlImage,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      job: job ?? this.job,
      admissionDate: admissionDate ?? this.admissionDate,
      phone: phone ?? this.phone,
      urlImage: urlImage ?? this.urlImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'job': job,
      'admissionDate': admissionDate.millisecondsSinceEpoch,
      'phone': phone,
      'urlImage': urlImage,
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      id: map['id'] as int,
      name: map['name'] as String,
      job: map['job'] as String,
      admissionDate: DateTime.fromMillisecondsSinceEpoch(map['admission_date'] as int),
      phone: map['phone'] as String,
      urlImage: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeModel.fromJson(String source) => EmployeeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EmployeeModel(id: $id, name: $name, job: $job, admissionDate: $admissionDate, phone: $phone, urlImage: $urlImage)';
  }

  @override
  bool operator ==(covariant EmployeeModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.job == job &&
      other.admissionDate == admissionDate &&
      other.phone == phone &&
      other.urlImage == urlImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      job.hashCode ^
      admissionDate.hashCode ^
      phone.hashCode ^
      urlImage.hashCode;
  }
}

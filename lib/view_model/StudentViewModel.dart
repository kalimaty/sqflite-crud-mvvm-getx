// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_sqflite/model/StudentModel.dart';
import 'package:flutter_sqflite/repositories/StudentRepository.dart';
import 'package:get/get.dart';

class StudentViewModel extends GetxController {
  var allStudent = <StudentModel>[].obs;
  StudentRepository studentRepository = StudentRepository();
  final studentId = 0.obs;
  final nameController = TextEditingController();
  late final isEditing = RxBool(false);
  @override
  void onInit() {
    super.onInit();
    fetchAllStudent();
  }

  fetchAllStudent() async {
    var student = await studentRepository.getStudent();
    allStudent.value = student;
    isEditing.value = false;
    update();
  }

  addStudent(StudentModel studentModel) {
    studentRepository.add(studentModel);
    fetchAllStudent();
  }

  updateStudent(StudentModel studentModel) {
    studentRepository.update(studentModel);
    fetchAllStudent();
  }

  deleteStudent(int id) {
    studentRepository.delete(id);
    Get.back();

    // update();
    fetchAllStudent();
    nameController.clear();
  }

  add() {
    if (nameController.text != "") {
      addStudent(StudentModel(id: null, name: nameController.text));
      // nameController.text = "";
      nameController.clear();
      fetchAllStudent();
    }
  }

  cancelEditing() {
    isEditing.value = false;
    // setState(() {});
    nameController.clear();
    fetchAllStudent();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_sqflite/model/StudentModel.dart';
import 'package:flutter_sqflite/view_model/StudentViewModel.dart';
import 'package:get/get.dart';

class StudentPage extends StatelessWidget {
  StudentPage({Key? key}) : super(key: key);

  final studentViewModel = Get.put(StudentViewModel());

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < studentViewModel.allStudent.length; i++) {}
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Obx(
          () => Container(
            color: Colors.blue[850],
            margin: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: studentViewModel.nameController,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  decoration: InputDecoration(
                    hintText: 'Enter name',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: studentViewModel.isEditing.value
                            ? studentViewModel.cancelEditing
                            : studentViewModel.add,
                        child: studentViewModel.isEditing.value
                            ? const Text("cancel editing")
                            : const Text("Add")),
                    const SizedBox(
                      width: 16,
                    ),
                    ElevatedButton(
                        onPressed: studentViewModel.isEditing.value
                            ? () {
                                if (studentViewModel.nameController.text !=
                                    "") {
                                  studentViewModel.updateStudent(StudentModel(
                                      id: studentViewModel.studentId.value,
                                      name: studentViewModel
                                          .nameController.text));
                                  studentViewModel.nameController.text = "";
                                  studentViewModel.isEditing.value = false;
                                  Get.back();
                                  // setState(() {});
                                }
                              }
                            : null,
                        child: Text("Update"))
                  ],
                ),
                Expanded(
                  // flex: 4,
                  child: ListView.builder(
                    itemCount: studentViewModel.allStudent.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              studentViewModel.studentId.value =
                                  studentViewModel.allStudent[index].id!;
                              studentViewModel.nameController.text =
                                  studentViewModel.allStudent[index].name!;
                              studentViewModel.isEditing.value = true;
                              // SizedBox sizedBox=SizedBox();

                              // setState(() {});
                            },
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  width: 3,
                                  color: Colors.black,
                                ),
                              ),
                              child: Card(
                                color: Colors.orange.shade300,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                          studentViewModel
                                              .allStudent[index].name!,
                                          style: const TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          studentViewModel.deleteStudent(
                                              studentViewModel
                                                  .allStudent[index].id!);
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                            // textDirection: TextDirection.rtl,
                                            size: 32,
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

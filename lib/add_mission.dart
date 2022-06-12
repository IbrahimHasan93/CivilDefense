import 'package:flutter/material.dart';
import 'package:missions/mission_dio.dart';
import 'package:missions/mission_modal.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  late TimeOfDay _selectedTime = TimeOfDay.now();
  final _controllerList = List<TextEditingController>.generate(
      7, (index) => TextEditingController());
  final _focusNodeList = List<FocusNode>.generate(7, (index) => FocusNode());

  void processData() {
    if (_formKey.currentState!.validate()) {
      MissionDio.insert(
        MissionModal(
            id: int.parse(_controllerList[2].text),
            name: _controllerList[1].text,
            age: int.parse(_controllerList[2].text),
            pandemicName: _controllerList[3].text,
            driverName: _controllerList[4].text,
            missionTime: _controllerList[5].text,
            additionalInfo: _controllerList[6].text),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("تم اضافة مهمة بنجاح")));
      // Navigator.pushNamed(context, ScreenRoutes.homeRoute);
      Navigator.pop(context);
    }
  }

  selecttime(BuildContext context) async {
    TimeOfDay? time =
        await showTimePicker(context: context, initialTime: _selectedTime);

    if (time != null) {
      _selectedTime = time;
      _controllerList[5]
        ..text = time.format(context)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _controllerList[5].text.length,
            affinity: TextAffinity.upstream));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            "إضافة مهمة",
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.purple.withAlpha(30),
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Wrap(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormField(
                    focusNode: _focusNodeList[1],
                    controller: _controllerList[1],
                    decoration: const InputDecoration(labelText: "الاسم :"),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ادخل المعلومات';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) =>
                        _focusNodeList[2].requestFocus(),
                  ),
                  TextFormField(
                    focusNode: _focusNodeList[2],
                    controller: _controllerList[2],
                    decoration: const InputDecoration(labelText: "العمر :"),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !RegExp(r'^[0-9]*$').hasMatch(value)) {
                        return 'الادخال للأرقام فقط';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) =>
                        _focusNodeList[3].requestFocus(),
                    //
                  ),
                  TextFormField(
                    focusNode: _focusNodeList[3],
                    controller: _controllerList[3],
                    decoration:
                        const InputDecoration(labelText: "اسم المسعف :"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ادخل المعلومات';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) =>
                        _focusNodeList[4].requestFocus(),
                  ),
                  TextFormField(
                    focusNode: _focusNodeList[4],
                    controller: _controllerList[4],
                    decoration:
                        const InputDecoration(labelText: "اسم السائق :"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ادخل المعلومات';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) => processData,
                  ),
                  TextFormField(
                    focusNode: AlwaysDisabledFocusNode(),
                    controller: _controllerList[5],
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.timer),
                        labelText: "وقت المهمة :"),
                    onTap: () {
                      selecttime(context);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ادخل المعلومات';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) =>
                        _focusNodeList[5].requestFocus(),
                  ),
                  TextFormField(
                    focusNode: _focusNodeList[6],
                    controller: _controllerList[6],
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration:
                        const InputDecoration(labelText: "معلومات اضافية  :"),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: processData,
                          child: const Text(
                            "تأكيد",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

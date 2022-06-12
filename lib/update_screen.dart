import 'package:flutter/material.dart';
import 'package:missions/mission_dio.dart';
import 'package:missions/mission_modal.dart';

class UpdateScreen extends StatefulWidget {
  final MissionModal missionModal;
  const UpdateScreen({required this.missionModal, Key? key}) : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  TextStyle textStyle = const TextStyle(fontSize: 14);
  final _controllerList = List<TextEditingController>.generate(
      7, (index) => TextEditingController());
  final _focusNodeList = List<FocusNode>.generate(7, (index) => FocusNode());

  @override
  void initState() {
    _controllerList[0].text = widget.missionModal.id.toString();
    _controllerList[1].text = widget.missionModal.name;
    _controllerList[2].text = widget.missionModal.age.toString();
    _controllerList[3].text = widget.missionModal.pandemicName;
    _controllerList[4].text = widget.missionModal.driverName;
    _controllerList[5].text = widget.missionModal.additionalInfo ?? '';
    _controllerList[6].text = widget.missionModal.missionTime;

    super.initState();
  }

  void processData() {
    if (_formKey.currentState!.validate()) {
      MissionDio.update(MissionModal(
          id: widget.missionModal.id,
          name: _controllerList[1].text,
          age: int.parse(_controllerList[2].text),
          pandemicName: _controllerList[3].text,
          driverName: _controllerList[4].text,
          additionalInfo: _controllerList[5].text,
          missionTime: _controllerList[6].text));
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("تم تعديل المهمة بنجاح")));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("تعديل مهمة",
              style: TextStyle(
                fontSize: 20,
              )),
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
                children: [
                  TextFormField(
                    focusNode: _focusNodeList[1],
                    controller: _controllerList[1],
                    style: textStyle,
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
                    style: textStyle,
                    decoration: const InputDecoration(labelText: "العمر :"),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ادخل المعلومات';
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
                    style: textStyle,
                    decoration:
                        const InputDecoration(labelText: "اسم المسعف :"),
                    keyboardType: TextInputType.name,
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
                    style: textStyle,
                    decoration:
                        const InputDecoration(labelText: "اسم السائق :"),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ادخل المعلومات';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) => processData,
                  ),
                  TextFormField(
                    focusNode: _focusNodeList[6],
                    controller: _controllerList[6],
                    style: textStyle,
                    decoration:
                        const InputDecoration(labelText: " وقت المهمة :"),
                  ),
                  TextFormField(
                    focusNode: _focusNodeList[5],
                    controller: _controllerList[5],
                    style: textStyle,
                    maxLines: 5,
                    decoration:
                        const InputDecoration(labelText: "معلومات اضافية :"),
                    keyboardType: TextInputType.name,
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
                            "تعديل",
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

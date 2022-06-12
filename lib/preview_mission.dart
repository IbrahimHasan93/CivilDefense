import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:missions/mission_modal.dart';

class PreviewMission extends StatefulWidget {
  final MissionModal missionModal;
  const PreviewMission({Key? key, required this.missionModal})
      : super(key: key);

  @override
  State<PreviewMission> createState() => _PreviewMissionState();
}

class _PreviewMissionState extends State<PreviewMission> {
  final textList = List<String>.generate(7, (index) => '');
  String? allTexts;
  @override
  void initState() {
    textList[0] = widget.missionModal.name;
    textList[1] = widget.missionModal.age.toString();
    textList[2] = widget.missionModal.pandemicName;
    textList[3] = widget.missionModal.driverName;
    textList[4] = widget.missionModal.missionTime;
    textList[5] = widget.missionModal.additionalInfo ?? '';
    allTexts = '' "الاسم :" +
        textList[0] +
        '\n ' +
        "العمر :" +
        textList[1] +
        '\n' +
        "اسم المسعف :" +
        textList[2] +
        '\n' +
        "اسم السائق :" +
        textList[3] +
        '\n' +
        " وقت المهمة :" +
        textList[4] +
        '\n' +
        "معلومات اضافية :" +
        textList[5] +
        '';

    super.initState();
  }

  Future<void> share() async {
    await FlutterShare.share(title: 'Example share', text: allTexts);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textstyle = const TextStyle(fontSize: 16);
    TextStyle textstyle1 =
        TextStyle(fontSize: 14, color: Theme.of(context).primaryColor);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            textList[0],
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/civil.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Wrap(children: [
            Card(
              margin: const EdgeInsets.all(20),
              elevation: 20,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "الاسم :",
                          style: textstyle,
                          textAlign: TextAlign.justify,
                        ),
                        Flexible(
                          child: Text(
                            textList[0],
                            style: textstyle1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "العمر :",
                          style: textstyle,
                          textAlign: TextAlign.justify,
                        ),
                        Flexible(
                          child: Text(
                            textList[1],
                            style: textstyle1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "اسم المسعف :",
                          style: textstyle,
                          textAlign: TextAlign.justify,
                        ),
                        Flexible(
                          child: Text(
                            textList[2],
                            style: textstyle1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "اسم السائق :",
                          style: textstyle,
                          textAlign: TextAlign.justify,
                        ),
                        Flexible(
                          child: Text(
                            textList[3],
                            style: textstyle1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " وقت المهمة :",
                          textAlign: TextAlign.justify,
                          style: textstyle,
                        ),
                        Flexible(
                          child: Text(
                            textList[4],
                            style: textstyle1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "معلومات اضافية :",
                          style: textstyle,
                          textAlign: TextAlign.justify,
                        ),
                        Flexible(
                          child: Text(
                            textList[5],
                            maxLines: 10,
                            style: textstyle1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              share();
                            },
                            icon: Icon(
                              Icons.share_sharp,
                              color: Theme.of(context).primaryColor,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:missions/main.dart';
import 'package:missions/mission_dio.dart';
import 'package:missions/mission_modal.dart';
import 'package:missions/preview_mission.dart';
import 'package:missions/update_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextStyle textStyle = const TextStyle(fontSize: 14);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () {
            setState(() {});
            return Future<void>.delayed(
              const Duration(seconds: 1),
            );
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: const Text(
                  "جدول المهام",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                centerTitle: true,
              ),
              SliverFillRemaining(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purple.withAlpha(30),
                  ),
                  child: FutureBuilder<List<MissionModal>>(
                      future: MissionDio.getAllData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "خطأ : " + snapshot.error.toString(),
                              style: textStyle,
                            ),
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data!.isEmpty) {
                            return Center(
                              child: Text(
                                "لا يوجد معلومات",
                                style: textStyle,
                              ),
                            );
                          }
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PreviewMission(
                                            missionModal:
                                                snapshot.data![index]),
                                      ),
                                    );
                                  },
                                  child: missionDetailWidget(
                                      snapshot.data![index]),
                                );
                              });
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () async {
            await Navigator.pushNamed(context, ScreenRoutes.addRoute);
            setState(() {});
          },
          label: Text(
            "إضافة مهمة",
            style: textStyle,
          ),
        ),
      ),
    );
  }

  Widget missionDetailWidget(MissionModal missionModal) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      SizedBox(
        width: 80,
        child: Text(
          missionModal.name,
          style: textStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      SizedBox(
        width: 30,
        child: Text(
          missionModal.age.toString(),
          style: textStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () async {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: Wrap(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                              ),
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'تأكيد حذف المهمة',
                                          style: textStyle,
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.close),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .7,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary:
                                                Theme.of(context).primaryColor),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          await MissionDio.delete(
                                              missionModal.id ?? 0);
                                          setState(() {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content:
                                                    Text("تم حذف المهمة بنجاح"),
                                              ),
                                            );
                                          });
                                        },
                                        child: Text(
                                          'تأكيد',
                                          style: textStyle,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      );
                    });
                //
              },
              icon: Icon(
                Icons.delete_forever_outlined,
                color: Colors.red.shade900,
              ),
            ),
            IconButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UpdateScreen(missionModal: missionModal),
                  ),
                );
                setState(() {});
              },
              icon: Icon(
                Icons.edit_outlined,
                color: Colors.indigo[900],
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

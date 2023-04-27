import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:extensionresoft/extensionresoft.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fontresoft/fontresoft.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/constants.dart';
import '../providers/providers.dart';

class Dashboard extends StatefulHookConsumerWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    bool a = ref.watch(themeProvider.select((value) => value));
    var controller = useTextEditingController();
    return Scaffold(
      //backgroundColor: Colors.white.withOpacity(0.95),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            //gradient: LinearGradient(colors: [Colors.black87, Colors.white], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 40, right: 20, left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Top Row
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  41.spaceXY(
                    Card(
                      color: Colors.blue,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                      ),
                      elevation: 3,
                      child: Constant.profile.circleImage(fit: BoxFit.cover),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            ref.watch(themeProvider.notifier).toggleTheme(!a);
                          },
                          child: Icons.brightness_4_outlined.edit(size: 30)),
                      20.spaceX(),
                      40.spaceXY(
                        Card(
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                          elevation: 3,
                          child: CircleAvatar(backgroundColor: Colors.white, child: CupertinoIcons.bell.edit(color: Colors.blue)),
                        ),
                      ),
                    ],
                  ),
                ]),
                30.spaceY(),
                Row(
                  children: [
                    'Hi M Daffa'.edit(textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                    5.spaceX(),
                    const Icon(CupertinoIcons.hand_thumbsup_fill, color: Colors.orange),
                  ],
                ),
                10.spaceY(),

                /// TextField
                20.radius(
                  elevation: 0,
                  child: TextFormField(
                    style: const TextStyle(fontFamily: FontResoft.sansPro),
                    controller: controller,
                    decoration: InputDecoration(
                      suffixIcon: 30.radius(color: Colors.white, child: CupertinoIcons.search.edit(color: Colors.blue)),
                      fillColor: Theme.of(context).colorScheme.inversePrimary,
                      filled: true,
                      hintText: 'Search for Poly',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue.shade400),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                30.spaceY(),

                /// Blue CardView
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    var isSize = layout(constraints);
                    return 25.radius(
                      elevation: 5,
                      color: Colors.blue,
                      child: SizedBox(
                        width: double.infinity,
                        height: isSize ? 180 : 155,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (isSize ? 300 : 165).spaceX(Constant.nurse.img(fit: BoxFit.cover, height: 350)),
                            //const VerticalDivider(width: 2),
                            Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                              'Covid 19'.edit(
                                textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: condition(isSize, 42, 21)),
                              ),
                              5.spaceY(),
                              (isSize ? 290 : 130).spaceX(
                                'Protect yourself and your family from Covid 19'.edit(textStyle: const TextStyle(color: Colors.white)),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                20.spaceY(),
                'What do you need?'.edit(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                ///GRID VIEW
                LayoutBuilder(
                  builder: (context, constraints) {
                    var isSize = layout(constraints);
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: 6,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisExtent: isSize ? 120 : 100),
                      itemBuilder: (context, index) {
                        index = index + 1;
                        return 25.radius(
                          color: index == 4 ? Colors.blue : Colors.white,
                          shadowColor: context.theme.primaryContainer,
                          elevation: 5,
                          margin: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                5.spaceY(),
                                iconList
                                    .map(
                                      (icon) => icon.edit(
                                        size: condition(isSize, 60, 30),
                                        color: condition(index == 4, Colors.white, Colors.blue.shade400),
                                      ),
                                    )
                                    .toList()[index - 1],
                                5.spaceY(),
                                'Medical Services $index'.edit(
                                  textStyle: TextStyle(color: condition(index == 4, Colors.white, Colors.black), fontSize: condition(isSize, 16, 12)),
                                  textAlign: TextAlign.center,
                                ),
                                //,
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                //200.spaceY()
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,

      /// Bottom Navigation
      bottomNavigationBar: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var isSize = layout(constraints);
          return Container(
            height: condition(isSize, 90, null),
            padding: EdgeInsets.only(left: 20, right: 20, top: 1, bottom: condition(isSize, 15, 20)),
            child: BottomBarFloating(
              items: [
                const TabItem(title: 'Home', icon: Icons.home_rounded),
                const TabItem(title: 'Alert', icon: Icons.screenshot_monitor_rounded),
                TabItem(
                  title: 'Location',
                  icon: Icons.location_on_rounded,
                  count: 15.radius(
                      color: Colors.blue.shade50,
                      width: 25,
                      child: '4'.edit(
                        textStyle: const TextStyle(color: Colors.blue),
                        textAlign: TextAlign.center,
                      )),
                ),
                const TabItem(title: 'Account', icon: Icons.person_rounded),
              ],
              backgroundColor: Colors.blue.shade600,
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(40),
              colorSelected: Colors.white,
              //boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 1, offset: Offset(0, 1))],
              indexSelected: ref.watch(tabProvider.select((value) => value)),
              paddingVertical: condition(isSize, 10, 20),
              onTap: (int index) {
                //current = index;
                controller.text = index.toString();
                ref.watch(tabProvider.notifier).setTab = index;
              },
              /*onTap: (int index) => setState(() {
                current = index;
                controller.text = index.toString();
              }),*/
            ),
          );
        },
      ),
    );
  }

  bool layout(BoxConstraints constraints) {
    var size = constraints.maxWidth;
    var orientation = MediaQuery.of(context).orientation.name;
    var width = condition(orientation == "portrait", MediaQuery.of(context).size.width, MediaQuery.of(context).size.flipped.width);
    return size > width;
  }

  var iconList = [
    Icons.medical_services_rounded,
    Icons.medical_information,
    Icons.local_hospital_rounded,
    Icons.health_and_safety_rounded,
    Icons.bedroom_parent_rounded,
    Icons.medication_liquid_rounded,
  ];
}

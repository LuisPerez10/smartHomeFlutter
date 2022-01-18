import 'dart:async';

import 'package:flutter/material.dart';
import 'package:openhab_flutter/services/items_service.dart';
import 'package:openhab_flutter/widgets/Buttons/boton_custom.dart';
import 'package:openhab_flutter/widgets/floating_button.dart';
import 'package:openhab_flutter/widgets/side_menu.dart';
import 'package:provider/provider.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({Key? key}) : super(key: key);

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  String itemControl = "control";
  @override
  void initState() {
    // syncItemsInterval();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final itemsService = Provider.of<ItemsService>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('Control Remoto'),
        ),
        drawer: const SideMenu(),
        floatingActionButton: FlaotingButton(),
        body: Container(
          color: Color.fromARGB(255, 246, 248, 250),
          child: GridView.count(
            crossAxisCount: 3,
            children: [
              BotonCustom(
                onPressed: () async {
                  await sendSwitch("tvMenuButton");
                },
                text: "menu",
                label: "",
                icon: Icons.menu,
                color: Colors.white,
              ),
              BotonCustom(
                onPressed: () async {
                  await sendSwitch("tvHomeButton");
                },
                text: "home",
                label: "",
                icon: Icons.home,
                color: Colors.white,
              ),
              BotonCustom(
                onPressed: () async {
                  await sendSwitch("tvOnOff");
                },
                text: "Power",
                label: "on/off",
                color: Colors.yellow,
                icon: Icons.settings_power,
              ),
              BotonCustom(
                onPressed: () async {
                  await sendSwitch("tvBackButton");
                },
                text: "Back",
                label: "",
                icon: Icons.arrow_back,
                color: Colors.white,
              ),
              BotonCustom(
                onPressed: () async {
                  await sendSwitch("tvVolumeUp");
                },
                text: "VOL +",
                label: "",
                icon: Icons.volume_up,
              ),
              BotonCustom(
                onPressed: () async {
                  await sendSwitch("tvChannelUp");
                },
                text: "CH + ",
                label: "",
                icon: Icons.control_camera,
              ),
              BotonCustom(
                  onPressed: () async {
                    await sendSwitch("tvAvButton");
                  },
                  text: "av mode",
                  label: "",
                  icon: Icons.mode,
                  color: Colors.white),
              BotonCustom(
                onPressed: () async {
                  await sendSwitch("tvVolumeDown");
                },
                text: "VOL -",
                label: "",
                icon: Icons.volume_down,
              ),
              BotonCustom(
                onPressed: () async {
                  await sendSwitch("tvChannelDown");
                },
                text: "CH - ",
                label: "",
                icon: Icons.control_camera,
              ),
              BotonCustom(
                onPressed: () async {
                  await sendSwitch("tvOneButton");
                },
                text: "1",
                label: "on/off",
                icon: Icons.dashboard,
              ),
              BotonCustom(
                onPressed: () async => await sendSwitch("tvTwoButton"),
                text: "2",
                label: "",
                icon: Icons.dashboard,
                color: Colors.white,
              ),
              BotonCustom(
                onPressed: () async {
                  await sendSwitch("tvThreeButton");
                },
                text: "3",
                label: "on/off",
                icon: Icons.dashboard,
              ),
              BotonCustom(
                onPressed: () async {
                  await sendSwitch("tvFourButton");
                },
                text: "4",
                label: "on/off",
                icon: Icons.dashboard,
                color: Colors.white,
              ),
              BotonCustom(
                onPressed: () async {
                  await sendSwitch("tvFiveButton");
                },
                text: "5",
                label: "on/off",
                icon: Icons.dashboard,
              ),
              BotonCustom(
                onPressed: () async {
                  await sendSwitch("tvSixButton");
                },
                text: "6",
                label: "on/off",
                icon: Icons.dashboard,
                color: Colors.white,
              ),
              BotonCustom(
                onPressed: () async {
                  await sendSwitch("tvSevenButton");
                },
                text: "7",
                label: "on/off",
                icon: Icons.dashboard,
              ),
              BotonCustom(
                onPressed: () async {
                  await sendSwitch("tvEightButton");
                },
                text: "8",
                label: "on/off",
                icon: Icons.dashboard,
                color: Colors.white,
              ),
              BotonCustom(
                onPressed: () async {
                  await sendSwitch("tvNineButton");
                },
                text: "9",
                label: "on/off",
                icon: Icons.dashboard,
              ),
            ],
          ),
        ));
  }

  Future sendSwitch(String state) async {
    final itemsService = Provider.of<ItemsService>(context, listen: false);
    await itemsService.setItemsState(itemControl, state);
  }

  void syncItemsInterval() {
    Timer.periodic(new Duration(seconds: 2), (timer) {
      syncItems();
    });
  }

  Future syncItems() async {
    // final setupServerService =
    //     Provider.of<SetupServerService>(context, listen: false);
    // await setupServerService.getState();
    setState(() {});
  }
}

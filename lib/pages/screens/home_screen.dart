import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:openhab_flutter/services/items_service.dart';
import 'package:openhab_flutter/widgets/Buttons/boton_custom.dart';
import 'package:openhab_flutter/widgets/floating_button.dart';
import 'package:openhab_flutter/widgets/side_menu.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  String stateled = "1";
  double _brightness = 100; //0-100
  double _colorTemp = 6500; //2700-6500
  bool _actionActivado = true; //2700-6500

  Color _currentColor = Colors.blue;
  final _controller = CircleColorPickerController(
    initialColor: Colors.blue,
  );
  @override
  void initState() {
    super.initState();
    syncItemsInterval();
    // timer =
    //     Timer.periodic(Duration(seconds: 15), (Timer t) => syncItemsInterval());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('Smart Home'),
        ),
        drawer: const SideMenu(),
        floatingActionButton: FlaotingButton(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                botonLuz(context),
                sensorLuz(context),
                sensorAction(context),
              ]),
              SizedBox(
                height: 20,
              ),
              brilloWidget(context),
              tempColorWidget(context),
              Container(
                color: _currentColor,
                child: Text(
                    "fd ${HSVColor.fromColor(_currentColor).hue.toString()}"),
              ),
              FittedBox(
                child: Row(
                  children: [
                    CircleColorPicker(
                      controller: _controller,
                      onChanged: (color) async {
                        _currentColor = color;
                        setState(() {});
                        await sendColor();
                      },
                    )
                  ],
                ),
              )
              // switchItem("text_sensor_value"),
            ],
          ),
        ));
  }

  Widget brillo(BuildContext context) {
    final itemsService = Provider.of<ItemsService>(context, listen: false);
    String itemName = "item_smart_brightness";
    return Container(
        child: FutureBuilder(
      future: itemsService.getItemState(itemName),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _brightness = double.parse(snapshot.data.toString());
          return Slider(
            key: UniqueKey(),
            activeColor: Colors.white,
            inactiveColor: Colors.white60,
            label: '',
            min: 1,
            max: 100,
            value: _brightness,
            onChanged: (valor) {
              setState(() {
                _brightness = valor;
                itemsService.setItemsState(itemName, valor.toStringAsFixed(0));
              });
            },
          );
        } else {
          return Slider(
            key: UniqueKey(),
            activeColor: Colors.white,
            inactiveColor: Colors.white60,
            label: '',
            min: 1,
            max: 100,
            value: _brightness,
            onChanged: (valor) {
              setState(() {
                _brightness = valor;
                itemsService.setItemsState(itemName, valor.toStringAsFixed(0));
              });
            },
          );
        }
      },
    ));
  }

  Widget brilloWidget(BuildContext context) {
    return Container(
      key: UniqueKey(),

      decoration: BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            const Color.fromARGB(255, 88, 160, 250),
            const Color.fromARGB(255, 54, 117, 246),
          ],
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        // border: Border.all(color: Colors.blueAccent),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      // width: 100,
      // height: 100,
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_sharp,
                color: Colors.white,
              ),
              Expanded(child: SizedBox()),
              Text(
                "Brillo",
                style: TextStyle(color: Colors.white, fontSize: 16),
                softWrap: true,
              )
            ],
          ),
          Column(
            children: [
              Center(
                child: Text(_brightness.toStringAsFixed(0),
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              brillo(context),
            ],
          )
        ],
      ),
    );
  }

  Widget tempColorWidget(BuildContext context) {
    return Container(
      key: UniqueKey(),

      decoration: BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            const Color.fromARGB(255, 88, 160, 250),
            const Color.fromARGB(255, 54, 117, 246),
          ],
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),

        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        // border: Border.all(color: Colors.blueAccent),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      // width: 100,
      // height: 100,
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_sharp,
                color: Colors.white,
              ),
              Expanded(child: SizedBox()),
              Text(
                "Temperatura",
                style: TextStyle(color: Colors.white, fontSize: 16),
                softWrap: true,
              )
            ],
          ),
          Column(
            children: [
              Center(
                child: Text(_colorTemp.toStringAsFixed(0),
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              tempColor(context),
            ],
          )
        ],
      ),
    );
  }

  Widget tempColor(BuildContext context) {
    final itemsService = Provider.of<ItemsService>(context, listen: false);
    String itemName = "item_smart_colortemp";
    return Container(
        child: FutureBuilder(
      future: itemsService.getItemState(itemName),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _colorTemp = double.parse(snapshot.data.toString());
          return Slider(
            key: UniqueKey(),
            activeColor: Colors.white,
            inactiveColor: Colors.white60,
            label: 'Tamano de la imagen',
            min: 2700,
            max: 6500,
            value: _colorTemp,
            onChanged: (valor) {
              setState(() {
                _colorTemp = valor;
                itemsService.setItemsState(itemName, valor.toStringAsFixed(0));
              });
            },
          );
        } else {
          return Slider(
            key: UniqueKey(),
            activeColor: Colors.white,
            inactiveColor: Colors.white60,
            label: 'Tamano de la imagen',
            //      divisions: 20,
            min: 2700,
            max: 6500,
            value: _colorTemp,
            onChanged: (valor) {
              setState(() {
                _colorTemp = valor;
                itemsService.setItemsState(itemName, valor.toStringAsFixed(0));
              });
            },
          );
        }
      },
    ));
  }

  Future sendSwitch(String itemName) async {
    final itemsService = Provider.of<ItemsService>(context, listen: false);
    await itemsService.setItemsState(itemName, stateled);
  }

  Widget switchItem(String itemname, VoidCallback onPressed) {
    final itemsService = Provider.of<ItemsService>(context);
    return FutureBuilder(
      future: itemsService.getItemState(itemname),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BotonCustom(
            onPressed: onPressed,
            text: snapshot.data.toString() == "1" ? "ON" : "OFF",
            label: "",
            icon: snapshot.data.toString() == "1"
                ? Icons.lightbulb
                : Icons.lightbulb_outline,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
          );
        } else {
          return Center(child: CircularProgressIndicator(strokeWidth: 2));
        }
      },
    );
  }

  Widget sensorItem(String label, IconData icon, Color? color, String itemname,
      VoidCallback onPressed) {
    final itemsService = Provider.of<ItemsService>(context);
    return FutureBuilder(
      future: itemsService.getItemState(itemname),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BotonCustom(
            onPressed: onPressed,
            text: snapshot.data.toString(),
            label: label,
            color: color, //Color.fromARGB(255, 0, 255, 153)
            icon: icon,
            borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
          );
        } else {
          return Center(child: CircularProgressIndicator(strokeWidth: 2));
        }
      },
    );
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

  Widget botonLuz(BuildContext context) {
    return switchItem("item_smart_led", () async {
      if (stateled.compareTo("1") == 0) {
        stateled = "0";
      } else {
        stateled = "1";
      }
      sendSwitch("item_smart_led");
      setState(() {});
    });
  }

  Widget sensorAction(BuildContext context) {
    return sensorItem("Reglas", Icons.rule, null, "NewItem", () {});
  }

  Widget sensorLuz(BuildContext context) {
    // cambiar la accion del incon sensor luz con este cuando sea bajo brightness_2
    return sensorItem("Sensor Luz", Icons.light_mode, Colors.white,
        "text_sensor_value", () {});
  }

  Future sendColor() async {
    String colorHSB = _getHSBColorStr(_currentColor);
    final itemsService = Provider.of<ItemsService>(context, listen: false);
    await itemsService.setItemsState("item_color_picker", colorHSB);
  }

  String _getHSBColorStr(Color currentColor) {
    HSVColor hsv = HSVColor.fromColor(currentColor);
    String h = hsv.hue.toStringAsFixed(0);
    String s = (hsv.saturation * 100).toStringAsFixed(0);
    String b = (hsv.value * 100).toStringAsFixed(0);
    return "$h,$s,$b";
  }
}

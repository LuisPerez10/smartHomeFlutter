import 'package:flutter/material.dart';
import 'package:openhab_flutter/services/setupServer_service.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _DrawerHeader(),
          ListTile(
            leading: const Icon(Icons.light),
            title: const Text('Broadlink'),
            onTap: () {
              Navigator.pushReplacementNamed(context, "home");
            },
          ),
          ListTile(
            leading: const Icon(Icons.tv),
            title: const Text('LG-TV'),
            onTap: () {
              Navigator.pushReplacementNamed(context, "control");
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Setup'),
            onTap: () async {
              final setupServerService =
                  Provider.of<SetupServerService>(context, listen: false);
              await setupServerService.forgotSetup();

              Navigator.pop(context);
              // Navigator.pushNamedAndRemoveUntil(
              //     context, 'setup', (Route<dynamic> route) => false);
              Navigator.pushReplacementNamed(context, "setup");
            },
          ),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Container(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/menu-img.jpg'), fit: BoxFit.cover)),
    );
  }
}

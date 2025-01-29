import 'package:flutter/material.dart';
import 'package:jupiter/src/presentation/widgets/image_network_jupiter.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                UserAccountsDrawerHeader(
                  accountName: const Text('Oflutter.com'),
                  accountEmail: Text(""),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: ImageNetworkJupiter(
                        url:
                            'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                      ),
                      // Image.network(
                      //   'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                      //   fit: BoxFit.cover,
                      //   width: 120,
                      //   height: 120,
                      // ),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    // color: Colors.blue,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('HOME'),
                  tileColor: Colors.transparent,
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('MAP'),
                  tileColor: Colors.transparent,
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('PAYBILL'),
                  tileColor: Colors.transparent,
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('SETTING'),
                  tileColor: Colors.transparent,
                  onTap: () {},
                ),
              ],
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Divider(color: Colors.grey),
                ListTile(
                  title: const Center(child: TextLabel(text: 'Sing Out')),
                  onTap: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

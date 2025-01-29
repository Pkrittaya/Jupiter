import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EdgeInsets edgeInsets = MediaQuery.of(context).padding;
    final bool isDrawer = Navigator.of(context).canPop() == false;
    return Column(
      children: [
        Container(
          color: Colors.blue,
          child: Padding(
            padding: edgeInsets,
            child: Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(5),
              child: Row(children: [
                IconButton(
                  icon: Icon(
                    isDrawer ? Icons.menu : Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (isDrawer) {
                      Scaffold.of(context).openDrawer();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.verified_user),
                  onPressed: () => {},
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}

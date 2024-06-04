import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hasPreviousRoute;
  final bool tohome;

  const CustomAppBar({
    Key? key,
    required this.hasPreviousRoute,
    this.tohome = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF1C51A1),
      titleSpacing: 0,
      title: Center(
        child: Image.asset(
          'assets/logo-horizontal.png',
          height: 40,
          alignment: Alignment.center,
        ),
      ),
      leading: IconButton(
        icon: hasPreviousRoute
            ? const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )
            : const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
        onPressed: () {
          if (hasPreviousRoute) {
            if (tohome) {
              navigateToHome(context);
            } else {
              Navigator.of(context).pop();
            }
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Sair do aplicativo?"),
                  actions: <Widget>[
                    TextButton(
                      child: const Text("Cancelar"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text("Sair"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        SystemNavigator.pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void navigateToHome(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: 1,
    );
  }
}

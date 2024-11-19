import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webordernft/config/constant.dart';
import 'package:webordernft/config/palette.dart';
import 'package:webordernft/config/sizeconf.dart';
import 'package:webordernft/module/login/provider/login_provider.dart';
import 'package:webordernft/module/main/provider/main_provider.dart';
import 'package:webordernft/module/main/view/side_menu.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? username;
  String? rolename;
  bool isPressed = false;
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  confirmLogout(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Sz.headline5(
                context,
                'Logout',
                TextAlign.left,
                Palette.blackClr,
              ),
              SizedBox(height: Sz.wpfactor(context, 25)),
              Sz.title(context, 'kamu akan keluar dari aplikasi ?',
                  TextAlign.left, Palette.textClr),
              SizedBox(height: Sz.wpfactor(context, 20)),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Provider.of<LoginProvider>(context, listen: false)
                    .submitLogout(context);
              },
              child: Sz.buttonText(
                context,
                'Ya, Keluar',
                TextAlign.center,
                Palette.white,
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Palette.primary,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Sz.buttonText(
                context,
                'Batal',
                TextAlign.center,
                Palette.blackClr,
              ),
              style: ButtonStyle(
                  // backgroundColor: MaterialStateProperty.all<Color>(
                  //   Palette.whiteClr,
                  // ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  // side: BorderSide(
                  //     color: Palette.primary, width: 1.0),
                ),
              )),
            ),
          ],
        );
      },

      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     top: Radius.circular(20),
      //   ),
      // ),
    );
  }

  getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _rolename = prefs.getString('rolename');
    final String? _username = prefs.getString('name');

    setState(() {
      username = _username;
      rolename = _rolename;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainbgcolor,
      body: SingleChildScrollView(
        child: Container(
          height: Sz.heightsz(context),
          padding: EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menu Samping dengan Animasi
              Consumer<MainProvider>(
                builder: (context, mainProvider, _) {
                  return ClipRRect(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 900),
                      curve: Curves.easeOutExpo,
                      width: mainProvider.isMenuOpen
                          ? Sz.wpfactor(context, 350)
                          : 0.0,
                      child: mainProvider.isMenuOpen
                          ? SideMenu()
                          : SizedBox.shrink(),
                    ),
                  );
                },
              ),
              Expanded(
                flex: 11,
                child: Consumer<MainProvider>(
                  builder: (context, main, _) => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: Sz.hpfactor(context, 40),
                          child: Row(
                            children: [
                              SizedBox(width: Sz.hpfactor(context, 10)),
                              GestureDetector(
                                onTapDown: (_) {
                                  // Mengatur status ketika ditekan
                                  setState(() {
                                    isPressed = true;
                                  });
                                },
                                onTapUp: (_) {
                                  // Mengatur status ketika selesai ditekan
                                  setState(() {
                                    isPressed = false;
                                  });
                                },
                                onTap: () {
                                  // Toggle menu saat ikon ditekan
                                  Provider.of<MainProvider>(context,
                                          listen: false)
                                      .toggleMenu();
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  transform: isPressed
                                      ? Matrix4.identity()
                                      : Matrix4.identity()
                                    ..scale(1.2),
                                  child: Icon(
                                    Icons.menu,
                                    color: Palette.primary,
                                  ),
                                ),
                              ),
                              SizedBox(width: Sz.hpfactor(context, 10)),
                              Sz.headline(context, '${companyname}',
                                  TextAlign.left, Palette.primary),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: EdgeInsets.all(
                                      Sz.hpfactor(context, 5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(Icons.notifications_none_rounded),
                                        SizedBox(
                                            width: Sz.wpfactor(context, 30)),
                                        Icon(Icons.person),
                                        SizedBox(
                                            width: Sz.wpfactor(context, 5)),
                                        Row(
                                          children: [
                                            Sz.title(
                                                context,
                                                '${username}',
                                                TextAlign.left,
                                                Palette.primary),
                                            SizedBox(
                                                width:
                                                    Sz.wpfactor(context, 25)),
                                            Sz.title(
                                                context,
                                                '|',
                                                TextAlign.center,
                                                Palette.labelClr),
                                            SizedBox(
                                                width:
                                                    Sz.wpfactor(context, 25)),
                                            Sz.caption(
                                                context,
                                                '${rolename}',
                                                TextAlign.left,
                                                Palette.labelClr),
                                          ],
                                        ),
                                        SizedBox(
                                            width: Sz.wpfactor(context, 30)),
                                        GestureDetector(
                                          onTap: () {
                                            confirmLogout(context);
                                          },
                                          child: Icon(Icons.logout,
                                              color: Palette.primary2),
                                        ),
                                        SizedBox(
                                            width: Sz.wpfactor(context, 30)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(indent: Sz.wpfactor(context, 12)),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Sz.hpfactor(context, 15),
                            ),
                            child: main.pages!,
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

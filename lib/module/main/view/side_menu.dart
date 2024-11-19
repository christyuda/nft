import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../common/widget/nodatawidget.dart';
import '../../../config/constant.dart';
import '../../../config/palette.dart';
import '../../../config/sizeconf.dart';
import '../../../routes/page_routes.dart';
import '../../login/service/login_service.dart';
import '../../login/service/model/list_menu.dart';
import '../provider/main_provider.dart';

class SideMenu extends StatelessWidget {
  SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 1.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
        ),
        child: itemMenu(),
      ),
    );
  }
}

class itemMenu extends StatefulWidget {
  const itemMenu({
    super.key,
  });

  @override
  State<itemMenu> createState() => _itemMenuState();
}

class _itemMenuState extends State<itemMenu> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: Sz.hpfactor(context, 10)),
              // height: Sz.wpfactor(context, 80),
              child: Image.asset(
                companyLogo,
                // width: Sz.wpfactor(context, 110),
                height: 45,
              ),
            ),
          ),
          SizedBox(height: 50),
          GestureDetector(
            onTap: () {
              // Provider.of<MainProvider>(context, listen: false).pages =
              // DashboardScreen();
            },
            child: Container(
              margin: EdgeInsets.only(left: 18),
              child:
                  Sz.title(context, 'MENU', TextAlign.left, Palette.blackClr),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: Container(
              child: FutureBuilder(
                future: LoginService.getListMenu(context),
                builder: (context, AsyncSnapshot<List> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (snapshot.hasError)
                        return NoDataWidgetWithIlustrator();

                      var _menu = snapshot.data;

                      if (snapshot.hasData) {
                        if (_menu!.length == 0) {
                          return NoDataWidgetWithIlustrator();
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: _menu.length,
                            itemBuilder: (context, index) {
                              ListMenu _item = _menu[index];
                              // final GlobalKey< ExpansionTileCustomState>
                              final GlobalKey<ExpansionTileCoreState> itemKey =
                                  GlobalKey();
                              return ExpansionTileGroup(
                                children: [
                                  ExpansionTileItem(
                                    // initiallyExpanded: currentIndex == 0,
                                    // onExpansionChanged: () {},
                                    maintainState: true,
                                    expansionKey: itemKey,
                                    isHasBottomBorder: false,
                                    isHasTopBorder: false,
                                    expendedBorderColor: Colors.blue,
                                    title: Row(
                                      children: [
                                        // Sz.caption(context, _item.icon!,
                                        //     TextAlign.left, Palette.primary1),
                                        SvgPicture.asset(
                                          'assets/icons/${_item.icon!}',
                                          height: 16,
                                          width: 16,
                                          color: Palette.primary,
                                        ),

                                        SizedBox(width: 6),
                                        Sz.subtitle(context, _item.namaMenu,
                                            TextAlign.left, Palette.blackClr)
                                      ],
                                    ),
                                    children: _item.submenu!.map<Widget>(
                                      (e) {
                                        return Row(
                                          children: [
                                            SizedBox(width: 25),
                                            Icon(Icons.circle_outlined,
                                                size: 10),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: TextButton(
                                                  onPressed: () {
                                                    itemKey.currentState
                                                        ?.expand();
                                                    Provider.of<MainProvider>(
                                                                context,
                                                                listen: false)
                                                            .pages =
                                                        pageRoutes
                                                            .firstWhere((m) =>
                                                                m.pagename ==
                                                                e.routesPage)
                                                            .routes;

                                                    Provider.of<MainProvider>(
                                                                context,
                                                                listen: false)
                                                            .namaMenu =
                                                        e.namaMenu!
                                                            .toUpperCase();
                                                  },
                                                  child: Sz.subtitle(
                                                    context,
                                                    e.namaMenu,
                                                    TextAlign.left,
                                                    Palette.blackClr,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } else {
                        return NoDataWidgetWithIlustrator();
                      }
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

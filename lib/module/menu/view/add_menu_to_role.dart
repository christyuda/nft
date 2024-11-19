import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:webordernft/common/provider/general_provider.dart';
import 'package:webordernft/config/palette.dart';
import 'package:webordernft/config/sizeconf.dart';
import 'package:webordernft/module/menu/provider/menu_provider.dart';
import 'package:webordernft/module/menu/service/model/all_menu.dart';

import '../../../config/constant.dart';
import '../../login/service/model/list_menu.dart';

class FormaddmenuToRole extends StatefulWidget {
  const FormaddmenuToRole({Key? key}) : super(key: key);

  @override
  State<FormaddmenuToRole> createState() => _FormaddmenuToRoleState();
}

class _FormaddmenuToRoleState extends State<FormaddmenuToRole> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MenuProvider>(context, listen: false).getAllMenu(context);
    Provider.of<MenuProvider>(context, listen: false).getRoleList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<MenuProvider>(
      builder: (context, mn, _) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Card(
              child: SingleChildScrollView(
                child: Column(
                  // shrinkWrap: true,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(Sz.hpfactor(context, 20)),
                      child: Sz.headline6(
                          context, 'Menu', TextAlign.left, Palette.blackClr),
                    ),
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: mn.allmenu.length,
                        itemBuilder: (context, index) {
                          AllMenu _item = mn.allmenu[index];

                          // final GlobalKey<ExpansionTileState> itemKeyAllmenu =
                          //     GlobalKey<ExpansionTileState>();

                          return ExpansionTileGroup(
                            children: [
                              ExpansionTileItem(
                                // initiallyExpanded: currentIndex == 0,
                                // onExpansionChanged: () {},
                                maintainState: true,
                                // expansionKey: itemKeyAllmenu,
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

                                    SizedBox(width: 10),
                                    Sz.title(context, _item.namaMenu,
                                        TextAlign.left, Palette.blackClr)
                                  ],
                                ),
                                children: _item.submenu!.map<Widget>(
                                  (e) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 25),
                                        Icon(Icons.circle_outlined, size: 10),
                                        Expanded(
                                          flex: 4,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: TextButton(
                                              onPressed: () {},
                                              child: Sz.title(
                                                context,
                                                e.namaMenu,
                                                TextAlign.left,
                                                Palette.blackClr,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Sz.subtitle(
                                                  context,
                                                  'Tambahkan',
                                                  TextAlign.right,
                                                  Palette.blackClr),
                                              IconButton(
                                                iconSize: 20,
                                                onPressed: () {
                                                  Provider.of<GeneralProv>(
                                                          context,
                                                          listen: false)
                                                      .isLoading();
                                                  mn.submitMenuToRole(context,
                                                      e.parentId, e.menuId);
                                                },
                                                icon: Icon(Icons.add),
                                              ),
                                            ],
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Card(
              child: SingleChildScrollView(
                child: Column(
                  // shrinkWrap: true,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(Sz.hpfactor(context, 20)),
                          child: Sz.headline6(context, 'Role Menu',
                              TextAlign.left, Palette.blackClr),
                        ),
                        Container(
                          width: Sz.hpfactor(context, 300),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: FormBuilderDropdown(
                            name: 'role',
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: 'role Tidak boleh Kosong'),
                            ]),
                            decoration: InputDecoration(
                              // labelText: 'Kategori TIcket',
                              fillColor: Colors.white,
                              hintText: 'Pilih role',
                              labelStyle: TextStyle(
                                  color: Palette.white,
                                  fontSize: titleSz,
                                  fontFamily: sfProFnt),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Palette.primary,
                                    width: 1.0,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(radiusVal)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(radiusVal),
                                borderSide: BorderSide(
                                  color: Palette.bordercolor,
                                  width: 1.0,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(radiusVal),
                                borderSide: BorderSide(
                                  color: Palette.primary,
                                  width: 1.0,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(radiusVal),
                                borderSide: BorderSide(
                                  color: Palette.errorColor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            items: mn.rolelist
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e.roleId,
                                    child: Text(
                                        e.rolename == null ? '' : e.rolename!),
                                  ),
                                )
                                .toList(),

                            onChanged: (val) {
                              mn.roleid = val.toString();
                              mn.getAllmenuByRole(context);
                            },
                            // valueTransformer: (val) =>
                            //     val?.toString(),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: mn.rolemenu.length,
                      itemBuilder: (context, index) {
                        ListMenu _item = mn.rolemenu[index];
                        // final GlobalKey<ExpansionTileCustomState>
                        //     itemKeyRolebymenu = GlobalKey();
                        return ExpansionTileGroup(
                          children: [
                            ExpansionTileItem(
                              maintainState: true,
                              // expansionKey: itemKeyRolebymenu,
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

                                  SizedBox(width: 10),
                                  Sz.title(context, _item.namaMenu,
                                      TextAlign.left, Palette.blackClr),
                                  SizedBox(width: 10),
                                  IconButton(
                                      onPressed: () {
                                        Provider.of<GeneralProv>(context,
                                                listen: false)
                                            .isLoading();
                                        mn.deleteMenuFromRole(
                                          context,
                                          _item.id,
                                          0,
                                        );
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Palette.errorColor,
                                      ))
                                ],
                              ),
                              children: _item.submenu!.map<Widget>(
                                (e) {
                                  return Row(
                                    children: [
                                      SizedBox(width: 25),
                                      Icon(Icons.circle_outlined, size: 10),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Sz.title(
                                            context,
                                            e.namaMenu,
                                            TextAlign.left,
                                            Palette.blackClr,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Provider.of<GeneralProv>(
                                                        context,
                                                        listen: false)
                                                    .isLoading();
                                                mn.deleteMenuFromRole(
                                                    context, e.id, e.parentid);
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Palette.errorColor,
                                              ))
                                        ],
                                      ))
                                    ],
                                  );
                                },
                              ).toList(),
                            ),
                          ],
                        );
                      },
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

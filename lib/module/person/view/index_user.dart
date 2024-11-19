import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:webordernft/config/palette.dart';
import 'package:webordernft/config/sizeconf.dart';
import 'package:webordernft/module/workflow/provider/workflow_provider.dart';

import '../../../common/provider/general_provider.dart';
import '../../../config/constant.dart';
import '../provider/user_provider.dart';

class FormListUser extends StatefulWidget {
  const FormListUser({Key? key}) : super(key: key);

  @override
  State<FormListUser> createState() => _FormListUserState();
}

class _FormListUserState extends State<FormListUser> {
  final _keylistuser = GlobalKey<FormBuilderState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getlistuser(context);
    Provider.of<UserProvider>(context, listen: false).getProfileUser(context);
    Provider.of<WorkflowProvider>(context, listen: false).getRole(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, usr, _) => Card(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Sz.headline5(context, 'Kelola User', TextAlign.left,
                          Palette.blackClr),
                      SizedBox(height: Sz.hpfactor(context, 20)),
                      Row(
                        children: [
                          FormBuilder(
                            key: _keylistuser,
                            child: Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    width: Sz.hpfactor(context, 200),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(radiusVal),
                                    ),
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (val) {
                                        usr.emailUser = val;
                                      },
                                      decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                            color: Palette.bgtexfield,
                                            fontSize: 12.0,
                                            fontFamily: 'Poppins'),
                                        hintText: 'Email / Nama',
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(radiusVal),
                                          borderSide: BorderSide(
                                            color: Palette.primary,
                                            width: 2.0,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(radiusVal),
                                          borderSide: BorderSide(
                                            color: Palette.bordercolor,
                                            width: 2.0,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(radiusVal),
                                          borderSide: BorderSide(
                                            color: Palette.primary,
                                            width: 2.0,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(radiusVal),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    width: Sz.hpfactor(context, 200),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: FormBuilderDropdown(
                                      name: 'role',
                                      decoration: InputDecoration(
                                        // labelText: 'Kategori TIcket',
                                        fillColor: Colors.white,
                                        hintText: 'Pilih Role',
                                        labelStyle: TextStyle(
                                            color: Palette.white,
                                            fontSize: titleSz,
                                            fontFamily: sfProFnt),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.primary,
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                radiusVal)),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(radiusVal),
                                          borderSide: BorderSide(
                                            color: Palette.bordercolor,
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(radiusVal),
                                          borderSide: BorderSide(
                                            color: Palette.primary,
                                            width: 1.0,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(radiusVal),
                                          borderSide: BorderSide(
                                            color: Palette.errorColor,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      items: Provider.of<WorkflowProvider>(
                                              context,
                                              listen: false)
                                          .listroles!
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: '${e.roleId.toString()}',
                                              child: Text(e.rolename == null
                                                  ? ''
                                                  : e.rolename!),
                                            ),
                                          )
                                          .toList(),

                                      onChanged: (val) {
                                        usr.roleUser = val!;
                                      },
                                      // valueTransformer: (val) =>
                                      //     val?.toString(),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    height: Sz.wpfactor(context, 49),
                                    width: Sz.hpfactor(context, 100),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_keylistuser.currentState!
                                            .validate()) {
                                          _keylistuser.currentState!.save();
                                          Provider.of<GeneralProv>(context,
                                                  listen: false)
                                              .isLoading();
                                          Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .page = 1;
                                          Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .getlistuser(context);
                                        }
                                      },
                                      child: Sz.buttonText(
                                        context,
                                        'Filter',
                                        TextAlign.center,
                                        Palette.white,
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            Palette.primary,
                                          ),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      radiusVal),
                                            ),
                                          )),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    height: Sz.wpfactor(context, 49),
                                    width: Sz.hpfactor(context, 100),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _keylistuser.currentState!.reset();
                                        usr.clearFilter();
                                      },
                                      child: Sz.buttonText(
                                        context,
                                        'Reset',
                                        TextAlign.center,
                                        Palette.blackClr,
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            Palette.white,
                                          ),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      radiusVal),
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Sz.hpfactor(context, 20)),
                      Expanded(
                        child: DataTable2(
                            headingRowHeight: 30,
                            columnSpacing: 12,
                            horizontalMargin: 12,
                            minWidth: 600,
                            headingRowColor: MaterialStateProperty.all<Color>(
                              Palette.primary2,
                            ),
                            columns: [
                              DataColumn2(
                                fixedWidth: 78,
                                label: Sz.headline(context, 'ID',
                                    TextAlign.left, Palette.white),
                                size: ColumnSize.S,
                              ),
                              DataColumn2(
                                size: ColumnSize.L,
                                label: Sz.headline(context, 'Nama',
                                    TextAlign.left, Palette.white),
                              ),
                              DataColumn2(
                                size: ColumnSize.L,
                                label: Sz.headline(context, 'Email',
                                    TextAlign.left, Palette.white),
                              ),
                              DataColumn2(
                                size: ColumnSize.M,
                                label: Sz.headline(context, 'Role',
                                    TextAlign.left, Palette.white),
                              ),
                              DataColumn2(
                                size: ColumnSize.M,
                                label: Sz.headline(context, 'Status',
                                    TextAlign.left, Palette.white),
                              ),
                              DataColumn2(
                                size: ColumnSize.M,
                                label: Sz.headline(context, 'Action',
                                    TextAlign.left, Palette.white),
                              ),
                            ],
                            rows: usr.userlist.map((e) {
                              return DataRow(cells: [
                                DataCell(
                                  Sz.subtitle(context, '${e.id}',
                                      TextAlign.left, Palette.blackClr),
                                ),
                                DataCell(
                                  GestureDetector(
                                    onTap: () {
                                      Provider.of<GeneralProv>(context,
                                              listen: false)
                                          .instantSendMessage(
                                              'User profile Segera hadir, sedang dalam tahap pengembangan');
                                    },
                                    child: Container(
                                      child: Sz.subtitle(context, '${e.name}',
                                          TextAlign.left, Palette.blackClr),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Sz.subtitle(context, '${e.email}',
                                      TextAlign.left, Palette.blackClr),
                                ),
                                DataCell(
                                  Sz.subtitle(context, '${e.rolename}',
                                      TextAlign.left, Palette.blackClr),
                                ),
                                DataCell(
                                  Sz.subtitle(
                                      context,
                                      '${e.status == 1 ? 'Aktif' : 'Non Aktif'}',
                                      TextAlign.left,
                                      Palette.blackClr),
                                ),
                                DataCell(ElevatedButton(
                                  onPressed: () {
                                    if (_keylistuser.currentState!.validate()) {
                                      _keylistuser.currentState!.save();
                                      Provider.of<GeneralProv>(context,
                                              listen: false)
                                          .isLoading();
                                    }
                                  },
                                  child: Sz.subtitle(
                                    context,
                                    'Disable',
                                    TextAlign.center,
                                    Palette.white,
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Palette.primary3,
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(radiusVal),
                                        ),
                                      )),
                                )),
                              ]);
                            }).toList()
                            // rows: List<DataRow>.generate(
                            //   100,
                            //   (index) => DataRow(
                            //     cells: [
                            //       DataCell(Text('A' * (10 - index % 10))),
                            //       DataCell(Text('B' * (10 - (index + 5) % 10))),
                            //       DataCell(Text('C' * (15 - (index + 5) % 10))),
                            //       DataCell(Text('D' * (15 - (index + 10) % 10))),
                            //       DataCell(
                            //           Text(((index + 0.1) * 25.4).toString()))
                            //     ],
                            //   ),
                            // ),
                            ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                    child: Sz.caption(
                                        context,
                                        'Showing ${usr.fromRow} to ${usr.toRow} of ${usr.totalRow} entries',
                                        TextAlign.start,
                                        Palette.primary)),
                                Expanded(
                                    child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.skip_previous_rounded),
                                        onPressed: () {
                                          usr.nextPage(context, 'previous');
                                        },
                                        color: Palette.primary),
                                    Sz.caption(
                                        context,
                                        'Page : ${usr.currentPage} / ${usr.lastPage}',
                                        TextAlign.center,
                                        Palette.primary),
                                    IconButton(
                                      icon: Icon(Icons.skip_next_rounded),
                                      onPressed: () {
                                        usr.nextPage(context, 'next');
                                      },
                                      color: Palette.primary,
                                    )
                                  ],
                                ))
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

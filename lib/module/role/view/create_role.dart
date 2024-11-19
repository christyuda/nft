import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../../../common/provider/general_provider.dart';
import '../../../config/constant.dart';
import '../../../config/palette.dart';
import '../../../config/sizeconf.dart';
import '../provider/role_provider.dart';

class FormCreateRole extends StatefulWidget {
  const FormCreateRole({Key? key}) : super(key: key);

  @override
  State<FormCreateRole> createState() => _FormCreateRoleState();
}

class _FormCreateRoleState extends State<FormCreateRole> {
  final _fKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      body: Consumer<RoleProvider>(
        builder: (context, rl, _) => Card(
          elevation: 1.5,
          child: Container(
            padding: EdgeInsets.all(Sz.hpfactor(context, 20)),
            child: FormBuilder(
              key: _fKey,
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Sz.hpfactor(context, 20)),
                          Sz.headline5(context, 'Create Role', TextAlign.left,
                              Palette.blackClr),
                          SizedBox(height: Sz.hpfactor(context, 20)),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Sz.title(context, 'Nama Role',
                                      TextAlign.left, Palette.blackClr),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: Sz.hpfactor(context, 300),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: FormBuilderTextField(
                                            // autovalidateMode: AutovalidateMode.always,
                                            maxLength: 50,
                                            name: 'rolename',
                                            validator:
                                                FormBuilderValidators.compose([
                                              FormBuilderValidators.required(),
                                            ]),
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              // suffixIcon: const Icon(Icons.error,
                                              //     color: Colors.red),
                                              counterText: '',
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
                                                      BorderRadius.circular(
                                                          radiusVal)),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        radiusVal),
                                                borderSide: BorderSide(
                                                  color: Palette.bordercolor,
                                                  width: 1.0,
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        radiusVal),
                                                borderSide: BorderSide(
                                                  color: Palette.primary,
                                                  width: 1.0,
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        radiusVal),
                                                borderSide: BorderSide(
                                                  color: Palette.errorColor,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            onChanged: (val) {
                                              rl.rolename = val;
                                            }),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: Sz.hpfactor(context, 20)),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Sz.title(context, 'Job Desk',
                                      TextAlign.left, Palette.blackClr),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: Sz.hpfactor(context, 300),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: FormBuilderTextField(
                                            // autovalidateMode: AutovalidateMode.always,
                                            maxLength: 50,
                                            name: 'jobdesk',
                                            validator:
                                                FormBuilderValidators.compose([
                                              FormBuilderValidators.required(),
                                            ]),
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              // suffixIcon: const Icon(Icons.error,
                                              //     color: Colors.red),
                                              counterText: '',
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
                                                      BorderRadius.circular(
                                                          radiusVal)),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        radiusVal),
                                                borderSide: BorderSide(
                                                  color: Palette.bordercolor,
                                                  width: 1.0,
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        radiusVal),
                                                borderSide: BorderSide(
                                                  color: Palette.primary,
                                                  width: 1.0,
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        radiusVal),
                                                borderSide: BorderSide(
                                                  color: Palette.errorColor,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            onChanged: (val) {
                                              rl.deskripsi = val;
                                            }),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: Sz.hpfactor(context, 20)),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(flex: 2, child: Container()),
                                Expanded(
                                  flex: 7,
                                  child: Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          if (_fKey.currentState
                                                  ?.saveAndValidate() ??
                                              false) {
                                            Provider.of<GeneralProv>(context,
                                                    listen: false)
                                                .isLoading();
                                            rl.submitCreateRole(context, _fKey);
                                          } else {
                                            debugPrint(_fKey.currentState?.value
                                                .toString());
                                            debugPrint('validation failed');
                                          }
                                        },
                                        child: Sz.buttonText(
                                          context,
                                          'SUBMIT',
                                          TextAlign.center,
                                          Palette.white,
                                        ),
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.all(20)),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            Palette.primary2,
                                          ),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      radiusVal),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          _fKey.currentState!.reset();
                                        },
                                        child: Sz.buttonText(
                                          context,
                                          'Batal',
                                          TextAlign.center,
                                          Palette.blackClr,
                                        ),
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.all(20)),
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
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

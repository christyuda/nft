import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../../../common/provider/general_provider.dart';
import '../../../config/constant.dart';
import '../../../config/palette.dart';
import '../../../config/sizeconf.dart';
import '../provider/user_provider.dart';

class FormCreateNewUser extends StatefulWidget {
  const FormCreateNewUser({Key? key}) : super(key: key);

  @override
  State<FormCreateNewUser> createState() => _FormCreateNewUserState();
}

class _FormCreateNewUserState extends State<FormCreateNewUser> {
  final _fKeyNewUser = GlobalKey<FormBuilderState>();

  // RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  // double password_strength = 0;
  // // 0: No password
  // // 1/4: Weak
  // // 2/4: Medium
  // // 3/4: Strong
  // //   1:   Great
  // //A function that validate user entered password
  // bool validatePassword(String pass) {
  //   String _password = pass.trim();
  //   if (_password.isEmpty) {
  //     setState(() {
  //       password_strength = 0;
  //     });
  //   } else if (_password.length < 6) {
  //     setState(() {
  //       password_strength = 1 / 4;
  //     });
  //   } else if (_password.length < 8) {
  //     setState(() {
  //       password_strength = 2 / 4;
  //     });
  //   } else {
  //     if (pass_valid.hasMatch(_password)) {
  //       setState(() {
  //         password_strength = 4 / 4;
  //       });
  //       return true;
  //     } else {
  //       setState(() {
  //         password_strength = 3 / 4;
  //       });
  //       return false;
  //     }
  //   }
  //   return false;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getRoleList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      body: Consumer<UserProvider>(
        builder: (context, usr, _) => Card(
          elevation: 1.5,
          child: Container(
            padding: EdgeInsets.all(Sz.hpfactor(context, 20)),
            child: FormBuilder(
              key: _fKeyNewUser,
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Sz.headline5(context, 'Create User Account',
                              TextAlign.left, Palette.blackClr),
                          SizedBox(height: Sz.hpfactor(context, 20)),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Sz.title(context, 'Nama Lengkap',
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
                                            name: 'namalengkap',
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
                                              usr.namaUser = val;
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Sz.title(context, 'Email',
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
                                            validator:
                                                FormBuilderValidators.compose([
                                              FormBuilderValidators.required(),
                                            ]),
                                            maxLength: 50,
                                            name: 'email',
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
                                              usr.emailUser = val;
                                              // textInputAction: TextInputAction.next,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Sz.title(context, 'Password',
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
                                            obscureText: true,
                                            name: 'Password',
                                            maxLength: 30,
                                            // validator: (value) {
                                            //   //call function to check password
                                            //   bool result = validatePassword(value!);
                                            //   if (result) {
                                            //     // create account event
                                            //     return null;
                                            //   } else {
                                            //     return " Password harus mengandung huruf Capital, huruf kecil & karakter special";
                                            //   }
                                            // },
                                            validator:
                                                FormBuilderValidators.compose([
                                              FormBuilderValidators.required(),
                                            ]),
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
                                              usr.password = val;
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Sz.title(
                                      context,
                                      'Konfirmasi Password',
                                      TextAlign.left,
                                      Palette.blackClr),
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
                                            obscureText: true,
                                            maxLength: 30,
                                            name: 'Konfirmasi',
                                            validator:
                                                FormBuilderValidators.compose([
                                              FormBuilderValidators.required(),
                                            ]),
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
                                              usr.cpassword = val;
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Sz.title(context, 'Role',
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
                                        child: FormBuilderDropdown(
                                          name: 'role',
                                          validator:
                                              FormBuilderValidators.compose([
                                            FormBuilderValidators.required(
                                                errorText:
                                                    'role Tidak boleh Kosong'),
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
                                          items: usr.rolelist!
                                              .map(
                                                (e) => DropdownMenuItem(
                                                  value: e.roleId,
                                                  child: Text(e.rolename == null
                                                      ? ''
                                                      : e.rolename!),
                                                ),
                                              )
                                              .toList(),

                                          onChanged: (val) {
                                            usr.isDisableCrtUsr = false;
                                            usr.roleUser = val.toString();
                                          },
                                          // valueTransformer: (val) =>
                                          //     val?.toString(),
                                        ),
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(flex: 2, child: Container()),
                                Expanded(
                                  flex: 7,
                                  child: Row(
                                    children: [
                                      Container(
                                        child: ElevatedButton(
                                          onPressed: usr.isDisableCrtUsr! ==
                                                  true
                                              ? null
                                              : () {
                                                  if (_fKeyNewUser.currentState
                                                          ?.saveAndValidate() ??
                                                      false) {
                                                    Provider.of<GeneralProv>(
                                                            context,
                                                            listen: false)
                                                        .isLoading();
                                                    usr.submitCreateUserAccount(
                                                        context, _fKeyNewUser);
                                                  } else {
                                                    debugPrint(_fKeyNewUser
                                                        .currentState?.value
                                                        .toString());
                                                    debugPrint(
                                                        'validation failed');
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
                                                MaterialStateProperty.all<
                                                    Color>(
                                              usr.isDisableCrtUsr == true
                                                  ? Palette.labelClr
                                                  : Palette.primary2,
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
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _fKeyNewUser.currentState!.reset();
                                            usr.isDisableCrtUsr = true;
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
                                                MaterialStateProperty.all<
                                                    Color>(
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

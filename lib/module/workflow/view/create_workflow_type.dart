import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../../../common/provider/general_provider.dart';
import '../../../config/constant.dart';
import '../../../config/palette.dart';
import '../../../config/sizeconf.dart';
import '../provider/workflow_provider.dart';

class FormCreateWorkflowType extends StatefulWidget {
  const FormCreateWorkflowType({Key? key}) : super(key: key);

  @override
  State<FormCreateWorkflowType> createState() => _FormCreateWorkflowTypeState();
}

class _FormCreateWorkflowTypeState extends State<FormCreateWorkflowType> {
  final _fKey = GlobalKey<FormBuilderState>();
  final _dropDownKey = GlobalKey<FormBuilderFieldState>();
  final _dropDownKeySA = GlobalKey<FormBuilderFieldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<WorkflowProvider>(context, listen: false)
        .getParentKategori(context, 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      body: Consumer<WorkflowProvider>(
        builder: (context, wf, _) => Card(
          child: Container(
            padding: EdgeInsets.all(Sz.hpfactor(context, 20)),
            child: FormBuilder(
              key: _fKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Sz.hpfactor(context, 20)),
                    Sz.headline5(context, 'Create Workflow Type ( Alur Kerja )',
                        TextAlign.left, Palette.blackClr),
                    SizedBox(height: Sz.hpfactor(context, 20)),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Sz.headline(context, 'Nama Workflow',
                                  TextAlign.left, Palette.blackClr),
                            ),
                          ),
                          Expanded(
                              flex: 7,
                              child: Row(
                                children: [
                                  Container(
                                    width: Sz.hpfactor(context, textFieldWidth),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: FormBuilderTextField(
                                        // autovalidateMode: AutovalidateMode.always,
                                        maxLength: 100,
                                        name: 'namaworkflow',
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                        ]),
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          // suffixIcon: const Icon(Icons.error,
                                          //     color: Colors.red),
                                          // isDense: true,

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
                                            borderRadius: BorderRadius.circular(
                                                radiusVal),
                                            borderSide: BorderSide(
                                              color: Palette.bordercolor,
                                              width: 1.0,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                radiusVal),
                                            borderSide: BorderSide(
                                              color: Palette.primary,
                                              width: 1.0,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                radiusVal),
                                            borderSide: BorderSide(
                                              color: Palette.errorColor,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        onChanged: (val) {
                                          wf.workflowname = val;
                                        }),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    SizedBox(height: Sz.hpfactor(context, 20)),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Sz.headline(context, 'Kategori',
                                  TextAlign.left, Palette.blackClr),
                            ),
                          ),
                          Expanded(
                              flex: 7,
                              child: Row(
                                children: [
                                  Container(
                                    width: Sz.hpfactor(context, textFieldWidth),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: FormBuilderDropdown(
                                      name: 'parent',
                                      decoration: InputDecoration(
                                        // labelText: 'Kategori TIcket',
                                        fillColor: Colors.white,
                                        hintText: 'Pilih Parent Kategori',
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
                                      items: wf.parentList!
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: e.id,
                                              child: Text(e.name == null
                                                  ? ''
                                                  : e.name!),
                                            ),
                                          )
                                          .toList(),

                                      onChanged: (val) {
                                        wf.parentid = val.toString();
                                        wf.kategoriId = val.toString();
                                        _dropDownKey.currentState!.reset();
                                        _dropDownKey.currentState!
                                            .setValue(null);
                                        wf.getSubKategori(context);
                                        // usr.isDisableCrtUsr = false;
                                        // usr.roleUser = val;
                                      },
                                      // valueTransformer: (val) =>
                                      //     val?.toString(),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    SizedBox(height: Sz.hpfactor(context, 20)),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Sz.headline(context, 'Sub Kategori',
                                  TextAlign.left, Palette.blackClr),
                            ),
                          ),
                          Expanded(
                              flex: 7,
                              child: Row(
                                children: [
                                  Container(
                                    width: Sz.hpfactor(context, textFieldWidth),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: FormBuilderDropdown(
                                      key: _dropDownKey,
                                      name: 'parent',
                                      decoration: InputDecoration(
                                        // labelText: 'Kategori TIcket',
                                        fillColor: Colors.white,
                                        hintText: 'Pilih Parent Kategori',
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
                                      items: wf.listsubkategori!
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: e.id,
                                              child: Text(e.name == null
                                                  ? ''
                                                  : e.name!),
                                            ),
                                          )
                                          .toList(),

                                      onChanged: (val) {
                                        wf.subkategoriId = val!.toString();
                                        // usr.isDisableCrtUsr = false;
                                        // usr.roleUser = val;
                                      },
                                      // valueTransformer: (val) =>
                                      //     val?.toString(),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    SizedBox(height: Sz.hpfactor(context, 20)),
                    Container(
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Sz.headline(
                                  context,
                                  'Service Level Guarante (SLG | Menit)',
                                  TextAlign.left,
                                  Palette.blackClr),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Row(
                              children: [
                                Container(
                                  width: Sz.hpfactor(context, 150),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: FormBuilderTextField(
                                      // autovalidateMode: AutovalidateMode.always,
                                      maxLength: 6,
                                      name: 'slg',
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                      ]),
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
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
                                      onChanged: (val) {
                                        wf.slg = int.parse(val!);
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Sz.hpfactor(context, 20)),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Sz.title(context, 'Deskripsi',
                                TextAlign.left, Palette.blackClr),
                          ),
                          Expanded(
                            flex: 7,
                            child: Row(
                              children: [
                                Container(
                                  width: Sz.hpfactor(context, textFieldWidth),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: FormBuilderTextField(
                                      // autovalidateMode: AutovalidateMode.always,
                                      maxLength: 500,
                                      maxLines: 4,
                                      name: 'Deskripsi',
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                      ]),
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
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
                                      onChanged: (val) {
                                        wf.desc = val;
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Sz.hpfactor(context, 20)),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 7,
                            child: Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    if (_fKey.currentState?.saveAndValidate() ??
                                        false) {
                                      Provider.of<GeneralProv>(context,
                                              listen: false)
                                          .isLoading();
                                      wf.submitWorkflowType(context, _fKey);
                                    } else {
                                      debugPrint(
                                          _fKey.currentState?.value.toString());
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
                                            BorderRadius.circular(radiusVal),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    _fKey.currentState!.reset();
                                  },
                                  child: Sz.buttonText(
                                    context,
                                    'Cancel',
                                    TextAlign.center,
                                    Palette.blackClr,
                                  ),
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(20)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.white,
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(radiusVal),
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
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../../../common/provider/general_provider.dart';
import '../../../config/constant.dart';
import '../../../config/palette.dart';
import '../../../config/sizeconf.dart';
import '../provider/workflow_provider.dart';
import '../service/model/node.dart';

class FormCreateWorkflowNode extends StatefulWidget {
  const FormCreateWorkflowNode({Key? key}) : super(key: key);

  @override
  State<FormCreateWorkflowNode> createState() => _FormCreateWorkflowNodeState();
}

class _FormCreateWorkflowNodeState extends State<FormCreateWorkflowNode> {
  final _fKey = GlobalKey<FormBuilderState>();
  final _dropDownKey = GlobalKey<FormBuilderFieldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<WorkflowProvider>(context, listen: false)
        .getWorkflowtype(context);
    Provider.of<WorkflowProvider>(context, listen: false).getRole(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      body: Consumer<WorkflowProvider>(
        builder: (context, wf, _) => Column(
          children: [
            Expanded(
              flex: 7,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(Sz.hpfactor(context, 20)),
                  child: FormBuilder(
                    key: _fKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Sz.hpfactor(context, 20)),
                          Sz.headline5(
                              context,
                              'Create Workflow Node ( Simpul alur kerja )',
                              TextAlign.left,
                              Palette.blackClr),
                          SizedBox(height: Sz.hpfactor(context, 20)),
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: Sz.headline(context, 'WorkflowType',
                                        TextAlign.left, Palette.blackClr),
                                  ),
                                ),
                                Expanded(
                                    flex: 7,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: Sz.hpfactor(
                                              context, textFieldWidth),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: FormBuilderDropdown(
                                            name: 'wf',
                                            decoration: InputDecoration(
                                              // labelText: 'Kategori TIcket',
                                              fillColor: Colors.white,
                                              hintText: 'Pilih Workflow Type',
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
                                            items: wf.listnodes!
                                                .map(
                                                  (e) => DropdownMenuItem(
                                                    value:
                                                        '${e.id.toString() + '|' + e.workflowName!}',
                                                    child: Text(
                                                        e.workflowName == null
                                                            ? ''
                                                            : e.workflowName!),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (val) {
                                              wf.workflowtypeid =
                                                  val!.split('|').elementAt(0);
                                              wf.workflowname =
                                                  val.split('|').elementAt(1);
                                            },
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
                                    child: Sz.headline(context, 'Role',
                                        TextAlign.left, Palette.blackClr),
                                  ),
                                ),
                                Expanded(
                                    flex: 7,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: Sz.hpfactor(
                                              context, textFieldWidth),
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
                                            items: wf.listroles!
                                                .map(
                                                  (e) => DropdownMenuItem(
                                                    value:
                                                        '${e.roleId.toString() + '|' + e.rolename!}',
                                                    child: Text(
                                                        e.rolename == null
                                                            ? ''
                                                            : e.rolename!),
                                                  ),
                                                )
                                                .toList(),

                                            onChanged: (val) {
                                              wf.roleid = val;
                                              print(wf.roleid);
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
                                        'Service Level Aggreement (SLA / Menit)',
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
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: FormBuilderTextField(
                                            // autovalidateMode: AutovalidateMode.always,
                                            maxLength: 6,
                                            name: 'slg',
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
                                              wf.sla = int.parse(val!);
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
                                  child: Sz.title(context, 'Job Desc',
                                      TextAlign.left, Palette.blackClr),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: Sz.hpfactor(
                                            context, textFieldWidth),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: FormBuilderTextField(
                                            // autovalidateMode: AutovalidateMode.always,
                                            maxLength: 500,
                                            maxLines: 4,
                                            name: 'jobdesc',
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
                                              wf.jobdesk = val;
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
                                          if (_fKey.currentState
                                                  ?.saveAndValidate() ??
                                              false) {
                                            Provider.of<GeneralProv>(context,
                                                    listen: false)
                                                .isLoading();
                                            wf.addNodesToLocal(context, _fKey);
                                          } else {
                                            debugPrint(_fKey.currentState?.value
                                                .toString());
                                            debugPrint('validation failed');
                                          }
                                        },
                                        child: Sz.buttonText(
                                          context,
                                          'Add',
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(Sz.hpfactor(context, 20)),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Sz.title(
                              context,
                              'Nodes ( ${wf.workflowname == null ? '' : wf.workflowname} )',
                              TextAlign.left,
                              Palette.blackClr)),
                      Expanded(
                        flex: 7,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: wf.listlocalnodes!.length,
                              itemBuilder: (context, index) {
                                NodeLocal _item = wf.listlocalnodes![index];
                                return Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: Sz.hpfactor(context, 10)),
                                    padding: EdgeInsets.all(
                                        Sz.hpfactor(context, 20)),
                                    child: Sz.title(context, _item.rolename,
                                        TextAlign.left, Palette.blackClr),
                                  ),
                                );
                              },
                            )),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            wf.simpanNodes(context, _fKey);
                          },
                          child: Sz.buttonText(
                            context,
                            'Simpan Nodes',
                            TextAlign.center,
                            Palette.white,
                          ),
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(20)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Palette.primary2,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(radiusVal),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

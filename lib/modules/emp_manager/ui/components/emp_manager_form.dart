import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yd8/core/common/types.dart';
import 'package:yd8/modules/emp_manager/domain/entities.dart';
import 'package:yd8/modules/emp_manager/ui/bloc/emp_manager_bloc.dart';
import 'package:yd8/modules/emp_manager/ui/components/widgets/custom_form_text_field.dart';
import 'package:yd8/modules/emp_manager/ui/components/widgets/form_block.dart';
import 'package:yd8/modules/emp_manager/ui/components/widgets/radio_groups.dart';
import 'package:yd8/modules/emp_manager/ui/components/widgets/key_value_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmpManagerForm extends StatefulWidget {
  final EmpManagerBloc empBloc;

  const EmpManagerForm({super.key, required this.empBloc});

  @override
  State<EmpManagerForm> createState() => _EmpManagerFormState();
}

class _EmpManagerFormState extends State<EmpManagerForm> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _departmentController = TextEditingController();
  final _salaryController = TextEditingController();
  final _roleController = TextEditingController();

  final List<KeyValuePairControllers> _keyValues = [];

  Gender _gender = Gender.male;
  DateTime _hireDate = DateTime.now();
  EmpStatus _empStatus = EmpStatus.active;
  EmploymentType _empType = EmploymentType.fullTime;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final locale = AppLocalizations.of(context)!;
    const double formWidth = 800;

    return Scaffold(
      appBar: AppBar(title: Text(locale.new_emp)),
      body: _ScrollableForm(
        formKey: _formKey,
        formFields: [
          FormBlock(
            title: locale.personal_info,
            fields: [
              CustomFormTextField(
                labelText: AppLocalizations.of(context)!.first_name,
                controller: _firstNameController,
              ),
              CustomFormTextField(
                labelText: locale.middle_name,
                isOptional: true,
                controller: _middleNameController,
              ),
              CustomFormTextField(
                labelText: locale.last_name,
                controller: _lastNameController,
              ),
              GenderRadioGroup(
                onChanged: (g) {
                  setState(() {
                    _gender = g!;
                  });
                },
              ),
            ],
          ),

          FormBlock(
            title: locale.contact_info,
            fields: [
              CustomFormTextField(
                labelText: locale.email,
                controller: _emailController,
                validator: (input) {
                  final emailRegex = RegExp(
                    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                  );
                  if (input != null) {
                    if (input.isNotEmpty) {
                      if (!emailRegex.hasMatch(input)) {
                        return locale.invalid_email;
                      }
                    }
                  }

                  return CustomFormTextField.requiredValidator(input);
                },
              ),
              CustomFormTextField(
                labelText: locale.phone,
                controller: _phoneNumberController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              CustomFormTextField(
                labelText: locale.address1,
                controller: _address1Controller,
              ),
              CustomFormTextField(
                labelText: locale.address2,
                controller: _address2Controller,
                isOptional: true,
              ),
            ],
          ),

          FormBlock(
            title: locale.employment_info,
            fields: [
              CustomFormTextField(
                labelText: locale.department,
                controller: _departmentController,
              ),
              CustomFormTextField(
                labelText: locale.role,
                controller: _roleController,
              ),
              CustomFormTextField(
                labelText: locale.salary,
                controller: _salaryController,
                inputFormatters: [
                  FilteringTextInputFormatter(
                    RegExp(r'^\d+\.?\d{0,2}'),
                    allow: true,
                  ),
                ],
              ),
              InputDatePickerFormField(
                fieldLabelText: locale.hiring_date,
                firstDate: DateTime.fromMillisecondsSinceEpoch(0),
                acceptEmptyDate: false,
                onDateSaved: (date) {
                  _hireDate = date;
                },
                lastDate: DateTime.now(),
                initialDate: DateTime.now(),
              ),
              EmploymentTypeRadioGroup(
                onChanged: (t) {
                  setState(() {
                    _empType = t!;
                  });
                },
              ),
              StatusRadioGroup(
                onChanged: (s) {
                  setState(() {
                    _empStatus = s!;
                  });
                },
              ),
            ],
          ),

          SizedBox(
            width: formWidth,
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(locale.additional_info, style: textTheme.headlineSmall),
                Expanded(child: KeyValueForm(items: _keyValues)),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton.icon(
        label: Text(locale.submit),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();

            widget.empBloc.add(
              AddEmp(
                emp: EmpImpl(
                  firstName: _firstNameController.text,
                  middleName: _middleNameController.text,
                  lastName: _lastNameController.text,
                  email: _emailController.text,
                  phone: [_phoneNumberController.text],
                  department: _departmentController.text,
                  role: _roleController.text,
                  address: [_address1Controller.text, _address2Controller.text],
                  salary: BigInt.from(double.parse(_salaryController.text)),
                  hireDate: _hireDate.toIso8601String(),
                  type: _empType,
                  gender: _gender.name,
                  status: _empStatus,
                  attr: {
                    for (var kv in _keyValues)
                      kv.keyController.text: kv.valueController.text,
                  },
                ),
              ),
            );

            Navigator.pop(context);
          }
        },
        icon: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _departmentController.dispose();
    _salaryController.dispose();
    _roleController.dispose();
  }
}

class _ScrollableForm extends StatelessWidget {
  final List<Widget> formFields;
  final Key? formKey;

  const _ScrollableForm({required this.formFields, this.formKey});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              spacing: 32,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [...formFields],
            ),
          ),
        ),
      ),
    );
  }
}

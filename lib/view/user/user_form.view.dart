import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:testme/model/models.dart';
import 'package:testme/view/components/simple_app_bar.dart';
import 'package:testme/viewmodel/user.dart';

class UserForm extends StatefulWidget {
  User? user;
  final bool isCreatePage;

  UserForm({Key? key, this.user, required this.isCreatePage}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

Widget _gap() => const SizedBox(height: 16);

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  bool _modified = false;
  late TextEditingController _country;
  late TextEditingController _countryCode;

  @override
  void initState() {
    super.initState();
    _country = TextEditingController(text: widget.user?.location?.country);
    _countryCode = TextEditingController(text: widget.user?.nat);
  }

  @override
  Widget build(BuildContext context) {
    widget.user ??= User();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SimpleAppBar(
          title: widget.isCreatePage ? "Creation" : "Modification"),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                initialValue: widget.user?.firstName,
                onChanged: (value) {
                  setState(() {
                    widget.user?.firstName = value;
                    if (!_modified) _modified = true;
                  });
                },
              ),
              _gap(),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Prénom',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                initialValue: widget.user?.lastName,
                onChanged: (value) {
                  setState(() {
                    widget.user?.lastName = value;
                    if (!_modified) _modified = true;
                  });
                },
              ),
              _gap(),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                initialValue: widget.user?.email,
                onChanged: (value) {
                  setState(() {
                    widget.user?.email = value;
                    if (!_modified) _modified = true;
                  });
                },
              ),
              _gap(),
              TextFormField(
                controller: _country,
                decoration: const InputDecoration(
                  labelText: 'Pays',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                // initialValue:,
                onChanged: (value) {
                  setState(() {
                    widget.user?.location?.country = value;
                    _country.text = value;
                    if (!_modified) _modified = true;
                  });
                },
                onTap: () {
                  // stop the keboard showing
                  FocusScope.of(context).unfocus();

                  // show country list
                  showCountryPicker(
                    context: context,
                    showPhoneCode:
                        true, // optional. Shows phone code before the country name.
                    onSelect: (Country country) {
                      _country.text = country.name.toString();
                      _countryCode.text = country.countryCode.toUpperCase();
                      setState(() {
                        widget.user?.location?.country =
                            country.name.toString().toUpperCase();
                        widget.user?.nat = country.countryCode.toLowerCase();
                      });
                    },
                  );
                },
              ),
              _gap(),
              // TextFormField(
              //   decoration:
              //       const InputDecoration(labelText: 'Numéro de téléphone'),
              //   initialValue: widget.user?.phone,
              //   onChanged: (value) {
              //     setState(() {
              //       widget.user?.phone = value;
              //     });
              //   },
              // ),
              IntlPhoneField(
                // autovalidateMode: AutovalidateMode.always,
                // controller: _phoneNumberController,
                decoration: const InputDecoration(
                  labelText: "Numeros de Telephone",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                initialCountryCode: _countryCode.text.toUpperCase() == ""
                    ? "TG"
                    : _countryCode.text.toUpperCase(),
                initialValue: widget.user?.phone,
                onChanged: (phone) {
                  setState(() {
                    widget.user?.phone =
                        "(${phone.countryCode}) ${phone.number}";
                    if (!_modified) _modified = true;
                  });
                },
                // disableLengthCheck: false,
                // validator: (phoneNumber) =>
                //     phoneNumberValidator(context, phoneNumber),
                onCountryChanged: (country) {
                  _country.text = country.name.toString();
                  _countryCode.text = country.code.toUpperCase();
                  setState(() {
                    widget.user?.location?.country =
                        country.name.toString().toUpperCase();
                    widget.user?.nat = country.code.toLowerCase();
                    if (!_modified) _modified = true;
                  });
                },
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_modified) {
                      if (_formKey.currentState!.validate()) {
                        final uservm =
                            Provider.of<UserViewModel>(context, listen: false);
                        if (widget.isCreatePage) {
                          uservm.insertUser(widget.user!);
                        } else {
                          uservm.updateUser(widget.user!);
                        }
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text(widget.isCreatePage ? "Creer" : "Modifier"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

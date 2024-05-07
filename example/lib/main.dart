import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<FormState> _formKey = GlobalKey();

  FocusNode focusNode = FocusNode();
  PhoneNumber? initialValue;
  // String? countryCode = kDebugMode ? 'NG' : 'GB';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Phone Field Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                IntlPhoneField(
                  showCountryFlag: false,
                  useCountryCode: true,
                  prefix: Icon(Icons.abc),
                  disableCountryPicker: true,
                  initialValue: initialValue?.number,
                  dropdownIconPosition: IconPosition.trailing,
                  flagsButtonPadding: const EdgeInsets.only(left: 16.0),
                  validator: (value) {
                    if (value == null) {
                      return 'Enter a valid phone number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(16),
                    filled: true,
                    counterStyle: const TextStyle(fontSize: 0),
                    hintText: '(+1) 704 8842 321',
                  ),

                  onCountryChanged: (value) {
                    print('Country changed to: ${value.dialCode}');
                    onCountryChanged(value);
                  },
                  // initialCountryCode: 'US',
                  // initialCountryCode: 'GB',
                  initialCountryCode: initialValue?.countryCode ?? 'GB',
                  onChanged: (phone) {
                    // print(phone.completeNumber);
                    onChanged(phone);
                  },
                ),
                IntlPhoneField(
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  languageCode: "en",
                  initialCountryCode: 'GB',
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                  onCountryChanged: (country) {
                    print('Country changed to: ' + country.name);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  child: Text('Submit'),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    _formKey.currentState?.validate();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onChanged(PhoneNumber? value) {
    initialValue = value;
    setState(() {});
  }

  void onCountryChanged(Country? value) {
    if (value == null) return;
    print('${value.dialCode} ${value.code} ');
    print('before ${initialValue?.countryCode} ${initialValue?.countryISOCode}');

    initialValue = PhoneNumber(
      countryISOCode: value.code,
      countryCode: '+${value.dialCode}',
      number: initialValue?.number ?? '',
    );
    // countryCode = value.dialCode;

    // phoneNumber?.countryCode = value.dialCode;
    // phoneNumber?.countryISOCode = value.code;
    print('after ${initialValue?.countryCode} ${initialValue?.countryISOCode}');
    setState(() {});
  }
}

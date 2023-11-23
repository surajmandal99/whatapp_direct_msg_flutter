import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String phone = "";
  String msg = "";
  String initialCountryCode = "+91";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "WhatsApp Direct",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            transform: GradientRotation(0.1),
            // begin: Alignment.topCenter,
            colors: [
              Colors.blue,
              // Colors.red,
              Colors.greenAccent,
              Colors.yellow,
            ],
          )),
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CountryCodePicker(
                dialogBackgroundColor: Colors.greenAccent,
                showDropDownButton: true,
                onChanged: (val) {
                  initialCountryCode = val.toString();
                },
                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                initialSelection: 'IN',
                favorite: const ['+91', 'IN'],
                // optional. Shows only country name and flag
                showCountryOnly: false,
                // optional. Shows only country name and flag when popup is closed.
                showOnlyCountryWhenClosed: false,
                // optional. aligns the flag and the Text left
                alignLeft: true,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  phone = value;
                },
                decoration: InputDecoration(
                    fillColor: Colors.teal,
                    focusColor: Colors.lightGreenAccent,
                    hoverColor: Colors.teal,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Enter Phone Number"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  msg = value;
                },
                decoration: InputDecoration(
                    fillColor: Colors.teal,
                    focusColor: Colors.lightGreenAccent,
                    hoverColor: Colors.teal,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Message"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  // https://wa.me/1XXXXXXXXXX?text=I'm%20interested%20in%20your%20car%20for%20sale

                  if (phone.length < 10) {
                    Fluttertoast.showToast(
                        msg: "Enter a valid phone number",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        webPosition: "center",
                        fontSize: 16.0);
                  } else {
                    initialCountryCode = initialCountryCode.replaceAll("+", "");

                    var url =
                        "https://wa.me/$initialCountryCode$phone?text=$msg";
                    if (await canLaunchUrlString(url)) {
                      await launchUrlString(url);
                    } else {
                      throw "Could not launch $url";
                    }
                    // print(code);
                  }
                },
                child: const Text(
                  'Send',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

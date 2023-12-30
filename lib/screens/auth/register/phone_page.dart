import 'package:apay/constants.dart';
import 'package:apay/screens/auth/register/phone_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhonePage extends StatefulWidget {
  PhonePage({
    Key? key,
    required this.pageController,
    required this.onPageChanged,
  }) : super(key: key);

  final PageController pageController;
  final Function(int) onPageChanged;

  @override
  State<PhonePage> createState() => _RegisPhonePage();
}

class _RegisPhonePage extends State<PhonePage> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Bir hesap oluştur",
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Telefon numaranızı yazmalısınız",
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: _phoneController,
                  maxLength: 10,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                  decoration: const InputDecoration(
                    counterText: "",
                    prefix: Text(
                      "+90",
                      style: TextStyle(color: Colors.white),
                    ),
                    labelText: 'Telefon Numarası',
                    labelStyle: TextStyle(
                      color: Colors.white70,
                      fontSize: 17,
                      fontFamily: 'averta',
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFF837E93),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFF9F7BFF),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(
                        () {}); // Trigger a rebuild to update button opacity
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _phoneController.text.length == 10
                    ? AppConst.primaryColor
                    : AppConst.primaryColor.withOpacity(0.5),
              ),
              onPressed: _phoneController.text.length == 10
                  ? () {
                      Provider.of<PhoneProvider>(context, listen: false)
                          .setPhone("+90" + _phoneController.text);
                      _showCustomDialog(context);
                      // widget.pageController.nextPage(
                      //   duration: Duration(milliseconds: 300),
                      //   curve: Curves.fastOutSlowIn,
                      // );
                      // widget.onPageChanged(widget.pageController.page?.round() ?? 0);
                    }
                  : null,
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Kayıt ol",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'jiho',
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCustomDialog(BuildContext context) {
    String phoneNumber =
        Provider.of<PhoneProvider>(context, listen: false).phone;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    "assets/images/illustration0.png",
                  ),
                ),
                const Text(
                  'Numaranı Kontrol Et',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins',
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  phoneNumber,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Bu senin mi ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'averta'),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 30,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppConst.primaryColor),
                        onPressed: () {
                          Navigator.pop(context);
                          widget.pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.fastOutSlowIn);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "Evet",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'jiho',
                                fontSize: 16),
                          ),
                        ))),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 30,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            side:
                                const BorderSide(color: AppConst.primaryColor)),
                        onPressed: () => {Navigator.pop(context)},
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "Hayır",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'jiho',
                                fontSize: 16),
                          ),
                        ))),
              ],
            ),
          ),
        );
      },
    );
  }
}

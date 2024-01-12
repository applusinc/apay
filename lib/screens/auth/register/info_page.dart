// ignore_for_file: use_build_context_synchronously

import 'package:apay/constants.dart';
import 'package:apay/screens/auth/register/provider/register_provider.dart';
import 'package:apay/screens/auth/service/auth_service.dart';
import 'package:apay/widgets/dialogs/response_dialog.dart';
import 'package:apay/widgets/dialogs/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:apay/classes/datepicker/scroll_date_picker.dart';
import 'package:kps_public/kps_public.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatefulWidget {
  final PageController controller;
  const InfoPage({super.key, required this.controller});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool isButtonEnabled = false; // Replace this with your actual condition
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tcController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final DateTime _selectedDate =
      DateTime.now().subtract(const Duration(days: 4745));

  late String year;
  double dateOpac = 0;
  late DateTime userDate;

  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bilgilerini doğrula",
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
              "Senin gerçekten sen olduğunu anlayabilmemiz için.",
              style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 15,
                color: Colors.white70,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: _nameController,
              maxLength: 30,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'Poppins',
              ),
              decoration: const InputDecoration(
                counterText: "",
                // prefix: Text(
                //   "+90",
                //   style: TextStyle(color: Colors.white),
                // ),
                labelText: 'İsim ve Soyisim',
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
                setState(() {}); // Trigger a rebuild to update button opacity
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _tcController,
              maxLength: 11,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'Poppins',
              ),
              decoration: const InputDecoration(
                counterText: "",
                // prefix: Text(
                //   "+90",
                //   style: TextStyle(color: Colors.white),
                // ),
                labelText: 'T.C Kimlik No',
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
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _dateController,
              showCursor: false,
              onTap: () {
                setState(() {
                  dateOpac = 1;
                  FocusManager.instance.primaryFocus?.unfocus();
                });
              },
              canRequestFocus: false,
              maxLength: 30,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'Poppins',
              ),
              decoration: InputDecoration(
                counterText: "",
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        dateOpac = 1;
                        FocusManager.instance.primaryFocus?.unfocus();
                      });
                    },
                    icon: const Icon(
                      Icons.date_range,
                      color: Colors.white70,
                    )),
                labelText: 'Doğum Tarihiniz',
                labelStyle: const TextStyle(
                  color: Colors.white70,
                  fontSize: 17,
                  fontFamily: 'averta',
                  fontWeight: FontWeight.w600,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(0xFF837E93),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(0xFF9F7BFF),
                  ),
                ),
              ),
            ),
            const Spacer(),
            AnimatedOpacity(
              opacity: dateOpac,
              duration: const Duration(milliseconds: 300),
              child: Stack(
                children: [
                  SizedBox(
                    height: 175,
                    child: ScrollDatePicker(
                      options: const DatePickerOptions(
                          backgroundColor: AppConst.backgroundColor),
                      selectedDate: _selectedDate,
                      locale: const Locale('tr'),
                      onDateTimeChanged: (DateTime value) {
                        userDate = value;
                        _dateController.text =
                            DateFormat('dd/MM/yyyy').format(value);
                        year = value.year.toString();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _nameController.text.isNotEmpty &
                          (_tcController.text.length == 11)
                      ? AppConst.primaryColor
                      : AppConst.primaryColor.withOpacity(0.5),
                ),
                // ignore: unrelated_type_equality_checks
                onPressed: _nameController.text.isNotEmpty &
                        (_tcController.text.length == 11)
                    ? () async {
                        try {
                          LoadingScreen.show(
                              context, 'Bilgileriniz kontrol ediliyor.');
                          List<String> nameList =
                              _nameController.text.trim().split(' ');
                          String soyad = nameList.last;
                          nameList.removeLast();
                          String name = nameList.join(' ');
                          debugPrint(
                              '$name, $soyad, ${_tcController.text}, $year');
                          KPSPublic kPSPublic = KPSPublic();
                          bool result = await kPSPublic.TCKimlikNoDogrula(
                              TCKimlikNo: _tcController.text,
                              Ad: name,
                              Soyad: soyad,
                              DogumYili: year);
                          LoadingScreen.hide(context);
                          if (result) {
                            Provider.of<RegisterProvider>(context,
                                    listen: false)
                                .setName(name);
                            Provider.of<RegisterProvider>(context,
                                    listen: false)
                                .setSurname(soyad);
                            Provider.of<RegisterProvider>(context,
                                    listen: false)
                                .setBirthdate(userDate);
                            Provider.of<RegisterProvider>(context,
                                    listen: false)
                                .setTckn(_tcController.text);

                            AuthService().checkTCKN(
                              Provider.of<RegisterProvider>(context,
                                  listen: false),
                              onSuccess: (result) {
                                if(!result){
                                  widget.controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.fastOutSlowIn);
                                }else {
                                  ResponseDialog.show(context, "Başarısız",
                                "Bu bilgilerle kayıtlı kullanıcı zaten bulunmakta.");
                                }
                              },
                              onFail: (errorMsg) {
                                ResponseDialog.show(context, "Başarısız",
                                AppConst.internalServerErrorMessage);
                              },
                            );
                            
                          } else {
                            ResponseDialog.show(context, "Başarısız",
                                "Bilgileriniz doğrulanamadı.");
                          }
                        } catch (e) {
                          LoadingScreen.hide(context);
                          ResponseDialog.show(
                              context, "Hata", "Bilinmeyen bir hata oluştu.");
                        }
                      }
                    : null,
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Doğrula",
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
      ),
    );
  }
}

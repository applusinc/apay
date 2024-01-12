// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously, duplicate_ignore

import 'package:apay/classes/letter.dart';
import 'package:apay/constants.dart';
import 'package:apay/controllers/extract_data_controller.dart';
import 'package:apay/screens/auth/register/provider/register_provider.dart';
import 'package:apay/widgets/dialogs/loading_dialog.dart';
import 'package:apay/widgets/dialogs/response_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class IdCardPage extends StatefulWidget {
  final PageController controller;

  const IdCardPage({super.key, required this.controller});

  @override
  State<IdCardPage> createState() => _IdCardPageState();
}

class _IdCardPageState extends State<IdCardPage> {
  final picker = ImagePicker();
  ExtractDataController extractDataController =
      Get.put(ExtractDataController());

  @override
  Widget build(BuildContext context) {
    debugPrint(DateFormat('dd.MM.yyyy').format(
        Provider.of<RegisterProvider>(context, listen: false).birthdate));
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Lottie.asset('assets/animations/id_card_scan.json'),
            const Text(
              'Kimliğini doğrulamak için kimlik kartını okut.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text('Kimliğinin ön yüzünü kamera ile taratmalısın.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontFamily: 'poppins',
                  fontSize: 15,
                )),
            const Spacer(),
            extractDataController.imagePaths.isEmpty
                ? Column(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            await extractDataController.getImage();
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppConst.primaryColor,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(17)),
                          child: const Icon(
                            Icons.qr_code_scanner,
                            color: Colors.white,
                          )),
                      const SizedBox(
                        height: 2,
                      ),
                      const Text(
                        'Tara',
                        style: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            LoadingScreen.show(
                                context, 'Bilgilerin kontrol ediliyor.');
                            await extractDataController.processImage();
                            // ignore: use_build_context_synchronously

                            if (extractDataController.idTCKN == '' ||
                                extractDataController.idName == '' ||
                                extractDataController.idSurname == '' ||
                                extractDataController.idBirthdate == '' ||
                                extractDataController.idSerialNumber == '' ||
                                extractDataController.idValidUntil == '') {
                              // ignore: use_build_context_synchronously
                              LoadingScreen.hide(context);
                              ResponseDialog.show(
                                  context, 'Hata', 'Kimlik okunamadı.');
                              extractDataController.imagePaths.clear();
                              setState(() {});
                            } else {
                              bool nameMatch = Letter.compareText(
                                  Provider.of<RegisterProvider>(context,
                                          listen: false)
                                      .name,
                                  extractDataController.idName.string);
                              bool surnameMatch = Letter.compareText(
                                  Provider.of<RegisterProvider>(context,
                                          listen: false)
                                      .surname,
                                  extractDataController.idSurname.string);
                              bool birtdateMatch = Letter.compareText(
                                  DateFormat('dd.MM.yyyy').format(
                                      Provider.of<RegisterProvider>(context,
                                              listen: false)
                                          .birthdate),
                                  extractDataController.idBirthdate.string);

                              bool tcMatch = Provider.of<RegisterProvider>(
                                          context,
                                          listen: false)
                                      .tckn
                                      .trim() ==
                                  extractDataController.idTCKN.trim();

                              if (nameMatch &
                                  surnameMatch &
                                  birtdateMatch &
                                  tcMatch) {

                                    Provider.of<RegisterProvider>(context,
                                    listen: false)
                                .setSerialnumber(extractDataController.idSerialNumber.string);
                                Provider.of<RegisterProvider>(context,
                                    listen: false)
                                .setValidUntil(extractDataController.idValidUntil.string);
                                Future.delayed(
                                  const Duration(seconds: 2),
                                  () {
                                    LoadingScreen.hide(context);
                                    widget.controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.fastOutSlowIn);
                                  },
                                );
                              } else {
                                LoadingScreen.hide(context);
                                ResponseDialog.show(context, 'Hata',
                                    'Bilgileriniz doğrulanamadı.');
                                debugPrint(
                                    'name $nameMatch, surname $surnameMatch, birthdate $birtdateMatch, tc $tcMatch');
                                extractDataController.imagePaths.clear();
                                extractDataController.imagePath = ''.obs;
                                setState(() {});
                              }
                            }
                            debugPrint(
                                'tckn :  ${extractDataController.idTCKN.value}, ad: ${extractDataController.idName}, soyad: ${extractDataController.idSurname}, dogum tarihi: ${extractDataController.idBirthdate}, seri no: ${extractDataController.idSerialNumber}, gecerlilik tarihi : ${extractDataController.idValidUntil}');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppConst.primaryColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 13)),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              Text('Doğrula',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'poppins'))
                            ],
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Çektiğin fotoğrafı doğrula',
                        style: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ],
                  ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}

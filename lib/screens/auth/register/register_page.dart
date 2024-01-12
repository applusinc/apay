import 'package:apay/constants.dart';
import 'package:apay/screens/auth/register/complete_page.dart';
import 'package:apay/screens/auth/register/email_page.dart';
import 'package:apay/screens/auth/register/id_card_page.dart';
import 'package:apay/screens/auth/register/info_page.dart';
import 'package:apay/screens/auth/register/otp_page.dart';
import 'package:apay/screens/auth/register/phone_page.dart';
import 'package:apay/screens/auth/register/pin_page.dart';
import 'package:apay/widgets/dialogs/response_dialog.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  PageController controller = PageController(initialPage: 0);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  double value = 0.142;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        if (currentPage == 0) {
          //phone input page
          Navigator.pop(context, true);
        } else if (currentPage == 1) {
          //phone validate page
          widget.controller.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn);
        } else if (currentPage == 2) {
          //tckn name surname input page
          ResponseDialog.show(context, "Uyarı", "Bu adımda geri dönemezsiniz.");
        } else if (currentPage == 3) {
          //identity card page
          widget.controller.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn);
        } else if (currentPage == 4) {
          ResponseDialog.show(context, "Uyarı", "Bu adımda geri dönemezsiniz.");
          //email page input
        } else if (currentPage == 5) {
          ResponseDialog.show(context, "Uyarı", "Bu adımda geri dönemezsiniz.");
          //pin page
        } else if (currentPage == 6) {
          ResponseDialog.show(context, "Uyarı", "Bu adımda geri dönemezsiniz.");
          //complete page
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: currentPage == 0
            ? true
            : currentPage == 1
                ? true
                : currentPage == 2
                    ? false
                    : currentPage == 3
                        ? false
                        : currentPage == 4
                            ? true
                            : currentPage == 5
                                ? true
                                : false,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (currentPage == 0) {
                          //phone input page
                          Navigator.pop(context, true);
                        } else if (currentPage == 1) {
                          //phone validate page
                          widget.controller.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.fastOutSlowIn);
                        } else if (currentPage == 2) {
                          //tckn name surname input page
                          ResponseDialog.show(
                              context, "Uyarı", "Bu adımda geri dönemezsiniz.");
                        } else if (currentPage == 3) {
                          //identity card page
                          widget.controller.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.fastOutSlowIn);
                        } else if (currentPage == 4) {
                          ResponseDialog.show(
                              context, "Uyarı", "Bu adımda geri dönemezsiniz.");
                          //email page input
                        } else if (currentPage == 5) {
                          ResponseDialog.show(
                              context, "Uyarı", "Bu adımda geri dönemezsiniz.");
                          //pin page
                        } else if (currentPage == 6) {
                          ResponseDialog.show(
                              context, "Uyarı", "Bu adımda geri dönemezsiniz.");
                          //complete page
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              ),
              const SizedBox(height: 5),
              ProgressBarIndicator(currentPage: value),
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 7,
                  controller: widget.controller,
                  onPageChanged: (int page) {
                    setState(() {
                      currentPage = page;
                      value = 0.142 * (page + 1);
                    });
                  },
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return PhonePage(
                        pageController: widget.controller,
                        onPageChanged: (int page) {
                          widget.controller.jumpToPage(page);
                        },
                      );
                    } else if (index == 1) {
                      return OTPPage(
                        controller: widget.controller,
                      );
                    } else if (index == 2) {
                      return InfoPage(
                        controller: widget.controller,
                      );
                    } else if (index == 3) {
                      return IdCardPage(
                        controller: widget.controller,
                      );
                    } else if (index == 4) {
                      return EmailPage(pageController: widget.controller);
                    } else if (index == 5) {
                      return PinPage(controller: widget.controller);
                    } else if (index == 6) {
                      return CompletePage(controller: widget.controller);
                    } else {
                      return PhonePage(
                        pageController: widget.controller,
                        onPageChanged: (int page) {
                          widget.controller.jumpToPage(page);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressBarIndicator extends StatelessWidget {
  final double currentPage;

  const ProgressBarIndicator({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 4,
      decoration: const BoxDecoration(color: Colors.white24),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: MediaQuery.of(context).size.width * currentPage,
            height: 4,
            decoration: const BoxDecoration(color: AppConst.primaryColor),
          ),
        ],
      ),
    );
  }
}

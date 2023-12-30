import 'package:apay/constants.dart';
import 'package:apay/screens/auth/register/otp_page.dart';
import 'package:apay/screens/auth/register/phone_page.dart';
import 'package:apay/screens/mainmenu/home_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  PageController controller = PageController(initialPage: 0);
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  double value = 0.2;
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
          Navigator.pop(context, true);
        } else {
          widget.controller.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn);
        }
      },
      child: Scaffold(
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
          Navigator.pop(context, true);
        } else {
          widget.controller.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn);
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
                  itemCount: 3,
                  controller: widget.controller,
                  onPageChanged: (int page) {
                    setState(() {
                      currentPage = page;
                      value = 0.2 * (page + 1);
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

  const ProgressBarIndicator({required this.currentPage});

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

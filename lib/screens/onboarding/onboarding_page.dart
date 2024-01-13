// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:apay/constants.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late PageController _pageController;
  int pageIndex = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        pageIndex = value;
                      });
                    },
                    itemCount: AppConst.onBoardList.length,
                    controller: _pageController,
                    itemBuilder: ((context, index) {
                      return OnBoardContent(
                          description: AppConst.onBoardList[index].description,
                          title: AppConst.onBoardList[index].title,
                          image: AppConst.onBoardList[index].image);
                    })),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  ...List.generate(
                      AppConst.onBoardList.length,
                      (index) => Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: DotIndicator(
                              isActive: index == pageIndex,
                            ),
                          )),
                  const Spacer(),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(
                            0), // İstediğiniz iç boşluk değerini ayarlayabilirsiniz
                      ),
                      onPressed: () {
                        if (_pageController.page ==
                            AppConst.onBoardList.length - 1) {
                          Navigator.popAndPushNamed(context, '/mainmenu');
                        } else {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.fastOutSlowIn);
                        }
                      },
                      child: const Icon(Icons.arrow_forward_rounded,
                          color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: isActive ? 20 : 8,
        height: 4,
        decoration: BoxDecoration(
          color: isActive
              ? AppConst.primaryColor
              : AppConst.primaryColor.withOpacity(0.6),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ));
  }
}

class OnBoard {
  final String title, image, description;
  OnBoard({
    required this.title,
    required this.description,
    required this.image,
  });
}

class OnBoardContent extends StatelessWidget {
  const OnBoardContent({
    super.key,
    required this.description,
    required this.title,
    required this.image,
  });
  final String title, image, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          image,
          height: 250,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontFamily: 'poppins', fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: 'poppins', fontSize: 14),
        ),
        const Spacer()
      ],
    );
  }
}
//"Ücretsiz para yükle istediğin gibi harca!",
//"Kartınla para yükle ister para gönder ister dilediğin gibi harca.",
// "assets/images/illustration0.png"
// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import
import 'package:apay/models/transaction_item.dart';
import 'package:apay/user/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:apay/classes/hex_color.dart';
import 'package:apay/constants.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int secilenItem = 0;
  bool isLoading = false;
  DateTime _parseDate(String dateString) {
  List<String> dateParts = dateString.split('.');
  int day = int.parse(dateParts[0]);
  int month = int.parse(dateParts[1]);
  int year = int.parse(dateParts[2]);

  return DateTime.utc(year, month, day); // Use UTC to avoid time zone offsets
}



  void _handleFilterSelection(int selectedItem) {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        secilenItem = selectedItem;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<TransactionItem> history = [
      TransactionItem(
          image: "sended",
          title: "Para Transferi",
          subtitle: "Aslı Korkmaz",
          date: "16.7.2023",
          amount: 10,
          isCost: true),
      TransactionItem(
          image: "sended",
          title: "Para Transferi",
          subtitle: "Aslı Korkmaz",
          date: "15.12.2023",
          amount: 10,
          isCost: true),
    ];

    List<TransactionItem> getFilteredHistory() {
      DateTime now = DateTime.now();
 DateTime todayStart = DateTime(now.year, now.month, now.day);
  DateTime todayEnd = todayStart.add(const Duration(days: 1));
      switch (secilenItem) {
        case 0: // Bugün (Today)
            return history.where((item) {
        DateTime itemDate = _parseDate(item.date);
        return itemDate.isAfter(todayStart) && itemDate.isBefore(todayEnd);
      }).toList();
        case 1: // Bu hafta (This week)
          DateTime startOfWeek =
              now.subtract(Duration(days: now.weekday - 1)); // Monday
          DateTime endOfWeek = startOfWeek.add(const Duration(days: 7));

          return history.where((item) {
            DateTime itemDate = _parseDate(item.date);
            return itemDate.isAfter(startOfWeek) &&
                itemDate.isBefore(endOfWeek);
          }).toList();
        case 2: // Bu ay (This month)
          return history.where((item) {
            DateTime itemDate = _parseDate(item.date);
            return itemDate.year == now.year && itemDate.month == now.month;
          }).toList();
        case 3: // Son 3 ay (Last 3 months)
          DateTime threeMonthsAgo = DateTime(now.year, now.month - 3, now.day);
          return history.where((item) {
            DateTime itemDate = _parseDate(item.date);
            return itemDate.isAfter(threeMonthsAgo);
          }).toList();
        case 4: // Son 6 ay (Last 6 months)
          DateTime sixMonthsAgo = DateTime(now.year, now.month - 6, now.day);
          return history.where((item) {
            DateTime itemDate = _parseDate(item.date);
            return itemDate.isAfter(sixMonthsAgo);
          }).toList();
        default:
          return history; // Return all transactions if no specific filter is selected
      }
    }

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppConst.backgroundColor,
        statusBarIconBrightness: Brightness.light));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                decoration:
                    const BoxDecoration(color: AppConst.backgroundColor),
                child: SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [

                        
                        Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/temp/home_profile.png"),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child:  Text(Provider.of<UserProvider>(context, listen: false).user.name,
                                    style: const TextStyle(
                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.w700,
                                       
                                        fontSize: 16)),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  Provider.of<UserProvider>(context, listen: false).user.id,
                                  style: const TextStyle(
                                      fontFamily: 'poppins',
                                      
                                      fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                            decoration: BoxDecoration(
                                color: AppConst.itemColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.notifications,
                                  
                                ))),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Opacity(
                      opacity: 0.60,
                      child: Text(
                        'Toplam Paranız',
                        style: TextStyle(
                          
                          fontSize: 18,
                          fontFamily: 'averta',
                        ),
                      ),
                    ),
                    Text(
                      "1000 TL",
                      style: TextStyle(
                          fontFamily: 'jiho',
                          fontSize: 28,
                         ),
                    )
                  ],
                ),
              ),
              const Opacity(
                opacity: 0.5,
                child: Divider(
                    indent: 15,
                    endIndent: 15,
                    thickness: 1,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppConst.itemColor),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/moneysend.png",
                                height: 50,
                                width: 50,
                              ),
                              const Spacer(),
                              const Text(
                                "Para Gönder",
                                style: TextStyle(
                                     fontFamily: 'jiho'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppConst.itemColor),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/moneyrece.png",
                                height: 50,
                                width: 50,
                              ),
                              const Spacer(),
                              const Text(
                                "Para Al",
                                style: TextStyle(
                                     fontFamily: 'jiho'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppConst.itemColor),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/menu.png",
                                height: 50,
                                width: 50,
                              ),
                              const Spacer(),
                              const Text(
                                "Daha Fazla",
                                style: TextStyle(
                                     fontFamily: 'jiho'),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Geçmiş İşlemlerim",
                  style: TextStyle(
                       fontSize: 22, fontFamily: 'jiho'),
                ),
              ),
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          secilenItem = 0;
                          _handleFilterSelection(0);
                        });
                      },
                      child: TransfilterItem(
                        label: "Bugün",
                        isSecilen: secilenItem == 0,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          secilenItem = 1;
                          _handleFilterSelection(1);
                        });
                      },
                      child: TransfilterItem(
                        label: "Bu hafta",
                        isSecilen: secilenItem == 1,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          secilenItem = 2;
                          _handleFilterSelection(2);
                        });
                      },
                      child: TransfilterItem(
                        label: "Bu ay",
                        isSecilen: secilenItem == 2,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          secilenItem = 3;
                          _handleFilterSelection(3);
                        });
                      },
                      child: TransfilterItem(
                        label: "Son 3 ay",
                        isSecilen: secilenItem == 3,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          secilenItem = 4;
                          _handleFilterSelection(4);
                        });
                      },
                      child: TransfilterItem(
                        label: "Son 6 ay",
                        isSecilen: secilenItem == 4,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : getFilteredHistory().isEmpty
                          ? const Center(
                              child: Text(
                                "Gösterilecek hiçbir veri yok :(",
                                style: TextStyle(
                                fontSize: 16, fontFamily: 'averta'),
                              ),
                            )
                          : ListView.builder(
                              itemCount: getFilteredHistory().length,
                              itemBuilder: (context, index) {
                                return TransItem(
                                    data: getFilteredHistory()[index]);
                              },
                            ))
            ],
          )),
    );
  }
}

// ignore: must_be_immutable
class TransfilterItem extends StatelessWidget {
  String label;
  bool isSecilen;
  TransfilterItem({
    super.key,
    required this.label,
    required this.isSecilen,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSecilen
                ? AppConst.primaryColor
                : AppConst.itemColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Text(
            label,
            style: TextStyle(
                color: isSecilen ? AppConst.transFilterItemTextEnable : AppConst.transFilterItemTextDisable,
                fontFamily: 'jiho'),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TransItem extends StatelessWidget {
  TransactionItem data;
  TransItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              getImageWidget(data.image),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${data.title}" " ·",
                          style: const TextStyle(
                              
                              fontFamily: "poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Opacity(
                          opacity: 0.6,
                          child: Text(
                            data.date,
                            style: const TextStyle(
                                
                                fontFamily: "poppins",
                                fontSize: 12,
                                fontStyle: FontStyle.italic),
                          ),
                        )
                      ]),
                  Text(
                    data.subtitle,
                    style: const TextStyle(
                     
                      fontFamily: "poppins",
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              Expanded(
                  child: Center(
                child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "${data.isCost ? "-${data.amount.toStringAsFixed(2)}" : "+${data.amount.toStringAsFixed(2)}"}"
                      " TL",
                      style: const TextStyle(
                         
                          fontSize: 14,
                          fontFamily: 'jiho'),
                    )),
              ))
            ],
          ),
        ),
        const Divider(
          indent: 12,
          endIndent: 12,
        )
      ],
    );
  }

  Widget getImageWidget(String imageData) {
    if (imageData == "sended") {
      // Durum [sended] ise asset'ten yükle
      return Image.asset(
        'assets/images/send.png',
        width: 75,
        height: 75,
      );
    } else if (imageData == "received") {
      // Durum [received] ise asset'ten yükle
      return Image.asset(
        'assets/images/receive.png',
        width: 75,
        height: 75,
      );
    } else {
      // Durum [sended] veya [received] değilse, URL'den yükle
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          fit: BoxFit.cover,
          imageData,
          width: 75,
          height: 75,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              );
            }
          },
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) {
            return const Text('Error loading image');
          },
        ),
      );
    }
  }
}

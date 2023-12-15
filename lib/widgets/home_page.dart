import 'package:apay/classes/hex_color.dart';
import 'package:apay/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: HexColor(AppConst.backgroundColor),
        statusBarIconBrightness: Brightness.light));
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(color: HexColor(AppConst.backgroundColor)),
        child: SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: AssetImage("assets/temp/home_profile.png"),
                          fit: BoxFit.cover)),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("Ali Abdullah",
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: Colors.white)),
                        margin: EdgeInsets.symmetric(vertical: 5),
                      ),
                      Container(
                        child: Text(
                          "Günaydın",
                          style: GoogleFonts.poppins(
                              fontSize: 13, color: Colors.white),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 5),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(12)),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications,
                          color: Colors.white,
                        )))
              ],
            ),
          ),
        ),
      )),
    );
  }
}

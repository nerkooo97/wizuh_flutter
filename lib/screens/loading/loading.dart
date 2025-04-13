import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/configs/config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Pozadinska slika ili boja
          Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(16, 165, 73, 33),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(Images.iconwzh, width: 120, height: 120),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 300),
            child: SizedBox(
              width: 26,
              height: 26,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          )
        ],
      ),
    );
  }
}

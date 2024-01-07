// import 'package:flutter/material.dart';
//
// class CityScreen extends StatefulWidget {
//   @override
//   _CityScreenState createState() => _CityScreenState();
// }
//
// class _CityScreenState extends State<CityScreen> {
//   String cityName = '';
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           color: Color(0xff0D2C54),
//         ),
//         constraints: const BoxConstraints.expand(),
//         child: SafeArea(
//           child: Column(
//             children: <Widget>[
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Icon(
//                     Icons.arrow_back_ios,
//                     size: 40.0,
//                     color: Color(0xff78C0E0),
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.all(20.0),
//                 child: TextField(
//                   style: const TextStyle(
//                     color: Colors.black,
//                   ),
//                   decoration: const InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     icon: Icon(
//                       Icons.location_city,
//                       color: Colors.white,
//                     ),
//                     hintText: 'Enter City Name',
//                     hintStyle: TextStyle(
//                       color: Colors.grey,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                   onChanged: (value) {
//                     cityName = value;
//                   },
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context, cityName);
//                 },
//                 child: const Text(
//                   'Get Weather',
//                   style: TextStyle(
//                     fontSize: 30.0,
//                     fontFamily: 'Spartan MB',
//                     color: Color(0xff78C0E0),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: size.height * 0.17,
//               ),
//               // Positioned(
//               //   child: Container(
//               //     height: size.height * 0.5,
//               //     width: size.width,
//               //     decoration: const BoxDecoration(
//               //       color: Colors.white,
//               //       borderRadius: BorderRadius.all(Radius.circular(50)),
//               //       // borderRadius: BorderRadius.only(
//               //       //   topLeft: Radius.circular(50),
//               //       //   topRight: Radius.circular(50),
//               //       // ),
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background Image
          // Image.asset(
          //   'assets/background.jpg',
          //   fit: BoxFit.cover,
          //   width: double.infinity,
          //   height: double.infinity,
          // ),

          // Cloud Widget
          Positioned(
            top: 50,
            left: 20,
            child: CustomPaint(
              painter: CloudPainter(),
            ),
          ),

          Container(
            decoration: const BoxDecoration(
              color: Color(0xff0D2C54),
            ),
            constraints: const BoxConstraints.expand(),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 40.0,
                        color: Color(0xff78C0E0),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        icon: Icon(
                          Icons.location_city,
                          color: Colors.white,
                        ),
                        hintText: 'Enter City Name',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        cityName = value;
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, cityName);
                    },
                    child: const Text(
                      'Get Weather',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'Spartan MB',
                        color: Color(0xff78C0E0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.17,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.white;

    // Draw a cloud-like shape
    canvas.drawCircle(Offset(50, 50), 20, paint);
    canvas.drawCircle(Offset(70, 50), 30, paint);
    canvas.drawCircle(Offset(90, 50), 20, paint);
    canvas.drawCircle(Offset(60, 65), 25, paint);
    canvas.drawCircle(Offset(80, 65), 25, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

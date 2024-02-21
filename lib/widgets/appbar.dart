import 'package:flutter/material.dart';

AppBar customAppbar() {
  return AppBar(
    title: const Text(
      "Todo App",
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Color(0xFF001133),
  );
}

// class customAppbar extends StatelessWidget {
//   const customAppbar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: const Text("Todo App"),
//       backgroundColor: Color(0xFF001133),
//     );
//   }
// }

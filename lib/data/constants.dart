// import 'package:flutter/material.dart';

// class KTextStyle {
//   static const TextStyle titleTextStyle = TextStyle(
//     color: Colors.teal,
//     fontSize: 18,
//     fontWeight: FontWeight.bold,
//   );
//   static const TextStyle descriptionTextStyle = TextStyle(fontSize: 13);
// }

import 'package:flutter/material.dart';

class KTextStyle{
  static const TextStyle headerTextStyle = TextStyle(
    color: Colors.teal,//i want to also handle for dark and light mode i should be able to specify the color for light and dark mode
    fontSize: 10.0
  );

  static const TextStyle descTextStyle = TextStyle(
    color: Colors.teal, ///same with this too
    fontSize: 4.0
  );
}
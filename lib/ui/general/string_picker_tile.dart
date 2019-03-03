// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../../constants.dart';

// class StringPickerTile extends StatelessWidget {
//   final List<String> items;
//   final String initialItem;
//   final ValueChanged<int> onChanged;
//   final Widget title, leading, trailing, subtitle;

//   StringPickerTile({
//     @required this.items,
//     @required this.title,
//     this.initialItem,
//     this.onChanged,
//     this.leading,
//     this.subtitle,
//     this.trailing,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: leading,
//       title: title,
//       trailing: trailing,
//       subtitle: subtitle,
//       onTap: () {
//         List<String> _items = items;
//         final FixedExtentScrollController scrollController =
//             FixedExtentScrollController(
//                 initialItem: _items.indexOf(initialItem ?? _items.first));
//         showCupertinoModalPopup<void>(
//           context: context,
//           builder: (BuildContext context) {
//             return _buildBottomPicker(
//               CupertinoPicker(
//                 scrollController: scrollController,
//                 itemExtent: kPickerItemHeight,
//                 backgroundColor: CupertinoColors.white,
//                 onSelectedItemChanged: onChanged,
//                 children: List<Widget>.generate(_items.length, (int index) {
//                   return Center(
//                     child: AutoSizeText(_items[index].toString()),
//                   );
//                 }),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget _buildBottomPicker(Widget picker) {
//     return Container(
//       height: kPickerSheetHeight,
//       padding: const EdgeInsets.only(top: 6.0),
//       color: CupertinoColors.white,
//       child: DefaultTextStyle(
//         style: const TextStyle(
//           color: CupertinoColors.black,
//           fontSize: 22.0,
//         ),
//         child: GestureDetector(
//           // Blocks taps from propagating to the modal sheet and popping.
//           onTap: () {},
//           child: SafeArea(
//             top: false,
//             child: picker,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:zakat_app/Services/post_model.dart';

class MyPostSegmentControl extends StatelessWidget {
  const MyPostSegmentControl({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> _getPostType() {
      return PostType.values.map((post) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Theme.of(context).colorScheme.inversePrimary,
              )),
          child: Text(post.toString().split('.').last),
        );

        // return Text(
        //   post.toString().split('_').last,
        // );
      }).toList();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: _getPostType(),
      ),
    );
  }
}

// class MyPostSegmentControl extends StatefulWidget {
//   const MyPostSegmentControl({super.key});

//   @override
//   State<MyPostSegmentControl> createState() => _MyPostSegmentControlState();
// }

// class _MyPostSegmentControlState extends State<MyPostSegmentControl> {
//   int _selectedIndex = 0;
//   final List<bool> _seletedList = [true, false, false];
//   List<Widget> _getPostType() {
//     return PostType.values.map((post) {
//       return Text(
//         post.toString().split('_').last,
//       );
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ToggleButtons(
//           textStyle: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             color: Theme.of(context).colorScheme.inversePrimary,
//           ),
//           fillColor: Theme.of(context).colorScheme.primary, //This Is Back Rond
//           selectedColor: Theme.of(context).colorScheme.background,
//           borderRadius: BorderRadius.circular(11),
//           onPressed: (index) {
//             setState(() {
//               _selectedIndex = index;
//             });
//           },
//           isSelected: _seletedList,
//           children: const [
//             // Column(
//             //   children: _getPostType(),
//             // ),
//             Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 16.0,
//               ),
//               child: Text("News"),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 16.0,
//               ),
//               child: Text("ProJicts"),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 16.0,
//               ),
//               child: Text("Ads"),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }

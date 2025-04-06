import 'package:flutter/material.dart';
import 'package:zakat_app/Components/Widget/my_DonationCard.dart';
import 'package:zakat_app/Models/post_Manger.dart';

class MyDonationGrid extends StatefulWidget {
  const MyDonationGrid({super.key});

  @override
  State<MyDonationGrid> createState() => _MyDonationGridState();
}

class _MyDonationGridState extends State<MyDonationGrid> {
  var listofPost = PostManger().postInfo;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        itemCount: listofPost.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return MyDonationCard(
            daysLeft: 22,
            progress: 0.1,
            raisedAmount: listofPost[index].detailsPost,
            title: listofPost[index].nameOfPost,
          );
        },
      ),
    );
  }
}


// class MyDonationGrid extends StatelessWidget {
//   const MyDonationGrid({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       crossAxisCount: 2,
//       physics: const BouncingScrollPhysics(),
//       shrinkWrap: true,
//       padding: const EdgeInsets.all(8),
//       childAspectRatio: 1,
//       children: const [
//         MyDonationCard(
//           title: 'Zakat Maal',
//           raisedAmount: 'Rp. 240 jt',
//           daysLeft: 280,
//           progress: 0.6,
//         ),

//         MyDonationCard(
//           title: 'Zakat for Clean Water',
//           raisedAmount: 'Rp. 78 jt',
//           daysLeft: 58,
//           progress: 0.4,
//         ),

//         MyDonationCard(
//           title: 'Zakat for Clean Water',
//           raisedAmount: 'Rp. 78 jt',
//           daysLeft: 58,
//           progress: 0.4,
//         ),

//         // Add more DonationCard widgets as needed
//       ],
//     );
//   }
// }

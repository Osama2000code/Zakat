import 'package:zakat_app/Models/post_model.dart';

class PostManger {
  List<PostModel> post = [
    PostModel(
      nameOfPost: "nameOfPost",
      detailsPost: "detailsPost",
      kindOfPost: 2,
      daysLeft: 124,
      pricePost: 230,
      progresLine: 0.1,
      progresMode: true,
    ),
  ];

/* Getter*/
  List<PostModel> get postInfo => post;

/* setter */

}

class PostModel {
  final String nameOfPost;
  final String detailsPost;
  final int kindOfPost;
   final double pricePost;
  final bool progresMode;
  final int daysLeft;
  final double progresLine;


  PostModel({
    required this.nameOfPost,
    required this.detailsPost,
    required this.kindOfPost,
     required this.daysLeft,
    required this.pricePost,
    required this.progresLine,
    required this.progresMode,
  });
}

enum PostType { newsPost, adsPost, projPost }

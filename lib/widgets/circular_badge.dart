import 'package:flutter/material.dart';
import 'package:sign_language_learning/pages/level_page.dart';

class CircularBadge extends StatelessWidget {
  const CircularBadge(
      {Key? key,
      required this.uid,
      this.title = "<Your text here>",
      this.badgeColor = const Color(0xFF1DB1F4),
      this.imageUrl =
          "https://www.sense.org.uk/wp-content/themes/sense-uk/assets/img/sign/o.png"})
      : super(key: key);

  final String uid;
  final String title;
  final Color badgeColor;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    const size = 125.0;
    return GestureDetector(
      onTap: () {
        //TODO: push params, such as exercise id
        Navigator.pushNamed(
          context,
          LevelPage.routeName,
          arguments: LevelPageArguments(uid),
        );
      },
      child: Column(
        children: [
          Container(
            width: size,
            height: size,
            child: Stack(
              children: [
                Container(
                  width: size,
                  height: size,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE4E5E5),
                  ),
                ),
                Center(
                  child: Container(
                    width: size - 20,
                    height: size - 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          imageUrl,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Text(title)
        ],
      ),
    );
  }
}

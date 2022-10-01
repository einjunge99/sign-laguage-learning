import 'package:flutter/material.dart';

class TileItem extends StatelessWidget {
  const TileItem(
      {Key? key, required this.tag, required this.child, this.thumbnail})
      : super(key: key);

  final String tag;

  final Widget? thumbnail;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                if (thumbnail != null)
                  AspectRatio(
                    aspectRatio: 485.0 / 384.0,
                    child: thumbnail,
                  ),
                Material(
                  child: ListTile(
                    title: Text("Ahora intentalo tú!"),
                    subtitle: Text("Proximanente..."),
                  ),
                )
              ],
            ),
            Positioned(
              left: 0.0,
              top: 0.0,
              bottom: 0.0,
              right: 0.0,
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: () async {
                    await Future.delayed(Duration(milliseconds: 200));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PageItem(tag: tag, child: child);
                        },
                        fullscreenDialog: true,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageItem extends StatelessWidget {
  final String tag;
  final Widget child;
  const PageItem({Key? key, required this.child, required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Hero(
        tag: tag,
        child: Material(child: child),
      ),
    ]);
  }
}

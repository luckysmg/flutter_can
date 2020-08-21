import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/constants.dart';

import 'load_asset_image.dart';

class BackIconView extends StatelessWidget {
  final bool darkIcon;

  const BackIconView({Key key, this.darkIcon = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Icon(
        Icons.arrow_back_ios,
        size: Constants.backIconSize,
        color: darkIcon ? Colors.black87 : Colors.white,
      ),
    );
  }
}

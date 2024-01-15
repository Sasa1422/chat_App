import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../widgets/image_picker_widget.dart';

class CustomListViewTileWithActivity extends StatelessWidget {

  final double height;
  final String title;
  final String subtitle;
  final String imagePath;
  final bool isActive;
  final bool isActivity;
  final Function onTap;



  const CustomListViewTileWithActivity({
    super.key,
    required this.height,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.isActive,
    required this.isActivity,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ()=> onTap(),
      minVerticalPadding:height*.20 ,
      leading:RoundedImageNetworkWithStatusIndicator(
        key: UniqueKey(),
        imagePath: imagePath,
        size: height/2,
        isActive: isActive,
      ) ,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle:isActivity ? Row(
        children: [
          SpinKitThreeBounce(
            color: Colors.white54,
            size: height*.10,
          )
        ],
      )  :Text(
        subtitle,
        style: const TextStyle(
          color: Colors.white54,
          fontWeight: FontWeight.w400,
          fontSize: 12
        ),
      ),
    );
  }
}

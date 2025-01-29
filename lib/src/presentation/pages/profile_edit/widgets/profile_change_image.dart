import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/profile_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';

class ProfileChangeImage extends StatefulWidget {
  const ProfileChangeImage({
    super.key,
    required this.profileEntity,
    required this.onSelectChangeImageProfile,
  });
  final ProfileEntity? profileEntity;
  final Function() onSelectChangeImageProfile;
  @override
  _ProfileChangeImageState createState() => _ProfileChangeImageState();
}

class _ProfileChangeImageState extends State<ProfileChangeImage> {
  double heightChangeImageProgile = 230;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: heightChangeImageProgile,
      color: AppTheme.white,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SvgPicture.asset(
            ImageAsset.background_edit_profile,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.values.first,
          ),
          Positioned(
            bottom: heightChangeImageProgile / 5,
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(42),
              ),
              onTap: widget.onSelectChangeImageProfile,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(42)),
                constraints: const BoxConstraints(
                  maxWidth: 84,
                  maxHeight: 84,
                ),
                child: Stack(
                  children: [
                    widget.profileEntity?.images != null &&
                            widget.profileEntity?.images != ''
                        ? CircleAvatar(
                            radius: 42,
                            backgroundImage: NetworkImage(
                                widget.profileEntity?.images ?? ''),
                          )
                        : CircleAvatar(
                            radius: 42,
                            child: Container(),
                          ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: AppTheme.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16)),
                        child: Icon(
                          Icons.camera_alt,
                          color: AppTheme.white,
                          size: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: heightChangeImageProgile / 15,
            child: TextLabel(
              text: widget.profileEntity?.username ?? 'N/A',
              color: AppTheme.black40,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                context,
                AppFontSize.little,
              ),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

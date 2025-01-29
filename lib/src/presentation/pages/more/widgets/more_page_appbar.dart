import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/profile_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/profile/cubit/profile_cubit.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

// ignore: must_be_immutable
class MorePageAppBar extends StatelessWidget {
  MorePageAppBar({
    super.key,
    required this.onClickProfile,
  });
  final Function() onClickProfile;
  ProfileEntity? profileEntity;

  void actionProfileLoading() {}

  void actionProfileSuccess(state) {
    profileEntity = state.profileEntity;
  }

  void actionProfileFailure() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      child: Stack(
        children: [
          SvgPicture.asset(
            ImageAsset.bg_homepage,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.values.first,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case ProfileLoading:
                      actionProfileLoading();
                      break;
                    case ProfileSuccess:
                      actionProfileSuccess(state);
                      break;
                    case ProfileFailure:
                      actionProfileFailure();
                      break;
                  }
                  return Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: onClickProfile,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              profileEntity?.images != null &&
                                      profileEntity?.images != ''
                                  ? CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                          profileEntity?.images ?? ''),
                                    )
                                  : CircleAvatar(
                                      radius: 30,
                                      child: Container(),
                                    ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextLabel(
                                      text:
                                          '${profileEntity?.name ?? 'firstname'} ${profileEntity?.lastname ?? 'lastname'}',
                                      color: AppTheme.black80,
                                      fontSize: Utilities
                                          .sizeFontWithDesityForDisplay(
                                              context, AppFontSize.superlarge),
                                      fontWeight: FontWeight.bold,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    // const SizedBox(height: 4),
                                    TextLabel(
                                      text:
                                          profileEntity?.username ?? 'username',
                                      color: AppTheme.black40,
                                      fontSize: Utilities
                                          .sizeFontWithDesityForDisplay(
                                              context, AppFontSize.normal),
                                      fontWeight: FontWeight.normal,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppTheme.gray9CA3AF,
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

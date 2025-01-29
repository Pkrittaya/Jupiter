import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/collect_coupon_entity.dart';
import 'package:jupiter_api/domain/entities/search_coupon_for_used_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/cubit/cubit/check_in_cubit.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/widgets/scan_qrcode_coupon.dart';
import 'package:jupiter/src/presentation/pages/coupon_detail/coupon_detail_page.dart';
import 'package:jupiter/src/presentation/widgets/text_input_form.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

// ignore: must_be_immutable
class ModalBottomOffer extends StatefulWidget {
  ModalBottomOffer({
    Key? key,
    required this.controllerTextSearch,
    required this.listItemOffer,
    required this.onSelectCouponOffer,
    this.ItemOffer,
  }) : super(key: key);

  final TextEditingController controllerTextSearch;
  final List<SearchCouponItemForUsedEntity> listItemOffer;
  final Function(SearchCouponItemForUsedEntity?) onSelectCouponOffer;
  SearchCouponItemForUsedEntity? ItemOffer;

  @override
  _ModalBottomOfferState createState() => _ModalBottomOfferState();
}

class _ModalBottomOfferState extends State<ModalBottomOffer> {
  final formKey = GlobalKey<FormState>();
  double heightItem = 75;
  double heightListCouponItem = 235;
  double heightModal = 385;
  SearchCouponItemForUsedEntity? couponItem;
  List<SearchCouponItemForUsedEntity> listCoupon = [];
  TextEditingController controllerTextSearch = TextEditingController();

  List<SearchCouponItemForUsedEntity> listCouponAll =
      List.empty(growable: true);

  SearchCouponItemForUsedEntity? chxCollectCoupon;
  bool chxSelectCollectCoupon = false;
  FocusNode _focus = FocusNode();
  Timer? _debounce;

  getDateFormat(int index) {
    String day = '';
    String yMMM = '';
    if (listCoupon[index].dateEnd != "") {
      DateTime date = DateTime.parse(listCoupon[index].dateEnd).toLocal();
      day = DateFormat('d').format(date);
      yMMM = DateFormat('yMMM').format(date);
    } else {
      day =
          '${listCoupon[index].expiredDate} ${translate("check_in_page.modal_offers.day_after_collected")}';
    }
    return '${translate("check_in_page.modal_offers.expire_date")} $day $yMMM';
  }

  filterListCoupon() {
    listCoupon.clear();
    listCoupon = listCouponAll
        .where(
            (item) => (item.dateAdd != '') && (item.statusUsedCoupon == false))
        .toList();
  }

  void onTapIsUse(SearchCouponItemForUsedEntity data, bool chxSelect) {
    // if (chxSelect) {
    //   widget.onSelectCouponOffer(data);
    //   widget.ItemOffer = data;
    // } else {
    //   widget.onSelectCouponOffer(null);
    //   widget.ItemOffer = null;
    // }

    int searchCoupon = listCouponAll.indexWhere((item) =>
        ((item.couponCode == data.couponCode) && (item.dateAdd == '')));
    if (searchCoupon >= 0) {
      chxCollectCoupon = data;
      chxSelectCollectCoupon = chxSelect;
      BlocProvider.of<CheckInCubit>(context)
          .collectCoupon(couponCode: data.couponCode);
    } else {
      if (chxSelect) {
        widget.onSelectCouponOffer(data);
        widget.ItemOffer = data;
      } else {
        widget.onSelectCouponOffer(null);
        widget.ItemOffer = null;
      }
      Navigator.of(context).pop();
    }

    setState(() {});

    // Navigator.of(context).pop();
  }

  void onTapIsuseInCouponDetail(String couponID, bool chxSelect) {
    int searchCoupon =
        listCouponAll.indexWhere((item) => item.couponCode == couponID);
    if (searchCoupon >= 0) {
      if (chxSelect) {
        // widget.onSelectCouponOffer(listCouponAll[searchCoupon]);
        // widget.ItemOffer = listCouponAll[searchCoupon];

        int checkCoupon = listCouponAll.indexWhere((item) =>
            ((item.couponCode == listCouponAll[searchCoupon].couponCode) &&
                (item.dateAdd == '')));
        if (checkCoupon >= 0) {
          chxCollectCoupon = listCouponAll[searchCoupon];
          chxSelectCollectCoupon = chxSelect;
          BlocProvider.of<CheckInCubit>(context).collectCoupon(
              couponCode: listCouponAll[searchCoupon].couponCode);
        } else {
          widget.onSelectCouponOffer(listCouponAll[searchCoupon]);
          widget.ItemOffer = listCouponAll[searchCoupon];
          Navigator.of(context).pop();
        }
      } else {
        widget.onSelectCouponOffer(null);
        widget.ItemOffer = null;
        Navigator.of(context).pop();
      }
    }

    setState(() {});
  }

  void getListSearch(String text) {
    if (text == '') {
      listCoupon = listCouponAll
          .where((item) =>
              (item.dateAdd != '') && (item.statusUsedCoupon == false))
          .toList();
    } else {
      listCoupon = listCouponAll
          .where(
              (item) => (item.couponCode.toLowerCase() == text.toLowerCase()))
          .toList();

      if (listCoupon.isNotEmpty) {
        int searchCoupon =
            listCoupon.indexWhere((item) => ((item.statusUsedCoupon == true)));
        if (searchCoupon >= 0) {
          Utilities.alertOneButtonAction(
            context: context,
            type: AppAlertType.DEFAULT,
            isForce: true,
            title: translate("check_in_page.modal_offers.title_alert"),
            description:
                translate("check_in_page.modal_offers.description_alert"),
            textButton: translate('button.try_again'),
            onPressButton: () {
              Navigator.of(context).pop();
            },
          );
        }
        listCoupon.removeWhere((item) => item.statusUsedCoupon == true);

        //   int searchCoupon =
        //       listCoupon.indexWhere((item) => ((item.statusUsedCoupon == true)));
        //   if (searchCoupon < 0) {
        //     // ScaffoldMessenger.of(context).showSnackBar(
        //     //   const SnackBar(content: Text('Used Coupon!!')),
        //     // );
        //     // listCoupon.removeWhere((item) => item.statusUsedCoupon == true);
        //     debugPrint(listCoupon[searchCoupon].couponCode);
        //   }
      }
    }

    setState(() {});
  }

  void onChangTextInput(String text) {
    widget.controllerTextSearch.text = controllerTextSearch.text;

    listCoupon.clear();

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      BlocProvider.of<CheckInCubit>(context).loadCouponSearch();
    });
  }

  void onClickScanQR() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => QRCodeCoupon(
                listItemOffer: listCouponAll,
                onSelectCouponOffer: onTapIsuseInCouponDetail,
                selectCoupon: (widget.ItemOffer != null
                    ? widget.ItemOffer!.couponCode
                    : ''),
              )),
    );
  }

  navigateCouponDetail(context, String data) {
    String ItemOffer = '';
    if (widget.ItemOffer != null) {
      ItemOffer = widget.ItemOffer!.couponCode;
    } else {
      ItemOffer = '';
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CouponDetailPage(
          couponID: data,
          bottomBar: 'checkin',
          onSelectCouponOffer: onTapIsuseInCouponDetail,
          selectCoupon: ItemOffer,
        ),
      ),
    );
  }

  void actionCouponSearchLoading() {}
  void actionCouponSearchSuccess(couponEntity) {
    listCouponAll = couponEntity;

    filterListCoupon();

    // onChangTextInput(controllerTextSearch.text);
    getListSearch(controllerTextSearch.text);
    // debugPrint('controllerTextSearch ${controllerTextSearch.text}');
  }

  void actionCouponSearchFailure() {}
  void actionCollectCouponLoading() {}
  void actionCollectCouponFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Utilities.alertOneButtonAction(
      //   context: context,
      //   type: AppAlertType.DEFAULT,
      //   isForce: true,
      //   title: translate('check_in_page.modal_offers.title_alert'),
      //   description: state.message ?? '',
      //   textButton: translate('button.try_again'),
      //   onPressButton: () {
      //     Navigator.of(context).pop();
      //   },
      // );
      Utilities.alertAfterSaveAction(
        context: context,
        type: AppAlertType.WARNING,
        time: 5,
        text:
            state.message ?? translate('alert_after_save.save_failure.coupon'),
      );
    });
    BlocProvider.of<CheckInCubit>(context).loadCouponSearch();
  }

  void actionCollectCouponSuccess(CollectCouponEntity? collectCoupon) {
    if (chxSelectCollectCoupon) {
      widget.onSelectCouponOffer(chxCollectCoupon);
      widget.ItemOffer = chxCollectCoupon;
    } else {
      widget.onSelectCouponOffer(null);
      widget.ItemOffer = null;
    }

    Utilities.alertAfterSaveAction(
      context: context,
      type: AppAlertType.SUCCESS,
      text: translate('alert_after_save.save_success.coupon'),
    );
    Navigator.of(context).pop();
    BlocProvider.of<CheckInCubit>(context).loadCouponSearch();
  }

  checkHeightModal() {
    if (listCoupon.length > 3) {
      heightListCouponItem = (heightItem * listCoupon.length);
      heightListCouponItem =
          heightListCouponItem > MediaQuery.of(context).size.height - 250
              ? MediaQuery.of(context).size.height - (heightItem * 3)
              : heightListCouponItem + 35;
      heightModal = (heightItem * (listCoupon.length + 3));
      heightModal = heightModal > MediaQuery.of(context).size.height
          ? MediaQuery.of(context).size.height - 100
          : heightModal + 5;
    }
    if (_focus.hasFocus) {
      heightListCouponItem = heightItem * 3;
      heightModal = heightItem * 5;
    }
  }

  @override
  void initState() {
    super.initState();

    listCouponAll = widget.listItemOffer;
    // widget.ItemOffer = null;
    filterListCoupon();
  }

  @override
  Widget build(BuildContext context) {
    checkHeightModal();
    return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          height: heightModal,
          child: Column(
            children: [
              _headerAndIconClose(),
              const SizedBox(height: 16),
              _textfiledSearch(),
              const SizedBox(height: 10),
              BlocListener<CheckInCubit, CheckInState>(
                listener: (context, state) {
                  switch (state.runtimeType) {
                    case CouponSearchLoading:
                      actionCouponSearchLoading();
                      break;
                    case CouponSearchSuccess:
                      actionCouponSearchSuccess(state.couponSearch);
                      break;
                    case CouponSearchFailure:
                      break;
                    case CollectCouponLoading:
                      actionCollectCouponLoading();
                      break;
                    case CollectCouponSuccess:
                      actionCollectCouponSuccess(state.collectCoupon);
                      break;
                    case CollectCouponFailure:
                      actionCollectCouponFailure(state);
                      break;
                    default:
                      break;
                  }
                },
                child: _listCouponItem(),
              ),
            ],
          ),
        ));
  }

  Widget _headerAndIconClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextLabel(
          text: translate("check_in_page.modal_offers.offers"),
          fontWeight: FontWeight.bold,
          color: AppTheme.black,
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.title),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: AppTheme.black),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _textfiledSearch() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 48,
        child: TextInputForm(
          focusNode: _focus,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          controller: controllerTextSearch,
          fillColor: AppTheme.lightBlue10,
          hintText: translate("check_in_page.modal_offers.hint_text_search"),
          hintStyle: TextStyle(
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.normal),
              color: AppTheme.black40),
          suffixIcon: IconButton(
            splashColor: AppTheme.transparent,
            icon: SvgPicture.asset(
              ImageAsset.ic_qr_code,
              width: 24,
              colorFilter: ColorFilter.mode(AppTheme.black60, BlendMode.srcIn),
            ),
            onPressed: () {
              onClickScanQR();
            },
          ),
          onSaved: (text) {},
          keyboardType: TextInputType.text,
          onChanged: (value) {
            onChangTextInput(value!);
          },
        ));
  }

  Widget _listCouponItem() {
    return SizedBox(
        height: heightListCouponItem,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: listCoupon.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) => _couponItem(context, index),
        ));
  }

  Widget _imageUrlItem(String url) {
    if (url == '') {
      return Container(
        width: 70,
        height: 70,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(3),
        ),
        child: SvgPicture.asset(
          ImageAsset.ic_coupons,
          width: 32,
          height: 32,
        ),
      );
    } else {
      return Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.fill,
          ),
        ),
      );
    }
  }

  Widget _couponItem(BuildContext context, int index) {
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
        height: heightItem,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                navigateCouponDetail(context, listCoupon[index].couponCode);
              },
              child: Container(
                  padding: const EdgeInsets.all(4),
                  width: width * 0.2,
                  child: Center(
                      child: _imageUrlItem(listCoupon[index].couponImage))),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  ((widget.ItemOffer != null
                              ? widget.ItemOffer!.couponCode
                              : '') ==
                          listCoupon[index].couponCode)
                      ? onTapIsUse(listCoupon[index], false)
                      : onTapIsUse(listCoupon[index], true);
                },
                child: Container(
                    padding: const EdgeInsets.only(left: 16),
                    width: width * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextLabel(
                            text: listCoupon[index].couponName,
                            maxLines: 1,
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.normal),
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.blueDark),
                        Row(
                          children: [
                            Icon(Icons.date_range,
                                color: AppTheme.gray9CA3AF, size: 12),
                            const SizedBox(width: 5),
                            Expanded(
                              child: TextLabel(
                                  text: getDateFormat(index),
                                  fontSize:
                                      Utilities.sizeFontWithDesityForDisplay(
                                          context, AppFontSize.small),
                                  color: AppTheme.gray9CA3AF,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 32),
              child: SizedBox.fromSize(
                  size: const Size(24, 24),
                  child: ((widget.ItemOffer != null
                              ? widget.ItemOffer!.couponCode
                              : '') ==
                          listCoupon[index].couponCode)
                      ? ClipOval(
                          child: Material(
                            color: AppTheme.blueD,
                            child: InkWell(
                              onTap: () {
                                onTapIsUse(listCoupon[index], false);
                              },
                              child: const Icon(Icons.done,
                                  color: AppTheme.white, size: 18),
                            ),
                          ),
                        )
                      : ClipOval(
                          child: Material(
                            color: AppTheme.lightBlue10,
                            child: InkWell(
                              onTap: () {
                                onTapIsUse(listCoupon[index], true);
                              },
                              child: const Icon(Icons.add,
                                  color: AppTheme.blueD, size: 24),
                            ),
                          ),
                        )),
            ),
          ],
        ));
  }
}

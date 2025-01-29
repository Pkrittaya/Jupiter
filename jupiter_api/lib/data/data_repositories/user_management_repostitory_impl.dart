import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/add_ev_car_charging_form.dart';
import 'package:jupiter_api/data/data_models/request/add_favorite_route_form.dart';
import 'package:jupiter_api/data/data_models/request/delete_favotite_route_form.dart';
import 'package:jupiter_api/data/data_models/request/fleet_charger_form.dart';
import 'package:jupiter_api/data/data_models/request/history_fleet_card_form.dart';
import 'package:jupiter_api/data/data_models/request/log_crash_form.dart';
import 'package:jupiter_api/data/data_models/request/object_empty_form.dart';
import 'package:jupiter_api/data/data_models/request/route_planning_form.dart';
import 'package:jupiter_api/data/data_models/request/set_notification_setting_form.dart';
import 'package:jupiter_api/data/data_models/request/update_fovorite_route_form.dart';
import 'package:jupiter_api/data/data_models/request/verify_email_form.dart';
import 'package:jupiter_api/data/data_models/response/list_car_select_fleet_model.dart';
import 'package:jupiter_api/domain/entities/favorite_route_item_entity.dart';
import 'package:jupiter_api/domain/entities/get_count_all_notification_entity.dart';
import 'package:jupiter_api/domain/entities/llst_charger_fleet_card_entity.dart';
import 'package:jupiter_api/domain/entities/llst_charger_fleet_operation_entity.dart';
import 'package:jupiter_api/domain/entities/notification_news.dart';
import 'package:jupiter_api/domain/entities/notification_setting_entity.dart';
import 'package:jupiter_api/domain/entities/route_planning_entity.dart';
import 'package:jupiter_api/domain/entities/verify_image_ocr_entity.dart';
import '../../domain/entities/advertisement_entity.dart';
import '../../domain/entities/car_entity.dart';
import '../../domain/entities/car_master_entity.dart';
import '../../domain/entities/charger_information_entity.dart';
import '../../domain/entities/check_status_entity.dart';
import '../../domain/entities/connector_type_entity.dart';
import '../../domain/entities/coupon_detail_entity.dart';
import '../../domain/entities/coupon_entity.dart';
import '../../domain/entities/credit_card_entity.dart';
import '../../domain/entities/default_entity.dart';
import '../../domain/entities/favorite_station_entity.dart';
import '../../domain/entities/finding_station_entity.dart';
import '../../domain/entities/fleet_card_info_entity.dart';
import '../../domain/entities/fleet_card_item_entity.dart';
import '../../domain/entities/fleet_operation_info_entity.dart';
import '../../domain/entities/fleet_operation_item_entity.dart';
import '../../domain/entities/get_list_reserve_entity.dart';
import '../../domain/entities/has_charging_fleet_card_entity.dart';
import '../../domain/entities/history_booking_detail_entity.dart';
import '../../domain/entities/history_booking_list_entity.dart';
import '../../domain/entities/history_detail_entity.dart';
import '../../domain/entities/history_entity.dart';
import '../../domain/entities/history_fleet_entity.dart';
import '../../domain/entities/list_billing_entity.dart';
import '../../domain/entities/list_data_permission_entity.dart';
import '../../domain/entities/list_notification_entity.dart';
import '../../domain/entities/llst_station_fleet_card_entity.dart';
import '../../domain/entities/llst_station_fleet_operation_entity.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/recommended_station_entity.dart';
import '../../domain/entities/request_access_key_entity.dart';
import '../../domain/entities/request_otp_forgot_pin_entity.dart';
import '../../domain/entities/reserve_receipt_entity.dart';
import '../../domain/entities/search_coupon_entity.dart';
import '../../domain/entities/search_coupon_for_used_entity.dart';
import '../../domain/entities/sign_in_entity.dart';
import '../../domain/entities/sign_up_entity.dart';
import '../../domain/entities/station_details_entity.dart';
import '../../domain/entities/station_entity.dart';
import '../../domain/entities/term_and_condition_entity.dart';
import '../../domain/entities/verify_account_entity.dart';
import '../../domain/entities/verify_card_entity.dart';
import '../../domain/repositories/user_management_repository.dart';
import '../data_models/request/active_notification_form.dart';
import '../data_models/request/add_ev_car_form.dart';
import '../data_models/request/add_tax_invoice_form.dart';
import '../data_models/request/change_password_form.dart';
import '../data_models/request/charger_information_form.dart';
import '../data_models/request/check_in_fleet_form.dart';
import '../data_models/request/check_status_fleet_form.dart';
import '../data_models/request/collect_coupon.dart';
import '../data_models/request/confirm_transaction_fleet_form.dart';
import '../data_models/request/coupon_information_form.dart';
import '../data_models/request/coupon_list_form.dart';
import '../data_models/request/create_reserve_form.dart';
import '../data_models/request/delete_account_form.dart';
import '../data_models/request/delete_card_payment_form.dart';
import '../data_models/request/delete_ev_car_form.dart';
import '../data_models/request/delete_ev_car_image_form.dart';
import '../data_models/request/delete_notification_form.dart';
import '../data_models/request/delete_tax_invoice_form.dart';
import '../data_models/request/edit_ev_car_form.dart';
import '../data_models/request/favorite_station_form.dart';
import '../data_models/request/finding_station_form.dart';
import '../data_models/request/fleet_detail_card_form.dart';
import '../data_models/request/fleet_no_form.dart';
import '../data_models/request/get_list_reserve_form.dart';
import '../data_models/request/history_booking_detail_form.dart';
import '../data_models/request/history_booking_list_form.dart';
import '../data_models/request/history_detail_form.dart';
import '../data_models/request/history_list_form.dart';
import '../data_models/request/list_payment_form.dart';
import '../data_models/request/manage_charger_form.dart';
import '../data_models/request/only_org_form.dart';
import '../data_models/request/payment_charging_form.dart';
import '../data_models/request/profile_form.dart';
import '../data_models/request/recommended_station_form.dart';
import '../data_models/request/remote_start_fleet_form.dart';
import '../data_models/request/remote_stop_fleet_form.dart';
import '../data_models/request/request_access_key_form.dart';
import '../data_models/request/request_otp_forgot_pin_form.dart';
import '../data_models/request/search_coupon_form.dart';
import '../data_models/request/send_email_forgot_password_form.dart';
import '../data_models/request/set_default_card_form.dart';
import '../data_models/request/set_language_form.dart';
import '../data_models/request/signin_account_form.dart';
import '../data_models/request/signout_account_form.dart';
import '../data_models/request/signup_account_form.dart';
import '../data_models/request/start_charger_form.dart';
import '../data_models/request/station_detail_form.dart';
import '../data_models/request/status_charger_form.dart';
import '../data_models/request/update_current_battery_form.dart';
import '../data_models/request/update_favorite_station_form.dart';
import '../data_models/request/update_select_payment_form.dart';
import '../data_models/request/username_and_orgcode_form.dart';
import '../data_models/request/verify_account_form.dart';
import '../data_models/request/verify_card_form.dart';
import '../data_models/request/verify_fleet_card_form.dart';
import '../data_models/request/verify_otp_forgot_pin_form.dart';
import '../data_models/response/collect_coupon_model.dart';
import '../data_sources/helper/exception.dart';
import 'package:dio/dio.dart';

import '../data_sources/helper/failure.dart';
import '../data_sources/remote/rest_client.dart';

@Injectable(as: UserManagementRepository)
class UserManagementRepositoryImpl implements UserManagementRepository {
  @FactoryMethod()
  late RestClient _client;

  UserManagementRepositoryImpl(RestClient client) {
    _client = client;
  }

  @override
  Future<Either<Failure, VerifyAccountEntity>> verifyAccount(
      VerifyAccountForm verifyAccountForm) async {
    debugPrint('verifyAccount  data ${verifyAccountForm.name}');
    debugPrint('verifyAccount  data ${verifyAccountForm.telphonenumber}');
    debugPrint('verifyAccount  data ${verifyAccountForm.username}');

    try {
      final response = await _client.verifyAccountFromService(
          verifyAccountForm: verifyAccountForm);
      debugPrint('verifyAccount success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('verifyAccount UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('verifyAccount CheckedFromJsonException');
      return const Left(DataModelFailure('verifyAccount DataWrong'));
    } on ServerException {
      debugPrint('verifyAccount server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('verifyAccount  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('verifyAccount DIo');
      debugPrint('verifyAccount DIo ${e.response?.statusCode}');
      debugPrint('verifyAccount DIo ${e.response?.statusMessage}');
      debugPrint('verifyAccount DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, TermAndConditionEntity>> registerConsent(
      String orgCode) async {
    try {
      final response =
          await _client.termAndConditionFromService(orgCode: orgCode);
      debugPrint('registerConsent success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('registerConsent UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('registerConsent CheckedFromJsonException');
      return const Left(DataModelFailure('registerConsent DataWrong'));
    } on ServerException {
      debugPrint('registerConsent server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('registerConsent  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('registerConsent DIo');
      debugPrint('registerConsent DIo ${e.response?.statusCode}');
      debugPrint('registerConsent DIo ${e.response?.statusMessage}');
      debugPrint('registerConsent DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, dynamic>> sendEmailForgotPassword(
      SendEmailForgotPasswordForm sendEmailForgotPasswordForm) async {
    try {
      final response = await _client.sendEmailForgotPasswordFromSevice(
          sendEmailForgotPasswordForm: sendEmailForgotPasswordForm);
      debugPrint('sendEmailForgotPassword success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('sendEmailForgotPassword UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('sendEmailForgotPassword CheckedFromJsonException');
      return const Left(DataModelFailure('registerConsent DataWrong'));
    } on ServerException {
      debugPrint('sendEmailForgotPassword server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('sendEmailForgotPassword  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('sendEmailForgotPassword DIo');
      debugPrint('sendEmailForgotPassword DIo ${e.response?.statusCode}');
      debugPrint('sendEmailForgotPassword DIo ${e.response?.statusMessage}');
      debugPrint('sendEmailForgotPassword DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, SignUpEntity>> signUp(
      SignupAccountForm signupAccountForm) async {
    try {
      final response =
          await _client.signUpToService(signupAccountForm: signupAccountForm);
      debugPrint('signUp success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('signUp UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('signUp CheckedFromJsonException');
      return const Left(DataModelFailure('signUp DataWrong'));
    } on ServerException {
      debugPrint('signUp server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('signUp  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('signUp DIo');
      debugPrint('signUp DIo ${e.response?.statusCode}');
      debugPrint('signUp DIo ${e.response?.statusMessage}');
      debugPrint('signUp DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, SignInEntity>> signIn(
      SignInAccountForm signInAccountForm) async {
    try {
      final response =
          await _client.signInToService(signInAccountForm: signInAccountForm);
      debugPrint('signIn success');
      debugPrint('signIn  success${signInAccountForm.username}');

      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('signIn UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('signIn CheckedFromJsonException');
      return const Left(DataModelFailure('signIn DataWrong'));
    } on ServerException {
      debugPrint('signIn server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('signIn  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('signIn DIo');
      debugPrint('signIn DIo ${e.response?.statusCode}');
      debugPrint('signIn DIo ${e.response?.statusMessage}');
      debugPrint('signIn DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> signOut(
      SignOutAccountForm signOutAccountForm) async {
    try {
      final response = await _client.signOutToService(
          signOutAccountForm: signOutAccountForm);
      debugPrint('signOut success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('signOut UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('signOut CheckedFromJsonException');
      return const Left(DataModelFailure('signIn DataWrong'));
    } on ServerException {
      debugPrint('signOut server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('signOut  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('signOut DIo');
      debugPrint('signOut DIo ${e.response?.statusCode}');
      debugPrint('signOut DIo ${e.response?.statusMessage}');
      debugPrint('signOut DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, RequestAccessKeyEntity>> requestAccessToken(
      RequestAccessKeyForm requestAccessKeyForm) async {
    try {
      final response = await _client.requestAccessTokenFromService(
          requestAccessKeyForm: requestAccessKeyForm);
      debugPrint('requestAccessToken success');
      debugPrint('requestAccessToken T ${response.data.token.accessToken} ');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('requestAccessToken UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('requestAccessToken CheckedFromJsonException');
      return const Left(DataModelFailure('requestAccessToken DataWrong'));
    } on ServerException {
      debugPrint('requestAccessToken server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('requestAccessToken  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('requestAccessToken DIo');
      debugPrint('requestAccessToken DIo ${e.response?.statusCode}');
      debugPrint('requestAccessToken DIo ${e.response?.statusMessage}');
      debugPrint('sigrequestAccessTokennUp DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, List<StationEntity>>> listAllMarkerStation(
      String accessToken, OnlyOrgForm onlyOrgForm) async {
    try {
      final response = await _client.listAllStationMarkerFromService(
          accessToken: 'Bearer $accessToken', onlyOrgForm: onlyOrgForm);
      debugPrint('listAllMarkerStation success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('listAllMarkerStation UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('listAllMarkerStation CheckedFromJsonException');
      return const Left(DataModelFailure('listAllMarkerStation DataWrong'));
    } on ServerException {
      debugPrint('listAllMarkerStation server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('listAllMarkerStation  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('listAllMarkerStation DIo');
      debugPrint('listAllMarkerStation DIo ${e.response?.statusCode}');
      debugPrint('listAllMarkerStation DIo ${e.response?.statusMessage}');
      debugPrint('listAllMarkerStation DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, StationDetailEntity>> stationDetail(
      String accessToken, StationDetailForm stationDetailForm) async {
    try {
      final response = await _client.stationDetailFromService(
          accessToken: 'Bearer $accessToken',
          stationDetailForm: stationDetailForm);
      debugPrint('stationDetail success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('stationDetail UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('stationDetail CheckedFromJsonException');
      return const Left(DataModelFailure('stationDetail DataWrong'));
    } on ServerException {
      debugPrint('stationDetail server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('stationDetail  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('stationDetail DIo');
      debugPrint('stationDetail DIo ${e.response?.statusCode}');
      debugPrint('stationDetail DIo ${e.response?.statusMessage}');
      debugPrint('stationDetail DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, FindingStationEntity>> findingStation(
      String accessToken, FindingStationForm findingStationForm) async {
    try {
      final response = await _client.findingStationFromService(
          accessToken: 'Bearer $accessToken',
          findingStationForm: findingStationForm);
      debugPrint('findingStation success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('findingStation UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('findingStation CheckedFromJsonException');
      return const Left(DataModelFailure('findingStation DataWrong'));
    } on ServerException {
      debugPrint('findingStation server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('findingStation  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('findingStation DIo');
      debugPrint('findingStation DIo ${e.response?.statusCode}');
      debugPrint('findingStation DIo ${e.response?.statusMessage}');
      debugPrint('findingStation DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, FavoriteStationEntity>> favoriteStation(
      String accessToken, FavoriteStationForm favoriteStationForm) async {
    try {
      final response = await _client.favoriteStationFromService(
          accessToken: 'Bearer $accessToken',
          favoriteStationForm: favoriteStationForm);
      debugPrint('favoriteStation success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('favoriteStation UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('favoriteStation CheckedFromJsonException');
      return const Left(DataModelFailure('favoriteStation DataWrong'));
    } on ServerException {
      debugPrint('favoriteStation server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('favoriteStation  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('favoriteStation DIo');
      debugPrint('favoriteStation DIo ${e.response?.statusCode}');
      debugPrint('favoriteStation DIo ${e.response?.statusMessage}');
      debugPrint('favoriteStation DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, dynamic>> updateFavoriteStation(String accessToken,
      UpdateFavoriteStationForm updateFavoriteStationForm) async {
    try {
      final response = await _client.updatefavoriteStationFromService(
          accessToken: 'Bearer $accessToken',
          updateFavoriteStationForm: updateFavoriteStationForm);
      debugPrint('updateFavoriteStation success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('updateFavoriteStation UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('updateFavoriteStation CheckedFromJsonException');
      return const Left(DataModelFailure('updateSelectPayment DataWrong'));
    } on ServerException {
      debugPrint('updateFavoriteStation server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('updateFavoriteStation  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('updateFavoriteStation DIo');
      debugPrint('updateFavoriteStation DIo ${e.response?.statusCode}');
      debugPrint('updateFavoriteStation DIo ${e.response?.statusMessage}');
      debugPrint('updateFavoriteStation DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, AdvertisementEntity>> advertisement(
      String accessToken, UsernameAndOrgCodeForm advertisementForm) async {
    try {
      final response = await _client.advertisementFromService(
          accessToken: 'Bearer $accessToken',
          advertisementForm: advertisementForm);
      debugPrint('advertisement success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('advertisement UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('advertisement CheckedFromJsonException');
      return const Left(DataModelFailure('advertisement DataWrong'));
    } on ServerException {
      debugPrint('advertisement server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('advertisement  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('advertisement DIo');
      debugPrint('advertisement DIo ${e.response?.statusCode}');
      debugPrint('advertisement DIo ${e.response?.statusMessage}');
      debugPrint('advertisement DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, ChargerInformationEntity>> chargerInformation(
      String accessToken, ChargerInformationForm chargerInformationForm) async {
    try {
      final response = await _client.chargerInformationFromService(
          accessToken: 'Bearer $accessToken',
          chargerInformationForm: chargerInformationForm);
      debugPrint('chargerInformation success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('chargerInformation UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('chargerInformation CheckedFromJsonException');
      return const Left(DataModelFailure('chargerInformation DataWrong'));
    } on ServerException {
      debugPrint('chargerInformation server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('chargerInformation  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('chargerInformation DIo');
      debugPrint('chargerInformation DIo ${e.response?.statusCode}');
      debugPrint('chargerInformation DIo ${e.response?.statusMessage}');
      debugPrint('chargerInformation DIo ${e.response?.data}');
      Map<String, dynamic> data = e.response?.data;
      debugPrint('chargerInformation DIoJson $data');
      return Left(ConnectionFailure(
          data["message"] ?? 'Failed to connect to the network ETC'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> listPayment(
      String accessToken, ListPaymentForm listPaymentForm) async {
    try {
      final response = await _client.listPaymentFromService(
          accessToken: 'Bearer $accessToken', listPaymentForm: listPaymentForm);
      debugPrint('listPayment success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('listPayment UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('listPayment CheckedFromJsonException');
      return const Left(DataModelFailure('listPayment DataWrong'));
    } on ServerException {
      debugPrint('listPayment server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('listPayment  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('listPayment DIo');
      debugPrint('listPayment DIo ${e.response?.statusCode}');
      debugPrint('listPayment DIo ${e.response?.statusMessage}');
      debugPrint('listPayment DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, dynamic>> updateSelectPayment(String accessToken,
      UpdateSelectPaymentForm updateSelectPaymentForm) async {
    try {
      final response = await _client.updateSelectPaymentFromService(
          accessToken: 'Bearer $accessToken',
          updateSelectPaymentForm: updateSelectPaymentForm);
      debugPrint('updateSelectPayment success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('updateSelectPayment UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('updateSelectPayment CheckedFromJsonException');
      return const Left(DataModelFailure('updateSelectPayment DataWrong'));
    } on ServerException {
      debugPrint('updateSelectPayment server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('updateSelectPayment  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('updateSelectPayment DIo');
      debugPrint('updateSelectPayment DIo ${e.response?.statusCode}');
      debugPrint('updateSelectPayment DIo ${e.response?.statusMessage}');
      debugPrint('updateSelectPayment DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, dynamic>> paymentCharging(
      String accessToken, PaymentChargingForm paymentChargingForm) async {
    try {
      final response = await _client.paymentChargingFromService(
          accessToken: 'Bearer $accessToken',
          paymentChargingForm: paymentChargingForm);
      debugPrint('paymentChargingForm success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('paymentChargingForm UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('paymentChargingForm CheckedFromJsonException');
      return const Left(DataModelFailure('paymentChargingForm DataWrong'));
    } on ServerException {
      debugPrint('paymentChargingForm server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('paymentChargingForm  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('paymentChargingForm DIo');
      debugPrint('paymentChargingForm DIo ${e.response?.statusCode}');
      debugPrint('paymentChargingForm DIo ${e.response?.statusMessage}');
      debugPrint('paymentChargingForm DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, dynamic>> updateCurrentBattery(String accessToken,
      UpdateCurrentBatteryForm updateCurrentBatteryForm) async {
    try {
      final response = await _client.updateCurrentBatteryFromService(
          accessToken: 'Bearer $accessToken',
          updateCurrentBatteryForm: updateCurrentBatteryForm);
      debugPrint('updateCurrentBattery success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('updateCurrentBattery UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('updateCurrentBattery CheckedFromJsonException');
      return const Left(DataModelFailure('updateSelectPayment DataWrong'));
    } on ServerException {
      debugPrint('updateCurrentBattery server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('updateCurrentBattery  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('updateCurrentBattery DIo');
      debugPrint('updateCurrentBattery DIo ${e.response?.statusCode}');
      debugPrint('updateCurrentBattery DIo ${e.response?.statusMessage}');
      debugPrint('updateCurrentBattery DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, List<ConnectorTypeEntity>>> filterMapType(
      String accessToken) async {
    try {
      final response = await _client.connectorTypeFilterFromService(
        accessToken: 'Bearer $accessToken',
      );
      debugPrint('filterMapType success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('filterMapType UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('filterMapType CheckedFromJsonException');
      return const Left(DataModelFailure('filterMapType DataWrong'));
    } on ServerException {
      debugPrint('filterMapType server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('filterMapType  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('filterMapType DIo');
      debugPrint('filterMapType DIo ${e.response?.statusCode}');
      debugPrint('filterMapType DIo ${e.response?.statusMessage}');
      debugPrint('filterMapType DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> startCharging(
      String accessToken, StartChargerForm startChargerForm) async {
    debugPrint('startChargerForm  ${startChargerForm.toJson()} ');

    try {
      final response = await _client.startChargeFromService(
          accessToken: 'Bearer $accessToken',
          startChargerForm: startChargerForm);
      debugPrint('startCharging success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('startCharging UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('startCharging CheckedFromJsonException');
      return const Left(DataModelFailure('startCharging DataWrong'));
    } on ServerException {
      debugPrint('startCharging server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('startCharging  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('startCharging DIo');
      debugPrint('startCharging DIo ${e.response?.statusCode}');
      debugPrint('startCharging DIo ${e.response?.statusMessage}');
      debugPrint('startCharging DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> stopCharging(
      String accessToken, ManageChargerForm manageChargerForm) async {
    try {
      final response = await _client.stopChargeFromService(
          accessToken: 'Bearer $accessToken',
          manageChargerForm: manageChargerForm);
      debugPrint('stopCharging success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('stopCharging UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('stopCharging CheckedFromJsonException');
      return const Left(DataModelFailure('stopCharging DataWrong'));
    } on ServerException {
      debugPrint('stopCharging server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('stopCharging  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('stopCharging DIo');
      debugPrint('stopCharging DIo ${e.response?.statusCode}');
      debugPrint('stopCharging DIo ${e.response?.statusMessage}');
      debugPrint('stopCharging DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, CheckStatusEntity>> statusCharing(
      String accessToken, StatusChargerForm statusChargerForm) async {
    try {
      final response = await _client.statusChargingFromService(
          accessToken: 'Bearer $accessToken',
          statusChargerForm: statusChargerForm);
      debugPrint('statusCharing success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('statusCharing UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException catch (e) {
      debugPrint('statusCharing CheckedFromJsonException');
      debugPrint('statusCharing CheckedFromJsonException ${e.message}');
      return const Left(DataModelFailure('statusCharing DataWrong'));
    } on ServerException {
      debugPrint('statusCharing server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('statusCharing  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('statusCharing DIo');
      debugPrint('statusCharing DIo ${e.response?.statusCode}');
      debugPrint('statusCharing DIo ${e.response?.statusMessage}');
      debugPrint('statusCharing DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> confirmCharging(
      String accessToken, ManageChargerForm manageChargerForm) async {
    try {
      final response = await _client.confirmCharigingFromService(
          accessToken: 'Bearer $accessToken',
          manageChargerForm: manageChargerForm);
      debugPrint('confirmCharging success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('confirmCharging UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('confirmCharging CheckedFromJsonException');
      return const Left(DataModelFailure('confirmCharging DataWrong'));
    } on ServerException {
      debugPrint('confirmCharging server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('confirmCharging  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('confirmCharging DIo');
      debugPrint('confirmCharging DIo ${e.response?.statusCode}');
      debugPrint('confirmCharging DIo ${e.response?.statusMessage}');
      debugPrint('confirmCharging DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> profile(
      String accessToken, UsernameAndOrgCodeForm usernameAndOrgCodeForm) async {
    try {
      final response = await _client.profileFromService(
          accessToken: 'Bearer $accessToken',
          usernameAndOrgCodeForm: usernameAndOrgCodeForm);
      debugPrint('profile success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('profile UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('profile CheckedFromJsonException');
      return const Left(DataModelFailure('profile DataWrong'));
    } on ServerException {
      debugPrint('profile server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('profile  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('profile DIo');
      debugPrint('profile DIo ${e.response?.statusCode}');
      debugPrint('profile DIo ${e.response?.statusMessage}');
      debugPrint('profile DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> updateProfile(
      String accessToken, ProfileForm profileForm) async {
    try {
      final response = await _client.updateProfileFromService(
          accessToken: 'Bearer $accessToken', profileForm: profileForm);
      debugPrint('updateProfile success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('updateProfile UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('updateProfile CheckedFromJsonException');
      return const Left(DataModelFailure('updateProfile DataWrong'));
    } on ServerException {
      debugPrint('updateProfile server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('updateProfile  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('updateProfile DIo');
      debugPrint('updateProfile DIo ${e.response?.statusCode}');
      debugPrint('updateProfile DIo ${e.response?.statusMessage}');
      debugPrint('updateProfile DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> updateProfilePicture(
      String accessToken, File file, String payload) async {
    try {
      final response = await _client.updateProfileImageFromService(
          accessToken: 'Bearer $accessToken', file: file, payload: payload);
      debugPrint('updateProfilePicture success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('updateProfilePicture UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('updateProfilePicture CheckedFromJsonException');
      return const Left(DataModelFailure('updateProfilePicture DataWrong'));
    } on ServerException {
      debugPrint('updateProfilePicture server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('updateProfilePicture  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('updateProfilePicture DIo');
      debugPrint('updateProfilePicture DIo ${e.response?.statusCode}');
      debugPrint('updateProfilePicture DIo ${e.response?.statusMessage}');
      debugPrint('updateProfilePicture DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, List<CreditCardEntity>>> creditCardList(
      String accessToken, UsernameAndOrgCodeForm usernameAndOrgCodeForm) async {
    try {
      final response = await _client.creditCardListFromService(
          accessToken: 'Bearer $accessToken',
          usernameAndOrgCodeForm: usernameAndOrgCodeForm);
      debugPrint('creditCardList success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('creditCardList UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('creditCardList CheckedFromJsonException');
      return const Left(DataModelFailure('creditCardList DataWrong'));
    } on ServerException {
      debugPrint('creditCardList server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('creditCardList  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('creditCardList DIo');
      debugPrint('creditCardList DIo ${e.response?.statusCode}');
      debugPrint('creditCardList DIo ${e.response?.statusMessage}');
      debugPrint('creditCardList DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, VerifyCardEntity>> verifyCard(
      String accessToken, VerifyCardForm verifyCardForm) async {
    try {
      final response = await _client.verifyCardFromService(
          accessToken: 'Bearer $accessToken', verifyCardForm: verifyCardForm);
      debugPrint('verifyCard success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('verifyCard UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('verifyCard CheckedFromJsonException');
      return const Left(DataModelFailure('verifyCard DataWrong'));
    } on ServerException {
      debugPrint('verifyCard server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('verifyCard  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('verifyCard DIo');
      debugPrint('verifyCard DIo ${e.response?.statusCode}');
      debugPrint('verifyCard DIo ${e.response?.statusMessage}');
      debugPrint('verifyCard DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, List<CarEntity>>> carList(
      String accessToken, UsernameAndOrgCodeForm usernameAndOrgCodeForm) async {
    try {
      final response = await _client.carListFromService(
          accessToken: 'Bearer $accessToken',
          usernameAndOrgCodeForm: usernameAndOrgCodeForm);
      debugPrint('carList success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('carList UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('carList CheckedFromJsonException');
      return const Left(DataModelFailure('carList DataWrong'));
    } on ServerException {
      debugPrint('carList server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('carList  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('carList DIo');
      debugPrint('carList DIo ${e.response?.statusCode}');
      debugPrint('carList DIo ${e.response?.statusMessage}');
      debugPrint('carList DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, List<CarMasterEntity>>> carMaster(
      String accessToken, String orgCode) async {
    try {
      final response = await _client.carMasterFromService(
        accessToken: 'Bearer $accessToken',
        orgCode: orgCode,
      );
      debugPrint('carMaster success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('carMaster UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('carMaster CheckedFromJsonException');

      return const Left(DataModelFailure('carMaster DataWrong'));
    } on ServerException {
      debugPrint('carMaster server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('carMaster  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('carMaster DIo');
      debugPrint('carMaster DIo ${e.response?.statusCode}');
      debugPrint('carMaster DIo ${e.response?.statusMessage}');
      debugPrint('carMaster DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> addCar(
      String accessToken, AddEvCarForm addEvCarForm) async {
    try {
      final response = await _client.addCarFromService(
          accessToken: 'Bearer $accessToken', addEvCarForm: addEvCarForm);
      debugPrint('addCar success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('addCar UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('addCar CheckedFromJsonException');
      return const Left(DataModelFailure('addCar DataWrong'));
    } on ServerException {
      debugPrint('addCar server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('addCar  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('addCar DIo');
      debugPrint('addCar DIo ${e.response?.statusCode}');
      debugPrint('addCar DIo ${e.response?.statusMessage}');
      debugPrint('addCar DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> deleteCar(
      String accessToken, DeleteEvCarForm deleteEvCarForm) async {
    try {
      final response = await _client.deleteCarFromService(
          accessToken: 'Bearer $accessToken', deleteEvCarForm: deleteEvCarForm);
      debugPrint('deleteCar success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('deleteCar UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('deleteCar CheckedFromJsonException');
      return const Left(DataModelFailure('deleteCar DataWrong'));
    } on ServerException {
      debugPrint('deleteCar server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('deleteCar  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('deleteCar DIo');
      debugPrint('deleteCar DIo ${e.response?.statusCode}');
      debugPrint('deleteCar DIo ${e.response?.statusMessage}');
      debugPrint('deleteCar DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> addCarImage(
      String accessToken, String brand, String model, File file) async {
    try {
      final response = await _client.addCarImageFromService(
        accessToken: 'Bearer $accessToken',
        brand: brand,
        model: model,
        file: file,
      );
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('addCarImage UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('addCarImage CheckedFromJsonException');
      return const Left(DataModelFailure('addCarImage DataWrong'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('addCarImage DIo');
      debugPrint('addCarImage DIo ${e.response?.statusCode}');
      debugPrint('addCarImage DIo ${e.response?.statusMessage}');
      debugPrint('addCarImage DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> deleteCarImage(
      String accessToken, DeleteEvCarImageForm form) async {
    try {
      final response = await _client.deleteCarImageFromService(
        accessToken: 'Bearer $accessToken',
        form: form,
      );
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('deleteCarImage UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('deleteCarImage CheckedFromJsonException');
      return const Left(DataModelFailure('deleteCarImage DataWrong'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('deleteCarImage DIo');
      debugPrint('deleteCarImage DIo ${e.response?.statusCode}');
      debugPrint('deleteCarImage DIo ${e.response?.statusMessage}');
      debugPrint('deleteCarImage DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, HistoryEntity>> getHistoryList(
      String accessToken, HistoryListForm form) async {
    try {
      final response = await _client.getHistoryListFromService(
          accessToken: 'Bearer $accessToken', form: form);
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('getHistoryList UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('getHistoryList CheckedFromJsonException');
      return const Left(DataModelFailure('getHistoryList DataWrong'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('getHistoryDetail DIo');
      debugPrint('getHistoryList DIo ${e.response?.statusCode}');
      debugPrint('getHistoryList DIo ${e.response?.statusMessage}');
      debugPrint('getHistoryList DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, HistoryBookingListEntity>> getHistoryBookingList(
      String accessToken, HistoryBookingListForm historyBookingListForm) async {
    try {
      final response = await _client.getHistoryBookingListFromService(
          accessToken: 'Bearer $accessToken',
          historyBookingListForm: historyBookingListForm);
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('getHistoryBookingList UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('getHistoryBookingList CheckedFromJsonException');
      return const Left(DataModelFailure('getHistoryBookingList DataWrong'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('getHistoryBookingList DIo');
      debugPrint('getHistoryBookingList DIo ${e.response?.statusCode}');
      debugPrint('getHistoryBookingList DIo ${e.response?.statusMessage}');
      debugPrint('getHistoryBookingList DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, HistoryDetailEntity>> getHistoryDetail(
      String accessToken, HistoryDetailForm form) async {
    try {
      final response = await _client.getHistoryDetailFromService(
          accessToken: 'Bearer $accessToken', form: form);
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('getHistoryDetail UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('getHistoryDetail CheckedFromJsonException');
      return const Left(DataModelFailure('getHistoryDetail DataWrong'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('getHistoryDetail DIo');
      debugPrint('getHistoryDetail DIo ${e.response?.statusCode}');
      debugPrint('getHistoryDetail DIo ${e.response?.statusMessage}');
      debugPrint('edigetHistoryDetailtCar DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, HistoryBookingDetailEntity>> getHistoryBookingDetail(
      String accessToken,
      HistoryBookingDetailForm historyBookingDetailForm) async {
    try {
      final response = await _client.getHistoryBookingDetailFromService(
          accessToken: 'Bearer $accessToken',
          historyBookingDetailForm: historyBookingDetailForm);
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('getHistoryBookingDetail UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('getHistoryBookingDetail CheckedFromJsonException');
      return const Left(DataModelFailure('getHistoryBookingDetail DataWrong'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('getHistoryBookingDetail DIo');
      debugPrint('getHistoryBookingDetail DIo ${e.response?.statusCode}');
      debugPrint('getHistoryBookingDetail DIo ${e.response?.statusMessage}');
      debugPrint('getHistoryBookingDetail DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> editCar(
      String accessToken, EditEvCarForm editEvCarForm) async {
    try {
      final response = await _client.editCarFromService(
          accessToken: 'Bearer $accessToken', editEvCarForm: editEvCarForm);
      debugPrint('editCar success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('editCar UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('editCar CheckedFromJsonException');
      return const Left(DataModelFailure('editCar DataWrong'));
    } on ServerException {
      debugPrint('editCar server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('editCar  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('editCar DIo');
      debugPrint('editCar DIo ${e.response?.statusCode}');
      debugPrint('editCar DIo ${e.response?.statusMessage}');
      debugPrint('editCar DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> addTaxInvoice(
      String accessToken, AddTaxInvoiceForm addTaxInvoiceForm) async {
    try {
      final response = await _client.addTaxInvoiceFromSevice(
          accessToken: 'Bearer $accessToken',
          addTaxInvoiceForm: addTaxInvoiceForm);
      debugPrint('addTaxInvoice success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('addTaxInvoice UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('addTaxInvoice CheckedFromJsonException');
      return const Left(DataModelFailure('addTaxInvoice DataWrong'));
    } on ServerException {
      debugPrint('addTaxInvoice server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('addTaxInvoice  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('addTaxInvoice DIo');
      debugPrint('addTaxInvoice DIo ${e.response?.statusCode}');
      debugPrint('addTaxInvoice DIo ${e.response?.statusMessage}');
      debugPrint('addTaxInvoice DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> updateTaxInvoice(
      String accessToken, AddTaxInvoiceForm updateTaxInvoiceForm) async {
    try {
      final response = await _client.updateTaxInvoiceFromSevice(
          accessToken: 'Bearer $accessToken',
          updateTaxInvoiceForm: updateTaxInvoiceForm);
      debugPrint('updateTaxInvoice success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('updateTaxInvoice UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('updateTaxInvoice CheckedFromJsonException');
      return const Left(DataModelFailure('updateTaxInvoice DataWrong'));
    } on ServerException {
      debugPrint('updateTaxInvoice server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('updateTaxInvoice  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('updateTaxInvoice DIo');
      debugPrint('updateTaxInvoice DIo ${e.response?.statusCode}');
      debugPrint('updateTaxInvoice DIo ${e.response?.statusMessage}');
      debugPrint('updateTaxInvoice DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, ListBillingEntity>> getTaxInvoice(
      String accessToken, UsernameAndOrgCodeForm usernameAndOrgCodeForm) async {
    try {
      final response = await _client.getTaxInvoiceFromSevice(
          accessToken: 'Bearer $accessToken',
          usernameAndOrgCodeForm: usernameAndOrgCodeForm);
      debugPrint('getListTaxInvoice success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('getListTaxInvoice UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('getListTaxInvoice CheckedFromJsonException');
      return const Left(DataModelFailure('getListTaxInvoice DataWrong'));
    } on ServerException {
      debugPrint('getListTaxInvoice server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('getListTaxInvoice  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('getListTaxInvoice DIo');
      debugPrint('getListTaxInvoice DIo ${e.response?.statusCode}');
      debugPrint('getListTaxInvoice DIo ${e.response?.statusMessage}');
      debugPrint('getListTaxInvoice DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> deleteTaxInvoice(
      String accessToken, DeleteTaxInvoiceForm deleteTaxInvoiceForm) async {
    try {
      final response = await _client.deleteTaxInvoiceFromSevice(
          accessToken: 'Bearer $accessToken',
          deleteTaxInvoiceForm: deleteTaxInvoiceForm);
      debugPrint('deleteTaxInvoice success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('deleteTaxInvoice UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('deleteTaxInvoice CheckedFromJsonException');
      return const Left(DataModelFailure('deleteTaxInvoice DataWrong'));
    } on ServerException {
      debugPrint('deleteTaxInvoice server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('deleteTaxInvoice  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('deleteTaxInvoice DIo');
      debugPrint('deleteTaxInvoice DIo ${e.response?.statusCode}');
      debugPrint('deleteTaxInvoice DIo ${e.response?.statusMessage}');
      debugPrint('deleteTaxInvoice DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> setDefaultCard(
      String accessToken, SetDefaultCardForm setDefaultCardForm) async {
    try {
      final response = await _client.setDefaultCardFromService(
          accessToken: 'Bearer $accessToken',
          setDefaultCardForm: setDefaultCardForm);
      debugPrint('setDefaultCard success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('setDefaultCard UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('setDefaultCard CheckedFromJsonException');
      return const Left(DataModelFailure('setDefaultCard DataWrong'));
    } on ServerException {
      debugPrint('setDefaultCard server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('setDefaultCard  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('setDefaultCard DIo');
      debugPrint('setDefaultCard DIo ${e.response?.statusCode}');
      debugPrint('setDefaultCard DIo ${e.response?.statusMessage}');
      debugPrint('setDefaultCard DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> deletePaymentCard(
      String accessToken, DeleteCardPaymentForm deleteCardPaymentForm) async {
    try {
      final response = await _client.deletePaymentCardFromService(
          accessToken: 'Bearer $accessToken',
          deleteCardPaymentForm: deleteCardPaymentForm);
      debugPrint('deletePaymentCard success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('deletePaymentCard UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('deletePaymentCard CheckedFromJsonException');
      return const Left(DataModelFailure('deletePaymentCard DataWrong'));
    } on ServerException {
      debugPrint('deletePaymentCard server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('deletePaymentCard  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('deletePaymentCard DIo');
      debugPrint('deletePaymentCard DIo ${e.response?.statusCode}');
      debugPrint('deletePaymentCard DIo ${e.response?.statusMessage}');
      debugPrint('deletePaymentCard DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, RequestOtpForgotPinEntity>> requestOtpForgotPin(
      RequestOtpForgotPinForm requestOtpForgotPinForm) async {
    try {
      final response = await _client.requestOtpForgotPinFromService(
          requestOtpForgotPinForm: requestOtpForgotPinForm);
      debugPrint('requestOtpForgotPin success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('requestOtpForgotPin UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('requestOtpForgotPin CheckedFromJsonException');
      return const Left(DataModelFailure('requestOtpForgotPin DataWrong'));
    } on ServerException {
      debugPrint('requestOtpForgotPin server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('requestOtpForgotPin  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('requestOtpForgotPin DIo');
      debugPrint('requestOtpForgotPin DIo ${e.response?.statusCode}');
      debugPrint('requestOtpForgotPin DIo ${e.response?.statusMessage}');
      debugPrint('requestOtpForgotPin DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> verifyOtpForgotPin(
      VerifyOtpForgotPinForm verifyOtpForgotPinForm) async {
    try {
      final response = await _client.verifyOtpForgotPinFromService(
          verifyOtpForgotPinForm: verifyOtpForgotPinForm);
      debugPrint('verifyOtpForgotPin success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('verifyOtpForgotPin UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('verifyOtpForgotPin CheckedFromJsonException');
      return const Left(DataModelFailure('deletePaymentCard DataWrong'));
    } on ServerException {
      debugPrint('verifyOtpForgotPin server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('verifyOtpForgotPin  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('verifyOtpForgotPin DIo');
      debugPrint('verifyOtpForgotPin DIo ${e.response?.statusCode}');
      debugPrint('verifyOtpForgotPin DIo ${e.response?.statusMessage}');
      debugPrint('verifyOtpForgotPin DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, List<CouponItemEntity>>> listMyCoupon(
      String accessToken, CouponListForm couponList, String orgCode) async {
    try {
      final response = await _client.listMyCouponFromService(
          accessToken: 'Bearer $accessToken',
          couponList: couponList,
          orgCode: orgCode);
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('getlistMyCoupon UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('getlistMyCoupon CheckedFromJsonException');
      return const Left(DataModelFailure('getlistMyCoupon DataWrong'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('listMyCoupon DIo');
      debugPrint('listMyCoupon DIo ${e.response?.statusCode}');
      debugPrint('listMyCoupon DIo ${e.response?.statusMessage}');
      debugPrint('listMyCoupon DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, List<CouponItemEntity>>> listUsedCoupon(
      String accessToken, CouponListForm couponList, String orgCode) async {
    try {
      final response = await _client.listUsedCouponFromService(
          accessToken: 'Bearer $accessToken',
          couponList: couponList,
          orgCode: orgCode);
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('getlistUsedCoupon UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('getlistUsedCoupon CheckedFromJsonException');
      return const Left(DataModelFailure('getlistUsedCoupon DataWrong'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('listUsedCoupon DIo');
      debugPrint('listUsedCoupon DIo ${e.response?.statusCode}');
      debugPrint('listUsedCoupon DIo ${e.response?.statusMessage}');
      debugPrint('listUsedCoupon DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, CouponDetailEntity>> couponDetail(String accessToken,
      CouponInformationForm couponDetail, String orgCode) async {
    try {
      final response = await _client.couponDetailFromService(
          accessToken: 'Bearer $accessToken',
          couponDetail: couponDetail,
          orgCode: orgCode);
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('getcouponDetail UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('getcouponDetail CheckedFromJsonException');
      return const Left(DataModelFailure('getcouponDetail DataWrong'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('couponDetail DIo');
      debugPrint('couponDetail DIo ${e.response?.statusCode}');
      debugPrint('couponDetail DIo ${e.response?.statusMessage}');
      debugPrint('couponDetail DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, List<SearchCouponItemEntity>>> searchCoupon(
      String accessToken, SearchCouponForm searchCoupon, String orgCode) async {
    try {
      final response = await _client.searchCouponFromService(
          accessToken: 'Bearer $accessToken',
          searchCoupon: searchCoupon,
          orgCode: orgCode);
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('getsearchcoupon UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('getsearchcoupon CheckedFromJsonException');
      return const Left(DataModelFailure('getsearchcoupon DataWrong'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('searchCoupon DIo');
      debugPrint('searchCoupon DIo ${e.response?.statusCode}');
      debugPrint('searchCoupon DIo ${e.response?.statusMessage}');
      debugPrint('searchCoupon DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, List<SearchCouponItemForUsedEntity>>>
      searchCouponCheckinPage(String accessToken, SearchCouponForm searchCoupon,
          String orgCode) async {
    try {
      final response = await _client.searchCouponCheckinPageFromService(
          accessToken: 'Bearer $accessToken',
          searchCoupon: searchCoupon,
          orgCode: orgCode);
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('getsearchcoupon UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('getsearchcoupon CheckedFromJsonException');
      return const Left(DataModelFailure('getsearchcoupon DataWrong'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('searchCoupon DIo');
      debugPrint('searchCoupon DIo ${e.response?.statusCode}');
      debugPrint('searchCoupon DIo ${e.response?.statusMessage}');
      debugPrint('searchCoupon DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, CollectCouponModel>> collectCoupon(String accessToken,
      CollectCouponForm collectCouponForm, String orgCode) async {
    try {
      final response = await _client.collectCouponFromSevice(
          accessToken: 'Bearer $accessToken',
          collectCouponForm: collectCouponForm,
          orgCode: orgCode);
      debugPrint('collectCoupon success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('collectCoupon UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('collectCoupon CheckedFromJsonException');
      return const Left(DataModelFailure('collectCoupon DataWrong'));
    } on ServerException {
      debugPrint('collectCoupon server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('collectCoupon  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('collectCoupon DIo');
      debugPrint('collectCoupon DIo ${e.response?.statusCode}');
      debugPrint('collectCoupon DIo ${e.response?.statusMessage}');
      debugPrint('collectCoupon DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, SearchCouponItemEntity>> scanQrcodeCoupon(
      String accessToken,
      CouponInformationForm scanQrcodeCoupon,
      String orgCode) async {
    try {
      final response = await _client.scanQrcodeCouponFromSevice(
          accessToken: 'Bearer $accessToken',
          scanQrcodeCoupon: scanQrcodeCoupon,
          orgCode: orgCode);
      debugPrint('scanQrcodeCoupon success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('scanQrcodeCoupon UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('scanQrcodeCoupon CheckedFromJsonException');
      return const Left(DataModelFailure('scanQrcodeCoupon DataWrong'));
    } on ServerException {
      debugPrint('scanQrcodeCoupon server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('scanQrcodeCoupon  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('scanQrcodeCoupon DIo');
      debugPrint('scanQrcodeCoupon DIo ${e.response?.statusCode}');
      debugPrint('scanQrcodeCoupon DIo ${e.response?.statusMessage}');
      debugPrint('scanQrcodeCoupon DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, SearchCouponItemForUsedEntity>>
      scanQrcodeCouponCheckinPage(String accessToken,
          CouponInformationForm scanQrcodeCoupon, String orgCode) async {
    try {
      final response = await _client.scanQrcodeCouponCheckinPageFromSevice(
          accessToken: 'Bearer $accessToken',
          scanQrcodeCoupon: scanQrcodeCoupon,
          orgCode: orgCode);
      debugPrint('scanQrcodeCouponForUsed success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('scanQrcodeCouponForUsed UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('scanQrcodeCouponForUsed CheckedFromJsonException');
      return const Left(DataModelFailure('scanQrcodeCouponForUsed DataWrong'));
    } on ServerException {
      debugPrint('scanQrcodeCouponForUsed server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('scanQrcodeCoupon  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('scanQrcodeCouponForUsed DIo');
      debugPrint('scanQrcodeCouponForUsed DIo ${e.response?.statusCode}');
      debugPrint('scanQrcodeCouponForUsed DIo ${e.response?.statusMessage}');
      debugPrint('scanQrcodeCouponForUsed DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, GetListReserveEntity>> listReserve(String accessToken,
      GetListReserveForm getListReserveForm, String orgCode) async {
    try {
      final response = await _client.listReserveFromSevice(
          accessToken: 'Bearer $accessToken',
          getListReserveForm: getListReserveForm,
          orgCode: orgCode);
      debugPrint('getListReserve success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('getListReserve UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('getListReserve CheckedFromJsonException');
      return const Left(DataModelFailure('getListReserve DataWrong'));
    } on ServerException {
      debugPrint('getListReserve server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('getListReserve  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('getListReserve DIo');
      debugPrint('getListReserve DIo ${e.response?.statusCode}');
      debugPrint('getListReserve DIo ${e.response?.statusMessage}');
      debugPrint('getListReserve DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, ReserveReceiptEntity>> createReserve(
      String accessToken,
      CreateReserveForm createReserveForm,
      String orgCode) async {
    try {
      final response = await _client.createReserveFromSevice(
          accessToken: 'Bearer $accessToken',
          createReserveForm: createReserveForm,
          orgCode: orgCode);
      debugPrint('createReserve success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('createReserve UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('createReserve CheckedFromJsonException');
      return const Left(DataModelFailure('createReserve DataWrong'));
    } on ServerException {
      debugPrint('createReserve server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('createReserve  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('createReserve DIo');
      debugPrint('createReserve DIo ${e.response?.statusCode}');
      debugPrint('createReserve DIo ${e.response?.statusMessage}');
      debugPrint('createReserve DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> changePassword(
      String accessToken, ChangePasswordForm changePasswordForm) async {
    try {
      final response = await _client.changePasswordFromSevice(
          // accessToken: 'Bearer $accessToken',
          changePasswordForm: changePasswordForm);
      debugPrint('changePassword success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('changePassword UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('changePassword CheckedFromJsonException');
      return const Left(DataModelFailure('changePassword DataWrong'));
    } on ServerException {
      debugPrint('changePassword server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('changePassword socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('changePassword DIo');
      debugPrint('changePassword DIo ${e.response?.statusCode}');
      debugPrint('changePassword DIo ${e.response?.statusMessage}');
      debugPrint('changePassword DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> deleteAccount(
      String accessToken, DeleteAccountForm deleteAccountForm) async {
    try {
      final response = await _client.deleteAccountFromSevice(
          accessToken: 'Bearer $accessToken',
          deleteAccountForm: deleteAccountForm);
      debugPrint('deleteAccount success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('deleteAccount UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('deleteAccount CheckedFromJsonException');
      return const Left(DataModelFailure('deleteAccount DataWrong'));
    } on ServerException {
      debugPrint('deleteAccount server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('deleteAccount socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('deleteAccount DIo');
      debugPrint('deleteAccount DIo ${e.response?.statusCode}');
      debugPrint('deleteAccount DIo ${e.response?.statusMessage}');
      debugPrint('deleteAccount DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, ListDataPermissionEntity>> permissionFleet(
      String accessToken) async {
    try {
      final response = await _client.permissionFleetFromSevice(
          accessToken: 'Bearer $accessToken');
      debugPrint('permissionFleet success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('permissionFleet UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('permissionFleet CheckedFromJsonException');
      return const Left(DataModelFailure('permissionFleet DataWrong'));
    } on ServerException {
      debugPrint('permissionFleet server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('permissionFleet socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('permissionFleet DIo');
      debugPrint('permissionFleet DIo ${e.response?.statusCode}');
      debugPrint('permissionFleet DIo ${e.response?.statusMessage}');
      debugPrint('permissionFleet DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, List<FleetCardItemEntity>>> listFleetCard(
      String accessToken, String orgCode) async {
    try {
      final response = await _client.listFleetCardFromSevice(
          accessToken: 'Bearer $accessToken', orgCode: orgCode);
      debugPrint('listFleetCard success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('listFleetCard UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('listFleetCard CheckedFromJsonException');
      return const Left(DataModelFailure('listFleetCard DataWrong'));
    } on ServerException {
      debugPrint('listFleetCard server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('listFleetCard socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('listFleetCard DIo');
      debugPrint('listFleetCard DIo ${e.response?.statusCode}');
      debugPrint('listFleetCard DIo ${e.response?.statusMessage}');
      debugPrint('listFleetCard DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, List<FleetOperationItemEntity>>> listFleetOperation(
      String accessToken, String orgCode) async {
    try {
      final response = await _client.listFleetOperationFromSevice(
          accessToken: 'Bearer $accessToken', orgCode: orgCode);
      debugPrint('listFleetOperation success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('listFleetOperation UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('listFleetOperation CheckedFromJsonException');
      return const Left(DataModelFailure('listFleetOperation DataWrong'));
    } on ServerException {
      debugPrint('listFleetOperation server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('listFleetOperation socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('listFleetOperation DIo');
      debugPrint('listFleetOperation DIo ${e.response?.statusCode}');
      debugPrint('listFleetOperation DIo ${e.response?.statusMessage}');
      debugPrint('listFleetOperation DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, FleetCardInfoEntity>> fleetCardInfo(String accessToken,
      FleetDetailCardForm fleetDetailCardForm, String orgCode) async {
    try {
      final response = await _client.fleetCardInfoFromSevice(
          accessToken: 'Bearer $accessToken',
          fleetDetailCardForm: fleetDetailCardForm,
          orgCode: orgCode);
      debugPrint('fleetCardInfo success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('fleetCardInfo UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('fleetCardInfo CheckedFromJsonException');
      return const Left(DataModelFailure('fleetCardInfo DataWrong'));
    } on ServerException {
      debugPrint('fleetCardInfo server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('fleetCardInfo socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('fleetCardInfo DIo');
      debugPrint('fleetCardInfo DIo ${e.response?.statusCode}');
      debugPrint('fleetCardInfo DIo ${e.response?.statusMessage}');
      debugPrint('fleetCardInfo DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, FleetOperationInfoEntity>> fleetOperationInfo(
      String accessToken, FleetNoForm fleetNoForm, String orgCode) async {
    try {
      final response = await _client.fleetOperationInfoFromSevice(
          accessToken: 'Bearer $accessToken',
          fleetNoForm: fleetNoForm,
          orgCode: orgCode);
      debugPrint('fleetOperationInfo success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('fleetOperationInfo UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('fleetOperationInfo CheckedFromJsonException');
      return const Left(DataModelFailure('fleetOperationInfo DataWrong'));
    } on ServerException {
      debugPrint('fleetOperationInfo server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('fleetOperationInfo socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('fleetOperationInfo DIo');
      debugPrint('fleetOperationInfo DIo ${e.response?.statusCode}');
      debugPrint('fleetOperationInfo DIo ${e.response?.statusMessage}');
      debugPrint('fleetOperationInfo DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, ListStationFleetCardEntity>> fleetCardStation(
      String accessToken, FleetNoForm fleetNoForm, String orgCode) async {
    try {
      final response = await _client.fleetCardStationFromSevice(
          accessToken: 'Bearer $accessToken',
          fleetNoForm: fleetNoForm,
          orgCode: orgCode);
      debugPrint('fleetCardStation success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('fleetCardStation UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('fleetCardStation CheckedFromJsonException');
      return const Left(DataModelFailure('fleetCardStation DataWrong'));
    } on ServerException {
      debugPrint('fleetCardStation server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('fleetCardStation socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('fleetCardStation DIo');
      debugPrint('fleetCardStation DIo ${e.response?.statusCode}');
      debugPrint('fleetCardStation DIo ${e.response?.statusMessage}');
      debugPrint('fleetCardStation DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, ListStationFleetOperationEntity>>
      fleetOperationStation(
          String accessToken, FleetNoForm fleetNoForm, String orgCode) async {
    try {
      final response = await _client.fleetOperationStationFromSevice(
          accessToken: 'Bearer $accessToken',
          fleetNoForm: fleetNoForm,
          orgCode: orgCode);
      debugPrint('fleetOperationStation success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('fleetOperationStation UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('fleetOperationStation CheckedFromJsonException');
      return const Left(DataModelFailure('fleetOperationStation DataWrong'));
    } on ServerException {
      debugPrint('fleetOperationStation server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('fleetOperationStation socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('fleetOperationStation DIo');
      debugPrint('fleetOperationStation DIo ${e.response?.statusCode}');
      debugPrint('fleetOperationStation DIo ${e.response?.statusMessage}');
      debugPrint('fleetOperationStation DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, ListChargerFleetCardEntity>> fleetCardCharger(
      String accessToken,
      FleetChargerForm fleetChargerForm,
      String orgCode) async {
    try {
      final response = await _client.fleetCardChargerFromSevice(
          accessToken: 'Bearer $accessToken',
          fleetChargerForm: fleetChargerForm,
          orgCode: orgCode);
      debugPrint('fleetCardCharger success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('fleetCardCharger UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('fleetCardCharger CheckedFromJsonException');
      return const Left(DataModelFailure('fleetCardCharger DataWrong'));
    } on ServerException {
      debugPrint('fleetCardCharger server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('fleetCardCharger socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('fleetCardCharger DIo');
      debugPrint('fleetCardCharger DIo ${e.response?.statusCode}');
      debugPrint('fleetCardCharger DIo ${e.response?.statusMessage}');
      debugPrint('fleetCardCharger DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, ListChargerFleetOperationEntity>>
      fleetOperationCharger(String accessToken,
          FleetChargerForm fleetChargerForm, String orgCode) async {
    try {
      final response = await _client.fleetOperationChargerFromSevice(
          accessToken: 'Bearer $accessToken',
          fleetChargerForm: fleetChargerForm,
          orgCode: orgCode);
      debugPrint('fleetOperationCharger success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('fleetOperationCharger UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('fleetOperationCharger CheckedFromJsonException');
      return const Left(DataModelFailure('fleetOperationCharger DataWrong'));
    } on ServerException {
      debugPrint('fleetOperationCharger server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('fleetOperationCharger socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('fleetOperationCharger DIo');
      debugPrint('fleetOperationCharger DIo ${e.response?.statusCode}');
      debugPrint('fleetOperationCharger DIo ${e.response?.statusMessage}');
      debugPrint('fleetOperationCharger DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, ChargerInformationEntity>> checkInFleetOperation(
      String accessToken, CheckInFleetForm checkInFleetForm) async {
    try {
      final response = await _client.checkInFleetOperationFromService(
          accessToken: 'Bearer $accessToken',
          checkInFleetForm: checkInFleetForm);
      debugPrint('checkInFleetOperation success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('checkInFleetOperation UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('checkInFleetOperation CheckedFromJsonException');
      return const Left(DataModelFailure('checkInFleetOperation DataWrong'));
    } on ServerException {
      debugPrint('checkInFleetOperation server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('checkInFleetOperation socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('checkInFleetOperation DIo');
      debugPrint('checkInFleetOperation DIo ${e.response?.statusCode}');
      debugPrint('checkInFleetOperation DIo ${e.response?.statusMessage}');
      debugPrint('checkInFleetOperation DIo ${e.response?.data}');
      Map<String, dynamic> data = e.response?.data;
      debugPrint('checkInFleetOperation DIoJson $data');
      return Left(ConnectionFailure(
          data["message"] ?? 'Failed to connect to the network ETC'));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> remoteStartFleetOperation(
      String accessToken, RemoteStartFleetForm remoteStartFleetForm) async {
    debugPrint('remoteStartFleetOperation  ${remoteStartFleetForm.toJson()} ');
    try {
      final response = await _client.remoteStartFleetOperationFromService(
          accessToken: 'Bearer $accessToken',
          remoteStartFleetForm: remoteStartFleetForm);
      debugPrint('remoteStartFleetOperation success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('remoteStartFleetOperation UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('remoteStartFleetOperation CheckedFromJsonException');
      return const Left(DataModelFailure('remoteStartFleetForm DataWrong'));
    } on ServerException {
      debugPrint('remoteStartFleetOperation server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('remoteStartFleetOperation socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('remoteStartFleetOperation DIo');
      debugPrint('remoteStartFleetOperation DIo ${e.response?.statusCode}');
      debugPrint('remoteStartFleetOperation DIo ${e.response?.statusMessage}');
      debugPrint('remoteStartFleetOperation DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, CheckStatusEntity>> checkStatusFleetOperation(
      String accessToken, CheckStatusFleetForm checkStatusFleetForm) async {
    try {
      final response = await _client.checkStatusFleetOperationFromService(
          accessToken: 'Bearer $accessToken',
          checkStatusFleetForm: checkStatusFleetForm);
      debugPrint('checkStatusFleetOperation success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('checkStatusFleetOperation UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException catch (e) {
      debugPrint('checkStatusFleetOperation CheckedFromJsonException');
      debugPrint(
          'checkStatusFleetOperation CheckedFromJsonException ${e.message}');
      return const Left(
          DataModelFailure('checkStatusFleetOperation DataWrong'));
    } on ServerException {
      debugPrint('checkStatusFleetOperation server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('checkStatusFleetOperation socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('checkStatusFleetOperation DIo');
      debugPrint('checkStatusFleetOperation DIo ${e.response?.statusCode}');
      debugPrint('checkStatusFleetOperation DIo ${e.response?.statusMessage}');
      debugPrint('checkStatusFleetOperation DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> remoteStopFleetOperation(
      String accessToken, RemoteStopFleetForm remoteStopFleetForm) async {
    try {
      final response = await _client.remoteStopFleetOperationFromService(
          accessToken: 'Bearer $accessToken',
          remoteStopFleetForm: remoteStopFleetForm);
      debugPrint('remoteStopFleetOperation success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('remoteStopFleetOperation UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('remoteStopFleetOperation CheckedFromJsonException');
      return const Left(DataModelFailure('remoteStopFleetOperation DataWrong'));
    } on ServerException {
      debugPrint('remoteStopFleetOperation server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('remoteStopFleetOperation socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('remoteStopFleetOperation DIo');
      debugPrint('remoteStopFleetOperation DIo ${e.response?.statusCode}');
      debugPrint('remoteStopFleetOperation DIo ${e.response?.statusMessage}');
      debugPrint('remoteStopFleetOperation DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> confirmTransactionFleetOperation(
      String accessToken,
      ConfirmTransactionFleetForm confirmTransactionFleetForm) async {
    try {
      final response =
          await _client.confirmTransactionFleetOperationFromService(
              accessToken: 'Bearer $accessToken',
              confirmTransactionFleetForm: confirmTransactionFleetForm);
      debugPrint('confirmTransactionFleetOperation success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('confirmTransactionFleetOperation UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('confirmTransactionFleetOperation CheckedFromJsonException');
      return const Left(
          DataModelFailure('confirmTransactionFleetOperation DataWrong'));
    } on ServerException {
      debugPrint('confirmTransactionFleetOperation server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('confirmTransactionFleetOperation socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('confirmTransactionFleetOperation DIo');
      debugPrint(
          'confirmTransactionFleetOperation DIo ${e.response?.statusCode}');
      debugPrint(
          'confirmTransactionFleetOperation DIo ${e.response?.statusMessage}');
      debugPrint('confirmTransactionFleetOperation DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, ChargerInformationEntity>> checkInFleetCard(
      String accessToken, CheckInFleetForm checkInFleetForm) async {
    try {
      final response = await _client.checkInFleetCardFromService(
          accessToken: 'Bearer $accessToken',
          checkInFleetForm: checkInFleetForm);
      debugPrint('checkInFleetCard success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('checkInFleetCard UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('checkInFleetCard CheckedFromJsonException');
      return const Left(DataModelFailure('checkInFleetCard DataWrong'));
    } on ServerException {
      debugPrint('checkInFleetCard server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('checkInFleetCard socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('checkInFleetCard DIo');
      debugPrint('checkInFleetCard DIo ${e.response?.statusCode}');
      debugPrint('checkInFleetCard DIo ${e.response?.statusMessage}');
      debugPrint('checkInFleetCard DIo ${e.response?.data}');
      Map<String, dynamic> data = e.response?.data;
      debugPrint('checkInFleetCard DIoJson $data');
      return Left(ConnectionFailure(
          data["message"] ?? 'Failed to connect to the network ETC'));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> remoteStartFleetCard(
      String accessToken, RemoteStartFleetForm remoteStartFleetForm) async {
    debugPrint('remoteStartFleetCard  ${remoteStartFleetForm.toJson()} ');
    try {
      final response = await _client.remoteStartFleetCardFromService(
          accessToken: 'Bearer $accessToken',
          remoteStartFleetForm: remoteStartFleetForm);
      debugPrint('remoteStartFleetCard success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('remoteStartFleetCard UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('remoteStartFleetCard CheckedFromJsonException');
      return const Left(DataModelFailure('remoteStartFleetForm DataWrong'));
    } on ServerException {
      debugPrint('remoteStartFleetCard server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('remoteStartFleetCard socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('remoteStartFleetCard DIo');
      debugPrint('remoteStartFleetCard DIo ${e.response?.statusCode}');
      debugPrint('remoteStartFleetCard DIo ${e.response?.statusMessage}');
      debugPrint('remoteStartFleetCard DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, CheckStatusEntity>> checkStatusFleetCard(
      String accessToken, CheckStatusFleetForm checkStatusFleetForm) async {
    try {
      final response = await _client.checkStatusFleetCardFromService(
          accessToken: 'Bearer $accessToken',
          checkStatusFleetForm: checkStatusFleetForm);
      debugPrint('checkStatusFleetCard success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('checkStatusFleetCard UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException catch (e) {
      debugPrint('checkStatusFleetCard CheckedFromJsonException');
      debugPrint('checkStatusFleetCard CheckedFromJsonException ${e.message}');
      return const Left(DataModelFailure('checkStatusFleetCard DataWrong'));
    } on ServerException {
      debugPrint('checkStatusFleetCard server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('checkStatusFleetCard socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('checkStatusFleetCard DIo');
      debugPrint('checkStatusFleetCard DIo ${e.response?.statusCode}');
      debugPrint('checkStatusFleetCard DIo ${e.response?.statusMessage}');
      debugPrint('checkStatusFleetCard DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> remoteStopFleetCard(
      String accessToken, RemoteStopFleetForm remoteStopFleetForm) async {
    try {
      final response = await _client.remoteStopFleetCardFromService(
          accessToken: 'Bearer $accessToken',
          remoteStopFleetForm: remoteStopFleetForm);
      debugPrint('remoteStopFleetCard success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('remoteStopFleetCard UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('remoteStopFleetCard CheckedFromJsonException');
      return const Left(DataModelFailure('remoteStopFleetCard DataWrong'));
    } on ServerException {
      debugPrint('remoteStopFleetCard server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('remoteStopFleetCard socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('remoteStopFleetCard DIo');
      debugPrint('remoteStopFleetCard DIo ${e.response?.statusCode}');
      debugPrint('remoteStopFleetCard DIo ${e.response?.statusMessage}');
      debugPrint('remoteStopFleetCard DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> confirmTransactionFleetCard(
      String accessToken,
      ConfirmTransactionFleetForm confirmTransactionFleetForm) async {
    try {
      final response = await _client.confirmTransactionFleetCardFromService(
          accessToken: 'Bearer $accessToken',
          confirmTransactionFleetForm: confirmTransactionFleetForm);
      debugPrint('confirmTransactionFleetCard success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('confirmTransactionFleetCard UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('confirmTransactionFleetCard CheckedFromJsonException');
      return const Left(
          DataModelFailure('confirmTransactionFleetCard DataWrong'));
    } on ServerException {
      debugPrint('confirmTransactionFleetCard server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('confirmTransactionFleetCard socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('confirmTransactionFleetCard DIo');
      debugPrint('confirmTransactionFleetCard DIo ${e.response?.statusCode}');
      debugPrint(
          'confirmTransactionFleetCard DIo ${e.response?.statusMessage}');
      debugPrint('confirmTransactionFleetCard DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, HasChargingFleetEntity>> checkHasChargingFleetCard(
      String accessToken) async {
    try {
      final response = await _client.checkHasChargingFleetCardFromService(
          accessToken: 'Bearer $accessToken');
      debugPrint('checkHasChargingFleetCard success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('checkHasChargingFleetCard UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('checkHasChargingFleetCard CheckedFromJsonException');
      return const Left(
          DataModelFailure('checkHasChargingFleetCard DataWrong'));
    } on ServerException {
      debugPrint('checkHasChargingFleetCard server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('checkHasChargingFleetCard socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('checkHasChargingFleetCard DIo');
      debugPrint('checkHasChargingFleetCard DIo ${e.response?.statusCode}');
      debugPrint('checkHasChargingFleetCard DIo ${e.response?.statusMessage}');
      debugPrint('checkHasChargingFleetCard DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, HasChargingFleetEntity>>
      checkHasChargingFleetOperation(String accessToken) async {
    try {
      final response = await _client.checkHasChargingFleetOperationFromService(
          accessToken: 'Bearer $accessToken');
      debugPrint('checkHasChargingFleetOperation success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('checkHasChargingFleetOperation UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('checkHasChargingFleetOperation CheckedFromJsonException');
      return const Left(
          DataModelFailure('checkHasChargingFleetOperation DataWrong'));
    } on ServerException {
      debugPrint('checkHasChargingFleetOperation server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('checkHasChargingFleetOperation socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('checkHasChargingFleetOperation DIo');
      debugPrint(
          'checkHasChargingFleetOperation DIo ${e.response?.statusCode}');
      debugPrint(
          'checkHasChargingFleetOperation DIo ${e.response?.statusMessage}');
      debugPrint('checkHasChargingFleetOperation DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, ListNotificationEntity>> listNotification(
      String accessToken) async {
    try {
      final response = await _client.listNotificationFromService(
          accessToken: 'Bearer $accessToken');
      debugPrint('getListNotification success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('getListNotification UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('getListNotification CheckedFromJsonException');
      return const Left(DataModelFailure('getListNotification DataWrong'));
    } on ServerException {
      debugPrint('getListNotification server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('getListNotification socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('getListNotification DIo');
      debugPrint('getListNotification DIo ${e.response?.statusCode}');
      debugPrint('getListNotification DIo ${e.response?.statusMessage}');
      debugPrint('getListNotification DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, NotificationNewsEntity>> listNotificationNews(
      String accessToken, ObjectEmptyForm objectEmpty) async {
    try {
      final response = await _client.listNotificationNewsFromService(
          accessToken: 'Bearer $accessToken', objectEmpty: objectEmpty);
      debugPrint('listNotificationNews success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('listNotificationNews UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('listNotificationNews CheckedFromJsonException');
      return const Left(DataModelFailure('listNotificationNews DataWrong'));
    } on ServerException {
      debugPrint('listNotificationNews server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('listNotificationNews socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('listNotificationNews DIo');
      debugPrint('listNotificationNews DIo ${e.response?.statusCode}');
      debugPrint('listNotificationNews DIo ${e.response?.statusMessage}');
      debugPrint('listNotificationNews DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> deleteNotification(
      String accessToken, DeleteNotificationForm deleteNotification) async {
    try {
      final response = await _client.deleteNotificationFromService(
          accessToken: 'Bearer $accessToken',
          deleteNotification: deleteNotification);
      debugPrint('deleteNotification success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('deleteNotification UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('deleteNotification CheckedFromJsonException');
      return const Left(DataModelFailure('deleteNotification DataWrong'));
    } on ServerException {
      debugPrint('deleteNotification server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('deleteNotification  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('deleteNotification DIo');
      debugPrint('deleteNotification DIo ${e.response?.statusCode}');
      debugPrint('deleteNotification DIo ${e.response?.statusMessage}');
      debugPrint('deleteNotification DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> activeNotification(
      String accessToken, ActiveNotificationForm activeNotification) async {
    try {
      final response = await _client.activeNotificationFromService(
          accessToken: 'Bearer $accessToken',
          activeNotification: activeNotification);
      debugPrint('activeNotification success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('activeNotification UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('activeNotification CheckedFromJsonException');
      return const Left(DataModelFailure('activeNotification DataWrong'));
    } on ServerException {
      debugPrint('activeNotification server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('activeNotification  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('activeNotification DIo');
      debugPrint('activeNotification DIo ${e.response?.statusCode}');
      debugPrint('activeNotification DIo ${e.response?.statusMessage}');
      debugPrint('activeNotification DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> setNotificationSetting(
      String accessToken,
      SetNotificationSettingForm setNotificationSetting) async {
    try {
      final response = await _client.setNotificationSettingFromService(
          accessToken: 'Bearer $accessToken',
          setNotificationSetting: setNotificationSetting);
      debugPrint('setNotificationSetting success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('setNotificationSetting UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('setNotificationSetting CheckedFromJsonException');
      return const Left(DataModelFailure('setNotificationSetting DataWrong'));
    } on ServerException {
      debugPrint('setNotificationSetting server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('setNotificationSetting  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('setNotificationSetting DIo');
      debugPrint('setNotificationSetting DIo ${e.response?.statusCode}');
      debugPrint('setNotificationSetting DIo ${e.response?.statusMessage}');
      debugPrint('setNotificationSetting DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, NotificationSettingEntity>> getNotificationSetting(
      String accessToken, ObjectEmptyForm objectEmpty) async {
    try {
      final response = await _client.getNotificationSettingFromService(
          accessToken: 'Bearer $accessToken', objectEmpty: objectEmpty);
      debugPrint('getNotificationSetting success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('getNotificationSetting UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('getNotificationSetting CheckedFromJsonException');
      return const Left(DataModelFailure('getNotificationSetting DataWrong'));
    } on ServerException {
      debugPrint('getNotificationSetting server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('getNotificationSetting  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('getNotificationSetting DIo');
      debugPrint('getNotificationSetting DIo ${e.response?.statusCode}');
      debugPrint('getNotificationSetting DIo ${e.response?.statusMessage}');
      debugPrint('getNotificationSetting DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, CountAllNotificationEntity>> getCountAllNotification(
      String accessToken, ObjectEmptyForm objectEmpty) async {
    try {
      final response = await _client.getCountAllNotificationFromService(
          accessToken: 'Bearer $accessToken', objectEmpty: objectEmpty);
      debugPrint('getCountAllNotification success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('getCountAllNotification UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('getCountAllNotification CheckedFromJsonException');
      return const Left(DataModelFailure('getCountAllNotification DataWrong'));
    } on ServerException {
      debugPrint('getCountAllNotification server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('getCountAllNotification  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('getCountAllNotification DIo');
      debugPrint('getCountAllNotification DIo ${e.response?.statusCode}');
      debugPrint('getCountAllNotification DIo ${e.response?.statusMessage}');
      debugPrint('getCountAllNotification DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, List<HistoryFleetDataEntity>>> getHistoryFleetCardList(
      String accessToken,
      String orgCode,
      HistoryFleetCardForm historyFleetCardForm) async {
    try {
      final response = await _client.getHistoryFleetCardListFromService(
          accessToken: 'Bearer $accessToken',
          orgCode: orgCode,
          historyFleetCardForm: historyFleetCardForm);
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('getHistoryFleetCardList UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('getHistoryFleetCardList CheckedFromJsonException');
      return const Left(DataModelFailure('getHistoryFleetCardList DataWrong'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('getHistoryFleetCardList DIo');
      debugPrint('getHistoryFleetCardList DIo ${e.response?.statusCode}');
      debugPrint('getHistoryFleetCardList DIo ${e.response?.statusMessage}');
      debugPrint('getHistoryFleetCardList DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, List<HistoryFleetDataEntity>>>
      getHistoryFleetOperationList(
          String accessToken, int fleetNo, String orgCode) async {
    try {
      final response = await _client.getHistoryFleetOperationListFromService(
          accessToken: 'Bearer $accessToken',
          fleetNo: fleetNo,
          orgCode: orgCode);
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('getHistoryFleetOperationList UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('getHistoryFleetOperationList CheckedFromJsonException');
      return const Left(
          DataModelFailure('getHistoryFleetOperationList DataWrong'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('getHistoryFleetOperationList DIo');
      debugPrint('getHistoryFleetOperationList DIo ${e.response?.statusCode}');
      debugPrint(
          'getHistoryFleetOperationList DIo ${e.response?.statusMessage}');
      debugPrint('getHistoryFleetOperationList DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, List<RecommendedStationEntity>>> recommendedStation(
      String accessToken, RecommendedStationForm recommendedStationForm) async {
    try {
      final response = await _client.recommendedStationFromService(
          accessToken: 'Bearer $accessToken',
          recommendedStationForm: recommendedStationForm);
      debugPrint('recommendedStation  success ');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('recommendedStation UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('recommendedStation CheckedFromJsonException');
      return const Left(DataModelFailure('recommendedStation DataWrong'));
    } on ServerException {
      debugPrint('recommendedStation server ');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('recommendedStation  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('recommendedStation DIo ');
      debugPrint('recommendedStation DIo ${e.response?.statusCode}');
      debugPrint('recommendedStation DIo ${e.response?.statusMessage}');
      debugPrint('recommendedStation DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> verifyFleetCard(String accessToken,
      VerifyFleetCardForm verifyFleetCardForm, String orgCode) async {
    try {
      final response = await _client.verifyFleetCardFromService(
          accessToken: 'Bearer $accessToken',
          verifyFleetCardForm: verifyFleetCardForm,
          orgCode: orgCode);
      debugPrint('verifyFleetCard success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('verifyFleetCard UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('verifyFleetCard CheckedFromJsonException');
      return const Left(DataModelFailure('verifyFleetCard DataWrong'));
    } on ServerException {
      debugPrint('verifyFleetCard server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('verifyFleetCard  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('verifyFleetCard DIo');
      debugPrint('verifyFleetCard DIo ${e.response?.statusCode}');
      debugPrint('verifyFleetCard DIo ${e.response?.statusMessage}');
      debugPrint('verifyFleetCard DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> verifyEmail(
      VerifyEmailForm verifyEmailForm) async {
    try {
      final response = await _client.verifyEmailFromService(
          verifyEmailForm: verifyEmailForm);
      debugPrint('verifyEmail success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('verifyEmail UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('verifyEmail CheckedFromJsonException');
      return const Left(DataModelFailure('verifyAccount DataWrong'));
    } on ServerException {
      debugPrint('verifyEmail server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('verifyEmail  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('verifyEmail DIo');
      debugPrint('verifyEmail DIo ${e.response?.statusCode}');
      debugPrint('verifyEmail DIo ${e.response?.statusMessage}');
      debugPrint('verifyEmail DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> setLanguage(
      String accessToken, SetLanguageForm setLanguageFrom) async {
    try {
      final response = await _client.setLanguageFromService(
          accessToken: 'Bearer $accessToken', setLanguageFrom: setLanguageFrom);
      debugPrint('setLanguage success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('setLanguage UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('setLanguage CheckedFromJsonException');
      return const Left(DataModelFailure('verifyAccount DataWrong'));
    } on ServerException {
      debugPrint('setLanguage server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('setLanguage  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('setLanguage DIo');
      debugPrint('setLanguage DIo ${e.response?.statusCode}');
      debugPrint('setLanguage DIo ${e.response?.statusMessage}');
      debugPrint('setLanguage DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, VerifyImageOcrEntity>> verifyImageOcr(
      String accessToken, File file, String licensePlate) async {
    try {
      final response = await _client.verifyImageOcrFromService(
          accessToken: 'Bearer $accessToken',
          file: file,
          license_plate: licensePlate);
      debugPrint('verifyImageOcr success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('verifyImageOcr UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('verifyImageOcr CheckedFromJsonException');
      return const Left(DataModelFailure('verifyImageOcr DataWrong'));
    } on ServerException {
      debugPrint('verifyImageOcr server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('verifyImageOcr socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('verifyImageOcr DIo');
      debugPrint('verifyImageOcr DIo ${e.response?.statusCode}');
      debugPrint('verifyImageOcr DIo ${e.response?.statusMessage}');
      debugPrint('verifyImageOcr DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, RoutePlanningEntity>> getRoutePlanning(
      String accessToken, RoutePlanningForm routePlanningForm) async {
    try {
      final response = await _client.getRoutePlanningFromService(
          accessToken: 'Bearer $accessToken',
          routePlanningForm: routePlanningForm);
      debugPrint('getRoutePlanning success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('getRoutePlanning UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('getRoutePlanning CheckedFromJsonException');
      return const Left(DataModelFailure('getRoutePlanning DataWrong'));
    } on ServerException {
      debugPrint('getRoutePlanning server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('getRoutePlanning  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('getRoutePlanning DIo');
      debugPrint('getRoutePlanning DIo ${e.response?.statusCode}');
      debugPrint('getRoutePlanning DIo ${e.response?.statusMessage}');
      debugPrint('getRoutePlanning DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteRouteItemEntity>>> favoriteRoute(
      String accessToken, UsernameAndOrgCodeForm usernameAndOrgCodeForm) async {
    try {
      final response = await _client.favoriteRouteFromService(
          accessToken: 'Bearer $accessToken',
          usernameAndOrgCodeForm: usernameAndOrgCodeForm);
      debugPrint('favoriteRoute success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('favoriteRoute UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('favoriteRoute CheckedFromJsonException');
      return const Left(DataModelFailure('favoriteRoute DataWrong'));
    } on ServerException {
      debugPrint('favoriteRoute server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('favoriteRoute  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('favoriteRoute DIo');
      debugPrint('favoriteRoute DIo ${e.response?.statusCode}');
      debugPrint('favoriteRoute DIo ${e.response?.statusMessage}');
      debugPrint('favoriteRoute DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> addFavoriteRoute(
      String accessToken, AddFavoriteRouteForm addFavoriteRouteForm) async {
    try {
      final response = await _client.addFavoriteRouteFromService(
          accessToken: 'Bearer $accessToken',
          addFavoriteRouteForm: addFavoriteRouteForm);
      debugPrint('addFavoriteRoute success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('addFavoriteRoute UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('addFavoriteRoute CheckedFromJsonException');
      return const Left(DataModelFailure('addFavoriteRoute DataWrong'));
    } on ServerException {
      debugPrint('addFavoriteRoute server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('addFavoriteRoute  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('addFavoriteRoute DIo');
      debugPrint('addFavoriteRoute DIo ${e.response?.statusCode}');
      debugPrint('addFavoriteRoute DIo ${e.response?.statusMessage}');
      debugPrint('addFavoriteRoute DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> updateFavoriteRoute(String accessToken,
      UpdateFavoriteRouteForm updateFavoriteRouteForm) async {
    try {
      final response = await _client.updateFavoriteRouteFromService(
          accessToken: 'Bearer $accessToken',
          updateFavoriteRouteForm: updateFavoriteRouteForm);
      debugPrint('updateFavoriteRoute success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('updateFavoriteRoute UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('updateFavoriteRoute CheckedFromJsonException');
      return const Left(DataModelFailure('updateFavoriteRoute DataWrong'));
    } on ServerException {
      debugPrint('updateFavoriteRoute server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('updateFavoriteRoute  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('updateFavoriteRoute DIo');
      debugPrint('updateFavoriteRoute DIo ${e.response?.statusCode}');
      debugPrint('updateFavoriteRoute DIo ${e.response?.statusMessage}');
      debugPrint('updateFavoriteRoute DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> deleteFavoriteRoute(String accessToken,
      DeleteFavoriteRouteForm deleteFavoriteRouteForm) async {
    try {
      final response = await _client.deleteFavoriteRouteFromService(
          accessToken: 'Bearer $accessToken',
          deleteFavoriteRouteForm: deleteFavoriteRouteForm);
      debugPrint('updateFavoriteRoute success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('updateFavoriteRoute UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('updateFavoriteRoute CheckedFromJsonException');
      return const Left(DataModelFailure('deleteFavoriteRoute DataWrong'));
    } on ServerException {
      debugPrint('updateFavoriteRoute server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('updateFavoriteRoute  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('updateFavoriteRoute DIo');
      debugPrint('updateFavoriteRoute DIo ${e.response?.statusCode}');
      debugPrint('updateFavoriteRoute DIo ${e.response?.statusMessage}');
      debugPrint('updateFavoriteRoute DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, ListCarSelectFleetModel>>
      listVehicleChargingFleetOperation(
          String accessToken, String orgCode, FleetNoForm fleetNoForm) async {
    try {
      final response =
          await _client.listVehicleChargingFleetOperationFromService(
              accessToken: 'Bearer $accessToken',
              orgCode: orgCode,
              fleetNoForm: fleetNoForm);
      debugPrint('ListCarSelectFleet success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('ListCarSelectFleet UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('ListCarSelectFleet CheckedFromJsonException');
      return const Left(DataModelFailure('listFleetCard DataWrong'));
    } on ServerException {
      debugPrint('ListCarSelectFleet server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('ListCarSelectFleet socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('ListCarSelectFleet DIo');
      debugPrint('ListCarSelectFleet DIo ${e.response?.statusCode}');
      debugPrint('ListCarSelectFleet DIo ${e.response?.statusMessage}');
      debugPrint('ListCarSelectFleet DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  @override
  Future<Either<Failure, DefaultEntity>> addVehicleChargingFleetOperation(
      String accessToken,
      String orgCode,
      AddCarChargingForm addCarChargingForm) async {
    try {
      final response =
          await _client.addVehicleChargingFleetOperationFromService(
              accessToken: 'Bearer $accessToken',
              orgCode: orgCode,
              addCarChargingForm: addCarChargingForm);
      debugPrint('addVehicleChargingFleetOperation success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('addVehicleChargingFleetOperation UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('addVehicleChargingFleetOperation CheckedFromJsonException');
      return const Left(DataModelFailure('verifyAccount DataWrong'));
    } on ServerException {
      debugPrint('addVehicleChargingFleetOperation server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('addVehicleChargingFleetOperation  socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('addVehicleChargingFleetOperation DIo');
      debugPrint(
          'addVehicleChargingFleetOperation DIo ${e.response?.statusCode}');
      debugPrint(
          'addVehicleChargingFleetOperation DIo ${e.response?.statusMessage}');
      debugPrint('addVehicleChargingFleetOperation DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  Future<Either<Failure, DefaultEntity>> addLog(
      LogCrashForm logCrashForm) async {
    try {
      final response =
          await _client.addLogFromService(logCrashForm: logCrashForm);
      debugPrint('addLog success');
      return Right(response.data);
    } on UnAuthorizedException {
      debugPrint('addLog UnAuthorized');
      return const Left(UnAuthorizeFailure('UnAuthorized'));
    } on CheckedFromJsonException {
      debugPrint('addLog CheckedFromJsonException');
      return const Left(DataModelFailure('verifyAccount DataWrong'));
    } on ServerException {
      debugPrint('addLog server');
      return const Left(ServerFailure(''));
    } on SocketException {
      debugPrint('addLog socket');
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      debugPrint('addLog DIo');
      debugPrint('addLog DIo ${e.response?.statusCode}');
      debugPrint('addLog DIo ${e.response?.statusMessage}');
      debugPrint('addLog DIo ${e.response?.data}');
      return Left(responseFailureConnectionFailureWithMessage(e));
    }
  }

  ConnectionFailure responseFailureConnectionFailureWithMessage(
      DioException e) {
    if (e.response?.data != null) {
      if (e.response?.data?.runtimeType == String) {
        return ConnectionFailure(translate('alert.description.server_error'));
      } else {
        int? code = e.response?.statusCode;
        String message = '${e.response?.data['message']}';
        if (code == 500) {
          return ConnectionFailure(translate('alert.description.server_error'));
        } else {
          return ConnectionFailure(message);
        }
      }
    } else {
      return ConnectionFailure(translate('alert.description.server_error'));
    }
  }
}

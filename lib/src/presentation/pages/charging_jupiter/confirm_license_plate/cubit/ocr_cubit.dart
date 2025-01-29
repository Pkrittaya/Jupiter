import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/domain/entities/verify_image_ocr_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

part 'ocr_state.dart';

class OcrCubit extends Cubit<OcrState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  OcrCubit(this._useCase) : super(OcrInitial());

  void sendImageVerify(File file, String license_plate) {
    emit(OcrLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result =
          await _useCase.verifyImageOcr(accessToken, file, license_plate);

      result.fold(
        (failure) {
          emit(OcrFailure(failure.message));
        },
        (data) {
          emit(OcrSuccess(data));
        },
      );
    }, 'SendImageVerifyOcr');
  }

  void resetCubit() async {
    emit(OcrInitial());
  }
}

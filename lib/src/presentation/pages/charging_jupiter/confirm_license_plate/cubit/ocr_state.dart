part of 'ocr_cubit.dart';

sealed class OcrState extends Equatable {
  const OcrState({
    this.message,
    this.verifyImageOcrEntity,
  });

  final String? message;
  final VerifyImageOcrEntity? verifyImageOcrEntity;

  @override
  List<Object> get props => [];
}

class OcrInitial extends OcrState {}

class OcrLoading extends OcrState {}

class OcrFailure extends OcrState {
  const OcrFailure(String message) : super(message: message);
}

class OcrSuccess extends OcrState {
  const OcrSuccess(
      VerifyImageOcrEntity verifyImageOcrEntity)
      : super(verifyImageOcrEntity: verifyImageOcrEntity);
}

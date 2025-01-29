part of 'policy_cubit.dart';

abstract class PolicyState extends Equatable {
  const PolicyState({this.message, this.policyEntity});

  final String? message;
  final TermAndConditionEntity? policyEntity;
  @override
  List<Object> get props => [];
}

class PolicyInitial extends PolicyState {}

class PolicyLoading extends PolicyState {}

class PolicySuccess extends PolicyState {
  const PolicySuccess(TermAndConditionEntity? termAndConditionEntity)
      : super(policyEntity: termAndConditionEntity);
}

class PolicyFailure extends PolicyState {
  const PolicyFailure(String? message) : super(message: message);
}

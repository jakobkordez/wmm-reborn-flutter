part of 'create_loan_cubit.dart';

@immutable
abstract class CreateLoanState extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateLoanInitial extends CreateLoanState {
  final List<LoanModel> loans;

  CreateLoanInitial({this.loans = const <LoanModel>[]});

  @override
  List<Object> get props => [loans];
}

class CreateLoanInProgress extends CreateLoanState {}

class CreateLoanSuccess extends CreateLoanState {}

class CreateLoanFailure extends CreateLoanState {
  final String error;

  CreateLoanFailure(this.error);

  @override
  List<Object> get props => [error];
}

part of 'create_loan_cubit.dart';

@immutable
abstract class CreateLoanState extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateLoanInitial extends CreateLoanState {}

class CreateLoanChanged extends CreateLoanState {
  final List<LoanModel> loans;

  CreateLoanChanged(this.loans);

  @override
  List<Object> get props => [loans];
}

class CreateLoanInProgress extends CreateLoanState {}

class CreateLoanSuccess extends CreateLoanState {}

class CreateLoanFailure extends CreateLoanState {
  final String error;
  final List<LoanModel> failedLoans;

  CreateLoanFailure(this.error, this.failedLoans);

  @override
  List<Object> get props => [error, failedLoans];
}

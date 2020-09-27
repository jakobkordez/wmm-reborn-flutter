part of 'loan_page_cubit.dart';

abstract class LoanPageState extends Equatable {
  const LoanPageState();

  @override
  List<Object> get props => [];
}

class LoanPageInitial extends LoanPageState {}

class LoanPageLoading extends LoanPageState {}

class LoanPageLoaded extends LoanPageState {
  final LoanModel loan;
  final UserModel other;

  const LoanPageLoaded(this.loan, this.other);

  @override
  List<Object> get props => [loan];
}

class LoanPageFailure extends LoanPageState {
  final String error;

  LoanPageFailure(this.error);

  @override
  List<Object> get props => [error];
}

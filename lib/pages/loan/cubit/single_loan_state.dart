part of 'single_loan_cubit.dart';

abstract class SingleLoanState extends Equatable {
  const SingleLoanState();

  @override
  List<Object> get props => [];
}

class SingleLoanInitial extends SingleLoanState {}

class SingleLoanLoading extends SingleLoanState {}

class SingleLoanLoaded extends SingleLoanState {
  final LoanModel loan;

  const SingleLoanLoaded(this.loan);

  @override
  List<Object> get props => [loan];
}

class SingleLoanFailure extends SingleLoanState {
  final String error;

  SingleLoanFailure(this.error);

  @override
  List<Object> get props => [error];
}

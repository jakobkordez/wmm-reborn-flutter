part of 'loan_cubit.dart';

@immutable
abstract class LoanState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoanInitial extends LoanState {}

class LoanLoaded extends LoanState {
  LoanLoaded(this.loans, this.hasMore);

  final List<LoanModel> loans;
  final bool hasMore;

  @override
  List<Object> get props => [loans, hasMore];
}

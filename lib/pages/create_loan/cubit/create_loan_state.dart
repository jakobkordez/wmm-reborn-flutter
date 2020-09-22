part of 'create_loan_cubit.dart';

class CreateLoanState extends Equatable {
  final String title;
  final User user;
  final Amount amount;
  final FormzStatus status;

  const CreateLoanState({
    this.title = '',
    this.user = const User.pure(),
    this.amount = const Amount.pure(),
    this.status = FormzStatus.pure,
  });

  CreateLoanState copyWith({
    String title,
    User user,
    Amount amount,
    FormzStatus status,
  }) {
    return CreateLoanState(
      title: title ?? this.title,
      user: user ?? this.user,
      amount: amount ?? this.amount,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [title, user, amount, status];
}

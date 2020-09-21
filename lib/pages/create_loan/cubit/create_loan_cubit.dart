import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import 'package:wmm_flutter/models/new_loan.dart';
import 'package:wmm_flutter/models/user.dart';
import 'package:wmm_flutter/pages/create_loan/models/models.dart';
import 'package:wmm_flutter/repositories/loan_repository.dart';

part 'create_loan_state.dart';

class CreateLoanCubit extends Cubit<CreateLoanState> {
  CreateLoanCubit({
    @required this.loanRepository,
  }) : super(const CreateLoanState());

  final LoanRepository loanRepository;

  Future<void> submit() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      final newLoan = NewLoan(
        title: state.title,
        user: state.user.value.username,
        amount: double.parse(state.amount.value),
      );

      await loanRepository.create(newLoan);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> setTitle(String title) async {
    emit(state.copyWith(
      title: title,
      status: Formz.validate([state.amount, state.user]),
    ));
  }

  Future<void> setUser(UserModel user) async {
    final userf = User.dirty(user);
    emit(state.copyWith(
      user: userf,
      status: Formz.validate([userf, state.amount]),
    ));
  }

  Future<void> setAmount(String amount) async {
    final amountf = Amount.dirty(amount);
    emit(state.copyWith(
      amount: amountf,
      status: Formz.validate([amountf, state.user]),
    ));
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:wmm_flutter/models/loan.dart';
import 'package:wmm_flutter/models/user.dart';
import 'package:wmm_flutter/repositories/loan_repository.dart';
import 'package:wmm_flutter/repositories/user_repository.dart';

part 'loan_page_state.dart';

class LoanPageCubit extends Cubit<LoanPageState> {
  LoanPageCubit({
    @required this.loanRepository,
    @required this.userRepository,
    @required this.loanId,
  }) : super(LoanPageInitial()) {
    loadLoan();
  }

  final LoanRepository loanRepository;
  final UserRepository userRepository;
  final int loanId;

  Future<void> loadLoan() async {
    emit(LoanPageLoading());

    try {
      final loan = await loanRepository.getId(loanId);

      final self = await userRepository.getUser();
      UserModel other;
      if (self.username == loan.sender)
        other = await userRepository.getUser(username: loan.reciever);
      else
        other = await userRepository.getUser(username: loan.sender);

      emit(LoanPageLoaded(loan, other));
    } catch (e) {
      emit(LoanPageFailure(e.toString()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:wmm_flutter/models/loan.dart';
import 'package:wmm_flutter/repositories/loan_repository.dart';

part 'single_loan_state.dart';

class SingleLoanCubit extends Cubit<SingleLoanState> {
  SingleLoanCubit({
    @required this.loanRepository,
    @required this.loanId,
  }) : super(SingleLoanInitial()) {
    loadLoan();
  }

  final LoanRepository loanRepository;
  final int loanId;

  Future<void> loadLoan() async {
    emit(SingleLoanLoading());

    try {
      final loan = await loanRepository.getId(loanId);

      emit(SingleLoanLoaded(loan));
    } catch (e) {
      emit(SingleLoanFailure(e.toString()));
    }
  }
}

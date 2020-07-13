import 'package:cubit/cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:wmm_reborn_flutter/models/loan.dart';
import 'package:wmm_reborn_flutter/repositories/loan_repository.dart';

part 'create_loan_state.dart';

class CreateLoanCubit extends Cubit<CreateLoanState> {
  CreateLoanCubit({
    @required this.loanRepository,
  }) : super(CreateLoanInitial());

  final LoanRepository loanRepository;

  void createLoans() {
    if (state is CreateLoanInitial) {
      final loans = List<LoanModel>.from((state as CreateLoanInitial).loans);

      emit(CreateLoanInProgress());

      List<LoanModel> failed = List<LoanModel>();
      for (int i = 0; i < loans.length; ++i) {
        if (loans[i].amount == 0) continue;
        try {
          loanRepository.create(loans[i]);
        } on ArgumentError {
          failed.add(loans[i]);
        } on Error {
          failed.addAll(loans.sublist(i));
          break;
        }
      }

      if (failed.isEmpty)
        emit(CreateLoanSuccess());
      else {
        emit(CreateLoanFailure('Something went wrong! Try again later'));
        emit(CreateLoanInitial(loans: failed));
      }
    }
  }

  void addLoan() {
    if (state is CreateLoanInitial) {
      final loans = List<LoanModel>.from((state as CreateLoanInitial).loans)
        ..add(LoanModel());
      emit(CreateLoanInitial(loans: loans));
    }
  }

  void removeLoan(int index) {
    if (state is CreateLoanInitial) {
      final loans = List<LoanModel>.from((state as CreateLoanInitial).loans)
        ..removeAt(index);
      emit(CreateLoanInitial(loans: loans));
    }
  }
}

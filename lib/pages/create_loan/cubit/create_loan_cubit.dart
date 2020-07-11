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
  List<LoanModel> loans = <LoanModel>[];

  void createLoans() {
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
        emit(CreateLoanFailure('Something went wrong!', failed));
        return;
      }
    }
    
    if (failed.isEmpty) emit(CreateLoanSuccess());
    else emit(CreateLoanFailure('Not all loans could be created.', failed));
  }

  void addLoan() {
    loans.add(LoanModel());
    emit(CreateLoanChanged(loans));
  }

  void removeLoan(int index) {
    loans.removeAt(index);
    emit(CreateLoanChanged(loans));
  }
}

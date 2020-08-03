import 'package:cubit/cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'package:wmm_flutter/cubit/auth_cubit.dart';
import 'package:wmm_flutter/models/loan.dart';
import 'package:wmm_flutter/repositories/loan_repository.dart';

part 'loan_state.dart';

class LoanCubit extends Cubit<LoanState> {
  static const int pageSize = 20;

  LoanCubit({
    @required this.authCubit,
    @required this.loanRepository,
  }) : super(LoanInitial()) {
    loadInitial();
  }

  final AuthCubit authCubit;
  final LoanRepository loanRepository;

  bool _loadingLock = false;

  Future<void> loadInitial() async {
    if (_loadingLock) return;
    _loadingLock = true;

    List<LoanModel> loans;
    try {
      loans = await loanRepository.getAll(count: pageSize);

      emit(LoanLoaded(loans, loans.length == pageSize));
    } on Error {
      emit(LoanLoadingFailure('Something went wrong! Try again later.'));
    }

    _loadingLock = false;
  }

  void loadMore() async {
    if (_loadingLock) return;
    _loadingLock = true;

    final currState = state;
    int lastIndex = 0;
    if (currState is LoanLoaded) {
      lastIndex = currState.loans.last.id;
      emit(LoanLoaded(currState.loans.toList(), false));
    }

    _loadingLock = false;
  }
}

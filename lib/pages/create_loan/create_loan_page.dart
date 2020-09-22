import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_loan_form.dart';
import 'cubit/create_loan_cubit.dart';
import 'package:wmm_flutter/repositories/loan_repository.dart';

class CreateLoanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateLoanCubit>(
      create: (context) => CreateLoanCubit(
        loanRepository: context.repository<LoanRepository>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("New loan"),
        ),
        body: CreateLoanForm(),
      ),
    );
  }
}

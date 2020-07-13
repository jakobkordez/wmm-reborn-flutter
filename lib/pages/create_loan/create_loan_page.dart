import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:provider/provider.dart';

import 'package:wmm_reborn_flutter/pages/create_loan/cubit/create_loan_cubit.dart';
import 'package:wmm_reborn_flutter/pages/create_loan/total_amount.dart';
import 'package:wmm_reborn_flutter/repositories/loan_repository.dart';

class CreateLoanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateLoanPageState();
}

class _CreateLoanPageState extends State<CreateLoanPage> {
  @override
  Widget build(BuildContext context) {
    return CubitProvider<CreateLoanCubit>(
      create: (context) => CreateLoanCubit(
        loanRepository: context.read<LoanRepository>(),
      ),
      child: _CreateLoanForm(),
    );
  }
}

class _CreateLoanForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New loan"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.cubit<CreateLoanCubit>().createLoans(),
        child: Icon(Icons.check),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: CubitBuilder<CreateLoanCubit, CreateLoanState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: <Widget>[
                  if (state is CreateLoanInitial && state.loans.length > 1)
                    SliverToBoxAdapter(
                      child: TotalAmount(
                        total: 0,
                        lent: 0,
                        borrowed: 0,
                      ),
                    ),
                  SliverToBoxAdapter(
                    child: FlatButton(
                      onPressed: () =>
                          context.cubit<CreateLoanCubit>().addLoan(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.person_add),
                          VerticalDivider(),
                          const Text('Add person')
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

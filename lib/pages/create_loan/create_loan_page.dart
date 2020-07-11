import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:wmm_reborn_flutter/pages/create_loan/cubit/create_loan_cubit.dart';
import 'package:wmm_reborn_flutter/pages/create_loan/total_amount.dart';

class CreateLoanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateLoanPageState();
}

class _CreateLoanPageState extends State<CreateLoanPage> {
  @override
  Widget build(BuildContext context) {
    return CubitProvider<CreateLoanCubit>(
      create: (context) => CreateLoanCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text("New loan")),
        body: Form(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: TotalAmount(
                    total: 0,
                    lent: 0,
                    borrowed: 0,
                  ),
                ),
                SliverToBoxAdapter(
                  child: FlatButton(
                    onPressed: null,
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
            ),
          ),
        ),
      ),
    );
  }
}

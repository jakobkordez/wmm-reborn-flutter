import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'cubit/create_loan_cubit.dart';
import 'package:wmm_flutter/components/amount_field.dart';
import 'package:wmm_flutter/components/friend_list.dart';
import 'package:wmm_flutter/components/user_tile.dart';
import 'package:wmm_flutter/cubit/loan_cubit.dart';

class CreateLoanForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateLoanCubit, CreateLoanState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          context.bloc<LoanCubit>().loadInitial();
          Navigator.pop(context);
        } else if (state.status.isSubmissionFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content:
                const Text('Something went wrong! Please try again later.'),
          ));
        }
      },
      child: BlocBuilder<CreateLoanCubit, CreateLoanState>(
        builder: (context, state) {
          if (state.status.isSubmissionInProgress)
            return Center(child: CircularProgressIndicator());

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Column(
                children: [
                  _UserInput(),
                  const Padding(padding: EdgeInsets.all(6)),
                  _TitleInput(),
                  const Padding(padding: EdgeInsets.all(6)),
                  _AmountInput(),
                  const Padding(padding: EdgeInsets.all(12)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton(
                      onPressed: state.status.isValidated
                          ? () => context.bloc<CreateLoanCubit>().submit()
                          : null,
                      disabledElevation: 0,
                      child: const Icon(Icons.send),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _UserInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLoanCubit, CreateLoanState>(
      buildWhen: (previous, current) => previous.user != current.user,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: state.user.invalid
                  ? Colors.grey
                  : Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          child: UserTile(
            color: Colors.transparent,
            user: state.user.value,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Scaffold(
                  body: FriendList(
                    onTap: (user) {
                      context.bloc<CreateLoanCubit>().setUser(user);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLoanCubit, CreateLoanState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        return TextFormField(
          key: const Key('createLoanForm_title'),
          onChanged: (value) => context.bloc<CreateLoanCubit>().setTitle(value),
          decoration: InputDecoration(
            labelText: 'Title',
          ),
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        );
      },
    );
  }
}

class _AmountInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLoanCubit, CreateLoanState>(
      buildWhen: (previous, current) => previous.amount != current.amount,
      builder: (context, state) {
        return AmountField(
          key: const Key('createLoanForm_amount'),
          onChanged: (value) =>
              context.bloc<CreateLoanCubit>().setAmount(value),
          decoration: InputDecoration(
            labelText: 'Amount',
            suffixText: '€',
          ),
        );
      },
    );
  }
}

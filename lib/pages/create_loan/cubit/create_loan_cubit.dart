import 'package:cubit/cubit.dart';
import 'package:meta/meta.dart';

part 'create_loan_state.dart';

class CreateLoanCubit extends Cubit<CreateLoanState> {
  CreateLoanCubit() : super(CreateLoanInitial());
}

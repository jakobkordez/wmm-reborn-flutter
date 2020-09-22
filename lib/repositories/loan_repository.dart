import 'dart:convert';

import 'package:http/http.dart' show Response;
import 'package:wmm_flutter/models/loan.dart';
import 'package:wmm_flutter/models/new_loan.dart';

import 'base_repository.dart';

class LoanRepository {
  LoanRepository(this.baseRepository);

  final BaseRepository baseRepository;

  String get basePath => '/loans';

  Future<List<LoanModel>> getAll({int count = 20, int start}) async {
    final params = <String>[];
    if (count != null) params.add('count=$count');
    if (start != null) params.add('start=$start');

    Response res =
        await baseRepository.send('GET', '$basePath?${params.join('&')}');

    if (res.statusCode != 200) throw Error();

    final lList = json.decode(res.body) as List<dynamic>;

    return lList.map((e) => LoanModel.fromJson(e)).toList();
  }

  Future<void> create(NewLoan loan) async {
    Response res = await baseRepository.send('POST', basePath, body: {
      'title': loan.title,
      'user': loan.user,
      'amount': loan.amount,
    });

    if (res.statusCode == 400)
      throw ArgumentError(res.body.substring(1, res.body.length - 1));
    if (res.statusCode != 201) throw Error();
  }
}

import 'dart:convert';

import 'package:http/http.dart' show Response;
import 'package:wmm_reborn_flutter/models/loan.dart';

import 'base_repository.dart';

class LoanRepository {
  LoanRepository(this.baseRepository);

  final BaseRepository baseRepository;

  String get baseUrl => '/loans';

  Future<List<LoanModel>> getAll({int count = 20, int start}) async {
    final params = <String>[];
    if (count != null) params.add('count=$count');
    if (start != null) params.add('start=$start');

    Response res =
        await baseRepository.send('GET', '$baseUrl?${params.join('&')}');

    if (res.statusCode != 200) throw Error();

    final lList = json.decode(res.body) as List<dynamic>;

    return lList.map((e) => LoanModel.fromJson(e)).toList();
  }

  Future<void> create(LoanModel loan) async {
    Response res = await baseRepository.send('POST', baseUrl,
      body: { 'user': loan.reciever, 'amount': loan.amount });
    
    if (res.statusCode == 400) throw ArgumentError(res.body.substring(1, res.body.length-1));
    if (res.statusCode != 200) throw Error();
  }
}

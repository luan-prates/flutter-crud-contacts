import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:newbytebank/models/contact.dart';
import 'package:newbytebank/models/transaction.dart';
import 'package:newbytebank/models/transaction.dart' as prefix0;

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('Request');
    print('url: ${data.url}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('Response');
    print('Status Code: ${data.statusCode}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }
}

final client = HttpWithInterceptor.build(interceptors: [
  LoggingInterceptor(),
]);

const String TransactionBaseUrl = 'http://172.17.174.193:8091/transactions';
const String TransactionBaseUrlNgrok = 'https://3db62739.ngrok.io:8091/transactions';

Future<List<Transaction>> findAll() async {

  final Response response =
//      await client.get('https://6e311a19.ngrok.io/transactions').timeout(Duration(seconds: 10));
      await client.get(TransactionBaseUrl);
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = List();
  for (Map<String, dynamic> transactionJson in decodedJson) {
    final Map<String, dynamic> contactJson = transactionJson['contact'];
    final Transaction  transaction = Transaction(
      transactionJson['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
    transactions.add(transaction);
  }
  return transactions;
}

void  save(Transaction transaction){
  client.post(url)
}
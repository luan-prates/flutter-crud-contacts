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

const String TransactionBaseUrl = 'http://192.168.139.145:8081/transactions';
const String TransactionBaseUrlNgrok = 'https://3b2c62f1.ngrok.io/transactions';

Future<List<Transaction>> findAll() async {
  final Response response =
      await client.get(TransactionBaseUrl).timeout(Duration(seconds: 5));
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = List();
  for (Map<String, dynamic> transactionJson in decodedJson) {
    final Map<String, dynamic> contactJson = transactionJson['contact'];
    final Transaction transaction = Transaction(
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

Future<Transaction> save(Transaction transaction) async {
  final Map<String, dynamic> transactonMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.name,
      'accountNumber': transaction.contact.accountNumber,
    }
  };

  final String transactionJson = jsonEncode(transactonMap);

  final Response response = await client.post(
    TransactionBaseUrl,
    headers: {
      'Content-type': 'application/json',
      'password': '1000',
    }, body: transactionJson);

  Map<String, dynamic> jsonTransactionResponse = jsonDecode(response.body);
  final Map<String, dynamic> contactJson = jsonTransactionResponse['contact'];
  final Transaction transactionResponse = Transaction(
    jsonTransactionResponse['value'],
    Contact(
      0,
      contactJson['name'],
      contactJson['accountNumber'],
    ),
  );
  return transactionResponse;
}

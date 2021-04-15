import 'dart:convert';

import 'dart:io';

import 'package:google_login/models/new.dart';
import 'package:google_login/utils/apikey.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:connectivity/connectivity.dart';

class NewsRepository {
  List<New> _noticiasList;

  static final NewsRepository _NewsRepository = NewsRepository._internal();
  factory NewsRepository() {
    return _NewsRepository;
  }

  NewsRepository._internal();
  Future<List<New>> getAvailableNoticias(int n, String query) async {
    Box _newsBox = Hive.box("Noticias");

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      var _uri;
      if (n == 0) {
        _uri = Uri(
          scheme: 'https',
          host: 'newsapi.org',
          path: 'v2/top-headlines',
          queryParameters: {
            "country": "mx",
            "category": "sports",
            "apiKey": API_KEY
          },
        );
      } else {
        _uri = Uri(
          scheme: 'https',
          host: 'newsapi.org',
          path: 'v2/top-headlines',
          queryParameters: {
            "country": "mx",
            "q": "${query}",
            "apiKey": API_KEY
          },
        );
      }

      try {
        final response = await get(_uri);
        if (response.statusCode == HttpStatus.ok) {
          List<dynamic> data = jsonDecode(response.body)["articles"];
          _noticiasList =
              ((data).map((element) => New.fromJson(element))).toList();

          await _newsBox.put("noticias", _noticiasList);

          return _noticiasList;
        }
        return [];
      } catch (e) {
        //arroje un error
        throw "Ha ocurrido un error: $e";
      }
    } else {
      return [];
    }
  }
}

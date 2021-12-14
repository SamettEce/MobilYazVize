// çekeceğimiz apideki gerekli olan article news ve source sınıflarını oluşturduk
// bunları çekebilmemiz için newsService sınıfını oluşturuyoruzve apimizi ekliyoruz

import 'dart:convert';

import 'package:http/http.dart' as http; // internete istek atıp internetteki veriyi çekebilmemiz için http paketine ihtiyacımız var
import 'package:newsApp/models/article.dart';
import 'package:newsApp/models/news.dart';


// bir kere newservice oluşturulacak ve static olduğu için ramde kayıtlı kalacak
class NewsService {
  static NewsService _singleton = NewsService._internal(); // singleton uygulamanın aşırı kaynakları kullanmasını engeller
  NewsService._internal(); // internal başına _ koyulması private olmasıdır

  factory NewsService() {
    return _singleton;
  }

    // haberleri geri dönderen metot
  static Future<List<Articles>> getNews() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=tr&category=sports&apiKey=5bf37eda333a4e03a10e4c6aed67a003';

    final response = await http.get(url); // await ile istek gerçekleştiriyoruz yanıtta response ile gerçekleştirilmeiş oluyor

    if (response.body.isNotEmpty) // yanıt boş değilse yani bir şeyler varsa {
      final responseJson = json.decode(response.body); // bir şeyler varsa response (yanıt) json çevir
      News news = News.fromJson(responseJson);
      return news.articles;
    }
    return null; // yanıt boşsa geri boş dönüyor
  }
}

import 'package:flutter/material.dart';
import 'package:newsApp/data/news_service.dart';
import 'package:newsApp/models/article.dart';
import 'package:url_launcher/url_launcher.dart'; // url tarayıcıda açmamızı sağlıyor


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haberler', //uygulama adı
      debugShowCheckedModeBanner: false, //uygulama çubuğunda ki demo yazısını kaldırır
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Haberler'), // uygulama başlığı
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Articles> articles = [];

  @override
  void initState() { // başlangıç durumu
    NewsService.getNews().then((value) {
      setState(() {
        articles = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true, // haber başlığı ortada gözükür
      ),
      body: Center(
          child: ListView.builder( //liste görünümü
              itemCount: articles.length, // haber sayısı articles uzunluğuna eşit
              itemBuilder: (context, index) {
                return Card( // haberlerin kart şeklinde görüntülenmesi için
                  child: Column( // kartın sütunları olucak 'yazar' 'açıklama'
                    children: [
                      Image.network(articles[index].urlToImage ?? // haber kartının resmi
                          'https://yt3.ggpht.com/ytc/AKedOLTnB7-iaUC2TyNBPbNE7SOVnTF6Xy15bKLWaqWq=s900-c-k-c0x00ffffff-no-rj'),
                      ListTile(
                        leading: Icon(Icons.arrow_drop_down_circle), // icon ekliyoruz
                        title: Text(articles[index].title ?? ''),  // articles haber başlığı gelicek
                        subtitle: Text(articles[index].author ?? ''),  // haber yazarı buraya gelicek
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0), // haber kartındaki yazar ile açıklama arasındaki boşluk 16
                        child: Text(articles[index].description ?? ''), // haber kartında açıklama satırı
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.start, // button barı ana eksene hizalıyoruz
                        children: [
                          MaterialButton(
                              onPressed: () async { //butona basıldığında
                                await launch(articles[index].url ?? '');
                              },
                              child: Text('Habere Git')), // butonda habere git yazıyor
                        ],
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}

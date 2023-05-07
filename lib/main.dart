import 'package:flutter/material.dart';
import 'package:api/model/article.dart';
import 'package:api/service/apiService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

/*class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        body: Text("hello"),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News app"),),
      body: FutureBuilder(
        future:  ApiService().getArticle(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, index){

                  return Card(
                    elevation:5,
                    child:Column(
                      children: [
                        Image.network("${snapshot.data![index].urlToImage}"),
                        Text("${snapshot.data![index].title}",style: TextStyle(fontSize: 20),),
                        Text("${snapshot.data![index].description}" ,maxLines:2,overflow: TextOverflow.ellipsis),
                      ],
                    ),

                  );
                }
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'config/key.dart';

Future<void> main() async {
  // Fireabse初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: fd_apiKey,
      authDomain: fd_authDomain,
      projectId: fd_projectId,
      storageBucket: fd_storageBucket,
      messagingSenderId: fd_messagingSenderId,
      appId: fd_appId,
    ),
  );
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyFirestorePage(),
    );
  }
}

class MyFirestorePage extends StatefulWidget {
  @override
  _MyFirestorePageState createState() => _MyFirestorePageState();
}

class _MyFirestorePageState extends State<MyFirestorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              child: Text('コレクション＋ドキュメント作成'),
              onPressed: () async {
                // ドキュメント作成
                await FirebaseFirestore.instance
                    .collection('users') // コレクションID
                    .doc('id_abc') // ドキュメントID
                    .set({'name': '鈴木', 'age': 40}); // データ
              },
            ),
            ElevatedButton(
              child: Text('サブコレクション＋ドキュメント作成'),
              onPressed: () async {
                // サブコレクション内にドキュメント作成
                await FirebaseFirestore.instance
                    .collection('users') // コレクションID
                    .doc('id_ghi') // ドキュメントID << usersコレクション内のドキュメント
                    .collection('orders') // サブコレクションID
                    .doc('id_123') // ドキュメントID << サブコレクション内のドキュメント
                    .set({'price': 600, 'date': '9/13'}); // データ
              },
            ),
          ],
        ),
      ),
    );
  }
}
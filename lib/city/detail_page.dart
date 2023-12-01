import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../env.dart';

class CityDetailPage extends StatefulWidget {
  const CityDetailPage({super.key, required this.city});

  final String city;

  @override
  State<CityDetailPage> createState() => _CityDetailPageState();
}

class _CityDetailPageState extends State<CityDetailPage> {
  late Future<String> _municipalitiesTaxesFuture;

  @override
  void initState() {
    super.initState();
    const host = 'opendata.resas-portal.go.jp';
    const endpoint = '/api/v1/municipality/taxes/perYear';
    final headers = {
      'X-API-KEY': Env.resasApiKey,
    };
    final param = {
      'prefCode': '14',
      'cityCode': '14131',
    };

    _municipalitiesTaxesFuture = http
        .get(
          Uri.https(host, endpoint, param),
          headers: headers,
        )
        .then((res) => res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city),
      ),
      body: FutureBuilder<String>(
          future: _municipalitiesTaxesFuture,
          builder: (context, snapshot) {
            print(snapshot.data);
            return Center(
              child: Text('${widget.city}の詳細画面です'),
            );
          }),
    );
  }
}

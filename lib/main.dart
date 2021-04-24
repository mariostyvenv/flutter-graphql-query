import 'package:flutter/material.dart';
import 'package:flutter_graphql/pages/home_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final HttpLink httpLink = new HttpLink('https://graphqlzero.almansi.me/api');
  @override
  Widget build(BuildContext context) {

    final ValueNotifier<GraphQLClient> client =
        new ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink, cache: GraphQLCache()),
    );

    return GraphQLProvider(
        client: client,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          home: HomePage()
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  final String albums = """
  query getalbums(\$page:Int, \$limit:Int) {
    albums(options: {paginate:{page:\$page, limit: \$limit} }){
      data{
        id
        title
        user{
          name
          username
          email
        }
      }
    }
  }
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: Query(
            options: QueryOptions(document: gql(albums), variables: {
              'page': 1,
              'limit': 5
            }),
            builder: (QueryResult result, {fetchMore, refetch}) {
              if (result.hasException) {
                return Center(
                  child: Text(result.exception.toString()),
                );
              }

              if (result.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              List albums = result.data['albums']['data'];

              return ListView.builder(
                  itemCount: albums.length, itemBuilder: (BuildContext context, int index) {

                    final album = albums[index]['title'];

                    return ListTile(
                      title: Text(album)
                    );
                  });
            }));
  }
}

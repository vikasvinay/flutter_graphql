import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlConfig {
  final httpLink = HttpLink(
    'https://api.spacex.land/graphql',
  );

  GraphQLClient qlClient() {
    return GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }
}

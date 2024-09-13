// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembea/core/commons/Loader.dart';
import 'package:tembea/core/commons/error_text.dart';
import 'package:tembea/features/destination/controller/destination_controller.dart';
import 'package:tembea/features/destination/screens/detail_screen.dart';
import 'package:tembea/models/destination_model.dart';

class SearchDestinationDelegate extends SearchDelegate {
  WidgetRef ref;
  SearchDestinationDelegate({
    required this.ref,
  });
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ref.watch(searchProvider(query)).when(
        data: (destinations) => ListView.builder(
            itemCount: destinations.length,
            itemBuilder: (context, index) => ListTile(
                  onTap: () => navigate(context, destinations[index]),
                  title: Text("${destinations[index].name}"),
                  subtitle: Text(
                    "${destinations[index].location}",
                    style: TextStyle(color: Colors.grey.shade300),
                  ),
                )),
        error: (e, s) => ErrorText(error: e.toString()),
        loading: () => const Loader());
  }

  void navigate(BuildContext context, DestinationModel model) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailScreen(model: model)));
  }
}

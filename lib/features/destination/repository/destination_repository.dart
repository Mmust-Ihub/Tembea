import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembea/core/constants/firebase_constants.dart';
import 'package:tembea/core/providers/firebase_provider.dart';
import 'package:tembea/models/destination_model.dart';

final destinationRepositoryProvider = Provider(
    (ref) => DestinationRepository(firestore: ref.read(firestoreProvider)));

class DestinationRepository {
  final FirebaseFirestore _firestore;

  DestinationRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _destinations =>
      _firestore.collection(FirebaseConstants.destinationColection);
  Stream<List<DestinationModel>> getDestinations() {
    // print("documents loading");
    return _destinations.snapshots().map((event) {
      List<DestinationModel> destinations = [];
      for (var doc in event.docs) {
        // print("documents: ${doc.data()}");
        destinations
            .add(DestinationModel.fromMap(doc.data() as Map<String, dynamic>));
      }
      return destinations;
    });
  }

  Future<List<DestinationModel>> getDestinations1() async {
    final dest = await _destinations.get().then((value) {
      List<DestinationModel> destinations = [];
      value.docs.map((event) {
        // print("documents: ${event.data()}");
        destinations.add(
            DestinationModel.fromMap(event.data() as Map<String, dynamic>));

        return destinations;
      });
    });
    return dest;
  }

  Stream<List<DestinationModel>> searchDestination(String query) {
    return _destinations
        .where("name",
            isGreaterThanOrEqualTo: query.isEmpty ? null : query,
            isLessThan: query.substring(0, query.length) +
                String.fromCharCode(query.codeUnitAt(query.length)))
        .snapshots()
        .map((event) {
      List<DestinationModel> destinations = [];
      for (var doc in event.docs) {
        // print("documents: ${doc.data()}");
        destinations
            .add(DestinationModel.fromMap(doc.data() as Map<String, dynamic>));
      }
      print("Search equals: $destinations");
      return destinations;
    });
  }

  Stream<DestinationModel> getDestination(String name) {
    // print("destinations: ");
    return _destinations.doc(name).snapshots().map(
          (event) =>
              DestinationModel.fromMap(event.data() as Map<String, dynamic>),
        );
  }
}

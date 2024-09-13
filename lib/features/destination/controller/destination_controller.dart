import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembea/features/destination/repository/destination_repository.dart';
import 'package:tembea/models/destination_model.dart';

final destinationControllerProvider =
    StateNotifierProvider<DestinationController, bool>((ref) {
  final destinationRepository = ref.read(destinationRepositoryProvider);
  return DestinationController(
      ref: ref, destinationRepository: destinationRepository);
});

final searchProvider = StreamProvider.family((ref,String query) {
   final destinationController =
      ref.watch(destinationControllerProvider.notifier);
  return destinationController.searchDestination(query) ;
});

final destinationsProvider = StreamProvider((ref) {
  final destinationController =
      ref.watch(destinationControllerProvider.notifier);
  return destinationController.getDestinations();
});
final destinationProvider = StreamProvider.family((ref, String name) {
  final destinationController =
      ref.watch(destinationControllerProvider.notifier);
  return destinationController.getDestination(name);
});

final destsProvider = StateProvider<List<DestinationModel>>((ref) {
  ref.read(destinationControllerProvider.notifier).getDestinations1();
  return [];
});

class DestinationController extends StateNotifier<bool> {
  final DestinationRepository _destinationRepository;
  final Ref _ref;

  DestinationController(
      {required Ref ref, required DestinationRepository destinationRepository})
      : _destinationRepository = destinationRepository,
        _ref = ref,
        super(false);

  Stream<List<DestinationModel>> getDestinations() {
    // print("destination contrller");
    return _destinationRepository.getDestinations();
  }

  Future<List<DestinationModel>> getDestinations1() async {
    final des = await _destinationRepository.getDestinations1();
    _ref.read(destsProvider.notifier).update((state) => des);
    return des;
  }

  Stream<DestinationModel> getDestination(String name) {
    return _destinationRepository.getDestination(name);
  }

  Stream<List<DestinationModel>> searchDestination(String query) {
    return _destinationRepository.searchDestination(query);
  }
}

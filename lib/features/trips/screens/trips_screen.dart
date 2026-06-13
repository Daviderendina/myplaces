import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/features/trips/controllers/trips_state.dart';
import 'package:myplaces/shared/widgets/main_titled_screen.dart';
import '../providers.dart';

class TripsScreen extends ConsumerWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripsAsync = ref.watch(tripsControllerProvider);

    return MainTitledScreen(
      title: 'Trips',
      subtitle: tripsAsync.when(
        data: (TripsState data) => data.isFiltered
            ? "${data.displayedTrips.length} trips found"
            : "${data.allCount} trips saved",
        loading: () => "...",
        error: (error, stack) => "",
      ),
      action: IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle)),
      child: tripsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Errore nel caricamento dei viaggi: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.read(tripsControllerProvider.notifier).refresh(),
                child: const Text('Riprova'),
              ),
            ],
          ),
        ),
        data: (TripsState state) {
          if (state.displayedTrips.isEmpty) {
            return const Center(child: Text('Nessun viaggio trovato.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.displayedTrips.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final trip = state.displayedTrips[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.flight_takeoff),
                  title: Text(trip.name, style: Theme.of(context).textTheme.titleMedium),
                  subtitle: Text('ID: ${trip.id}'),
                  onTap: () {
                    // TODO: Navigazione
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

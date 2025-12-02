import 'package:flutter/material.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/tv_channel_entity.dart';
import '../../domain/usecases/search_tv_channels_usecase.dart';

class TvChannelSearchDelegate extends SearchDelegate<TvChannelEntity?> {
  final SearchTvChannelsUseCase searchTvChannelsUseCase = sl();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    if (query.isEmpty) {
      return const Center(child: Text('Start typing to search...'));
    }

    return FutureBuilder(
      future: searchTvChannelsUseCase(
          SearchTvChannelsParams(query: query, page: 1)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.hasData) {
          return snapshot.data!.fold(
            (failure) => Center(child: Text(failure.message)),
            (channels) {
              if (channels.isEmpty) {
                return const Center(child: Text('No channels found.'));
              }
              return ListView.builder(
                itemCount: channels.length,
                itemBuilder: (context, index) {
                  final channel = channels[index];
                  return ListTile(
                    leading: channel.logo.isNotEmpty
                        ? Image.network(
                            channel.logo,
                            width: 40,
                            height: 40,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.tv),
                          )
                        : const Icon(Icons.tv),
                    title: Text(channel.name),
                    subtitle: Text(channel.country.name),
                    onTap: () {
                      close(context, channel);
                    },
                  );
                },
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

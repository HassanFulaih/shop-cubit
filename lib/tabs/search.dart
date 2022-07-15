import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/default_text_field.dart';
import '../cubit/search_cubit.dart';
import '../models/search_model.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final SearchCubit cubit = SearchCubit.get(context);
        return Column(
          children: [
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultTextField(
                controller: _controller,
                onSubmitted: (String value) {
                  cubit.getSearch(value);
                },
                label: 'Search',
                type: TextInputType.text,
                prefix: Icons.search,
                validate: (String? val) {
                  if (val!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            if (state is GetSearchLoadingStatus)
              const LinearProgressIndicator(),
            if (state is GetSearchSuccessStatus)
              cubit.search!.data == null
                  ? Center(child: Text(cubit.search!.message!))
                  : Expanded(
                      child: ListView.separated(
                        itemCount: cubit.search!.data!.searchData.length,
                        itemBuilder: (context, index) {
                          final SearchItemModel item =
                              cubit.search!.data!.searchData[index];
                          return ListTile(
                            leading: Image.network(item.image),
                            title: Text(item.name, maxLines: 2),
                            subtitle: Text(item.description, maxLines: 2),
                            trailing: Text(item.price.round().toString()),
                          );
                        },
                        separatorBuilder: (_, __) => const Divider(),
                        physics: const BouncingScrollPhysics(),
                      ),
                    ),
            if (state is GetSearchErrorStatus)
              const Center(child: Text('An error occurred')),
          ],
        );
      },
    );
  }
}

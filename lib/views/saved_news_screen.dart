import 'package:fake_assigment_1/cubit/new_cubit.dart';
import 'package:fake_assigment_1/cubit/news_state.dart';
import 'package:fake_assigment_1/widgets/News_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';

class SavedNewsScreen extends StatelessWidget{
  const SavedNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 190,
              pinned: true,
              backgroundColor: const Color.fromARGB(141, 255, 4, 4),

              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Saved News", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
                background: Padding(
                  padding: const EdgeInsets.only(right: 100.0),
                  child: Image.asset("images/logsimple.png", width: 250, height: 250),
                ),

              ),
            ),
            //List of news items goes here
            BlocBuilder<NewsCubit, NewsState>(
              builder: (context, state) {
                if (state is NewsLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );

                } else if (state is NewsLoaded) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (state.newsSavedItems.isEmpty) {
                              return const Center(child: Text('No saved news available'));
                            } else{
                              final newsItem = state.newsSavedItems[index];
                              return NewsButton(newsItem: newsItem, index: index);
                            }
                          },
                      childCount: state.newsSavedItems.length,
                    ),
                  );
                } else if (state is NewsError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('Error: ${state.message}')),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(child: Text('No news available')),
                  );
                }
              },
            ),
          ],
        )
    );
  }
}
import 'package:fake_assigment_1/cubit/new_cubit.dart';
import 'package:fake_assigment_1/cubit/news_state.dart';
import 'package:fake_assigment_1/widgets/News_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';

class News extends StatelessWidget{
  const News({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: CustomScrollView(
          slivers: [
           SliverAppBar(
            expandedHeight: 90,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 16, bottom: 12),
              title: Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min, 
                  children: [
                    
                    Text(
                      "Upei News",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(width: 8),
                    Image.asset(
                      "images/logsimple.png",
                      width: 28, 
                      height: 28,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
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
                            if (state.newsItems.isEmpty) {
                              return const Center(child: Text('No news available'));
                            } else{
                              final newsItem = state.newsItems[index];
                              return NewsButton(newsItem: newsItem, index: index);
                            }
                          },
                      childCount: state.newsItems.length,
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

import 'package:fake_assigment_1/cubit/new_cubit.dart';
import 'package:fake_assigment_1/cubit/news_state.dart';
import 'package:fake_assigment_1/news/model/news_item.dart';
import 'package:fake_assigment_1/routers/route_generator.dart';
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
              expandedHeight: 190,
              pinned: true,
              backgroundColor: const Color.fromARGB(117, 79, 255, 214),

              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Upei News", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
                background: Padding(
                  padding: const EdgeInsets.only(right: 100.0),
                  child: Image.asset("images/trump.png", width: 250, height: 250),
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
                        final newsItem = state.newsItems[index];
                        return NewsButton(newsItem: newsItem, index: index);
                      },
                      childCount: state.newsItems.length,
                    ),
                  );
                }else if (state is NewsSaved) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final newsItem = state.newsItems[index];
                        return NewsButton(newsItem: newsItem, index: index);
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


class NewsButton extends StatelessWidget {
  final NewsItem newsItem;
  final int index;

  const NewsButton({Key? key, required this.newsItem, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: newsItem.isRead
            ? Colors.grey
            : (index % 2 == 0 ? const Color.fromARGB(255, 149, 221, 255) : const Color.fromARGB(255, 164, 178, 255)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.all(10),
      ),
      onPressed: () {
        Navigator.pushNamed(context, RouteGenetaror.newDetails, arguments: newsItem);
        context.read<NewsCubit>().readNew(newsItem);
      },
      child: Row(
        children: [
          Image.network(newsItem.image, width: 100, height: 100),
          SizedBox(width: 10),
          Expanded(child: Text(newsItem.title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800))),
        ],
      ),
    );
  }
}
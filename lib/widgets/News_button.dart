import 'package:fake_assigment_1/cubit/new_cubit.dart';
import 'package:fake_assigment_1/news/model/news_item.dart';
import 'package:fake_assigment_1/routers/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsButton extends StatelessWidget {
  final NewsItem newsItem;
  final int index;

  const NewsButton({Key? key, required this.newsItem, required this.index})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: newsItem.isRead
            ? const Color.fromARGB(184, 158, 158, 158)
            : (index % 2 == 0
                  ? const Color.fromARGB(191, 164, 178, 255)
                  : const Color.fromARGB(157, 209, 164, 255)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.all(10),
      ),
      onPressed: () {
        Navigator.pushNamed(
          context,
          RouteGenetaror.newDetails,
          arguments: newsItem,
        );
        context.read<NewsCubit>().readNew(newsItem);
      },
      onLongPress: () {
        context.read<NewsCubit>().addNew(newsItem);
      },

      child: Row(
        children: [
          Image.network(newsItem.image, width: 100, height: 100),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              newsItem.title,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}

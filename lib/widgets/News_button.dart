import 'package:fake_assigment_1/cubit/new_cubit.dart';
import 'package:fake_assigment_1/news/model/news_item.dart';
import 'package:fake_assigment_1/routers/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
                  ? const Color.fromARGB(255, 255, 210, 210)
                  : const Color.fromARGB(255, 228, 255, 236)),
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
          //Image.network(newsItem.image, width: 100, height: 100),
          //to not load the image every time, we use cached network image, it will cache the image after the first load, and load it from cache next time
          CachedNetworkImage(
            imageUrl: newsItem.image,
            height: 100,
            width: 120,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              height: 180,
              color: Colors.grey[200],
            ),
            errorWidget: (context, url, error) => Container(
              height: 180,
              color: Colors.grey[200],
              child: Icon(Icons.image_not_supported, color: Colors.grey),
            ),
        ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              newsItem.title,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black ),
            ),
          ),
        ],
      ),
    );
  }
}

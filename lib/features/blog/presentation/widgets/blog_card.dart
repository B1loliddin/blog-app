import 'package:blog_app/core/theme/app_pallet.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final BlogEntity blog;
  final Color color;

  const BlogCard({
    super.key,
    required this.blog,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    void navigateToBlogDetailsPage() =>
        Navigator.pushNamed(context, '/blog_details_page', arguments: blog);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: navigateToBlogDetailsPage,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (int i = 0; i < blog.topics.length; i++)
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: i == 0 ? 16 : 8,
                                      ),
                                      child: Chip(
                                        color: WidgetStatePropertyAll(
                                          AppPallet.backgroundColor,
                                        ),
                                        label: Text(blog.topics[i].toString()),
                                        side: BorderSide(),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          blog.title,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text('${calculateReadingTime(blog.content)} min'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

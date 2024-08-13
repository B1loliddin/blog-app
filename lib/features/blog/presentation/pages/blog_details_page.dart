import 'package:blog_app/core/theme/app_pallet.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/format_date.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class BlogDetailsPage extends StatelessWidget {
  const BlogDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final BlogEntity blog =
        ModalRoute.of(context)?.settings.arguments as BlogEntity;

    return Scaffold(
      appBar: AppBar(
        title: Text('Details Page'),
      ),
      body: Scrollbar(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'By ${blog.userName}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                Text(
                  '${formatDateByDMMMYYYY(blog.updatedAt)}. Reading time: ${calculateReadingTime(blog.content)} min',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppPallet.greyColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: blog.imageUrl,
                    height: 200,
                    width: MediaQuery.sizeOf(context).width,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  blog.content,
                  style: TextStyle(fontSize: 16, height: 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

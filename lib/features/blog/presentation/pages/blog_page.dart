import 'package:blog_app/core/common/widgets/loading.dart';
import 'package:blog_app/core/theme/app_pallet.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/presentation/blocs/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    _getAllBlogs();
  }

  void _getAllBlogs() => context.read<BlogBloc>().add(BlogGetAllBlogs());

  void _navigateToAddNewBlogPage() =>
      Navigator.pushNamed(context, '/add_new_blog_page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog App'),
        actions: [
          IconButton(
            onPressed: _navigateToAddNewBlogPage,
            icon: Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogUploadBlogSuccess) {
            _getAllBlogs();
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return Loading();
          } else if (state is BlogGetAllBlogsSuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final BlogEntity blog = state.blogs[index];

                return BlogCard(
                  blog: blog,
                  color: index % 3 == 0
                      ? AppPallet.gradient1
                      : index % 3 == 1
                          ? AppPallet.gradient2
                          : AppPallet.gradient3,
                );
              },
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}

import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loading.dart';
import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/core/theme/app_pallet.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/show_snack_bar.dart';
import 'package:blog_app/features/blog/presentation/blocs/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  List<String> selectedTopics = [];
  File? image;

  @override
  void initState() {
    super.initState();
    _initializeAllControllers();
  }

  @override
  void dispose() {
    _disposeAllControllers();
    super.dispose();
  }

  void _initializeAllControllers() {
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  void _disposeAllControllers() {
    _titleController.dispose();
    _contentController.dispose();
  }

  void _selectImage() async {
    HapticFeedback.lightImpact();
    final File? pickedImage = await pickImage();

    if (pickedImage != null) {
      image = pickedImage;
      setState(() {});
    }
  }

  void _uploadBlog() {
    if (formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        image != null) {
      final blogId =
          (context.read<AppUserCubit>().state as AppUserSignedIn).user.id;

      context.read<BlogBloc>().add(
            BlogUpload(
              image: image!,
              title: _titleController.text.trim(),
              content: _contentController.text.trim(),
              blogId: blogId,
              topics: selectedTopics,
            ),
          );

      navigateToBlogPage();
    }
  }

  void navigateToBlogPage() => Navigator.pop(context);

  void textFieldUnFocus() => FocusScope.of(context).unfocus();

  @override
  Widget build(BuildContext context) {
    final phonePadding = MediaQuery.of(context).padding;

    return GestureDetector(
      onTap: textFieldUnFocus,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create your post'),
          actions: [
            IconButton(
              onPressed: _uploadBlog,
              icon: Icon(Icons.done_rounded),
            ),
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              showSnackBar(context, state.message);
            } else if (state is BlogUploadBlogSuccess) {
              navigateToBlogPage();
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return Loading();
            }

            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    image != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: GestureDetector(
                              onTap: _selectImage,
                              child: SizedBox(
                                height: 150,
                                width: MediaQuery.sizeOf(context).width,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: Image.file(image!, fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: GestureDetector(
                              onTap: _selectImage,
                              child: DottedBorder(
                                dashPattern: [15, 4],
                                color: AppPallet.borderColor,
                                radius: Radius.circular(10),
                                borderType: BorderType.RRect,
                                strokeCap: StrokeCap.round,
                                child: SizedBox(
                                  height: 150,
                                  width: MediaQuery.sizeOf(context).width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.folder_open, size: 40),
                                      SizedBox(height: 15),
                                      Text(
                                        'Select your image',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: Constants.topics.map((Object element) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: GestureDetector(
                              onTap: () {
                                if (selectedTopics.contains(element)) {
                                  selectedTopics.remove(element);
                                } else {
                                  selectedTopics.add(element.toString());
                                }

                                setState(() {});
                              },
                              child: TweenAnimationBuilder<Color?>(
                                duration: Duration(milliseconds: 250),
                                tween: ColorTween(
                                  begin: AppPallet.backgroundColor,
                                  end: selectedTopics.contains(element)
                                      ? AppPallet.gradient1
                                      : AppPallet.backgroundColor,
                                ),
                                builder: (_, Color? color, __) {
                                  return Chip(
                                    color: WidgetStatePropertyAll(color),
                                    label: Text(element.toString()),
                                    side: BorderSide(
                                      color: selectedTopics.contains(element)
                                          ? AppPallet.backgroundColor
                                          : AppPallet.borderColor,
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          BlogEditor(
                            controller: _titleController,
                            hintText: 'Blog Title',
                          ),
                          SizedBox(height: 10),
                          BlogEditor(
                            controller: _contentController,
                            hintText: 'Blog Content',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: phonePadding.bottom + 30),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

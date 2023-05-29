// ignore_for_file: use_build_context_synchronously

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_users_app/core/shared_widgets/app_appbar.dart';
import 'package:test_users_app/modules/post_page/ui/bloc/post_detail_bloc.dart';
import 'package:test_users_app/modules/post_page/ui/widgets/comments_list_view.dart';
import 'package:test_users_app/core/shared_widgets/custom_text_field.dart';
import 'package:test_users_app/core/shared_widgets/loader.dart';
import 'package:test_users_app/core/theme/app_colors.dart';
import 'package:test_users_app/core/theme/app_text_styles.dart';

import '../../../../core/services/services_locator.dart';
import '../../../user_page/data/models/post_model.dart';
import 'package:flutter/material.dart';

import '../bloc/send_comment_bloc.dart';

class PostDetailPage extends StatefulWidget {
  final PostModel post;

  const PostDetailPage({required this.post, Key? key, required this.userId})
      : super(key: key);
  final int userId;

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  // List<CommentModel> comments = List.empty();
  final _commentBloc = sl<PostDetailBloc>();
  final _sendBloc = sl<SendCommentBloc>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    _commentBloc.add(GetPostDetailCommentsEvent(userId: widget.userId));
    super.initState();
  }

  void _clearText() {
    nameController.clear();
    emailController.clear();
    commentController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    commentController.dispose();
    super.dispose();
  }

  Future<void> _displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          scrollable: true,
          title: const Text('Add new comment'),
          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: BlocProvider.value(
                  value: _sendBloc,
                  child: BlocConsumer<SendCommentBloc, SendCommentState>(
                    listener: (context, state) async {
                      if (state is SendCommentErrorState) {
                        await Future.delayed(const Duration(seconds: 1));
                        Navigator.pop(context);
                        _sendBloc.add(UserSendCommendInitEvent());
                      }
                      if (state is SendCommentSuccessState) {
                        await Future.delayed(const Duration(seconds: 1));
                        Navigator.pop(context);
                        _sendBloc.add(UserSendCommendInitEvent());
                      }
                    },
                    builder: (context, state) {
                      if (state is SendCommentSuccessState) {
                        return const Center(
                          child: Icon(
                            Icons.done,
                            color: AppColors.green,
                          ),
                        );
                      }
                      if (state is SendCommentLoadingState) {
                        return const Loader();
                      }
                      if (state is SendCommentErrorState) {
                        return const Center(
                          child: Text('Error'),
                        );
                      }
                      return Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            controller: nameController,
                            prefixIcon: const Icon(Icons.person),
                            hintText: 'Name',
                            validatorMessage: 'Name cannot be empty',
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: emailController,
                            prefixIcon: const Icon(Icons.email),
                            hintText: 'E-mail',
                            validatorMessage: 'Email cannot be empty',
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: commentController,
                            prefixIcon: const Icon(Icons.message),
                            hintText: 'Comment',
                            validatorMessage: 'Comment cannot be empty',
                          )
                        ],
                      );
                    },
                  )),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                sl<SendCommentBloc>().add(UserSendCommentEvent(
                    body: commentController.text,
                    email: emailController.text,
                    name: nameController.text));
                _clearText();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(title: widget.post.title),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            widget.post.title,
            style: AppTextStyles.title.copyWith(
              color: AppColors.cyan,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 7),
          Text(
            widget.post.body,
            style: AppTextStyles.bodyTextStyle.copyWith(
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Comments:',
            style: AppTextStyles.subtitle.copyWith(color: AppColors.cyan),
          ),
          const SizedBox(
            height: 8,
          ),
          BlocProvider.value(
            value: _commentBloc,
            child: BlocBuilder<PostDetailBloc, PostDetailState>(
              builder: (context, state) {
                if (state is PostDetailLoadingState) {
                  return const Loader();
                }
                if (state is PostDetailSuccessState) {
                  return CommentsListView(comments: state.comments);
                }
                if (state is PostDetailErrorState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Error'),
                      Text(state.errorText),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.cyan,
        child: const Icon(
          Icons.add,
          size: 20,
        ),
        onPressed: () => _displayDialog(context),
      ),
    );
  }
}

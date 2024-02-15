part of '../users_view.dart';

class UserPosts extends StatelessWidget {
  final List<PostModel> posts;
  final UserDataModel user;
  final UsersViewModel viewModel;
  const UserPosts(
      {super.key,
      required this.viewModel,
      required this.posts,
      required this.user});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return buildUserPost(index);
        });
  }

  Widget buildUserPost(int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Padding(
            padding: PaddingConsts.instance.top10,
            child: Image.network(
              posts[index].apiImage!,
            ),
          ),
          Padding(
            padding: PaddingConsts.instance.top10,
            child: Text(
              posts[index].description!,
              style: TextConsts.instance.regularBlack25,
            ),
          ),
          IconButton(
              onPressed: () async =>
                  await viewModel.deletePost(user, posts[index].id!),
              icon: Icon(
                Icons.delete,
                color: ColorConsts.instance.red,
                size: 40,
              ))
        ],
      ),
    );
  }
}

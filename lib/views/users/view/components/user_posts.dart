part of '../users_view.dart';

class UserPosts extends StatelessWidget {
  final UserDataModel user;
  final UsersViewModel viewModel;
  const UserPosts({super.key, required this.user, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: user.posts!.length,
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
              user.posts![index].apiImage!,
            ),
          ),
          Padding(
            padding: PaddingConsts.instance.top10,
            child: Text(
              user.posts![index].description!,
              style: TextConsts.instance.regularBlack25,
            ),
          ),
          IconButton(
              onPressed: () {},
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

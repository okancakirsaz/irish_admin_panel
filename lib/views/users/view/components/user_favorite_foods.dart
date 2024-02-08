part of '../users_view.dart';

class UserFavoriteFoods extends StatelessWidget {
  final UserDataModel user;
  final UsersViewModel viewModel;
  const UserFavoriteFoods(
      {super.key, required this.user, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: user.favoriteFoods!.length,
        itemBuilder: (context, index) {
          return buildUserFavoriteFood(index);
        });
  }

  Widget buildUserFavoriteFood(int index) {
    return Card(
      child: ListTile(
        title: Text(
          "${user.favoriteFoods![index].foodName}  x${user.favoriteFoods![index].count}",
          style: TextConsts.instance.regularBlack18,
        ),
        trailing: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: RadiusConsts.instance.circularAll10,
              image: DecorationImage(
                  image: NetworkImage(user.favoriteFoods![index].photo))),
        ),
      ),
    );
  }
}

part of '../users_view.dart';

class UserScores extends StatelessWidget {
  final UserDataModel user;
  final UsersViewModel viewModel;
  const UserScores({super.key, required this.user, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: user.scores!.length,
        itemBuilder: (context, index) {
          return buildUserScore(index);
        });
  }

  Widget buildUserScore(int index) {
    return Card(
      child: ListTile(
        title: Text(
          "${user.scores![index].userName} vs ${user.scores![index].challengedUserName}",
          style: TextConsts.instance.regularBlack18,
        ),
        subtitle: Text(
          user.scores![index].game,
          style: TextConsts.instance.regularBlack14Bold,
        ),
        trailing: Text(user.scores![index].isWinned ? "Kazandı" : "Kaybetti",
            style: user.scores![index].isWinned
                ? TextConsts.instance.regularGreen14Bold
                : TextConsts.instance.regularRed14Bold),
      ),
    );
  }
}

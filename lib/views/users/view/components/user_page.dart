part of '../users_view.dart';

class UserPage extends StatelessWidget {
  final UserDataModel user;
  final UsersViewModel viewModel;
  const UserPage({super.key, required this.user, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.name!,
          style: TextConsts.instance.regularBlack25Bold,
        ),
        actions: <Widget>[
          Padding(
            padding: PaddingConsts.instance.horizontal30,
            child: UserProfileImage(
              profileImage: user.profileImage,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 3, child: buildUserDataRow()),
          Expanded(flex: 1, child: buildInputsRow())
        ],
      ),
    );
  }

  Widget buildUserDataRow() {
    return Row(
      children: <Widget>[
        Expanded(child: buildUserPosts()),
        Expanded(child: buildUserScores()),
        Expanded(child: buildUserFavoriteFoods())
      ],
    );
  }

  Widget buildInputsRow() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          margin: PaddingConsts.instance.all10,
          color: Colors.black,
        ))
      ],
    );
  }

  Widget buildUserPosts() {
    return Container(
      margin: PaddingConsts.instance.all10,
      padding: PaddingConsts.instance.all10,
      decoration: BoxDecoration(
          color: ColorConsts.instance.orange,
          borderRadius: RadiusConsts.instance.circularAll10,
          boxShadow: ColorConsts.instance.shadow),
      child: Column(
        children: <Widget>[
          Padding(
            padding: PaddingConsts.instance.bottom15,
            child: Text("Gönderiler",
                style: TextConsts.instance.regularWhite25Bold),
          ),
          Expanded(
              child: user.posts!.isEmpty
                  ? Center(
                      child: Text(
                        "Kullanıcı henüz paylaşım yapmamış.",
                        style: TextConsts.instance.regularWhite20Bold,
                      ),
                    )
                  : UserPosts(user: user, viewModel: viewModel)),
        ],
      ),
    );
  }

  Widget buildUserScores() {
    return Container(
      margin: PaddingConsts.instance.all10,
      padding: PaddingConsts.instance.all10,
      decoration: BoxDecoration(
          color: ColorConsts.instance.orange,
          borderRadius: RadiusConsts.instance.circularAll10,
          boxShadow: ColorConsts.instance.shadow),
      child: Column(
        children: <Widget>[
          Padding(
            padding: PaddingConsts.instance.bottom15,
            child:
                Text("Skorlar", style: TextConsts.instance.regularWhite25Bold),
          ),
          Expanded(
              child: user.scores!.isEmpty
                  ? Center(
                      child: Text(
                        "Kullanıcının kayıtlı bir skoru yok.",
                        style: TextConsts.instance.regularWhite20Bold,
                      ),
                    )
                  : UserScores(user: user, viewModel: viewModel)),
        ],
      ),
    );
  }

  Widget buildUserFavoriteFoods() {
    return Container(
      margin: PaddingConsts.instance.all10,
      padding: PaddingConsts.instance.all10,
      decoration: BoxDecoration(
          color: ColorConsts.instance.orange,
          borderRadius: RadiusConsts.instance.circularAll10,
          boxShadow: ColorConsts.instance.shadow),
      child: Column(
        children: <Widget>[
          Padding(
            padding: PaddingConsts.instance.bottom15,
            child: Text("Favori Yiyecekler",
                style: TextConsts.instance.regularWhite25Bold),
          ),
          Expanded(
              child: user.favoriteFoods!.isEmpty
                  ? Center(
                      child: Text(
                        "Kullanıcı henüz sipariş vermemiş.",
                        style: TextConsts.instance.regularWhite20Bold,
                      ),
                    )
                  : UserFavoriteFoods(user: user, viewModel: viewModel)),
        ],
      ),
    );
  }
}

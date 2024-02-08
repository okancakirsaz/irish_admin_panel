part of '../users_view.dart';

class UserPage extends StatefulWidget {
  final UserDataModel user;
  final UsersViewModel viewModel;
  const UserPage({super.key, required this.user, required this.viewModel});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    widget.viewModel.fetchBlockUserButtonText(widget.user.isUserBanned!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user.name!,
          style: TextConsts.instance.regularBlack25Bold,
        ),
        actions: <Widget>[
          Padding(
            padding: PaddingConsts.instance.horizontal30,
            child: UserProfileImage(
              profileImage: widget.user.profileImage,
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
              child: widget.user.posts!.isEmpty
                  ? Center(
                      child: Text(
                        "Kullanıcı henüz paylaşım yapmamış.",
                        style: TextConsts.instance.regularWhite20Bold,
                      ),
                    )
                  : UserPosts(user: widget.user, viewModel: widget.viewModel)),
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
              child: widget.user.scores!.isEmpty
                  ? Center(
                      child: Text(
                        "Kullanıcının kayıtlı bir skoru yok.",
                        style: TextConsts.instance.regularWhite20Bold,
                      ),
                    )
                  : UserScores(user: widget.user, viewModel: widget.viewModel)),
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
              child: widget.user.favoriteFoods!.isEmpty
                  ? Center(
                      child: Text(
                        "Kullanıcı henüz sipariş vermemiş.",
                        style: TextConsts.instance.regularWhite20Bold,
                      ),
                    )
                  : UserFavoriteFoods(
                      user: widget.user, viewModel: widget.viewModel)),
        ],
      ),
    );
  }

  Widget buildInputsRow() {
    return Row(
      children: <Widget>[
        Padding(
          padding: PaddingConsts.instance.all20,
          child: Observer(builder: (context) {
            return CustomStateFullButton(
              onPressed: () {},
              text: widget.viewModel.blockUserButtonText!,
              width: 250,
              height: 70,
              style: TextConsts.instance.regularBlack20Bold,
            );
          }),
        ),
        CustomStateFullButton(
          onPressed: () {},
          text: "Profil Fotoğrafını Kaldır",
          width: 250,
          height: 70,
          style: TextConsts.instance.regularBlack18Bold,
        ),
        Expanded(
          child: Padding(
            padding: PaddingConsts.instance.all20,
            child: Column(
              children: <Widget>[
                buildUserInformationElement(
                    "Telefon Numarası:", widget.user.phoneNumber!),
                buildUserInformationElement("Mail Adresi:", widget.user.email!),
                buildUserInformationElement("Anonimlik:",
                    widget.user.isAnonym! ? "Anonim" : "Anonim değil")
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildUserInformationElement(String title, String value) {
    return ListTile(
      leading: Text(
        title,
        style: TextConsts.instance.regularBlack20Bold,
      ),
      title: Text(
        value,
        style: TextConsts.instance.regularBlack20,
      ),
    );
  }
}

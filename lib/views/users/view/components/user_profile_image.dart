part of '../users_view.dart';

class UserProfileImage extends StatelessWidget {
  final String? profileImage;
  const UserProfileImage({super.key, this.profileImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: RadiusConsts.instance.circularAll100,
          image: profileImage != null
              ? DecorationImage(
                  image: NetworkImage(profileImage!), fit: BoxFit.cover)
              : null),
      child: profileImage == null
          ? Icon(
              Icons.portrait,
              size: 45,
              color: ColorConsts.instance.black,
            )
          : null,
    );
  }
}

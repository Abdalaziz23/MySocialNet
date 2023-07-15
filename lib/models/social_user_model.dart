class SocialUserModel
{
  String? name;
  String? email;
  String? uId;
  bool? isEmailVerified;
  String? image;
  String? bio;
  String? cover;

  SocialUserModel({
    this.name,
    this.email,
    this.uId,
    this.isEmailVerified,
    this.image,
    this.bio,
    this.cover,
});

   SocialUserModel.fromJson(Map<String,dynamic>? json)
  {
    name = json!['name'];
    email = json['email'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'email':email,
      'uId':uId,
      'isEmailVerified':isEmailVerified,
      'bio':bio,
      'image':image,
      'cover':cover,
    };
  }
}
abstract class SocialStates{}

class SocialInitialStates extends SocialStates{}

class SocialGetUserLoadingStates extends SocialStates{}

class SocialGetUserSuccessStates extends SocialStates{}

class SocialGetUserErrorStates extends SocialStates
{
  final String? error;

  SocialGetUserErrorStates(this.error);
}


class SocialGetAllUsersLoadingStates extends SocialStates{}

class SocialGetAllUsersSuccessStates extends SocialStates{}

class SocialGetAllUsersErrorStates extends SocialStates
{
  final String? error;

  SocialGetAllUsersErrorStates(this.error);
}

class SocialGetPostsLoadingStates extends SocialStates{}

class SocialGetPostsSuccessStates extends SocialStates{}

class SocialGetPostsErrorStates extends SocialStates
{
  final String? error;

  SocialGetPostsErrorStates(this.error);
}

class SocialLikePostSuccessStates extends SocialStates{}

class SocialLikePostErrorStates extends SocialStates
{
  final String? error;

  SocialLikePostErrorStates(this.error);
}

class SocialChangeBottomNavStates extends SocialStates{}

class SocialNewPostStates extends SocialStates{}

class SocialProfileImagePickedSuccessStates extends SocialStates{}

class SocialProfileImagePickedErrorStates extends SocialStates{}

class SocialCoverImagePickedSuccessStates extends SocialStates{}

class SocialCoverImagePickedErrorStates extends SocialStates{}

class SocialUploadProfileImageSuccessStates extends SocialStates{}

class SocialUploadProfileImageErrorStates extends SocialStates{}

class SocialUploadCoverImageSuccessStates extends SocialStates{}

class SocialUploadCoverImageErrorStates extends SocialStates{}

class SocialUserUpdateLoadingStates extends SocialStates{}

class SocialUserUpdateErrorStates extends SocialStates{}


class SocialCreatePostLoadingStates extends SocialStates{}

class SocialCreatePostSuccessStates extends SocialStates{}

class SocialCreatePostErrorStates extends SocialStates{}

class SocialPostImagePickedSuccessStates extends SocialStates{}

class SocialPostImagePickedErrorStates extends SocialStates{}

class SocialRemovePostImageStates extends SocialStates{}

// chat message
class SocialSendMessageSuccessStates extends SocialStates{}

class SocialSendMessageErrorStates extends SocialStates{}

class SocialGetMessageSuccessStates extends SocialStates{}

class SocialGetMessageErrorStates extends SocialStates{}

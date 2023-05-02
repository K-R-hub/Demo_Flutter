abstract class SocialSates{}

class SocialInitialState extends SocialSates{}

class SocialGetUserLoadingState extends SocialSates{}

class SocialGetUserSuccessState extends SocialSates{}

class SocialGetUserErrorState extends SocialSates{
  final String? error;

  SocialGetUserErrorState(this.error);
}
//get all users
class SocialGetAllUsersSuccessState extends SocialSates{}

class SocialGetAllUsersErrorState extends SocialSates{
  final String? error;

  SocialGetAllUsersErrorState(this.error);
}

class SocialGetPostsLoadingState extends SocialSates{}

class SocialGetPostsSuccessState extends SocialSates{}

class SocialGetPostsErrorState extends SocialSates{
  final String? error;

  SocialGetPostsErrorState(this.error);
}
// likes
class SocialLikeSuccessState extends SocialSates{}

class SocialLikeErrorState extends SocialSates{
  final String? error;

  SocialLikeErrorState(this.error);
}
// comment
class SocialCommentSuccessState extends SocialSates{}

class SocialCommentErrorState extends SocialSates{
  final String? error;

  SocialCommentErrorState(this.error);
}

class BottomChangeNavState extends SocialSates{}

class SocialNewPostState extends SocialSates{}

class SocialGetImageProfilePickerSuccessState extends SocialSates{}

class SocialGetImageProfilePickerErrorState extends SocialSates{}

class SocialGetImageCoverPickerSuccessState extends SocialSates{}

class SocialGetImageCoverPickerErrorState extends SocialSates{}

class SocialUploadImageProfileSuccessState extends SocialSates{}

class SocialUploadImageProfileErrorState extends SocialSates{}

class SocialUploadImageLoadingState extends SocialSates{}

class SocialUploadImageCoverSuccessState extends SocialSates{}

class SocialUploadImageCoverErrorState extends SocialSates{}

class SocialUserUpdateLoadingState extends SocialSates{}
// new post

class SocialGetImagePostPickerSuccessState extends SocialSates{}

class SocialGetImagePostPickerErrorState extends SocialSates{}

class SocialRemoveImagePostPickerState extends SocialSates{}

class SocialPostLoadingState extends SocialSates{}

class SocialUploadPostImageErrorState extends SocialSates{}

class SocialCreatePostSuccessState extends SocialSates{}

class SocialCreatePostErrorState extends SocialSates{}

// Chats details
class SocialSendMessageSuccessState extends SocialSates{}

class SocialSendMessageErrorState extends SocialSates{}

class SocialGetMessageSuccessState extends SocialSates{}

// Scroll To Bottom
class SocialScrollToBottomSuccessState extends SocialSates{}


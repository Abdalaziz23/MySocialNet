import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/shared/components/constant.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialStates());
  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;

  void getUserData() {
    emit(SocialGetUserLoadingStates());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      model = SocialUserModel.fromJson(value.data());
      emit(SocialGetUserSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorStates(error.toString()));
    });
  }

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  int currentIndex = 0;
  void changeBottomNavBar(int index) {

    if(index == 1)
    {
      getUsers();
    }
    if (index == 2) {
      emit(SocialNewPostStates());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavStates());
    }
  }

  File? profileImage;
  var picker = ImagePicker();
  void getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      //print("fi $profileImage");
      emit(SocialProfileImagePickedSuccessStates());
    } else {
      print('No Image Selected');
      emit(SocialProfileImagePickedErrorStates());
    }
  }

  File? coverImage;
  void getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      //print("fi $profileImage");
      emit(SocialCoverImagePickedSuccessStates());
    } else {
      print('No Image Selected');
      emit(SocialCoverImagePickedErrorStates());
    }
  }


  void uploadProfileImage({
    required String name,
    required String bio,
}) {
    emit(SocialUserUpdateLoadingStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
       // emit(SocialUploadProfileImageSuccessStates());
        print(value);
        updateUser(
            name: name,
            bio: bio,
            image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorStates());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorStates());
    });
  }


  void uploadCoverImage({
    required String name,
    required String bio,
}) {
    emit(SocialUserUpdateLoadingStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImageSuccessStates());
        print(value);
        updateUser(
          name: name,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorStates());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorStates());
    });
  }

//   void updateUserImages({
//   required String name,
//   required String bio,
// }) {
//     emit(SocialUserUpdateLoadingStates());
//
//     if(coverImage != null)
//     {
//       uploadCoverImage();
//     }else if(profileImage != null)
//     {
//       uploadProfileImage();
//     }else if(coverImage != null && profileImage != null)
//     {
//
//     }else
//     {
//       updateUser(
//         name: name,
//         bio: bio,
//       );
//     }
//
//   }

  void updateUser({
    required String name,
    required String bio,
    String? cover,
    String? image,
  })
  {
    SocialUserModel userModel = SocialUserModel(
      name: name,
      email: model!.email,
      uId: model!.uId,
      isEmailVerified: false,
      bio: bio,
      image: image ?? model!.image,
      cover: cover ?? model!.cover,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .update(userModel.toMap())
        .then((value)
    {
      getUserData();
    })
        .catchError((error)
    {
      emit(SocialUserUpdateErrorStates());
    });
  }

  File? postImage;
  void getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      //print("fi $profileImage");
      emit(SocialPostImagePickedSuccessStates());
    } else {
      print('No Image Selected');
      emit(SocialPostImagePickedErrorStates());
    }
  }

  void removePostImage()
  {
    postImage = null;
    emit(SocialRemovePostImageStates());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorStates());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorStates());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  })
  {
    PostModel postModel = PostModel(
      name: model?.name,
      image: model?.image,
      uId: model?.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value)
    {
      emit(SocialCreatePostSuccessStates());
    })
        .catchError((error)
    {
      emit(SocialCreatePostErrorStates());
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];

  void getPosts()
  {
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value)
    {
      value.docs.forEach((element)
      {
        element.reference
        .collection('likes')
        .get()
        .then((value)
        {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        })
        .catchError((error){});
      });
      emit(SocialGetPostsSuccessStates());
    })
        .catchError((error)
    {
      emit(SocialGetPostsErrorStates(error.toString()));
    });
  }

  void likePost(String? postId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model?.uId)
        .set({
      'like':true,
    })
        .then((value){
          emit(SocialLikePostSuccessStates());
    })
        .catchError((error){
          emit(SocialLikePostErrorStates(error.toString()));
    });
  }

  List<SocialUserModel> users =[];

  void getUsers()
  {
    if(users.length == 0)
    {
      FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value)
    {
      value.docs.forEach((element)
      {
        if(element.data()['uId'] != model?.uId) {
          users.add(SocialUserModel.fromJson(element.data()));
        }
      });
      emit(SocialGetAllUsersSuccessStates());
    })
        .catchError((error)
    {
      emit(SocialGetAllUsersErrorStates(error.toString()));
    });
    }
  }


  void sendMessage({
  required String receiverId,
  required String dateTime,
  required String text,
})
  {
    MessageModel messageModel =MessageModel(
      text:text ,
      senderId: model?.uId,
      receiverId:receiverId ,
      dateTime: dateTime,
    );

    FirebaseFirestore.instance
    .collection('users')
    .doc(model?.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .add(messageModel.toMap())
    .then((value)
    {
      emit(SocialSendMessageSuccessStates());
    })
    .catchError((error)
    {
      emit(SocialSendMessageErrorStates());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model?.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value)
    {
      emit(SocialSendMessageSuccessStates());
    })
        .catchError((error)
    {
      emit(SocialSendMessageErrorStates());
    });
  }

  List<MessageModel> messages =[];

  void getMessages({
    required String receiverId,
})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      messages =[];
      event.docs.forEach((element)
      {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessStates());
    });
  }

  //////////////////////

  // List<MessageModel> messages = [];
  //
  // void getMessages({
  //   @required String? receiverId,
  // }) {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(model?.uId)
  //       .collection('chats')
  //       .doc(receiverId)
  //       .collection('messages')
  //       .orderBy('dateTime')
  //       .snapshots()
  //       .listen((event) {
  //     messages = [];
  //
  //     event.docs.forEach((element) {
  //       messages.add(MessageModel.fromJson(element.data()));
  //     });
  //
  //     emit(SocialGetMessagesSuccessStates());
  //   });
  // }

}

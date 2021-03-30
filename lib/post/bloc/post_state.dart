part of 'post_bloc.dart';

abstract class PostsState {}

class LoadingState extends PostsState {}

class FailedToLoadState extends PostsState {
  Error error;
  FailedToLoadState({this.error});
}

class LoadedPostsState extends PostsState {
  List<Post> posts;
  LoadedPostsState({this.posts});
}

class LoadPostState extends PostsState {
  Post post;
  LoadPostState({this.post});
}

class LoadedPostState extends PostsState {
  Post post;
  LoadedPostState({this.post});
}
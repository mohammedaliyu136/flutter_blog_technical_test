part of 'post_bloc.dart';

abstract class PostsEvent {}

class LoadPostsEvent extends PostsEvent {}

class PullToRefreshPostEvent extends PostsEvent {}

class LoadPostEvent extends PostsEvent {
  final Post post;

  LoadPostEvent(this.post);
}
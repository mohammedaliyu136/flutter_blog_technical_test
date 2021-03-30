import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_tech_test/post/model/post.dart';
import 'package:flutter_blog_tech_test/repository/post_api_client.dart';
import 'package:meta/meta.dart';

import '../post_detail.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final _postAPIClient = PostAPIClient();
  List<Post> posts = [];

  PostsBloc() : super(LoadingState());

  @override
  Stream<PostsState> mapEventToState(PostsEvent event) async* {
    if (event is LoadPostsEvent || event is PullToRefreshPostEvent) {
      yield LoadingState();

      try {
        if(posts.isEmpty || event is PullToRefreshPostEvent){
          posts = await _postAPIClient.fetchPosts();
        }
        yield LoadedPostsState(posts: posts);
      } catch (e) {
        yield FailedToLoadState(error: e);
      }
    }else if(event is LoadPostEvent){
      yield LoadingState();

      try {
        final post = await _postAPIClient.fetchPost(event.post);
        yield LoadedPostState(post: post);
      } catch (e) {
        yield FailedToLoadState(error: e);
      }
    }
  }
}

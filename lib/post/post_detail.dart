import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_tech_test/repository/post_api_client.dart';

import 'bloc/post_bloc.dart';
import 'model/post.dart';

class PostDetail extends StatefulWidget {
  PostDetail(this.post);
  Post post;

  @override
  _PostDetailState createState() {
    return _PostDetailState(post);
  }
}

class _PostDetailState extends State<PostDetail> {
  _PostDetailState(this.post);
  Post post;
  Future<Post> futurePost;
  @override
  void initState() {
    BlocProvider.of<PostsBloc>(context).add(LoadPostEvent(post));
    print(post.id);
    print(post.title);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
        leading: GestureDetector(
            onTap: (){
              BlocProvider.of<PostsBloc>(context).add(LoadPostsEvent());
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedPostState) {
            return Column(children: [
              Image.network(state.post.imageUrl, width: MediaQuery.of(context).size.width, fit: BoxFit.cover,),
              Image.network("https://picsum.photos/250?image=9", width: MediaQuery.of(context).size.width, fit: BoxFit.cover,),
              Text(state.post.title),
              Text(state.post.id),
              Text(state.post.createdAt),
            ],);
          } else if (state is FailedToLoadState) {
            return Center(
              child: Text('Error occured: ${state.error}'),
            );
          } else {
            return Container(
              child: Text(""),
            );
          }
        },
      ),
    );



  }
}
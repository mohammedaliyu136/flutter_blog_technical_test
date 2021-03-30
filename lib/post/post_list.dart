import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_tech_test/authentication/bloc/auth_bloc.dart';

import 'bloc/post_bloc.dart';
import 'model/post.dart';
import 'post_detail.dart';

class PostList extends StatefulWidget {
  PostList({Key key}) : super(key: key);

  @override
  _PostListState createState() {
    return _PostListState();
  }
}

class _PostListState extends State<PostList> {
  BuildContext _context;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          print(state);
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
              onRefresh: ()async{
                BlocProvider.of<PostsBloc>(context).add(PullToRefreshPostEvent(),);
              },
              child: ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_context) => (PostDetail(state.posts[index]))),
                      ).then((value){
                        //BlocProvider.of<PostsBloc>(context).add(LoadPostsEvent());
                      });
                    },
                    leading: Stack(
                      children: [
                        Icon(Icons.image_rounded, size:40),
                        Image.network("https://picsum.photos/250?image=9", width: 50, fit: BoxFit.cover,),
                      ],
                    ),
                    title: Text('${state.posts[index].title}'),
                    subtitle: Text('created at: ${state.posts[index].createdAt}'),
                  );
                },
              ),
            );
          } else if (state is FailedToLoadState) {
            return Center(
              child: Text('Error occured: ${state.error}'),
            );
          }else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
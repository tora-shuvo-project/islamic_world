
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:searchtosu/FinalModels/comment_models.dart';

final COLLECTION_COMMENT='comments';

class FirestoreDatabaseHelper{

  static final Firestore db=Firestore.instance;
  static Future addComment(CommentModels commentModels)async{
    final doc=db.collection(COLLECTION_COMMENT).document(commentModels.id);
    return await doc.setData(commentModels.tomap());
  }

  static Future<List<CommentModels>> getAllCommentModels()async{
    QuerySnapshot snapshot=await db.collection(COLLECTION_COMMENT).getDocuments();
    if(snapshot!=null){
      return snapshot.documents.map((e) => CommentModels.fromMap(e.data)).toList();
    }
  }

}
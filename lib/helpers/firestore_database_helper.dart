
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:searchtosu/FinalModels/comment_feedback_models.dart';
import 'package:searchtosu/FinalModels/comment_models.dart';

final COLLECTION_COMMENT='comments';
final COLLECTION_REPLY='reply';

class FirestoreDatabaseHelper{

  static final Firestore db=Firestore.instance;
  static Future addComment(CommentModels commentModels)async{
    final doc=db.collection(COLLECTION_COMMENT).document(commentModels.id);
    return await doc.setData(commentModels.tomap());
  }

  static Future addFeedBack(ComentFeedBackModels comentFeedBackModels)async{
    final doc=db.collection(COLLECTION_REPLY).document(comentFeedBackModels.id).collection('reply').document(comentFeedBackModels.dateKey);
    return await doc.setData(comentFeedBackModels.tomap());
  }

  static Future<List<CommentModels>> getAllCommentModels()async{
    QuerySnapshot snapshot=await db.collection(COLLECTION_COMMENT).getDocuments();
    if(snapshot!=null){
      return snapshot.documents.map((e) => CommentModels.fromMap(e.data)).toList();
    }
  }

  static Future<List<ComentFeedBackModels>> getAllReplySpecifyQuestion(String id)async{
    QuerySnapshot snapshot=await db.collection(COLLECTION_REPLY).document(id).collection('reply').getDocuments();
    if(snapshot!=null){
      return snapshot.documents.map((e) => ComentFeedBackModels.fromMap(e.data)).toList();
    }
  }

}
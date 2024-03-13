import 'dart:html';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite_todo/constants/app_constants.dart';
import 'package:appwrite_todo/data/helper/network_client_helper.dart';
import 'package:appwrite_todo/data/model/Task.dart';

import 'package:logger/logger.dart';

class AppwriteTaskRepository {
  late Client _appwriteClient;
  late Databases databases;
  var logger = Logger();

  AppwriteTaskRepository() {
    _appwriteClient = NetworkClientHelper.instance.appwriteClient;
    databases = Databases(_appwriteClient);
  }

  Future<List<Task>?> listDocument() async {
    try {
      final response = await databases.listDocuments(
          databaseId: Appconstants.dbID,
          collectionId: Appconstants.collectionID);
      // logger.d(response.documents);
      List<Task> listData =
          response.documents.map((e) => Task.fromJson(e.data)).toList();
      return listData;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Task>?> listDocumentByCategory(String category) async {
    try {
      DocumentList? response;
      if (category == 'all') {
        response = await databases.listDocuments(
            databaseId: Appconstants.dbID,
            collectionId: Appconstants.collectionID);
      } else {
        response = await databases.listDocuments(
          databaseId: Appconstants.dbID,
          collectionId: Appconstants.collectionID,
          queries: [
            Query.equal('category', category),
          ],
        );
      }

      List<Task> listData =
          response.documents.map((e) => Task.fromJson(e.data)).toList();
      // logger.d(listData);
      return listData;
    } catch (e) {
      rethrow;
    }
  }

  createDocument(Task task, context) async {
    try {
      final response = await databases.createDocument(
          databaseId: Appconstants.dbID,
          collectionId: Appconstants.collectionID,
          documentId: ID.unique(),
          data: {
            'title': task.title,
            'desc': task.desc,
            'date': task.date,
            'category': task.category,
            'isDone': task.isDone
          });
      // logger.d(response.data['\$id']);
      if (response.data.isNotEmpty) {
        return await response.data['\$id'];
      }
    } on AppwriteException catch (e) {
      print(e);
    }
  }

  updateDocument(Task task) async {
    try {
      final response = await databases.updateDocument(
          databaseId: Appconstants.dbID,
          collectionId: Appconstants.collectionID,
          documentId: task.id!,
          data: {
            'title': task.title,
            'desc': task.desc,
            'date': task.date,
            'category': task.category,
            'isDone': task.isDone
          });
      // if (response.data.isNotEmpty) {
      //   return await listDocument();
      // }
    } on AppwriteException catch (e) {
      print(e);
    }
  }

  removeReminder(String documentID) async {
    try {
      await databases.deleteDocument(
          databaseId: Appconstants.dbID,
          collectionId: Appconstants.collectionID,
          documentId: documentID);

      return await listDocument();
    } catch (e) {
      rethrow;
    }
  }

  // getCategoryById(String id) async {
  //   try {
  //     final response = await databases.listDocuments(
  //         databaseId: Appconstants.dbID,
  //         collectionId: Appconstants.collectionID,
  //         queries: [Query.equal('category', id)]);
  //     List<Task> listData =
  //         response.documents.map((e) => Task.fromJson(e.data)).toList();

  //     return listData;
  //   } on AppwriteException catch (e) {
  //     logger.d(e);
  //   }
  //   return null;
  // }

  @override
  List<Task> build() => <Task>[];
}
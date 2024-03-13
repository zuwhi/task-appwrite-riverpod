import 'package:appwrite/appwrite.dart';
import 'package:appwrite_todo/constants/app_constants.dart';
import 'package:appwrite_todo/data/helper/network_client_helper.dart';
import 'package:appwrite_todo/data/model/Category.dart';
import 'package:appwrite_todo/data/model/Task.dart';
import 'package:logger/logger.dart';

class AppwriteCategoryRepository {
  late Client _appwriteClient;
  late Databases databases;
  var logger = Logger();

  AppwriteCategoryRepository() {
    _appwriteClient = NetworkClientHelper.instance.appwriteClient;
    databases = Databases(_appwriteClient);
  }

  Future<List<Category>?> listCategory() async {
    try {
      final response = await databases.listDocuments(
          databaseId: Appconstants.dbID,
          collectionId: Appconstants.collectionCategoryID);
      List<Category> listData =
          response.documents.map((e) => Category.fromJson(e.data)).toList();
      return listData;
    } catch (e) {
      rethrow;
    }
  }

  createDocument(Category category, context) async {
    try {
      final response = await databases.createDocument(
          databaseId: Appconstants.dbID,
          collectionId: Appconstants.collectionID,
          documentId: ID.unique(),
          data: {
            'name': category.name,
            'total': category.total,
            'doneTotal': category.doneTotal,
            'tasks': category.tasks
          });
      // logger.d(response.data);
      if (response.data.isNotEmpty) {
        // return await listCategory();
        logger.d("success");
      }
    } on AppwriteException catch (e) {
      print(e);
    }
  }

  listCategoryById(String id) async {
    try {
      final response = await databases.listDocuments(
          databaseId: Appconstants.dbID,
          collectionId: Appconstants.collectionCategoryID,
          queries: [
            Query.equal(r'$id', [id])
          ]);

      List<Category> listData =
          response.documents.map((e) => Category.fromJson(e.data)).toList();
      return listData;
    } catch (e) {
      rethrow;
    }
  }

  getCategoryById(String id) async {
    try {
      final response = await databases.listDocuments(
          databaseId: Appconstants.dbID,
          collectionId: Appconstants.collectionCategoryID,
          queries: [
            Query.equal(r'$id', [id])
          ]);

      return response.documents[0].data;
    } catch (e) {
      rethrow;
    }
  }

  updateDocument(String category, String task) async {
    try {
      var cat = await getCategoryById(category);

      List<String> categories = [];
      // if (cat['tasks'] == null) {
      //   categories.add(task);
      // } else {
      //   categories.add(cat['tasks'][0]['\$id']);
      //   categories.add(task);
      // }
      // Logger().d(cat['tasks'].length);
      for (var item in cat['tasks']) {
        if (item.containsKey("\$id")) {
          // Logger().d(item["\$id"]);
          categories.add(item["\$id"]);
        }
      }

      categories.add(task);
      int count = 0;
      for (var item in cat['tasks']) {
        if (item["isDone"] == true) {
          count++;
        }
      }
      // logger.d(count);

      final response = await databases.updateDocument(
          databaseId: Appconstants.dbID,
          collectionId: Appconstants.collectionCategoryID,
          documentId: cat['\$id'],
          data: {
            'name': cat['name'],
            'total': cat['total'],
            'doneTotal': count,
            'tasks': categories
          });
    } on AppwriteException catch (e) {
      print(e);
    }
  }
}

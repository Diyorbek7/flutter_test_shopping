import 'package:flutter_test_shopping/src/model/home/home_product_model.dart';
import 'package:sqflite/sqlite_api.dart';

class FavouriteTable {
  final String tableName = 'favourite_table';
  final String columnId = 'id';
  final String columnProductId = 'product_id';
  final String columnName = 'name';
  final String columnImage = 'image';
  final String columnPrice = 'price';

  createTable(Database db) async {
    await db.execute(
      'CREATE TABLE $tableName('
      '$columnId INTEGER PRIMARY KEY, '
      '$columnProductId INTEGER, '
      '$columnName TEXT , '
      '$columnImage TEXT , '
      '$columnPrice REAL)',
    );
  }

  Future<int> saveFavourite(HomeProductModel data, Database dbClient) async {
    List<Map> list = await dbClient.rawQuery(
      "SELECT * FROM $tableName WHERE $columnProductId = ${data.id}",
    );
    if (list.isEmpty) {
      int result = await dbClient.insert(
        tableName,
        data.toJson(),
      );
      return result;
    } else {
      await updateFavourite(data, dbClient);
      return data.id;
    }
  }

  Future<List<HomeProductModel>> getAllFavourite(Database dbClient) async {
    List<Map> list = await dbClient.rawQuery("SELECT * FROM $tableName");
    List<HomeProductModel> data = <HomeProductModel>[];
    for (int i = 0; i < list.length; i++) {
      var items = HomeProductModel(
        id: list[i][columnProductId],
        title: list[i][columnName],
        price: list[i][columnPrice],
        description: '',
        category: Category.JEWELERY,
        image: list[i][columnImage],
        rating: Rating.fromJson({}),
      );
      data.add(items);
    }
    return data;
  }

  Future<List<HomeProductModel>> getFavourite(Database dbClient, int id) async {
    List<Map> list = await dbClient.rawQuery(
      "SELECT * FROM $tableName WHERE $columnProductId = $id",
    );
    List<HomeProductModel> data = <HomeProductModel>[];
    for (int i = 0; i < list.length; i++) {
      var items = HomeProductModel(
        id: list[i][columnProductId],
        title: list[i][columnName],
        price: list[i][columnPrice],
        description: '',
        category: Category.JEWELERY,
        image: list[i][columnImage],
        rating: Rating.fromJson({}),
      );
      data.add(items);
    }
    return data;
  }

  Future<int> deleteFavourite(int id, Database dbClient) async {
    return await dbClient.delete(
      tableName,
      where: '$columnProductId = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateFavourite(HomeProductModel data, Database dbClient) async {
    return await dbClient.update(
      tableName,
      data.toJson(),
      where: '$columnProductId = ?',
      whereArgs: [data.id],
    );
  }

  Future<void> clearFavourite(Database dbClient) async {
    await dbClient.rawQuery('DELETE FROM $tableName');
  }
}

final favouriteTable = FavouriteTable();

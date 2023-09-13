// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_test_shopping/src/database/table/cart_table.dart';
import 'package:flutter_test_shopping/src/database/table/favourite_table.dart';
import 'package:flutter_test_shopping/src/model/home/home_product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'user_database.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await cartTable.createTable(db);
    await favouriteTable.createTable(db);
  }

  /// cart
  Future<int> saveCart(HomeProductModel performer) async {
    return cartTable.saveCart(performer, await db);
  }

  Future<List<HomeProductModel>> getCart(int performerId) async {
    return cartTable.getCart(await db, performerId);
  }

  Future<List<HomeProductModel>> getAllCart() async {
    return cartTable.getAllCart(await db);
  }

  Future<int> deleteCart(int performerId) async {
    return cartTable.deleteCart(performerId, await db);
  }

  Future<int> updateCart(HomeProductModel performer) async {
    return cartTable.updateCart(performer, await db);
  }

  Future<void> clearCart() async {
    return cartTable.clearCart(await db);
  }

  /// favourite
  Future<int> saveFavourite(HomeProductModel data) async {
    return favouriteTable.saveFavourite(data, await db);
  }

  Future<List<HomeProductModel>> getAllFavourite() async {
    return favouriteTable.getAllFavourite(await db);
  }

  Future<List<HomeProductModel>> getFavourite(int id) async {
    return favouriteTable.getFavourite(await db, id);
  }

  Future<int> deleteFavourite(int id) async {
    return favouriteTable.deleteFavourite(id, await db);
  }

  Future<int> updateFavourite(HomeProductModel data) async {
    return favouriteTable.updateFavourite(data, await db);
  }

  Future<void> clearFavourite() async {
    return favouriteTable.clearFavourite(await db);
  }
}

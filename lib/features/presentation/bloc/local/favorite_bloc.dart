import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/features/domain/usecase/local/get_favorites_usecase.dart';
import 'package:restaurant_app/features/domain/usecase/local/insert_favorite_usecase.dart';
import 'package:restaurant_app/features/domain/usecase/local/remove_favorite_usecase.dart';

import 'package:restaurant_app/features/presentation/bloc/local/favorite_event.dart';
import 'package:restaurant_app/features/presentation/bloc/local/favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavoriteUseCase getFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;
  final InsertFavoriteUseCase insertFavoriteUseCase;

  FavoriteBloc(
    this.getFavoriteUseCase,
    this.insertFavoriteUseCase,
    this.removeFavoriteUseCase,
  ) : super(const FavoriteLoadingState()) {
    on<GetAllFavoriteEvent>(onGetAllFavorite);
    on<DeleteSingleFavoriteEvent>(onRemoveSingleFavorite);
    on<InsertFavoriteEvent>(onInsertFavorite);
    on<CheckFavoriteEvent>(onCheckFavorites);
  }

  Future<void> onGetAllFavorite(
    GetAllFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(const FavoriteLoadingState());
    final favorites = await getFavoriteUseCase();
    if (favorites.isEmpty) {
      emit(const FavoriteEmptyState());
    } else {
      emit(FavoriteSucccessState(favorites));
    }
  }

  Future<void> onRemoveSingleFavorite(
    DeleteSingleFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    await removeFavoriteUseCase(params: event.id);
    final currentFavorites = await getFavoriteUseCase();
    emit(const FavoriteLoadingState());
    emit(FavoriteSucccessState(currentFavorites));
    add(CheckFavoriteEvent(event.id!));
    add(const GetAllFavoriteEvent());
  }

  Future<void> onInsertFavorite(
    InsertFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    await insertFavoriteUseCase(params: event.favorite);
    final currentFavorites = await getFavoriteUseCase();
    emit(const FavoriteLoadingState());
    emit(FavoriteSucccessState(currentFavorites));
    add(CheckFavoriteEvent(event.id!));
    add(const GetAllFavoriteEvent());
  }

  Future<void> onCheckFavorites(
    CheckFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    final allFavorites = await getFavoriteUseCase();
    final isFavorite = allFavorites.any((item) => item.id == event.id);
    if (isFavorite) {
      emit(const IsFavoriteState());
    } else {
      emit(const IsNotFavoriteState());
    }
  }
}

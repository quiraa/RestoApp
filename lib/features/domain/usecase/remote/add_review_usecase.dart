import 'package:restaurant_app/core/data_state/data_state.dart';
import 'package:restaurant_app/core/usecases/use_case.dart';
import 'package:restaurant_app/features/data/model/add_review/add_review_response.dart';
import 'package:restaurant_app/features/data/model/add_review/review_body.dart';
import 'package:restaurant_app/features/domain/repository/restaurant_repository.dart';

class AddReviewUseCase
    implements UseCase<DataState<AddReviewResponse>, ReviewBody> {
  final RestaurantRepository repository;

  AddReviewUseCase(this.repository);

  @override
  Future<DataState<AddReviewResponse>> call({ReviewBody? params}) {
    return repository.addCustomerReview(params!);
  }
}

import 'package:chopper/chopper.dart';
import 'model_converter.dart';
import 'model_response.dart';
import 'recipe_model.dart';

part 'recipe_service.chopper.dart';

const String apiKey = '3d9f8b71cb47125c0890866aec8592e8';
const String apiId = '3a94c2ca';
const String apiUrl = 'https://api.edamam.com';

@ChopperApi()
abstract class RecipeService extends ChopperService {
  @Get(path: 'search')
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
      @Query('q') String query, @Query('from') int from, @Query('to') int to);

  static RecipeService create() {
    final client = ChopperClient(
        baseUrl: Uri.parse(apiUrl),
        interceptors: [
          _addQuery,
          HttpLoggingInterceptor(),
        ],
        converter: ModelConverter(),
        errorConverter: JsonConverter(),
        services: [
          _$RecipeService(),
        ]);
    return _$RecipeService(client);
  }
}

Request _addQuery(Request request) {
  final params = Map<String, dynamic>.from(request.parameters);
  params['app_id'] = apiId;
  params['app_key'] = apiKey;
  return request.copyWith(parameters: params);
}

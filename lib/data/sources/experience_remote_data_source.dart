import 'package:dio/dio.dart';
import 'package:flick_tv_ott/core/error/exeception.dart';
import 'package:flick_tv_ott/data/model/experience_model.dart';


abstract class ExperienceRemoteDataSource {
  Future<List<ExperienceModel>> getExperiences();
}

class ExperienceRemoteDataSourceImpl implements ExperienceRemoteDataSource {
  final Dio dio;
  final String apiUrl = 'https://staging.chamberofsecrets.8club.co/v1/experiences?active=true';

  ExperienceRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ExperienceModel>> getExperiences() async {
    try {
      final response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        final List<dynamic> experiencesJson = response.data['data']['experiences'];
        return experiencesJson
            .map((json) => ExperienceModel.fromJson(json))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      // Handle DioError or other exceptions
      throw ServerException();
    }
  }
}
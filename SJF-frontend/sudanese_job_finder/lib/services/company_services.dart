// ignore_for_file: use_build_context_synchronously, avoid_print
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:sudanese_job_finder/constant/app_config.dart';
import 'package:sudanese_job_finder/constant/app_route.dart';
import 'package:sudanese_job_finder/model/account_data_response.dart';
import 'package:sudanese_job_finder/model/company_images_request.dart';
import 'package:sudanese_job_finder/model/company_images_response.dart';
import 'package:sudanese_job_finder/model/company_job_detail_response.dart';
import 'package:sudanese_job_finder/model/company_job_request.dart';
import 'package:sudanese_job_finder/model/company_job_response.dart';
import 'package:sudanese_job_finder/model/company_profile_response.dart';
// import 'package:sudanese_job_finder/model/interview_request.dart';
import 'package:sudanese_job_finder/model/interview_response.dart';
import 'package:sudanese_job_finder/model/job_application_request.dart';
import 'package:sudanese_job_finder/model/job_application_seeker_detail_response.dart';
import 'package:sudanese_job_finder/model/job_view_request.dart';
import 'package:sudanese_job_finder/services/api_interceptor.dart';
import 'package:sudanese_job_finder/util/dialog.dart';
import 'package:sudanese_job_finder/util/errors.dart';
import 'package:sudanese_job_finder/util/route_config.dart';

class CompanyServices {
  final Dio _dio;
  CompanyServices() : _dio = Dio() {
    final context = navigatorKey.currentContext!;
    final apiInterceptor = ApiInterceptor(
      onLogout: () =>
          GoRouter.of(context).pushNamed(AppRoute.onboardingRouteName),
      dio: _dio,
      onConnectionError: () => connectionError(context),
      timeoutConnection: () => connectionTimeout(context),
    );
    _dio.interceptors.add(apiInterceptor);
  }

  void close() {
    _dio.close(force: true);
  }

  Future<List<AccountDataResponse>> getAccountData(int id) async {
    try {
      final response =
          await _dio.get('${AppConfig.apiURL}account/account_data/$id/');
      if (response.statusCode == 200) {
        final accountData =
            accountDataResponseFromJson(json.encode(response.data));
        return [accountData];
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<List<CompanyProfileResponse>> getProfile(int id) async {
    try {
      final response = await _dio
          .get('${AppConfig.apiURL}company/company_profile/?user=$id');
      if (response.statusCode == 200) {
        final data = companyProfileResponseFromJson(json.encode(response.data));
        return data;
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<bool> patchProfile(
      BuildContext context, CompanyProfileResponse payload, File? file) async {
    try {
      FormData formData = FormData.fromMap({
        'company_name': payload.companyName,
        'mobile': payload.mobile,
        'description': payload.description,
        'web_site': payload.webSite,
        'created_by': payload.createdBy,
        'modified_by': payload.modifiedBy,
        'is_delete': payload.isDelete,
      });
      if (file != null) {
        formData.files.add(
          MapEntry(
            'image',
            await MultipartFile.fromFile(file.path),
          ),
        );
      }
      final response = await _dio.patch(
        '${AppConfig.apiURL}company/company_profile/${payload.id}/',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      if (response.statusCode == 200) return true;
      return false;
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        final message = error.response?.data[0];
        errorDialog(
          context: context,
          errorTitle: "Error",
          errorDescription: message ?? '',
        );
        return false;
      }
      unhandledExceptionMessage(context);
      return false;
    }
  }

  Future<List<CompanyImagesResponse>> getImages(int id) async {
    final response = await _dio.get(
        '${AppConfig.apiURL}company/company_images/?company_profile_id=$id');
    if (response.statusCode == 200) {
      final data = companyImagesResponseFromJson(json.encode(response.data));
      return data;
    }
    throw 'error';
  }

  Future<bool> postImage(CompanyImagesRequest payload) async {
    try {
      FormData formData = FormData.fromMap({
        "company_profile": payload.companyProfile,
        "title": payload.title,
        "description": payload.description,
        "image": await MultipartFile.fromFile(payload.image!),
        "created_by": payload.createdBy,
        "is_delete": false
      });
      final response = await _dio.post(
        '${AppConfig.apiURL}company/company_images/',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
      if (response.statusCode == 201) return true;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteImage(int id) async {
    try {
      final response =
          await _dio.delete('${AppConfig.apiURL}company/company_images/$id/');
      if (response.statusCode == 204) {
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<List<CompanyJobResponse>> getJobs(int id) async {
    final response = await _dio
        .get('${AppConfig.apiURL}company/company_job/?company_profile=$id');
    if (response.statusCode == 200) {
      final data = companyJobResponseFromJson(json.encode(response.data));
      return data;
    }
    throw 'error';
  }

  Future<CompanyJob> getJobByTitle(String title) async {
    final response = await _dio
        .get('${AppConfig.apiURL}company/company_job/?jobTitle=$title');
    if (response.statusCode == 200) {
      final data = singleCompanyJobFromJson(json.encode(response.data));
      return data;
    }
    throw 'error';
  }

  Future<bool> postJob(CompanyJobRequest payload) async {
    final response = await _dio.post(
      '${AppConfig.apiURL}company/company_job/',
      data: payload,
      options: Options(contentType: 'application/json'),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      // print('Error posting job: ${response}');
      return false;
    }
  }

  Future<bool> patchJob(int id, CompanyJobResponse payload) async {
    try {
      final response = await _dio.patch(
        '${AppConfig.apiURL}company/company_job/$id/',
        data: payload,
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 200) return true;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteJob(int id) async {
    try {
      final response =
          await _dio.delete('${AppConfig.apiURL}company/company_job/$id/');
      if (response.statusCode == 204) return true;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<List<CompanyJobDetailResponse>> getJobsDetail() async {
    final response =
        await _dio.get('${AppConfig.apiURL}company/company_job_detail/');
    if (response.statusCode == 200) {
      final data = companyJobDetailResponseFromJson(json.encode(response.data));
      return data;
    }
    throw 'Error';
  }

  Future<List<CompanyJobDetailResponse>> getRecommedJob(int id) async {
    final response = await _dio
        .get('${AppConfig.apiURL}company/job_recommended/?pramid=$id');
    if (response.statusCode == 200) {
      final data = companyJobDetailResponseFromJson(json.encode(response.data));
      return data;
    }
    throw 'Error';
  }

  Future<List<JobApplicationSeekerDetailResponse>> getJobApplicationDetail(
      int id) async {
    final response = await _dio.get(
        '${AppConfig.apiURL}job_seeker/job_application_seeker_detail/?company_job__company_profile=$id');
    if (response.statusCode == 200) {
      final data = jobApplicationSeekerDetailResponseFromJson(
          json.encode(response.data));
      return data;
    }
    throw 'Error';
  }

  Future<bool> patchJobApplication(
      int id, JobApplicationRequest payload) async {
    try {
      final response = await _dio.patch(
        '${AppConfig.apiURL}job_seeker/job_seeker_job_application/$id/',
        data: payload,
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 200) return true;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<List<InterviewResponse>> fetchInterviews(int companyProfileId) async {
    try {
      final response = await _dio.get(
        '${AppConfig.apiURL}company/interviews/?user=$companyProfileId',
      );
      if (response.statusCode == 200) {
        return interviewResponseListFromJson(json.encode(response.data));
      } else {
        throw Exception('Failed to load interviews');
      }
    } catch (e) {
      throw Exception('Failed to load interviews: $e');
    }
  }

  Future<bool> postInterview(InterviewResponse interview) async {
    try {
      final response = await _dio.post(
        '${AppConfig.apiURL}company/interviews/',
        data: interview.toJson(),
        options: Options(contentType: 'application/json'),
      );
      print('Response: ${response.data}');
      if (response.statusCode == 201) {
        return true;
      } else {
        print('Failed to add interview: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error posting interview: $e');
      return false;
    }
  }

  Future<bool> patchInterview(int id, InterviewResponse interview) async {
    try {
      final response = await _dio.patch(
        '${AppConfig.apiURL}company/interviews/$id/',
        data: interview.toJson(),
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateInterviewStatus(int interviewId, String status) async {
    try {
      final response = await _dio.patch(
        '${AppConfig.apiURL}company/interviews/$interviewId/',
        data: {'status': status},
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // تحتاج لتحسين
  Future<Map<String, int>> fetchJobRequestsCounts(int id) async {
    try {
      final response = await _dio.get(
        '${AppConfig.apiURL}job_seeker/job_application_detail/',
      );
      if (response.statusCode == 200) {
        final data = response.data as List;
        final filteredData = data.where((jobRequest) {
          final companyJob = jobRequest['company_job'];
          return companyJob != null && companyJob['id'] == id;
        }).toList();

        int approvedCount = 0;
        int rejectedCount = 0;
        int pendingCount = 0;

        for (var jobRequest in filteredData) {
          final status = jobRequest['application_status']['description'];
          if (status == 'Approved') {
            approvedCount++;
          } else if (status == 'Rejected') {
            rejectedCount++;
          } else if (status == 'Pending') {
            pendingCount++;
          }
        }

        return {
          'Requests': filteredData.length,
          'Approved': approvedCount,
          'Rejected': rejectedCount,
          'Pending': pendingCount,
        };
      } else {
        throw Exception('Failed to load job requests');
      }
    } catch (e) {
      throw Exception('Failed to load job requests: $e');
    }
  }

  Future<bool> checkJobViewExists(int companyJobId, int jobSeekerId) async {
    try {
      final response = await _dio.get(
        '${AppConfig.apiURL}company/job_views/',
        queryParameters: {
          'company_job': companyJobId,
          'job_seeker': jobSeekerId,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.isNotEmpty; // Return true if a view exists
      } else {
        throw Exception('Failed to check job view');
      }
    } catch (e) {
      print('Error checking job view: $e');
      return false;
    }
  }

  Future<bool> postJobView(JobViewRequest jobViewRequest) async {
    try {
      final response = await _dio.post(
        '${AppConfig.apiURL}company/job_views/',
        data: jobViewRequest.toJson(),
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error posting job view: $e');
      return false;
    }
  }

  Future<int> getJobViewCount(int id) async {
    try {
      final response = await _dio.get(
        '${AppConfig.apiURL}company/job_views/',
        queryParameters: {
          'company_job': id,
        },
        options: Options(contentType: 'application/json'),
      );

      if (response.statusCode == 200) {
        print('aaaaa $id ${response.data}');
        final data = response.data as List;
        return data.length; // Return the number of records as the viewCount
      } else {
        throw Exception('Failed to fetch job view count');
      }
    } catch (e) {
      print('Error fetching job view count: $e');
      return 0; // Return 0 if an error occurs
    }
  }
}

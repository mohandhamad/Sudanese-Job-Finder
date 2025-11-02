// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sudanese_job_finder/constant/app_config.dart';
import 'package:sudanese_job_finder/constant/app_route.dart';
import 'package:sudanese_job_finder/model/job_application_request.dart';
import 'package:sudanese_job_finder/model/job_seeker_attachment_request.dart';
import 'package:sudanese_job_finder/model/job_seeker_attachment_response.dart';
import 'package:sudanese_job_finder/model/job_seeker_contact_request.dart';
import 'package:sudanese_job_finder/model/job_seeker_contact_response.dart';
import 'package:sudanese_job_finder/model/job_seeker_experience_request.dart';
import 'package:sudanese_job_finder/model/job_seeker_experience_response.dart';
import 'package:sudanese_job_finder/model/job_seeker_job_application_detail_response.dart';
import 'package:sudanese_job_finder/model/job_seeker_professional_request.dart';
import 'package:sudanese_job_finder/model/job_seeker_professional_response.dart';
import 'package:sudanese_job_finder/model/job_seeker_profile_request.dart';
import 'package:sudanese_job_finder/model/job_seeker_profile_response.dart';
import 'package:sudanese_job_finder/model/job_seeker_qualifications_request.dart';
import 'package:sudanese_job_finder/model/job_seeker_qualifications_response.dart';
import 'package:sudanese_job_finder/services/api_interceptor.dart';
import 'package:sudanese_job_finder/util/dialog.dart';
import 'package:sudanese_job_finder/util/errors.dart';
import 'package:sudanese_job_finder/util/route_config.dart';

class JobSeekerServices {
  final Dio _dio;
  JobSeekerServices() : _dio = Dio() {
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

  Future<List<JobSeekerProfileResponse>> getProfile(int id) async {
    try {
      final response = await _dio
          .get('${AppConfig.apiURL}job_seeker/job_seeker_profile/?user=$id');
      if (response.statusCode == 200) {
        final data =
            jobSeekerProfileResponseFromJson(json.encode(response.data));
        return data;
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<JobSeekerProfile> getProfileByName(String name) async {
    final response = await _dio.get(
        '${AppConfig.apiURL}job_seeker/job_seeker_profile/?firstName=$name');
    if (response.statusCode == 200) {
      final data = singleJobSeekerProfileFromJson(json.encode(response.data));
      return data;
    }
    throw 'error';
  }

  Future<bool> patchProfile(BuildContext context,
      JobSeekerProfileResponse payload, File? file) async {
    try {
      FormData formData = FormData.fromMap({
        'national_id': payload.nationalId,
        'first_name': payload.firstName,
        'middle_name': payload.middleName,
        'last_name': payload.lastName,
        'birth_date': DateFormat("yyyy-MM-dd").format(payload.birthDate!),
        'gender': payload.gender,
        'marital_status': payload.maritalStatus,
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
        '${AppConfig.apiURL}job_seeker/job_seeker_profile/${payload.id}/',
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

  Future<bool> updateProfile(JobSeekerProfileRequest profileRequest) async {
    try {
      final response = await _dio.put(
        '${AppConfig.apiURL}job_seeker/job_seeker_profile/${profileRequest.id}/',
        data: profileRequest.toJson(),
      );
      return response.statusCode == 200;
    } catch (e) {
      // print(e);
      return false;
    }
  }

  Future<List<JobSeekerContactResponse>> getContact(int id) async {
    final response = await _dio.get(
        '${AppConfig.apiURL}job_seeker/job_seeker_contact/?job_seeker_profile=$id');
    if (response.statusCode == 200) {
      final data = jobSeekerContactResponseFromJson(json.encode(response.data));
      return data;
    }
    throw 'error';
  }

  Future<bool> postContact(JobSeekerContactRequest payload) async {
    try {
      final response = await _dio.post(
        '${AppConfig.apiURL}job_seeker/job_seeker_contact/',
        data: payload,
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 201) return true;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> patchContact(int id, JobSeekerContactResponse payload) async {
    try {
      final response = await _dio.patch(
        '${AppConfig.apiURL}job_seeker/job_seeker_contact/$id/',
        data: payload,
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 200) return true;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteContact(int id) async {
    try {
      final response = await _dio
          .delete('${AppConfig.apiURL}job_seeker/job_seeker_contact/$id/');
      if (response.statusCode == 204) return true;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<List<JobSeekerQualificationsResponse>> getQualifications(
      int id) async {
    final response = await _dio.get(
        '${AppConfig.apiURL}job_seeker/job_seeker_academic_qualifications/?job_seeker_profile=$id');
    if (response.statusCode == 200) {
      final data =
          jobSeekerQualificationsResponseFromJson(json.encode(response.data));
      return data;
    }
    throw 'error';
  }

  Future<bool> postQualifications(
      JobSeekerQualificationsRequest payload) async {
    try {
      final response = await _dio.post(
        '${AppConfig.apiURL}job_seeker/job_seeker_academic_qualifications/',
        data: payload,
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 201) return true;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> patchQualifications(
      int id, JobSeekerQualificationsResponse payload) async {
    try {
      final response = await _dio.patch(
        '${AppConfig.apiURL}job_seeker/job_seeker_academic_qualifications/$id/',
        data: payload,
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 200) return true;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteQualifications(int id) async {
    try {
      final response = await _dio.delete(
          '${AppConfig.apiURL}job_seeker/job_seeker_academic_qualifications/$id/');
      if (response.statusCode == 204) return true;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<List<JobSeekerExperienceResponse>> getExperience(int id) async {
    final response = await _dio.get(
        '${AppConfig.apiURL}job_seeker/job_seeker_experience_certificate/?job_seeker_profile=$id');
    if (response.statusCode == 200) {
      final data =
          jobSeekerExperienceResponseFromJson(json.encode(response.data));
      return data;
    }
    throw 'error';
  }

  Future<bool> postExperience(JobSeekerExperienceRequest payload) async {
    try {
      final response = await _dio.post(
        '${AppConfig.apiURL}job_seeker/job_seeker_experience_certificate/',
        data: payload,
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 201) return true;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> patchExperience(
      int id, JobSeekerExperienceResponse payload) async {
    try {
      final response = await _dio.patch(
        '${AppConfig.apiURL}job_seeker/job_seeker_experience_certificate/$id/',
        data: payload,
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 200) return true;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteExperience(int id) async {
    try {
      final response = await _dio.delete(
          '${AppConfig.apiURL}job_seeker/job_seeker_experience_certificate/$id/');
      if (response.statusCode == 204) return true;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<List<JobSeekerProfessionalResponse>> getProfessional(int id) async {
    final response = await _dio.get(
        '${AppConfig.apiURL}job_seeker/job_seeker_professional_certificate/?job_seeker_profile=$id');
    if (response.statusCode == 200) {
      final data =
          jobSeekerProfessionalResponseFromJson(json.encode(response.data));
      return data;
    }
    throw 'error';
  }

  Future<bool> postProfessional(JobSeekerProfessionalRequest payload) async {
    try {
      final response = await _dio.post(
        '${AppConfig.apiURL}job_seeker/job_seeker_professional_certificate/',
        data: payload,
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 201) return true;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> patchProfessional(
      int id, JobSeekerProfessionalResponse payload) async {
    try {
      final response = await _dio.patch(
        '${AppConfig.apiURL}job_seeker/job_seeker_professional_certificate/$id/',
        data: payload,
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 200) return true;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteProfessional(int id) async {
    try {
      final response = await _dio.delete(
          '${AppConfig.apiURL}job_seeker/job_seeker_professional_certificate/$id/');
      if (response.statusCode == 204) return true;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<List<JobSeekerAttachmentResponse>> getAttachment(int id) async {
    final response = await _dio.get(
        '${AppConfig.apiURL}job_seeker/job_seeker_attachment/?job_seeker_profile=$id');
    if (response.statusCode == 200) {
      final data =
          jobSeekerAttachmentResponseFromJson(json.encode(response.data));
      return data;
    }
    throw 'Error';
  }

  Future<bool> postAttachment(
      BuildContext context, JobSeekerAttachmentRequest payload) async {
    try {
      FormData formData = FormData.fromMap({
        'job_seeker_profile': payload.jobSeekerProfile,
        'job_seeker_attachment_type': payload.jobSeekerAttachmentType,
        'created_by': payload.createdBy,
        'modified_by': payload.modifiedBy,
        'is_delete': payload.isDelete,
      });
      if (payload.fileData != null) {
        formData.files.add(
          MapEntry(
            'file_data',
            await MultipartFile.fromFile(payload.fileData!),
          ),
        );
      }
      final response = await _dio.post(
        '${AppConfig.apiURL}job_seeker/job_seeker_attachment/',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      if (response.statusCode == 201) return true;
      return false;
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        errorDialog(
          context: context,
          errorTitle: "Error",
          errorDescription: error.response.toString(),
        );
        return false;
      }
      unhandledExceptionMessage(context);
      return false;
    }
  }

  Future<bool> deleteAttachment(int id) async {
    try {
      final response = await _dio
          .delete('${AppConfig.apiURL}job_seeker/job_seeker_attachment/$id/');
      if (response.statusCode == 204) return true;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> postJobApplication(JobApplicationRequest data) async {
    try {
      final response = await _dio.post(
        '${AppConfig.apiURL}job_seeker/job_seeker_job_application/',
        data: data,
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 201) return true;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteJobApplication(int id) async {
    try {
      final response = await _dio.delete(
          '${AppConfig.apiURL}job_seeker/job_seeker_job_application/$id/');
      if (response.statusCode == 204) return true;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteProgramApplication(int id) async {
    try {
      final response = await _dio.delete(
          '${AppConfig.apiURL}job_seeker/job_seeker_program_application/$id/');
      if (response.statusCode == 204) return true;
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<List<JobSeekerJobApplicationDetailResponse>> getJobApplicationDetail(
      int id) async {
    final response = await _dio.get(
        '${AppConfig.apiURL}job_seeker/job_application_detail/?job_seeker_profile=$id');
    if (response.statusCode == 200) {
      final data = jobSeekerJobApplicationDetailResponseFromJson(
          json.encode(response.data));
      return data;
    }
    throw 'Error';
  }

  Future<List> getApplicationStatus() async {
    final response =
        await _dio.get('${AppConfig.apiURL}lookup_data/application-status/');
    if (response.statusCode == 200) {
      final data = response.data;
      return data;
    }
    throw 'Error';
  }
}

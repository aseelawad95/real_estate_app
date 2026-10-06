// lib/features/messages/data/source/message_api_service.dart

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_estate/core/constants/api_urls.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/network/dio_client.dart';
import 'package:real_estate/features/message/data/models/conversation_model.dart';
import 'package:real_estate/features/message/data/models/message_model.dart';
import 'package:real_estate/features/message/data/models/send_message_model.dart';
import 'package:real_estate/service_locator.dart';

abstract class MessageApiService {
  Future<Either<Failure, MessageModel>> sendMessage(
    SendMessageRequestModel request,
  );
  Future<Either<Failure, List<ConversationModel>>> getConversations();
  Future<Either<Failure, List<MessageModel>>> getConversationMessages(
    int conversationId,
  );
  Future<Either<Failure, Unit>> markAsRead(int conversationId);
}

class MessageApiServiceImpl extends MessageApiService {
  @override
  Future<Either<Failure, MessageModel>> sendMessage(
    SendMessageRequestModel request,
  ) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrls.sendMessage,
        data: request.toJson(),
      );
      final data = response.data as Map<String, dynamic>;
      
      return Right(MessageModel.fromJson(data));
    } on DioException catch (e) {
      print('STATUS: ${e.response?.statusCode}');
      print('BODY: ${e.response?.data}'); 
      print('SENT: ${e.requestOptions.data}');
      return Left(_mapDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ConversationModel>>> getConversations() async {
    try {
      final response = await sl<DioClient>().get(ApiUrls.conversations);
      final data = response.data as List<dynamic>;
      debugPrint("data getConversations ${data}");
      final conversations = data
          .map((e) => ConversationModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(conversations);
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MessageModel>>> getConversationMessages(
    int conversationId,
  ) async {
    try {
      final response = await sl<DioClient>().get(
        ApiUrls.conversationMessages(conversationId),
      );
      final data = response.data as List<dynamic>;
       debugPrint("data getConversationMessages ${data}");
      final messages = data
          .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(messages);
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> markAsRead(int conversationId) async {
    try {
      await sl<DioClient>().patch(ApiUrls.markAsRead(conversationId));
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Failure _mapDioError(DioException e) {
    final data = e.response?.data;
    final message = (data is Map && data['message'] != null)
        ? data['message'].toString()
        : (e.message ?? 'حدث خطأ غير متوقع');
    return ServerFailure(message);
  }
}

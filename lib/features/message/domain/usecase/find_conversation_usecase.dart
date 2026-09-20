



import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/usecase/usecase.dart';
import 'package:real_estate/features/message/domain/entities/find_conversation.dart';
import 'package:real_estate/features/message/domain/repository/message_repo.dart';
import 'package:real_estate/service_locator.dart';

class FindConversationIdUseCase
    implements UseCase<Either<Failure, int?>, FindConversationParams> {
  @override
  Future<Either<Failure, int?>> call({FindConversationParams? param}) {
    return sl<MessageRepository>().findConversationId(
      propertyId: param!.propertyId,
      otherUserId: param.otherUserId,
    );
  }
}
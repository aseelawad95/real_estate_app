import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/usecase/usecase.dart';
import 'package:real_estate/features/message/domain/entities/message_entity.dart';
import 'package:real_estate/features/message/domain/entities/send_message.dart';
import 'package:real_estate/features/message/domain/repository/message_repo.dart';
import 'package:real_estate/service_locator.dart';

class SendMessageUseCase
    implements UseCase<Either<Failure, MessageEntity>, SendMessageParams> {
  @override
  Future<Either<Failure, MessageEntity>> call({SendMessageParams? param}) {
    return sl<MessageRepository>().sendMessage(param!);
  }
}
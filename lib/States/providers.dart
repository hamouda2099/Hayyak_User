import 'package:flutter_riverpod/flutter_riverpod.dart';

// Login Screen
final rememberMeProvider = StateProvider<bool>((ref) => true);
final termsAndConditionsProvider = StateProvider<bool>((ref) => false);
final saveMyCardDetailsProvider = StateProvider<bool>((ref) => false);
final refundGuaranteeProvider = StateProvider<bool>((ref) => false);
final sendMeTicketsVisSmsProvider = StateProvider<bool>((ref) => false);
final sendMeTicketsVisWhatsappProvider = StateProvider<bool>((ref) => false);

// date Time Api

final dateTimeProvider = StateProvider<Map>((ref)=>{});
import 'package:flutter_riverpod/flutter_riverpod.dart';
// check in / out scan screen
final checkInBoxProvider = StateProvider<bool>((ref) => false);
final checkOutBoxProvider = StateProvider<bool>((ref) => false);
// Login Screen
final rememberMeProvider = StateProvider<bool>((ref) => false);
final termsAndConditionsProvider = StateProvider<bool>((ref) => false);
final saveMyCardDetailsProvider = StateProvider<bool>((ref) => false);
final refundGuaranteeProvider = StateProvider<bool>((ref) => false);
final sendMeTicketsVisSmsProvider = StateProvider<bool>((ref) => false);
final sendMeTicketsVisWhatsappProvider = StateProvider<bool>((ref) => false);

// Event Details Screen

//places Screen
final placesProvider = StateProvider<Map>((ref)=>{});
final dashboardProvider = StateProvider<Map>((ref)=>{});
final dashboardDetailsProvider = StateProvider<Map>((ref)=>{});
final eventDashboardProvider = StateProvider<Map>((ref)=>{});
final eventCategoriesProvider = StateProvider<Map>((ref)=>{});
final eventServicesProvider = StateProvider<Map>((ref)=>{});
final checkPlaceResponse = StateProvider<Map>((ref)=>{});
final loadingLiveDashboard = StateProvider<bool>((ref)=>false);


//events Screen
final loadingEventsProvider = StateProvider<bool>((ref)=>false);
final eventsProvider = StateProvider<Map>((ref)=>{});
final checkEventResponse = StateProvider<Map>((ref)=>{});
final checkServiceResponse = StateProvider<Map>((ref)=>{});
final orderNumbersProvider = StateProvider<Map>((ref)=>{});
final ordersResponseProvider = StateProvider((ref)=>{});


// Scanner Screen
final visibilityProvider = StateProvider<bool>((ref)=>false);

// date Time Api

final dateTimeProvider = StateProvider<Map>((ref)=>{});
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miles_assignment/providers/providers.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Generate mock classes
@GenerateNiceMocks([MockSpec<FirebaseAuth>(), MockSpec<User>()])
import 'providers_test.mocks.dart';

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late ProviderContainer container;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    container = ProviderContainer(
      overrides: [
        // Override the Firebase instance with our mock
        authStateProvider.overrideWith(
          (ref) => mockFirebaseAuth.authStateChanges(),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('AuthStateProvider Tests', () {
    test('initial state should be loading', () {
      final authState = container.read(authStateProvider);
      expect(authState.isLoading, true);
    });

    test('should emit null when user is not signed in', () async {
      // Setup mock to return null user (not signed in)
      when(
        mockFirebaseAuth.authStateChanges(),
      ).thenAnswer((_) => Stream.value(null));

      // Wait for the stream to emit a value
      final user = await container.read(authStateProvider.future);
      expect(user, null);
    });

    test('should emit User when signed in', () async {
      // Create a mock user
      final mockUser = MockUser();
      when(
        mockFirebaseAuth.authStateChanges(),
      ).thenAnswer((_) => Stream.value(mockUser));

      // Wait for the stream to emit a value
      final user = await container.read(authStateProvider.future);
      expect(user, isNotNull);
    });
  });

  group('CurrentUserProvider Tests', () {
    test('should return null when no user is authenticated', () {
      when(
        mockFirebaseAuth.authStateChanges(),
      ).thenAnswer((_) => Stream.value(null));

      final currentUser = container.read(currentUserProvider);
      expect(currentUser, null);
    });
  });
}

import { AuthTokenReponseData, signInWithIdToken } from '@cage-clash/supabase';
import * as AppleAuthentication from 'expo-apple-authentication';
import { Platform } from 'react-native';

import { isNativeSignInError } from './is-native-sign-in-error';

type AppleSignInButtonProps = {
  onSuccess: (userInfo: AuthTokenReponseData) => void;
  onError: (error: string) => void;
};

export function AppleSignInButton({
  onSuccess,
  onError,
}: AppleSignInButtonProps) {
  if (Platform.OS === 'ios')
    return (
      <AppleAuthentication.AppleAuthenticationButton
        buttonType={AppleAuthentication.AppleAuthenticationButtonType.SIGN_IN}
        buttonStyle={AppleAuthentication.AppleAuthenticationButtonStyle.BLACK}
        cornerRadius={5}
        style={{ width: 200, height: 64 }}
        onPress={async () => {
          try {
            const credential = await AppleAuthentication.signInAsync({
              requestedScopes: [
                AppleAuthentication.AppleAuthenticationScope.FULL_NAME,
                AppleAuthentication.AppleAuthenticationScope.EMAIL,
              ],
            });
            // Sign in via Supabase Auth.
            if (credential.identityToken) {
              const data = await signInWithIdToken(
                'apple',
                credential.identityToken,
              );
              onSuccess(data);
            } else {
              throw new Error('No identityToken.');
            }
          } catch (e) {
            if (isNativeSignInError(e)) {
              if (e.code === 'ERR_REQUEST_CANCELED') {
                // handle that the user canceled the sign-in flow
              }
            }
            onError('Error with apple sign in');
          }
        }}
      />
    );
  return <>{/* Implement Android Auth options. */}</>;
}

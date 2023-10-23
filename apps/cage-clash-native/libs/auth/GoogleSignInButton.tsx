import { AuthTokenReponseData, signInWithIdToken } from '@cage-clash/supabase';
import {
  GoogleSignin,
  GoogleSigninButton as _GoogleSigninButton,
  statusCodes,
} from '@react-native-google-signin/google-signin';
import React from 'react';

import { isNativeSignInError } from './is-native-sign-in-error';

type GoogleSignInButtonProps = {
  onSuccess: (userInfo: AuthTokenReponseData) => void;
  onError: (error: string) => void;
};

export const GoogleSignInButton = ({
  onSuccess,
  onError,
}: GoogleSignInButtonProps) => {
  GoogleSignin.configure({
    scopes: ['https://www.googleapis.com/auth/drive.readonly'],
    webClientId: 'YOUR CLIENT ID FROM GOOGLE CONSOLE',
  });

  return (
    <_GoogleSigninButton
      size={_GoogleSigninButton.Size.Wide}
      color={_GoogleSigninButton.Color.Dark}
      onPress={async () => {
        try {
          await GoogleSignin.hasPlayServices();
          const userInfo = await GoogleSignin.signIn();
          if (userInfo.idToken) {
            const data = await signInWithIdToken('google', userInfo.idToken);
            onSuccess(data);
          }
        } catch (error) {
          if (isNativeSignInError(error)) {
            if (error.code === statusCodes.SIGN_IN_CANCELLED) {
              // user cancelled the login flow
            } else if (error.code === statusCodes.IN_PROGRESS) {
              // operation (e.g. sign in) is in progress already
            } else if (error.code === statusCodes.PLAY_SERVICES_NOT_AVAILABLE) {
              // play services not available or outdated
            }
          }
          // some other error happened
          onError('Error with google sign in');
        }
      }}
    />
  );
};

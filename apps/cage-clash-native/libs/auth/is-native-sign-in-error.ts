type NativeSignInError = Error & {
  code?: string;
};
export const isNativeSignInError = (error: any): error is NativeSignInError => {
  return error instanceof Error && error.hasOwnProperty('code');
};

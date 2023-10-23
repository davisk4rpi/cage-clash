import { signInWithIdToken } from './auth';

export type AuthTokenReponseData = Awaited<
  ReturnType<typeof signInWithIdToken>
>;

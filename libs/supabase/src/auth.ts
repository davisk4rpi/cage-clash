import { SignInWithIdTokenCredentials } from '@supabase/supabase-js';
import { supabase } from './client';

export const signInWithIdToken = async (
  provider: SignInWithIdTokenCredentials['provider'],
  token: SignInWithIdTokenCredentials['token'],
) => {
  const { data, error } = await supabase().auth.signInWithIdToken({
    provider,
    token,
  });
  if (error) {
    throw error;
  }
  return data;
};

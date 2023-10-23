import { AuthTokenReponseData } from '@cage-clash/supabase';
import type {} from '@redux-devtools/extension'; // required for devtools typing
import { create } from 'zustand';
import { devtools } from 'zustand/middleware';

interface SessionState {
  session: AuthTokenReponseData['session'] | undefined;
  isLoading: boolean;
  setSession: (session?: AuthTokenReponseData['session']) => void;
}

export const useSessionStore = create<SessionState>()(
  devtools(set => ({
    isLoading: true,
    setSession: session => set(_ => ({ session, isLoading: false })),
    session: undefined,
  })),
);

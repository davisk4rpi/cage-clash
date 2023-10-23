import { SupabaseClientOptions, createClient } from '@supabase/supabase-js';
import { Database } from './db.types';

const SUPABASE_PUBLIC_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRpdHl4aGR6aHRtc3Ryam5zb3lsIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODU1ODM0MTksImV4cCI6MjAwMTE1OTQxOX0.lWJIiZQGeoVwirT0Yy4yCrfY258lP5KL7dBXFRqyS4U";
const SUPABASE_PROJECT_URL = "https://dityxhdzhtmstrjnsoyl.supabase.co";

export const DB_SCHEMA_NAME = 'public' as const;
export type ClientOptions = SupabaseClientOptions<typeof DB_SCHEMA_NAME>;
let client: ReturnType<typeof createClient<Database>>;

const DEFAULT_CREATE_CLIENT_OPTIONS: ClientOptions = {
  auth: {
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: false,
  },
};

export const initClient = (
  options: ClientOptions,
) => {
  const mergedOptions = {
    ...options,
    auth: {
      ...DEFAULT_CREATE_CLIENT_OPTIONS.auth,
      ...options.auth,
    },
  };
  client = createClient<Database>(SUPABASE_PROJECT_URL, SUPABASE_PUBLIC_ANON_KEY, mergedOptions);
};


export const supabase = () => {
  if (client) {
    return client;
  }
  throw new Error('Supabase client has not been initialized');
};

export const SUPABASE_URL = "https://xsrgfbhxhavasrjscaik.supabase.co";
export const SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhzcmdmYmh4aGF2YXNyanNjYWlrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA4MzQ2NDEsImV4cCI6MjA4NjQxMDY0MX0.qOTtfazgB6deUpgaZPoCvPWYVRMDQ0CWhkYxDXhr88g";
export const supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
  auth: {
    persistSession: true,
    autoRefreshToken: true,
    detectSessionInUrl: true,
  }
});

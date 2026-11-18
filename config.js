/* Connection to the hotel's own Supabase project (admin page + statistics).
   Leave both values empty to switch this feature off: the website then works exactly as before.
   The "anon" key is meant to be public; it can only do what the database rules allow. */
window.MIRAMAR_SB = {
  url: "",   // example: https://abcdefghijkl.supabase.co
  key: ""    // the "anon public" key from Supabase > Project Settings > API
};

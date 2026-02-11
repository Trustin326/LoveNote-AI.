LoveNote AI — Phase 2 Production Starter (Supabase + Stripe-ready)
======================================================

WHAT YOU GET
- index.html        : High-converting landing page + login/CTA
- dashboard.html    : Auth-guarded app + feature tools + uploads + save/history + share
- admin.html        : Owner admin panel (plan management + simple analytics)
- supabase.sql      : Tables + RLS + trigger to auto-create profiles
- CONFIG.txt        : Where to paste your Supabase URL/Anon key + Stripe Payment Links

IMPORTANT NOTES
1) Stripe:
   - This Phase 2 uses Stripe Payment LINKS on the front-end (no secret keys in browser).
   - For automatic plan activation after Stripe, you MUST add a webhook (Phase 3).
   - In Phase 2, owner can grant plan in admin.html (writes to profiles.plan).

2) Uploads:
   - Uploads are stored as base64 inside the database for simplicity.
   - For larger files and better scalability, use Supabase Storage (Phase 3).

SETUP (FAST)
A) Supabase
1) Create a new Supabase project
2) Open SQL Editor → run supabase.sql
3) Copy Project URL + Anon Key
4) Paste into CONFIG block at top of index.html, dashboard.html, admin.html

B) Deploy
Upload all files to your GitHub Pages repo root (or Netlify).
Open index.html.

DEFAULT PLANS
- Free: Message Generator
- Bundle: + Meme + Greeting Card
- Pro: + Photo Transform + all extras

OWNER ACCESS
After you sign up, set yourself to owner:
- In Supabase SQL Editor:
  update public.profiles set role='owner', plan='pro' where email='YOUR_EMAIL';

Then open admin.html.

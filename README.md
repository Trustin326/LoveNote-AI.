# LoveNote AI — Final Sell Version

## Repo files
- index.html (landing + hero cupid + pricing)
- login.html (Supabase auth)
- dashboard.html (pixel-style 4-card grid layout + live previews)
- upsell.html (dancing greeting-card upsell)
- css/style.css
- js/common.js (embedded images as base64)
- js/supabase.js (Supabase URL + anon key prefilled)
- js/guard.js (auth guard)

## Stripe hookup
Replace the demo unlock buttons:
- On Stripe success, set `localStorage.lovenote_paid = "true"` then redirect to `/dashboard.html`.

## Supabase setup
Supabase → Authentication → URL Configuration:
- Site URL: your GitHub Pages root
- Redirect URLs: include `/dashboard.html` and `/login.html`

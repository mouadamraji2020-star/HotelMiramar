# Hôtel Miramar Tanger — Website handover

## What this is
The official website for Hôtel Miramar, a 3-star seafront hotel at 168 Avenue Mohamed VI, Tangier, Morocco (40 rooms).
It's a static site (plain HTML/CSS/JavaScript, no framework, no build step), hosted on GitHub Pages.
The owner is a beginner programmer who works at the hotel's reception.

## Files
- `index.html`: the whole website (HTML + CSS in `<style>` + JavaScript in `<script>`).
- `images/`: the hotel's own photos, already resized and compressed.
  - `hero.jpg`: daytime photo of the facade on the Corniche (top banner)
  - `facade.jpg`: close-up of the facade with the MIRAMAR sign ("Welcome" section)
  - `room-double-sea.jpg`, `room-twin-sea.jpg`, `room-twin-city.jpg`, `room-triple-sea.jpg`, `room-triple-city.jpg`: one photo per room card
  - `gallery-1.jpg` … `gallery-8.jpg`: photo gallery (gallery-2 is the romantic room set-up with towel swans)

## Design (current = "professional modern" version)
- Font: Manrope (Noto Kufi Arabic for Arabic). Colours: white / light grey `#f6f7f8`, near-black `#0c1116`, accent ocean blue `#0e7490`.
- The CSS has layers: the original base styles first, then a "VERSION 3 — Modern" block, then a "V4 — refined professional" block. Later blocks override earlier ones. When editing styles, edit or override in the V4 block.
- Sections in order: header + language switch, hero, booking bar, highlights strip, About, Rooms (5 cards), Services (8 tiles), Gallery (8 photos + full-screen lightbox), Location (Google Maps embed), Good to know, Contact + WhatsApp form, footer (4 columns), floating WhatsApp button.

## Languages
English, French and Arabic (Arabic switches the page to right-to-left). All text lives in the `T` object in the script (`T.en`, `T.fr`, `T.ar`). Elements use `data-i18n="key"` (text) or `data-i18n-ph="key"` (placeholder). **Any new text must be added in all 3 languages.**

## Reservations
- No Booking.com. Every "Book now" / "Check availability" button opens a 2-step reservation pop-up: (1) dates, guests, room choice (rooms that sleep fewer than the guest count are greyed out) → (2) name, phone/WhatsApp, email, arrival time, message.
- On submit, it POSTs JSON to FormSubmit: `https://formsubmit.co/ajax/hotelmiramartanger@gmail.com`. The hotel receives an email with a table of the details; Reply goes to the guest.
- FormSubmit needs a one-time activation: after the first real submission from the live site, click "Activate" in the email FormSubmit sends to hotelmiramartanger@gmail.com (check Spam).
- If sending fails, the guest gets a `mailto:` fallback link.
- The site says the reception replies by email to confirm availability and explain the deposit; the reservation is confirmed once the deposit is received. No payment is taken on the site. The email sent to the hotel is labelled "Reservation request (not confirmed until the deposit is received)".
- The hotel has no terrace (removed from the site).

## Settings to edit (top of the `<script>`, `CONFIG` object)
- `phone`: +212 5 39 30 16 20 (real; a landline).
- The hotel has NO WhatsApp, so there is no WhatsApp button or form on the site (removed).
- `email`: hotelmiramartanger@gmail.com (real; shown on the site).
- `web3formsKey`: Web3Forms access key (account moadamraji2023@gmail.com, limited to the domain mouadamraji2020-star.github.io). Requests are sent through Web3Forms to the email of that account. FormSubmit is only a fallback when the key is empty. BEFORE GO-LIVE: create a Web3Forms form for hotelmiramartanger@gmail.com and put its key here.
- `bookingEmail` (FormSubmit fallback only): where reservation requests are SENT. TEMPORARILY set to a test address while testing. BEFORE GO-LIVE set it back to hotelmiramartanger@gmail.com and activate FormSubmit for that address.

## Facts used on the site (from the hotel's Expedia / Hotels.com listings, to be confirmed by the owner)
- Check-in 15:00–20:00, check-out until 12:00. Breakfast 07:00–11:00 is NOT included in the room rate (owner confirmed; to confirm: is it served and what does it cost?).
- Free WiFi, restaurant, 24h reception, A/C, laundry, room service, 24h security. No on-site parking, no pets, no alcohol served.
- Distances: Tanja Marina Bay 20 m, Tangier Beach 50 m (owner confirmed), restaurants & cafés next door, Ibn Battouta Mall 100 m (owner confirmed), city port 0.7 km, Tanger City Mall 1 km, Grand Socco/Medina 1.3 km, Kasbah Museum 1.5 km, Cap Malabata 3 km, airport 11 km (from the owner's hotel description, read as "distance, then place").
- From the owner's hotel description: café-restaurant, 24h reception, one of the best-rated hotels for couples and families, panoramic view over the beach and marina. All rooms: A/C, flat-screen satellite TV, WiFi, minibar; laundry and room service; some rooms sea view, some city view. (The description also says "terrasse", but the owner said there is NO terrace, so it stays removed.)
- Room types: Double Sea View (queen bed), Twin Sea View, Twin City View (16 m²), Standard Triple Sea View (3 singles), Superior Triple City View.

## Open questions / to-do
1. DONE: real phone in `CONFIG`. The hotel has no WhatsApp (button and form removed).
2. Confirm which room photos are really sea view vs city view.
3. Superior Triple: the listing says 3 single beds, but its photo shows 1 double + 1 single. Confirm and fix the text.
4. Publish on GitHub Pages, send a test reservation, activate FormSubmit.
5. Optional later: own domain (e.g. hotelmiramartanger.com) connected to GitHub Pages.
6. DONE: the WhatsApp form in Contact was replaced by a "Book now" button that opens the reservation pop-up.

## How the owner likes to work
- Explain things simply; tell him exactly what he has to do himself; avoid making him do many tiny manual steps.
- Make focused changes; don't rewrite the whole site or break features that work; keep the design consistent.
- Test changes in the browser (desktop and phone width, and in Arabic) before saying they work.
- Ask before committing or pushing to GitHub; stage files explicitly (no blind `git add .`).

## Admin page + statistics (added Nov 2026)
- Files: `admin.html` (owner-only page, English UI, no link from the public site, `noindex`), `config.js` (Supabase URL + anon key, EMPTY until connected), `supabase/setup.sql` (tables, security rules).
- Uses a NEW, separate Supabase project for the hotel (not ReviewRise). No libraries: plain `fetch` to the REST/auth endpoints.
- With `config.js` empty the site behaves exactly as before and the admin page says "Not connected yet".
- Settings (table `site_settings`, key/value): `sec_about, sec_rooms, sec_amenities, sec_dining, sec_gallery, sec_location, sec_plan, sec_contact` (false = hidden, default on), `room_r1..room_r5` (false = hidden), `reservations_on` (false = "please call us" instead of the form), `banner_on` + `banner_en/fr/ar`.
- The site reads the settings on every load (last known settings are cached in localStorage so it applies instantly).
- Statistics (table `events`): anonymous only (visit, section_view, book_click, request_sent + language, device, referrer host, room, nights, guests, random per-tab session id). NO names, e-mails or phone numbers. Skipped when the browser sends Do Not Track.
- Security: only the e-mail written in `public.is_admin()` (setup.sql) can change settings or read events (Row Level Security). Turn OFF "Allow new users to sign up" in Supabase Auth. The anon key in config.js is public by design.
- Risk: anyone can insert fake events (spam the statistics); they cannot read or change anything else.
- Admin page v2 (Nov 2026): EN/FR/AR (RTL for Arabic, choice remembered in localStorage `mz_admin_lang`; all texts in the `I18N` object inside admin.html). Statistics: KPI cards with change vs the previous period + sparklines, plain-language insights, visits/requests chart with hover tooltip (hourly for "Today"), visit→request funnel, sources, language/device donuts, room performance, sections reached, busiest hours/weekdays, latest requests, CSV export (anonymous event data only).

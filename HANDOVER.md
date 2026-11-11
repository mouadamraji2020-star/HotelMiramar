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
- The site says the reception will confirm by email/phone. It is a request, not an instant confirmed booking.

## Settings to edit (top of the `<script>`, `CONFIG` object)
- `phone`: +212 5 39 30 16 20 (real; a landline).
- The hotel has NO WhatsApp, so there is no WhatsApp button or form on the site (removed).
- `email`: hotelmiramartanger@gmail.com (real).

## Facts used on the site (from the hotel's Expedia / Hotels.com listings, to be confirmed by the owner)
- Check-in 15:00–20:00, check-out until 12:00. Breakfast 07:00–11:00 is NOT included in the room rate (owner confirmed; to confirm: is it served and what does it cost?).
- Free WiFi, restaurant, 24h reception, A/C, terrace, laundry, room service, 24h security. No on-site parking, no pets, no alcohol served.
- Distances: Tanja Marina Bay 200 m, Tangier Beach 300 m, city port 0.7 km, Grand Socco/Medina 1.3 km, airport ~20 min.
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

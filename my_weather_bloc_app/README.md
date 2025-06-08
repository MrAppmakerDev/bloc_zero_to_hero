Last two weekends, I dove into Flutter BLoC—I’d heard it powers production apps but thought it was too complex. 

After binging tutorials from these YouTube heroes, everything clicked:

PRODUCTION READY Flutter App in 6 HOURS with Bloc and Firebase!
DevVibe: https://lnkd.in/gCwJNfir

The Best Flutter Bloc Complete Course – Visualise, Understand, Learn & Practice Bloc Concepts
Flutterly: https://lnkd.in/g72r7ETH

Build an Offline First App using Flutter, Node, Bloc, Express, TypeScript, Docker and PostgreSQL!
Rivaan Ranawat: https://lnkd.in/gFgrtZag

… I finally felt confident enough to build a mini weather app that fetches data with Dio, manages state via BLoC/Cubit, and uses GetIt for dependency injection.

1. Learning Functional Error Handling
Pretty soon I realized my error‑handling was a mess, so I adopted the Either pattern from functional programming and slotted it into a simple Clean‑Architecture mix. Now my repos return Either<Model<Failure>, Model<Success>> for crystal‑clear success/error paths.

2. Hosting Flutter Web on Firebase
With the app working locally, I deployed to Firebase Hosting (firebase init hosting, firebase deploy) and my app was live on Firebase’s global CDN—zero backend fuss.

3. Battling CORS & Hiding My API Key
Browsers blocked direct calls to WeatherAPI and exposed my key in DevTools . My fix: a lightweight Node.js + Express proxy in TypeScript that:
Receives /api/weather?q=City from Flutter Injects the secret key, forwards to WeatherAPI, Returns only the needed JSON, No more CORS errors, no leaked keys.

4. My AI Sidekicks to the Rescue
I turned to ChatGPT and Claude—asking them “no code, just tips and pointers, please,” and to focus on StackOverflow and official docs for speed. A reminder that efficient prompts unlock the best guidance, but they’re still tools, not magic.

5. Containerizing with Docker & Deploying on Render
To guarantee “works on my machine” → “works everywhere,” I wrote a multi‑stage Dockerfile to compile TS → lean JS, then pointed my GitHub repo to Render’s free tier. except: Free instances on Render sleep after ~15 min of inactivity and take ~20–25s to wake up.

6. Handling Cold‑Start UX & Retry Logic
I added RetryInterceptor in Dio to automatically retry failed calls and built a custom loader with a “Waiting for server…” message. The catch? My BLoC didn’t recognize the waitingForServer state yet, so the UI displays normal loader instead of loader with text: "Waiting for server to restart..." 
🐛 Fix incoming!

🔗 Curious? Check out the code & live site:
GitHub: https://lnkd.in/gDTnZQun
https://lnkd.in/gKWfnqDP

Live site: https://lnkd.in/ghCiY9HG

🚀 Let’s connect!
If you’ve tamed similar cold‑starts, BLoC quirks, or have ideas on signaling that “waiting” state, drop me a message—always happy to learn from fellow devs!

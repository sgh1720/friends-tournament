# Friends Tournament Bracket

A small web app for running game-night tournaments with friends.

- Register players with a gamer tag and optional main character
- Seed manually or shuffle
- Three formats: **Bracket** (knockout), **Everyone plays everyone** (league), or **League + playoffs**
- Tap a player to record a win, tap again to undo
- Installable on your phone (Add to Home Screen) and works offline

Everything is one static page: no build step, no server. Results are saved in the browser of the device running the tournament.

## Put it on GitHub

You need [git](https://git-scm.com) and the [GitHub CLI](https://cli.github.com), signed in with `gh auth login`.

```bash
chmod +x deploy.sh
./deploy.sh                 # creates github.com/<you>/friends-tournament
./deploy.sh my-brawl-night  # or pick your own repo name
```

The script creates a public repo, pushes the files, and turns on GitHub Pages. The app goes live at `https://<you>.github.io/<repo>/` after about a minute. Run it again after any change to push the update.

## Files

| File | What it does |
|---|---|
| `index.html` | The whole app |
| `manifest.webmanifest` | Lets phones install it like an app |
| `sw.js` | Caches the app so it opens offline |
| `icon.svg`, `icon-192.png`, `icon-512.png` | App icons |
| `deploy.sh` | One-command publish to GitHub Pages |

## Run locally

Open `index.html` in a browser, or serve the folder with `python3 -m http.server` and visit http://localhost:8000.

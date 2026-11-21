#!/usr/bin/env bash
# Publishes this folder to a new GitHub repo and turns on GitHub Pages.
# Usage:  ./deploy.sh [repo-name]
# Needs:  git and the GitHub CLI (gh), signed in with `gh auth login`.
set -euo pipefail

REPO="${1:-friends-tournament}"
cd "$(dirname "$0")"

command -v git >/dev/null || { echo "git is not installed."; exit 1; }
command -v gh  >/dev/null || { echo "GitHub CLI not installed. Get it at https://cli.github.com"; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "Not signed in. Run: gh auth login"; exit 1; }

OWNER="$(gh api user -q .login)"
echo "Publishing to github.com/$OWNER/$REPO ..."

# 1. Local git repo + first commit
if [ ! -d .git ]; then
  git init -q -b main
fi
git add -A
git diff --cached --quiet || git commit -q -m "Friends tournament web app"

# 2. Create the GitHub repo (public: free GitHub Pages needs a public repo) and push
if gh repo view "$OWNER/$REPO" >/dev/null 2>&1; then
  echo "Repo already exists, pushing changes."
  git remote get-url origin >/dev/null 2>&1 || git remote add origin "https://github.com/$OWNER/$REPO.git"
  git push -u origin main
else
  gh repo create "$REPO" --public --source=. --remote=origin --push \
    --description "Tournament bracket app for game nights with friends"
fi

# 3. Turn on GitHub Pages from the main branch
if gh api "repos/$OWNER/$REPO/pages" >/dev/null 2>&1; then
  echo "GitHub Pages already on."
else
  gh api -X POST "repos/$OWNER/$REPO/pages" \
    -f "source[branch]=main" -f "source[path]=/" >/dev/null
  echo "GitHub Pages turned on."
fi

URL="https://$OWNER.github.io/$REPO/"
echo
echo "Done. Your app will be live in about a minute at:"
echo "  $URL"
echo "On your phone, open it and choose 'Add to Home Screen' to install it."

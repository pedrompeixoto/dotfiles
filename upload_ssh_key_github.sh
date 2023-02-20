sslpub="$(cat ~/.ssh/id_ed25519.pub |tail -1)"
echo -n "Github token:"
read -s github_token

curl \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${github_token}"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/user/keys \
  -d "{\"title\":\"skyvalley key\",\"key\":\"${sslpub}\"}"
